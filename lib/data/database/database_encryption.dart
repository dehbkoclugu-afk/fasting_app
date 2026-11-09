import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqlite3/sqlite3.dart';

const _keyName = 'fasting_db_key_v1';
const _sqliteNotADatabase = 26;
final _plaintextHeader = ascii.encode('SQLite format 3\x00');
final _hexKey = RegExp(r'^[0-9a-f]{64}$');

// Android: a decrypt failure must surface instead of wiping the key, otherwise a
// transient Keystore error would make the database permanently unreadable.
// iOS: first_unlock keeps the key available while the phone is locked and lets
// encrypted device backups restore it together with the database.
const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(resetOnError: false),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
);

Future<String?> _readStoredKey() => _secureStorage.read(key: _keyName);

Future<void> _writeStoredKey(String key) =>
    _secureStorage.write(key: _keyName, value: key);

/// Where a database whose key is gone is kept. Erasing user data removes it.
String unreadableDatabasePath(String databasePath) =>
    '$databasePath.unreadable';

String _encryptingPath(String databasePath) => '$databasePath.encrypting';

/// Opens [file] encrypted, migrating an older plaintext database in place.
///
/// Availability wins over encryption when the two conflict: if the key store or
/// the migration fails, a plaintext database stays usable and is retried on the
/// next launch. An encrypted database with an unavailable key cannot be opened,
/// so that error is rethrown and the file is left untouched.
Future<QueryExecutor> openEncryptedDatabase(
  File file, {
  Future<String?> Function() readKey = _readStoredKey,
  Future<void> Function(String key) writeKey = _writeStoredKey,
}) async {
  final path = file.path;
  // A crash mid-migration can leave a plaintext copy behind.
  _deleteIfExists(_encryptingPath(path));
  _deleteIfExists('${_encryptingPath(path)}-journal');

  final String? stored;
  try {
    stored = await readKey();
  } catch (error) {
    if (_isEncrypted(file)) rethrow;
    debugPrint('Database key unavailable, staying unencrypted: $error');
    return NativeDatabase.createInBackground(file);
  }

  if (stored != null && !_hexKey.hasMatch(stored)) {
    throw StateError('Stored database key has an unexpected format');
  }

  var key = stored;
  if (key != null && _isEncrypted(file)) {
    final candidate = key;
    if (!await Isolate.run(() => _keyOpens(path, candidate))) {
      _moveAside(file);
    }
  } else if (key == null) {
    // A restored backup brings the database without its device-bound key.
    if (_isEncrypted(file)) _moveAside(file);
    try {
      key = await _createKey(readKey, writeKey);
    } catch (error) {
      debugPrint('Database key not saved, staying unencrypted: $error');
      return NativeDatabase.createInBackground(file);
    }
  }

  if (_isPlaintext(file)) {
    final migrationKey = key;
    try {
      await Isolate.run(() => _encryptPlaintextDatabase(path, migrationKey));
    } catch (error) {
      debugPrint('Database encryption failed, will retry next launch: $error');
      _deleteIfExists(_encryptingPath(path));
      return NativeDatabase.createInBackground(file);
    }
  }

  final openKey = key;
  return NativeDatabase.createInBackground(
    file,
    setup: (db) => _applyKey(db, openKey),
  );
}

Future<String> _createKey(
  Future<String?> Function() readKey,
  Future<void> Function(String key) writeKey,
) async {
  final random = Random.secure();
  final key = List.generate(
    32,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
  await writeKey(key);
  // Encrypting with a key that did not persist would lose the data next launch.
  if (await readKey() != key) {
    throw StateError('Database key did not persist');
  }
  return key;
}

void _applyKey(Database db, String key) {
  // Pinned so a future library default cannot change how existing files open.
  db.execute("PRAGMA cipher = 'chacha20'");
  db.execute("PRAGMA hexkey = '$key'");
  db.select('SELECT count(*) FROM sqlite_master');
}

bool _keyOpens(String path, String key) {
  final db = sqlite3.open(path);
  try {
    _applyKey(db, key);
    return true;
  } on SqliteException catch (error) {
    if (error.resultCode == _sqliteNotADatabase) return false;
    rethrow;
  } finally {
    db.close();
  }
}

/// The original stays in place until a verified encrypted copy replaces it, so
/// a crash or full disk at any step cannot lose data.
void _encryptPlaintextDatabase(String path, String key) {
  final temporary = _encryptingPath(path);

  final Map<String, int> expected;
  final plaintext = sqlite3.open(path);
  try {
    expected = _rowCounts(plaintext);
    plaintext.execute('VACUUM INTO ?', [temporary]);
  } finally {
    plaintext.close();
  }

  final copy = sqlite3.open(temporary);
  try {
    copy.execute("PRAGMA cipher = 'chacha20'");
    copy.execute("PRAGMA hexrekey = '$key'");
  } finally {
    copy.close();
  }

  final encrypted = sqlite3.open(temporary);
  try {
    _applyKey(encrypted, key);
    final check = encrypted.select('PRAGMA integrity_check').first.values.first;
    if (check != 'ok') {
      throw StateError('Encrypted copy failed integrity check');
    }
    if (!mapEquals(_rowCounts(encrypted), expected)) {
      throw StateError('Encrypted copy lost rows');
    }
  } finally {
    encrypted.close();
  }
  if (_isPlaintext(File(temporary))) {
    throw StateError('Copy was not encrypted');
  }

  // Closing the plaintext database above resolved its journal. A leftover next
  // to the encrypted file would be replayed as a hot journal and corrupt it.
  for (final suffix in const ['-journal', '-wal', '-shm']) {
    _deleteIfExists('$path$suffix');
  }
  File(temporary).renameSync(path);
}

Map<String, int> _rowCounts(Database db) {
  final tables = db.select(
    "SELECT name FROM sqlite_master WHERE type = 'table' "
    "AND name NOT LIKE 'sqlite_%'",
  );
  return {
    for (final table in tables)
      table['name'] as String:
          db.select('SELECT count(*) AS c FROM "${table['name']}"').first['c']
              as int,
  };
}

Uint8List? _header(File file) {
  if (!file.existsSync() || file.lengthSync() == 0) return null;
  final handle = file.openSync();
  try {
    return handle.readSync(_plaintextHeader.length);
  } finally {
    handle.closeSync();
  }
}

bool _isPlaintext(File file) {
  final header = _header(file);
  return header != null && listEquals(header, _plaintextHeader);
}

bool _isEncrypted(File file) {
  final header = _header(file);
  return header != null && !listEquals(header, _plaintextHeader);
}

void _moveAside(File file) {
  debugPrint('Database key lost, keeping unreadable copy and starting fresh');
  file.renameSync(unreadableDatabasePath(file.path));
  for (final suffix in const ['-journal', '-wal', '-shm']) {
    _deleteIfExists('${file.path}$suffix');
  }
}

void _deleteIfExists(String path) {
  final file = File(path);
  if (file.existsSync()) file.deleteSync();
}
