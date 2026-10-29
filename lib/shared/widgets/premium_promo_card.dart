import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../features/paywall/providers/subscription_provider.dart';
import '../../services/admob_service.dart';

/// A high-visibility, value-first entry point to the paywall.
///
/// The copy is driven by the actual store product. We only mention a free
/// trial when RevenueCat returns a zero-price introductory period, so users who
/// are not offered a trial never see a misleading promise.
class PremiumPromoCard extends ConsumerWidget {
  const PremiumPromoCard({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscription = ref.watch(subscriptionProvider);
    if (subscription.isPremium) return const SizedBox.shrink();

    final trialDays = _bestTrialDays(subscription.availablePackages);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final title =
        trialDays == null
            ? l10n.profile_upgradePremium
            : l10n.paywall_freeTrialDays(trialDays);

    return Semantics(
      button: true,
      label: title,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/paywall'),
          borderRadius: BorderRadius.circular(22),
          child: Ink(
            padding: EdgeInsets.all(compact ? 14 : 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: .18),
                  AppColors.secondary.withValues(alpha: .10),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: .30),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(compact ? 8 : 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    PhosphorIcons.crown(PhosphorIconsStyle.fill),
                    color: Colors.white,
                    size: compact ? 20 : 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        // Builds without ad units have no ads to remove.
                        AdmobService.hasAdUnits
                            ? l10n.profile_premiumDesc
                            : l10n.paywall_allPlansDesc,
                        maxLines: compact ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  PhosphorIcons.caretRight(),
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? _bestTrialDays(List<Package> packages) {
    int? best;
    for (final package in packages) {
      final intro = package.storeProduct.introductoryPrice;
      if (intro == null || intro.price > 0) continue;
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
      if (days > 0 && (best == null || days > best)) best = days;
    }
    return best;
  }
}
