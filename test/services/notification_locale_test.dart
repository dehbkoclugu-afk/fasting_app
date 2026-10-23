import 'package:fasting_app/services/notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unsupported device language falls back to English', () {
    expect(resolveNotificationLocale('zz-ZZ').languageCode, 'en');
  });

  test('supported language survives an unsupported region tag', () {
    expect(resolveNotificationLocale('tr-XX').languageCode, 'tr');
  });
}
