import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:fasting_app/shared/widgets/premium_promo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(SubscriptionState state) {
  return ProviderScope(
    overrides: [
      subscriptionProvider.overrideWith(
        (ref) => SubscriptionNotifier(initialState: state),
      ),
    ],
    child: const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: PremiumPromoCard()),
    ),
  );
}

void main() {
  testWidgets('shows a clear premium entry point for free users', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const SubscriptionState()));

    expect(find.text('Upgrade to Premium'), findsOneWidget);
    expect(find.text('Every fasting plan, with no ads'), findsOneWidget);
  });

  testWidgets('hides the upsell for premium users', (tester) async {
    await tester.pumpWidget(
      _app(const SubscriptionState(isPremium: true)),
    );

    expect(find.text('Upgrade to Premium'), findsNothing);
  });
}
