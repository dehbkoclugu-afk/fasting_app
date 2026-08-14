import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:fasting_app/features/paywall/screens/paywall_screen.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:fasting_app/shared/widgets/gradient_button.dart';

Package _package(
  String identifier,
  PackageType type,
  double price,
  String priceString,
) {
  return Package(
    identifier,
    type,
    StoreProduct(identifier, identifier, identifier, price, priceString, 'TRY'),
    const PresentedOfferingContext('default', null, null),
  );
}

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
      home: PaywallScreen(),
    ),
  );
}

void main() {
  final monthly = _package(
    r'$rc_monthly',
    PackageType.monthly,
    99.99,
    '₺99,99',
  );
  final annual = _package(r'$rc_annual', PackageType.annual, 499.99, '₺499,99');
  final custom = _package('premium_pro', PackageType.custom, 149.99, '₺149,99');

  testWidgets('renders an enabled purchase button for the loaded packages', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(SubscriptionState(availablePackages: [monthly, annual])),
    );
    await tester.pump();

    expect(find.text('₺99,99'), findsOneWidget);
    expect(find.text('₺499,99'), findsOneWidget);

    final button = tester.widget<GradientButton>(find.byType(GradientButton));
    expect(button.text, 'Continue');
    expect(button.onPressed, isNotNull);
  });

  testWidgets('sells packages with a custom package type', (tester) async {
    // Regression: matching strictly on monthly/annual/lifetime left offerings
    // with custom identifiers unbuyable.
    await tester.pumpWidget(
      _app(SubscriptionState(availablePackages: [custom])),
    );
    await tester.pump();

    expect(find.text('₺149,99'), findsOneWidget);
    expect(
      tester.widget<GradientButton>(find.byType(GradientButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('shows the yearly plan as preselected with its savings', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(SubscriptionState(availablePackages: [monthly, annual])),
    );
    await tester.pump();

    // 499.99/12 = 41.67 a month against a 99.99 monthly plan.
    expect(find.text('₺41,67 / month'), findsOneWidget);
    expect(find.text('Save 58%'), findsOneWidget);
  });

  testWidgets('lays out on a small screen at a large text scale', (
    tester,
  ) async {
    // Regression: the plan row used CrossAxisAlignment.stretch inside a scroll
    // view, which threw "BoxConstraints forces an infinite height" and blanked
    // out everything below the feature list — including the purchase button.
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.3)),
        child: _app(SubscriptionState(availablePackages: [monthly, annual])),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(
      tester.widget<GradientButton>(find.byType(GradientButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('offers a retry instead of a dead button when no products load', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const SubscriptionState()));
    await tester.pump();

    final button = tester.widget<GradientButton>(find.byType(GradientButton));
    expect(button.text, 'Try again');
    expect(button.onPressed, isNotNull);
  });
}
