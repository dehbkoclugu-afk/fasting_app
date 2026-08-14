import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../providers/subscription_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  int _selectedPlan = 1;

  static const _privacyUrlEnv = String.fromEnvironment('PRIVACY_POLICY_URL');
  static const _termsUrlEnv = String.fromEnvironment('TERMS_OF_USE_URL');
  // Fallback so the required legal links always render even if the build-time
  // dart-define is empty. App Review rejects a subscription paywall without them.
  String get _privacyUrl => _privacyUrlEnv.isNotEmpty
      ? _privacyUrlEnv
      : 'https://dehbkoclugu-afk.github.io/privacy/';
  String get _termsUrl =>
      _termsUrlEnv.isNotEmpty ? _termsUrlEnv : 'https://dehbkoclugu-afk.github.io/terms/';
  static const _packageTypes = [
    PackageType.monthly,
    PackageType.annual,
    PackageType.lifetime,
  ];

  Package? _package(SubscriptionState state, int index) {
    for (final package in state.availablePackages) {
      if (package.packageType == _packageTypes[index]) return package;
    }
    return null;
  }

  Future<void> _purchase() async {
    final package = _package(ref.read(subscriptionProvider), _selectedPlan);
    if (package == null) return;
    final success = await ref
        .read(subscriptionProvider.notifier)
        .purchase(package);
    if (success && mounted) Navigator.pop(context);
  }

  Future<void> _restore() async {
    final success = await ref.read(subscriptionProvider.notifier).restore();
    if (!mounted || !success) return;
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
    _ => l10n.paywall_purchaseFailed,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(subscriptionProvider);

    if (state.isPremium) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    PhosphorIconsFill.crown,
                    color: AppColors.primary,
                    size: 56,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.paywall_premiumActive,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.paywall_premiumActiveDesc),
                  const SizedBox(height: 28),
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

    final plans = [
      (l10n.paywall_monthly, l10n.paywall_monthly),
      (l10n.paywall_yearly, l10n.paywall_yearly),
      (l10n.paywall_lifetime, l10n.paywall_once),
    ];
    final selectedPackage = _package(state, _selectedPlan);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Column(
                  children: [
                    const Icon(
                      PhosphorIconsFill.crown,
                      color: AppColors.primary,
                      size: 44,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.paywall_title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.paywall_subtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: .6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _feature(
                      context,
                      PhosphorIcons.timer(),
                      l10n.paywall_allPlans,
                    ),
                    _feature(
                      context,
                      PhosphorIcons.chartBar(),
                      l10n.paywall_advancedStats,
                    ),
                    _feature(
                      context,
                      PhosphorIcons.forkKnife(),
                      l10n.paywall_mealPlanner,
                    ),
                    _feature(
                      context,
                      PhosphorIcons.sparkle(),
                      l10n.paywall_themes,
                    ),
                    _feature(
                      context,
                      PhosphorIcons.bellRinging(),
                      l10n.paywall_noAds,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(plans.length, (index) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 0 : 6),
                            child: _planCard(
                              context,
                              index,
                              plans[index].$1,
                              _package(
                                    state,
                                    index,
                                  )?.storeProduct.priceString ??
                                  '—',
                              plans[index].$2,
                              badge: index == 1 ? l10n.paywall_bestValue : null,
                            ),
                          ),
                        );
                      }),
                    ),
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          _errorText(l10n, state.errorMessage!),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    if (state.availablePackages.isEmpty && !state.isLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          l10n.paywall_productsUnavailable,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: .6,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        l10n.paywall_autoRenewInfo,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: .55,
                          ),
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      text:
                          state.isLoading
                              ? l10n.paywall_processing
                              : l10n.paywall_continue,
                      isLoading: state.isLoading,
                      onPressed:
                          selectedPackage == null || state.isLoading
                              ? null
                              : _purchase,
                    ),
                    const SizedBox(height: 6),
                    TextButton(
                      onPressed: state.isLoading ? null : _restore,
                      child: Text(l10n.paywall_restore),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        if (_privacyUrl.isNotEmpty)
                          TextButton(
                            onPressed: () => _open(_privacyUrl),
                            child: Text(l10n.profile_privacyPolicy),
                          ),
                        if (_termsUrl.isNotEmpty)
                          TextButton(
                            onPressed: () => _open(_termsUrl),
                            child: Text(l10n.paywall_terms),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feature(BuildContext context, IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
        const Icon(Icons.check_circle, color: AppColors.success, size: 20),
      ],
    ),
  );

  Widget _planCard(
    BuildContext context,
    int index,
    String title,
    String price,
    String period, {
    String? badge,
  }) {
    final selected = _selectedPlan == index;
    final theme = Theme.of(context);
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        borderRadius: AppSpacing.borderRadiusMd,
        onTap: () => setState(() => _selectedPlan = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withValues(alpha: .1) : null,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(
              color:
                  selected
                      ? AppColors.primary
                      : theme.colorScheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 18,
                child:
                    badge == null
                        ? null
                        : Text(
                          badge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
              ),
              Text(title, textAlign: TextAlign.center, maxLines: 2),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  price,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: selected ? AppColors.primary : null,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                period,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: .55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
