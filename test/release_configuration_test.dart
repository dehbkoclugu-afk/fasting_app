import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('production release configuration', () {
    test('Android release declares network and notification permissions', () {
      final manifest = File(
        'android/app/src/main/AndroidManifest.xml',
      ).readAsStringSync();

      expect(manifest, contains('android.permission.INTERNET'));
      expect(manifest, contains('android.permission.POST_NOTIFICATIONS'));
    });

    test('pull requests do not trigger duplicate push and PR builds', () {
      final workflow = File(
        '.github/workflows/android-build.yml',
      ).readAsStringSync();

      expect(workflow, contains("branches: ['main']"));
      expect(workflow, isNot(contains("branches: ['**']")));
    });

    test('signing material and release secrets stay ignored', () {
      final gitignore = File('.gitignore').readAsStringSync();

      expect(gitignore, contains('/android/key.properties'));
      expect(gitignore, contains('*.jks'));
      expect(gitignore, contains('*.keystore'));
      expect(gitignore, contains('/release.json'));
    });
  });
}
