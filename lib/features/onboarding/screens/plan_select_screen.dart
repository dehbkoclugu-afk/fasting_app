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
              OnboardingProgress(
                currentStep: 2,
                onBack: () => context.go('/onboarding/goals'),
              ),
              const SizedBox(height: 24),

              EditorialScreenHero(
                assetPath: 'assets/images/editorial/v3/plan-clock-16-8.webp',
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
                            assetPath: _planArtwork(plan.id),
                            height: 158,
                            borderRadius: 17,
                            variant: FastingArtVariant.bare,
                            semanticLabel: plan.name,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: theme.brightness == Brightness.dark
                                      ? const [Colors.transparent, Color(0xF20F1424)]
                                      : [
                                          Colors.transparent,
                                          theme.colorScheme.surface.withValues(alpha: .96),
                                        ],
                                  stops: const [.28, 1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (isLocked) ...[
                                            _proBadge(),
                                            const SizedBox(width: 7),
                                          ],
                                          Icon(
                                            isLocked
                                                ? Icons.lock_outline
                                                : isSelected
                                                    ? Icons.check_circle
                                                    : Icons.circle_outlined,
                                            color: isSelected && !isLocked
                                                ? AppColors.primary
                                                : fastingArtForeground(context),
                                            size: 23,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${plan.shortName}  •  ${plan.name}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme.textTheme.titleMedium?.copyWith(
                                                  color: fastingArtForeground(context),
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                plan.description(l10n),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme.textTheme.bodySmall?.copyWith(
                                                  color: fastingArtMutedForeground(context),
                                                  height: 1.25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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

  String _planArtwork(String id) => switch (id) {
    '12_12' => 'assets/images/editorial/v3/plan-clock-12-12.webp',
    '16_8' => 'assets/images/editorial/v3/plan-clock-16-8.webp',
    '18_6' => 'assets/images/editorial/v3/plan-clock-18-6.webp',
    '20_4' => 'assets/images/editorial/v3/plan-clock-20-4.webp',
    'omad' => 'assets/images/editorial/v3/plan-clock-omad.webp',
    '5_2' => 'assets/images/editorial/v3/plan-clock-5-2.webp',
    'eat_stop_eat' => 'assets/images/editorial/v3/plan-clock-ese.webp',
    _ => 'assets/images/editorial/v3/plan-clock-warrior.webp',
  };

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
