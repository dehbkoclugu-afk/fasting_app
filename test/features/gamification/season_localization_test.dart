import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('season countdown follows English and Russian plural rules', () async {
    final en = await AppLocalizations.delegate.load(const Locale('en'));
    expect(en.game_stepsToSeal(1), '1 step to seal');
    expect(en.game_stepsToSeal(5), '5 steps to seal');
    final ru = await AppLocalizations.delegate.load(const Locale('ru'));
    expect(ru.game_stepsToSeal(1), '1 шаг до печати');
    expect(ru.game_stepsToSeal(2), '2 шага до печати');
    expect(ru.game_stepsToSeal(5), '5 шагов до печати');
    expect(ru.game_stepsToSeal(21), '21 шаг до печати');
  });

  test('every supported locale supplies the countdown', () async {
    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = await AppLocalizations.delegate.load(locale);
      for (final count in [0, 1, 2, 3, 5, 11, 21]) {
        expect(l10n.game_stepsToSeal(count), isNotEmpty);
      }
    }
  });
}
