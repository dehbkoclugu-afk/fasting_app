import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../providers/subscription_provider.dart';
import '../../../services/revenue_cat_service.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  int _selectedPlan = 1; // 0: haftalık, 1: yıllık, 2: aylık

  final _productIds = [
    RevenueCatService.weeklyProductId,
    RevenueCatService.yearlyProductId,
    RevenueCatService.monthlyProductId,
  ];

  Future<void> _handlePurchase() async {
    final productId = _productIds[_selectedPlan];
    final success = await ref
        .read(subscriptionProvider.notifier)
        .purchaseByProductId(productId);
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _handleRestore() async {
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final success = await ref.read(subscriptionProvider.notifier).restore();
    if (success && mounted) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Satın almalar geri yüklendi!'),
          backgroundColor: AppColors.success,
        ),
      );
      nav.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final subState = ref.watch(subscriptionProvider);

    // If already premium, show success
    if (subState.isPremium) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Icon(
                      PhosphorIconsFill.crown,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.paywall_premiumActive,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.paywall_premiumActiveDesc,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 32),
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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              // Close button
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ),
              const SizedBox(height: 8),

              // Crown icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  PhosphorIconsFill.crown,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                l10n.paywall_title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.paywall_subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 32),

              // Features
              _buildFeature(context, PhosphorIcons.timer(), l10n.paywall_allPlans),
              _buildFeature(
                  context, PhosphorIcons.chartBar(), l10n.paywall_advancedStats),
              _buildFeature(
                  context, PhosphorIcons.forkKnife(), l10n.paywall_mealPlanner),
              _buildFeature(
                  context, PhosphorIcons.heartbeat(), l10n.paywall_healthKit),
              _buildFeature(
                  context, PhosphorIcons.palette(), l10n.paywall_themes),
              _buildFeature(context, PhosphorIcons.bellRinging(), l10n.paywall_noAds),

              const Spacer(),

              // Error message
              if (subState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    subState.errorMessage!,
                    style: TextStyle(color: Colors.red.shade400, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Plans
              Row(
                children: [
                  _buildPlanCard(context, 0, l10n.paywall_weekly, '₺29.99', '/hafta'),
                  const SizedBox(width: 8),
                  _buildPlanCard(context, 1, l10n.paywall_yearly, '₺149.99', '/yıl',
                      badge: l10n.paywall_bestValue),
                  const SizedBox(width: 8),
                  _buildPlanCard(context, 2, l10n.paywall_monthly, '₺49.99', '/ay'),
                ],
              ),
              const SizedBox(height: 20),

              GradientButton(
                text: subState.isLoading
                    ? 'İşleniyor...'
                    : l10n.paywall_freeTrial,
                isLoading: subState.isLoading,
                onPressed: () {
                  if (subState.isLoading) return;
                  _handlePurchase();
                },
                colors: [AppColors.primary, AppColors.secondary],
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: subState.isLoading
                    ? null
                    : () => _handleRestore(),
                child: Text(
                  l10n.paywall_restore,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Text(text, style: theme.textTheme.bodyMedium),
          const Spacer(),
          const Icon(Icons.check_circle, color: AppColors.success, size: 20),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    int index,
    String title,
    String price,
    String period, {
    String? badge,
  }) {
    final isSelected = _selectedPlan == index;
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPlan = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              if (badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              Text(
                title,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.primary : null,
                ),
              ),
              Text(
                period,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
