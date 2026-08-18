import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('editorial artwork folders are bundled and every referenced asset exists', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('- assets/images/editorial/'));
    expect(pubspec, contains('- assets/images/editorial/v2/'));
    expect(pubspec, contains('- assets/images/editorial/v3/'));
    expect(pubspec, contains('- assets/images/editorial/v4/'));

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
    }
  });

  test('manual meal entry offers at least twelve visual quick meals', () {
    final quickMealAssets = Directory('assets/images/editorial/v4/quick')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.webp'));

    expect(quickMealAssets.length, greaterThanOrEqualTo(12));
  });
}
