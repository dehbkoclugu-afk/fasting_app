import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
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

              EditorialScreenHero(
                assetPath: 'assets/images/editorial/goals-path.webp',
                title: l10n.onboarding_selectPlan,
                subtitle: l10n.onboarding_selectPlanDesc,
                icon: Icons.schedule_outlined,
                height: 124,
              ),
              const SizedBox(height: 18),

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
                        padding: EdgeInsets.all(
                          isSelected && !isLocked ? 2 : 1,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected && !isLocked
                              ? AppColors.primary
                              : theme.dividerColor,
                          borderRadius: AppSpacing.borderRadiusLg,
                        ),
                        child: Opacity(
                          opacity: isLocked ? .58 : 1,
                          child: FastingArtSlot(
                            assetPath: _planArtwork(plan.fastingHours),
                            height: 102,
                            borderRadius: 17,
                            variant: FastingArtVariant.row,
                            semanticLabel: plan.name,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: .3),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: .16),
                                      ),
                                    ),
                                    child: Text(
                                      plan.shortName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                plan.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme.textTheme.titleSmall
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                              ),
                                            ),
                                            if (isLocked) ...[
                                              const SizedBox(width: 6),
                                              _proBadge(),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          '${plan.fastingHours}s oruç · ${plan.eatingHours}s yemek',
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: Colors.white.withValues(alpha: .76),
                                          ),
                                        ),
                                        Text(
                                          plan.description(l10n),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: Colors.white.withValues(alpha: .58),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    isLocked
                                        ? Icons.lock_outline
                                        : isSelected
                                        ? Icons.check_circle
                                        : Icons.chevron_right,
                                    color: Colors.white,
                                    size: isSelected ? 24 : 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
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

  String _planArtwork(int fastingHours) {
    if (fastingHours <= 12) {
      return 'assets/images/editorial/v2/plan-12-12.webp';
    }
    if (fastingHours <= 16) {
      return 'assets/images/editorial/v2/plan-16-8.webp';
    }
    if (fastingHours <= 18) {
      return 'assets/images/editorial/v2/plan-18-6.webp';
    }
    if (fastingHours <= 20) {
      return 'assets/images/editorial/v2/plan-20-4.webp';
    }
    return 'assets/images/editorial/v2/plan-omad.webp';
  }

  Widget _proBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      'PRO',
      style: TextStyle(
        color: Colors.white,
        fontSize: 9,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
