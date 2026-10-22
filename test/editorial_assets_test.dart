import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('editorial artwork folders are bundled and every referenced asset exists', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('- assets/images/editorial/'));
    expect(pubspec, contains('- assets/images/editorial/v2/'));
    expect(pubspec, contains('- assets/images/editorial/v3/'));
    expect(pubspec, contains('- assets/images/editorial/v4/'));
    expect(pubspec, contains('- assets/images/editorial/v4/quick/'));
    expect(pubspec, contains('- assets/images/editorial/v5/'));
    expect(pubspec, contains('- assets/images/editorial/v6/'));

    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    final assetPattern = RegExp(r"assets/images/editorial/[A-Za-z0-9_./-]+\.(?:webp|png|jpg)");
    final referencedAssets = <String>{
      for (final file in dartFiles)
        ...assetPattern
            .allMatches(file.readAsStringSync())
            .map((match) => match.group(0)!),
    };

    expect(referencedAssets, isNotEmpty);
    for (final asset in referencedAssets) {
      expect(File(asset).existsSync(), isTrue, reason: 'Missing artwork: $asset');
      expect(File(asset).lengthSync(), greaterThan(0), reason: 'Empty artwork: $asset');

      final extensionIndex = asset.lastIndexOf('.');
      final lightAsset = '${asset.substring(0, extensionIndex)}-light'
          '${asset.substring(extensionIndex)}';
      expect(
        File(lightAsset).existsSync(),
        isTrue,
        reason: 'Missing light-mode artwork: $lightAsset',
      );
      expect(
        File(lightAsset).lengthSync(),
        greaterThan(0),
        reason: 'Empty light-mode artwork: $lightAsset',
      );
    }
  });

  test('every metabolic phase has a physical light and dark artwork pair', () {
    for (final phase in [
      'anabolic',
      'catabolic',
      'fat-burning',
      'ketosis',
      'autophagy',
    ]) {
      for (final suffix in ['', '-light']) {
        final asset = File(
          'assets/images/editorial/v5/phase-$phase$suffix.webp',
        );
        expect(asset.existsSync(), isTrue, reason: 'Missing ${asset.path}');
        expect(asset.lengthSync(), greaterThan(0), reason: 'Empty ${asset.path}');
      }
    }
  });

  test('manual meal entry offers at least twelve visual quick meals', () {
    final quickMealAssets = Directory('assets/images/editorial/v4/quick')
        .listSync()
        .whereType<File>()
        .where(
          (file) =>
              file.path.endsWith('.webp') &&
              !file.path.endsWith('-light.webp'),
        );

    expect(quickMealAssets.length, greaterThanOrEqualTo(12));
  });
}
