import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/app.dart';

void main() {
  testWidgets('App builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: FastingApp(showOnboarding: true)),
    );
    expect(find.text('FastTrack'), findsOneWidget);
  });
}
