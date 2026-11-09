import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/data/database/database_encryption.dart';
import 'package:flutter_test/flutter_test.dart';

const marker = 'private-weight-note';

class MemoryKeyStore {
  MemoryKeyStore([this.key]);

  String? key;
  Object? readError;
  Object? writeError;

  Future<String?> read() async {
    if (readError != null) throw readError!;
    return key;
  }

  Future<void> write(String value) async {
    if (writeError != null) throw writeError!;
    key = value;
  }
}

void main() {
  late Directory directory;
  late File file;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('db_encryption_');
    file = File('${directory.path}/fasting_app.sqlite');
  });

  tearDown(() => directory.deleteSync(recursive: true));

  Future<AppDatabase> open(MemoryKeyStore keys) async => AppDatabase.forTesting(
    await openEncryptedDatabase(file, readKey: keys.read, writeKey: keys.write),
  );

  /// Builds the database the way released versions did: real schema, no key.
  Future<void> createPlaintextDatabase() async {
    final db = AppDatabase.forTesting(NativeDatabase(file));
    await db.setSetting('note', marker);
    await db.close();
  }

  bool fileContains(File target, String text) =>
      latin1.decode(target.readAsBytesSync()).contains(text);

  bool hasPlaintextHeader() =>
      fileContains(file, 'SQLite format 3') &&
      latin1.decode(file.readAsBytesSync().sublist(0, 15)) == 'SQLite format 3';

  test('a new database is encrypted and reopens with the same key', () async {
    final keys = MemoryKeyStore();
    var db = await open(keys);
    await db.setSetting('note', marker);
    await db.close();

    expect(keys.key, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(hasPlaintextHeader(), isFalse);
    expect(fileContains(file, marker), isFalse);

    final savedKey = keys.key;
    db = await open(keys);
    expect(await db.getSetting('note'), marker);
    await db.close();
    expect(keys.key, savedKey);
  });

  test('a plaintext database migrates without losing rows', () async {
    await createPlaintextDatabase();
    expect(fileContains(file, marker), isTrue);

    final db = await open(MemoryKeyStore());
    expect(await db.getSetting('note'), marker);
    await db.close();

    expect(hasPlaintextHeader(), isFalse);
    expect(fileContains(file, marker), isFalse);
    expect(File('${file.path}.encrypting').existsSync(), isFalse);
  });

  test('a plaintext copy left by a crash is removed', () async {
    await createPlaintextDatabase();
    final leftover = File('${file.path}.encrypting')
      ..writeAsStringSync('partial $marker');

    final db = await open(MemoryKeyStore());
    expect(await db.getSetting('note'), marker);
    await db.close();
    expect(leftover.existsSync(), isFalse);
  });

  test('a failed migration keeps the original plaintext database', () async {
    final corrupt = [
      ...ascii.encode('SQLite format 3\x00'),
      ...List.filled(4096, 7),
    ];
    file.writeAsBytesSync(corrupt);

    final keys = MemoryKeyStore();
    final executor = await openEncryptedDatabase(
      file,
      readKey: keys.read,
      writeKey: keys.write,
    );
    await executor.close();

    expect(keys.key, isNotNull, reason: 'must reach the migration step');
    expect(file.readAsBytesSync(), corrupt);
    expect(File('${file.path}.encrypting').existsSync(), isFalse);
  });

  test('a lost key keeps an unreadable copy and starts fresh', () async {
    final original = MemoryKeyStore();
    var db = await open(original);
    await db.setSetting('note', marker);
    await db.close();
    final encrypted = file.readAsBytesSync();

    db = await open(MemoryKeyStore());
    expect(await db.getSetting('note'), isNull);
    await db.setSetting('note', 'new');
    expect(await db.getSetting('note'), 'new');
    await db.close();

    expect(
      File(unreadableDatabasePath(file.path)).readAsBytesSync(),
      encrypted,
    );
  });

  test('a mismatched key keeps an unreadable copy and starts fresh', () async {
    var db = await open(MemoryKeyStore());
    await db.setSetting('note', marker);
    await db.close();

    db = await open(MemoryKeyStore('ab' * 32));
    expect(await db.getSetting('note'), isNull);
    await db.close();
    expect(File(unreadableDatabasePath(file.path)).existsSync(), isTrue);
  });

  test('a key store outage never touches an encrypted database', () async {
    final keys = MemoryKeyStore();
    final db = await open(keys);
    await db.setSetting('note', marker);
    await db.close();
    final encrypted = file.readAsBytesSync();

    keys.readError = StateError('keystore offline');
    await expectLater(open(keys), throwsStateError);
    expect(file.readAsBytesSync(), encrypted);
    expect(File(unreadableDatabasePath(file.path)).existsSync(), isFalse);

    keys.readError = null;
    final recovered = await open(keys);
    expect(await recovered.getSetting('note'), marker);
    await recovered.close();
  });

  test('a key store outage leaves plaintext data usable', () async {
    await createPlaintextDatabase();
    final keys = MemoryKeyStore()..readError = StateError('keystore offline');

    var db = await open(keys);
    expect(await db.getSetting('note'), marker);
    await db.close();
    expect(hasPlaintextHeader(), isTrue);

    keys.readError = null;
    db = await open(keys);
    expect(await db.getSetting('note'), marker);
    await db.close();
    expect(hasPlaintextHeader(), isFalse);
  });

  test('an unsaved key leaves plaintext data usable', () async {
    await createPlaintextDatabase();
    final keys = MemoryKeyStore()..writeError = StateError('write failed');

    final db = await open(keys);
    expect(await db.getSetting('note'), marker);
    await db.close();
    expect(hasPlaintextHeader(), isTrue);
  });
}
