import 'package:fasting_app/core/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('localized journey formatting', () {
    test('uses the locale-specific percent pattern', () {
      expect(Formatters.formatPercentage(0, locale: 'en'), '0%');
      expect(Formatters.formatPercentage(0, locale: 'tr'), '%0');
    });

    test('uses translated duration labels without reading the device locale', () {
      expect(
        Formatters.formatShortDuration(
          240,
          locale: 'en',
          hoursLabel: 'hours',
          minutesLabel: 'minutes',
        ),
        '4 hours',
      );
      expect(
        Formatters.formatShortDuration(
          250,
          locale: 'tr',
          hoursLabel: 'saat',
          minutesLabel: 'dakika',
        ),
        '4 saat 10 dakika',
      );
    });
  });
}
