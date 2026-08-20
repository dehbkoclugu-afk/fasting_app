import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../widgets/onboarding_progress.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final _selectedGoals = <String>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final goals = [
      {
        'id': 'weight',
        'title': l10n.onboarding_goalWeight,
        'icon': Icons.monitor_weight_outlined,
        'desc': l10n.onboarding_goalWeightDesc,
        'art': 'assets/images/editorial/v2/goal-weight.webp',
      },
      {
        'id': 'health',
        'title': l10n.onboarding_goalHealth,
        'icon': Icons.favorite_outline,
        'desc': l10n.onboarding_goalHealthDesc,
        'art': 'assets/images/editorial/v2/goal-health.webp',
      },
      {
        'id': 'energy',
        'title': l10n.onboarding_goalEnergy,
        'icon': Icons.bolt_outlined,
        'desc': l10n.onboarding_goalEnergyDesc,
        'art': 'assets/images/editorial/v2/goal-energy.webp',
      },
      {
        'id': 'mental',
        'title': l10n.onboarding_goalMental,
        'icon': Icons.psychology_outlined,
        'desc': l10n.onboarding_goalMentalDesc,
        'art': 'assets/images/editorial/v2/goal-focus.webp',
      },
      {
        'id': 'longevity',
        'title': l10n.onboarding_goalLongevity,
        'icon': Icons.spa_outlined,
        'desc': l10n.onboarding_goalLongevityDesc,
        'art': 'assets/images/editorial/v2/goal-longevity.webp',
      },
      {
        'id': 'discipline',
        'title': l10n.onboarding_goalDiscipline,
        'icon': Icons.flag_outlined,
        'desc': l10n.onboarding_goalDisciplineDesc,
        'art': 'assets/images/editorial/v2/goal-discipline.webp',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgress(currentStep: 1),
              const SizedBox(height: 24),

              EditorialScreenHero(
                assetPath: 'assets/images/editorial/goals-path.webp',
                title: l10n.onboarding_selectGoal,
                subtitle: l10n.onboarding_selectGoalDesc,
                icon: Icons.flag_outlined,
                height: 124,
              ),
              const SizedBox(height: 18),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.18,
                  children:
                      goals.map((goal) {
                        final isSelected = _selectedGoals.contains(
                          goal['id'] as String,
                        );
                        return LayoutBuilder(
                          builder: (context, constraints) => InkWell(
                            borderRadius: AppSpacing.borderRadiusLg,
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() {
                                if (isSelected) {
                                  _selectedGoals.remove(goal['id'] as String);
                                } else {
                                  _selectedGoals.add(goal['id'] as String);
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.all(isSelected ? 2 : 1),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : theme.dividerColor,
                                borderRadius: AppSpacing.borderRadiusLg,
                              ),
                              child: FastingArtSlot(
                                assetPath: goal['art'] as String,
                                height:
                                    constraints.maxHeight -
                                    (isSelected ? 4 : 2),
                                borderRadius: 17,
                                variant: FastingArtVariant.card,
                                semanticLabel: goal['title'] as String,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Stack(
                                    children: [
                                      if (isSelected)
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: theme.colorScheme.primary,
                                            size: 22,
                                          ),
                                        ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              goal['title'] as String,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.titleSmall
                                                  ?.copyWith(
                                                    color:
                                                        fastingArtForeground(
                                                          context,
                                                        ),
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              goal['desc'] as String,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color:
                                                        fastingArtMutedForeground(
                                                          context,
                                                        ),
                                                    fontSize: 10,
                                                    height: 1.15,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              GradientButton(
                text: l10n.onboarding_next,
                onPressed:
                    _selectedGoals.isEmpty
                        ? null
                        : () => context.go('/onboarding/plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
