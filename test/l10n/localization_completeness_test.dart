import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final _placeholderPattern = RegExp(r'\{([A-Za-z_][A-Za-z0-9_]*)\}');

Set<String> _messageKeys(Map<String, dynamic> arb) =>
    arb.keys.where((key) => !key.startsWith('@')).toSet();

Set<String> _placeholders(Object? value) {
  if (value is! String) return const {};
  return _placeholderPattern
      .allMatches(value)
      .map((match) => match.group(1)!)
      .toSet();
}

void main() {
  final l10nDirectory = Directory('lib/l10n');
  final templateFile = File('${l10nDirectory.path}/app_en.arb');
  final template =
      jsonDecode(templateFile.readAsStringSync()) as Map<String, dynamic>;
  final templateKeys = _messageKeys(template);

  final localeFiles =
      l10nDirectory
          .listSync()
          .whereType<File>()
          .where(
            (file) =>
                file.path.endsWith('.arb') &&
                file.path != templateFile.path,
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  test('every locale has the complete English message set', () {
    expect(localeFiles, isNotEmpty);

    for (final file in localeFiles) {
      final locale =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final localeKeys = _messageKeys(locale);

      expect(
        localeKeys.difference(templateKeys),
        isEmpty,
        reason: '${file.path} contains keys that are not in app_en.arb',
      );
      expect(
        templateKeys.difference(localeKeys),
        isEmpty,
        reason: '${file.path} is missing translated messages',
      );
    }
  });

  test('every translation preserves the template placeholders', () {
    for (final file in localeFiles) {
      final locale =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      for (final key in templateKeys) {
        expect(
          _placeholders(locale[key]),
          _placeholders(template[key]),
          reason: '${file.path}: placeholder mismatch in "$key"',
        );
      }
    }
  });

  test('ARB locale metadata matches each file name', () {
    for (final file in [templateFile, ...localeFiles]) {
      final arb =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final fileName = file.uri.pathSegments.last;
      final expectedLocale = fileName
          .substring('app_'.length, fileName.length - '.arb'.length);

      expect(
        arb['@@locale'],
        expectedLocale,
        reason: '${file.path} has incorrect @@locale metadata',
      );
    }
  });
}
