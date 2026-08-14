import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/app.dart';

void main() {
  // google_fonts reads AssetManifest.json to find bundled fonts, and the test
  // binding serves no assets, so building the app threw before it could be
  // pumped. An empty manifest makes it fall back to the platform font.
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
          final key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'AssetManifest.json') {
            return ByteData.sublistView(utf8.encode('{}'));
          }
          return null;
        });
  });

  testWidgets('App builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: FastingApp(showOnboarding: true)),
    );
    expect(find.text('FastTrack'), findsOneWidget);
  });
}
