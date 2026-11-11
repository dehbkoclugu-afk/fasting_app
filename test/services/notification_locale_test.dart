import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:fasting_app/services/notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unsupported device language falls back to English', () {
    expect(resolveNotificationLocale('zz-ZZ').languageCode, 'en');
  });

  test('Norwegian device codes reach the Norwegian text', () {
    expect(resolveNotificationLocale('nb-NO').languageCode, 'no');
    expect(resolveNotificationLocale('nn').languageCode, 'no');
  });

  test('device languages the app lacks never throw at lookup', () {
    for (final tag in ['el', 'bg', 'nb-NO', 'zz-ZZ']) {
      expect(
        () => lookupAppLocalizations(resolveNotificationLocale(tag)),
        returnsNormally,
        reason: tag,
      );
    }
  });

  test('supported language survives an unsupported region tag', () {
    expect(resolveNotificationLocale('tr-XX').languageCode, 'tr');
  });
}
