import 'dart:convert';

import 'package:fasting_app/core/theme/app_theme.dart';
import 'package:fasting_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Inter weights are bundled and load without a font download', () async {
    final manifest =
        jsonDecode(await rootBundle.loadString('FontManifest.json'))
            as List<dynamic>;
    final inter = manifest.cast<Map<String, dynamic>>().singleWhere(
      (family) => family['family'] == 'Inter',
    );
    final fonts = (inter['fonts'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    expect(
      fonts.map((font) => font['weight']),
      orderedEquals([400, 500, 600, 700, 800, 900]),
    );
    final loader = FontLoader('Inter');
    for (final font in fonts) {
      final data = await rootBundle.load(font['asset'] as String);
      // TrueType sfnt header; reject missing files or an HTML download response.
      expect(data.getUint32(0), 0x00010000);
      loader.addFont(Future.value(data));
    }
    await loader.load();
    expect(
      await rootBundle.loadString('assets/fonts/OFL.txt'),
      contains('SIL OPEN FONT LICENSE'),
    );
    expect(AppTheme.light.textTheme.bodyMedium!.fontFamily, 'Inter');
    expect(AppTheme.dark.textTheme.bodyMedium!.fontFamily, 'Inter');
    expect(AppTypography.timerLarge(Colors.white).fontFamily, 'Inter');
    expect(AppTypography.timerMedium(Colors.white).fontFamily, 'Inter');
    expect(AppTypography.timerSmall(Colors.white).fontFamily, 'Inter');
  });
}
