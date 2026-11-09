import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/app.dart';

void main() {
  // Supply an empty image manifest for this startup smoke test.
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
          final key = utf8.decode(message!.buffer.asUint8List());
          // Asset images look themselves up here to pick a resolution.
          if (key == 'AssetManifest.bin') {
            return const StandardMessageCodec().encodeMessage(<String, Object>{});
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
