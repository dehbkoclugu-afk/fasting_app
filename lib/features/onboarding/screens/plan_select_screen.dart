import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../profile/providers/settings_provider.dart';
import '../../paywall/providers/subscription_provider.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../widgets/onboarding_progress.dart';

class PlanSelectScreen extends ConsumerStatefulWidget {
  const PlanSelectScreen({super.key});

  @override
  ConsumerState<PlanSelectScreen> createState() => _PlanSelectScreenState();
}

class _PlanSelectScreenState extends ConsumerState<PlanSelectScreen> {
  String _selectedPlanId = '16_8';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgress(currentStep: 2),
              const SizedBox(height: 24),

              Text(
                l10n.onboarding_selectPlan,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboarding_selectPlanDesc,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: ListView.separated(
                  itemCount: FastingPlans.all.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final plan = FastingPlans.all[index];
                    final isSelected = _selectedPlanId == plan.id;
                    final isPremium = ref.watch(isPremiumProvider);
                    final isLocked = plan.isPremium && !isPremium;

                    return InkWell(
                      borderRadius: AppSpacing.borderRadiusLg,
                      onTap: () {
                        if (isLocked) {
                          context.push('/paywall');
                          return;
                        }
                        HapticFeedback.selectionClick();
                        setState(() => _selectedPlanId = plan.id);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isLocked
                                  ? theme.colorScheme.onSurface.withValues(
                                    alpha: 0.02,
                                  )
                                  : isSelected
                                  ? AppColors.primary.withValues(alpha: 0.08)
                                  : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.03,
                                  ),
                          borderRadius: AppSpacing.borderRadiusLg,
                          border: Border.all(
                            color:
                                isSelected && !isLocked
                                    ? AppColors.primary
                                    : theme.colorScheme.onSurface.withValues(
                                      alpha: 0.08,
                                    ),
                            width: isSelected && !isLocked ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color:
                                    isLocked
                                        ? theme.colorScheme.onSurface
                                            .withValues(alpha: 0.04)
                                        : isSelected
                                        ? AppColors.primary.withValues(
                                          alpha: 0.15,
                                        )
                                        : theme.colorScheme.onSurface
                                            .withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  plan.shortName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        isLocked
                                            ? theme.colorScheme.onSurface
                                                .withValues(alpha: 0.3)
                                            : isSelected
                                            ? AppColors.primary
                                            : theme.colorScheme.onSurface
                                                .withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        plan.name,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  isLocked
                                                      ? theme
                                                          .colorScheme
                                                          .onSurface
                                                          .withValues(
                                                            alpha: 0.4,
                                                          )
                                                      : null,
                                            ),
                                      ),
                                      if (isLocked) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                AppColors.primary,
                                                AppColors.secondary,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Text(
                                            'PRO',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${plan.fastingHours}s oruç · ${plan.eatingHours}s yemek',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(
                                            alpha: isLocked ? 0.3 : 0.5,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    plan.description(l10n),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(
                                            alpha: isLocked ? 0.25 : 0.4,
                                          ),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isLocked)
                              Icon(
                                Icons.lock_outline,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.3,
                                ),
                                size: 20,
                              )
                            else if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              GradientButton(
                text: l10n.onboarding_next,
                onPressed: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setSelectedPlan(_selectedPlanId);
                  context.go('/onboarding/body-info');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
