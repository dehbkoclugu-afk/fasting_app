import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/build_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../../../services/revenue_cat_service.dart';
import '../providers/subscription_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  /// Selected package identifier. Held by identifier rather than list index so
  /// the selection survives the product list arriving or being reloaded.
  String? _selectedId;

  /// The package the CTA will buy: the user's pick, or the best default.
  Package? _selected(SubscriptionState state) {
    final packages = state.availablePackages;
    if (packages.isEmpty) return null;
    for (final package in packages) {
      if (package.identifier == _selectedId) return package;
    }
    return _defaultPackage(packages);
  }

  /// Preselect the annual plan when it exists — it is the plan the pricing is
  /// built around. Otherwise fall back to the longest subscription, then to
  /// whatever the offering actually contains, so the CTA is never dead.
  Package _defaultPackage(List<Package> packages) {
    for (final package in packages) {
      if (package.packageType == PackageType.annual) return package;
    }
    final subscriptions =
        packages.where((p) => p.packageType != PackageType.lifetime).toList();
    if (subscriptions.isNotEmpty) return subscriptions.last;
    return packages.first;
  }

  /// Billing length in months, used for the "per month" line and the savings
  /// badge. Null when the package has no monthly equivalent (lifetime/custom).
  double? _months(Package package) => switch (package.packageType) {
    PackageType.weekly => 12 / 52,
    PackageType.monthly => 1,
    PackageType.twoMonth => 2,
    PackageType.threeMonth => 3,
    PackageType.sixMonth => 6,
    PackageType.annual => 12,
    _ => null,
  };

  double? _monthlyPrice(Package package) {
    final months = _months(package);
    if (months == null || months == 0) return null;
    return package.storeProduct.price / months;
  }

  /// Savings against the cheapest monthly-equivalent plan on the paywall.
  int? _savingsPercent(SubscriptionState state, Package package) {
    final monthly = _monthlyPrice(package);
    if (monthly == null) return null;
    double? baseline;
    for (final other in state.availablePackages) {
      if (other.packageType != PackageType.monthly) continue;
      final price = other.storeProduct.price;
      if (baseline == null || price < baseline) baseline = price;
    }
    if (baseline == null || baseline <= 0) return null;
    final percent = ((1 - monthly / baseline) * 100).round();
    return percent > 0 ? percent : null;
  }

  /// Free trial length in days, when the store product has one attached.
  int? _trialDays(Package package) {
    final intro = package.storeProduct.introductoryPrice;
    if (intro == null || intro.price > 0) return null;
    final unitDays = switch (intro.periodUnit) {
      PeriodUnit.day => 1,
      PeriodUnit.week => 7,
      PeriodUnit.month => 30,
      PeriodUnit.year => 365,
      PeriodUnit.unknown => 0,
    };
    final days =
        unitDays *
        intro.periodNumberOfUnits *
        (intro.cycles > 0 ? intro.cycles : 1);
    return days > 0 ? days : null;
  }

  String _planTitle(AppLocalizations l10n, Package package) => switch (package
      .packageType) {
    PackageType.weekly => l10n.paywall_weekly,
    PackageType.monthly => l10n.paywall_monthly,
    PackageType.annual => l10n.paywall_yearly,
    PackageType.lifetime => l10n.paywall_lifetime,
    // Three/six month and custom packages carry their own store title.
    _ => package.storeProduct.title,
  };

  Future<void> _purchase() async {
    final package = _selected(ref.read(subscriptionProvider));
    if (package == null) return;
    final outcome = await ref
        .read(subscriptionProvider.notifier)
        .purchase(package);
    if (!mounted) return;
    if (outcome == PurchaseOutcome.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.paywall_premiumActive),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    }
    // A cancel is not an error — the paywall just stays open.
  }

  Future<void> _restore() async {
    final outcome = await ref.read(subscriptionProvider.notifier).restore();
    if (!mounted || outcome != RestoreOutcome.success) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.paywall_restoreSuccess),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _open(String value) async {
    final uri = Uri.tryParse(value);
    if (uri != null) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  String _errorText(AppLocalizations l10n, String error) => switch (error) {
    'nothing_to_restore' => l10n.paywall_nothingToRestore,
    'restore_failed' => l10n.paywall_restoreFailed,
    'already_owned' => l10n.paywall_alreadyOwned,
    'store_unavailable' => l10n.paywall_storeUnavailable,
    _ => l10n.paywall_purchaseFailed,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(subscriptionProvider);

    if (state.isPremium) return _premiumActive(context, l10n);

    final selected = _selected(state);
    final trialDays = selected == null ? null : _trialDays(selected);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            _header(context, l10n),
            const SizedBox(height: 24),
            _features(context, l10n),
            const SizedBox(height: 20),
                    if (state.isLoadingProducts &&
                        state.availablePackages.isEmpty)
                      ...List.generate(
                        3,
                        (_) => const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: SkeletonLoader(height: 76),
                        ),
                      )
                    else if (state.hasNoProducts)
                      _unavailable(context, l10n, state)
                    else
                      ...state.availablePackages.map(
                        (package) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _planCard(
                            context,
                            l10n,
                            state,
                            package,
                            isSelected:
                                package.identifier == selected?.identifier,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      selected?.packageType == PackageType.lifetime
                          ? l10n.paywall_once
                          : Platform.isIOS
                          ? l10n.paywall_autoRenewInfo
                          : l10n.paywall_autoRenewInfoPlay,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: .55,
                        ),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 12),
            const SizedBox(height: 4),
            _bottomBar(context, l10n, state, selected, trialDays),
            const SizedBox(height: 12),
          ],
        ),
      ),
      ),
    );
  }

  Widget _premiumActive(BuildContext context, AppLocalizations l10n) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EditorialScreenHero(
                  assetPath: 'assets/images/editorial/v6/premium-orbit.webp',
                  title: l10n.paywall_premiumActive,
                  subtitle: l10n.paywall_premiumActiveDesc,
                  icon: Icons.auto_awesome_outlined,
                  height: 164,
                ),
                const SizedBox(height: 20),
                GradientButton(
                  text: l10n.common_ok,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, AppLocalizations l10n) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final accessibleHeight =
        184.0 + ((textScale - 1).clamp(0.0, 1.0) * 80);
    return EditorialScreenHero(
      assetPath: 'assets/images/editorial/v6/premium-orbit.webp',
      title: l10n.paywall_title,
      subtitle: l10n.paywall_subtitle,
      icon: Icons.auto_awesome_outlined,
      height: accessibleHeight,
    );
  }

  Widget _features(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    // Only what premium actually delivers today: the six locked plans, the
    // AI food scan and the ad-free experience. Nothing else in the app is
    // gated. The scan row is dropped when the build has no Gemini key, so the
    // paywall never sells a feature that build cannot run.
    final features = <(IconData, String, String)>[
      (PhosphorIcons.timer(), l10n.paywall_allPlans, l10n.paywall_allPlansDesc),
      if (BuildConfig.isFoodScanEnabled)
        (
          PhosphorIcons.camera(),
          l10n.paywall_aiFoodScan,
          l10n.paywall_aiFoodScanDesc,
        ),
      (PhosphorIcons.prohibit(), l10n.paywall_noAds, l10n.paywall_noAdsDesc),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.borderRadiusLg,
        color: AppColors.primary.withValues(alpha: .05),
        border: Border.all(color: AppColors.primary.withValues(alpha: .12)),
      ),
      child: Column(
        children: [
          for (final (index, feature) in features.indexed)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == features.length - 1 ? 0 : 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(feature.$1, color: AppColors.primary, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature.$2,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          feature.$3,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: .6,
                            ),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _unavailable(
    BuildContext context,
    AppLocalizations l10n,
    SubscriptionState state,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            PhosphorIcons.wifiSlash(),
            color: theme.colorScheme.onSurface.withValues(alpha: .5),
            size: 28,
          ),
          const SizedBox(height: 12),
          Text(
            state.isStoreAvailable
                ? l10n.paywall_productsUnavailable
                : l10n.paywall_storeUnavailable,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _planCard(
    BuildContext context,
    AppLocalizations l10n,
    SubscriptionState state,
    Package package, {
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final savings = _savingsPercent(state, package);
    final monthly = _monthlyPrice(package);
    final months = _months(package);
    final trialDays = _trialDays(package);

    final subtitle = switch (package.packageType) {
      PackageType.lifetime => l10n.paywall_once,
      _ when trialDays != null => l10n.paywall_freeTrialDays(trialDays),
      _ when monthly != null && months != null && months > 1 => l10n
          .paywall_perMonth(
            _formatPrice(monthly, package.storeProduct.priceString),
          ),
      _ => package.storeProduct.description,
    };

    return Semantics(
      selected: isSelected,
      button: true,
      child: InkWell(
        borderRadius: AppSpacing.borderRadiusLg,
        onTap: () => setState(() => _selectedId = package.identifier),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withValues(alpha: .08) : null,
            borderRadius: AppSpacing.borderRadiusLg,
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.primary
                      : theme.colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color:
                        isSelected
                            ? AppColors.primary
                            : theme.colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                child:
                    isSelected
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _planTitle(l10n, package),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (savings != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              l10n.paywall_savePercent(savings),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: .6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    package.storeProduct.priceString,
                    maxLines: 1,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isSelected ? AppColors.primary : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomBar(
    BuildContext context,
    AppLocalizations l10n,
    SubscriptionState state,
    Package? selected,
    int? trialDays,
  ) {
    final theme = Theme.of(context);
    final canRetry = state.hasNoProducts;
    final label =
        state.isLoading
            ? l10n.paywall_processing
            : canRetry
            ? l10n.paywall_retry
            : selected == null
            ? l10n.paywall_continue
            : trialDays != null
            ? '${l10n.paywall_startFreeTrial} · ${selected.storeProduct.priceString}'
            : '${_planTitle(l10n, selected)} · ${selected.storeProduct.priceString}';

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                _errorText(l10n, state.errorMessage!),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          GradientButton(
            text: label,
            isLoading: state.isLoading || state.isLoadingProducts,
            colors: const [AppColors.primary, AppColors.secondary],
            onPressed:
                state.isLoading || state.isLoadingProducts
                    ? null
                    : canRetry
                    ? () =>
                        ref.read(subscriptionProvider.notifier).loadProducts()
                    : selected == null
                    ? null
                    : _purchase,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.paywall_secureNote,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .5),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton(
                onPressed: state.isLoading ? null : _restore,
                child: Text(l10n.paywall_restore),
              ),
              TextButton(
                onPressed: () => _open(BuildConfig.privacyPolicyUrl),
                child: Text(l10n.profile_privacyPolicy),
              ),
              TextButton(
                onPressed: () => _open(BuildConfig.termsOfUseUrl),
                child: Text(l10n.paywall_terms),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Renders a derived per-month amount with the same currency formatting the
  /// store used for the full price (e.g. "₺499,99" -> "₺41,67").
  String _formatPrice(double value, String template) {
    // Digits plus grouping separators (some locales group with a space/nbsp).
    final amount = RegExp(
      '\\d[\\d.,\u00A0 ]*\\d|\\d',
    ).firstMatch(template)?.group(0);
    if (amount == null) return value.toStringAsFixed(2);
    // The decimal separator is the last '.' or ',' with exactly two digits
    // after it — everything else in the amount is a grouping separator.
    final decimal = RegExp(r'[.,](?=\d{2}$)').firstMatch(amount)?.group(0);
    final formatted =
        decimal == null
            ? value
                .round()
                .toString() // zero-decimal currency (e.g. ¥, ₩)
            : value.toStringAsFixed(2).replaceFirst('.', decimal);
    return template.replaceFirst(amount, formatted);
  }
}
