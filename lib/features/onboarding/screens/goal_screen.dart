import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
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
      },
      {
        'id': 'health',
        'title': l10n.onboarding_goalHealth,
        'icon': Icons.favorite_outline,
        'desc': l10n.onboarding_goalHealthDesc,
      },
      {
        'id': 'energy',
        'title': l10n.onboarding_goalEnergy,
        'icon': Icons.bolt_outlined,
        'desc': l10n.onboarding_goalEnergyDesc,
      },
      {
        'id': 'mental',
        'title': l10n.onboarding_goalMental,
        'icon': Icons.psychology_outlined,
        'desc': l10n.onboarding_goalMentalDesc,
      },
      {
        'id': 'longevity',
        'title': l10n.onboarding_goalLongevity,
        'icon': Icons.spa_outlined,
        'desc': l10n.onboarding_goalLongevityDesc,
      },
      {
        'id': 'discipline',
        'title': l10n.onboarding_goalDiscipline,
        'icon': Icons.flag_outlined,
        'desc': l10n.onboarding_goalDisciplineDesc,
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

              Text(
                l10n.onboarding_selectGoal,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboarding_selectGoalDesc,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children:
                      goals.map((goal) {
                        final isSelected = _selectedGoals.contains(
                          goal['id'] as String,
                        );
                        return InkWell(
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
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.primary.withValues(alpha: 0.1)
                                      : theme.colorScheme.onSurface.withValues(
                                        alpha: 0.03,
                                      ),
                              borderRadius: AppSpacing.borderRadiusLg,
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : theme.colorScheme.onSurface
                                            .withValues(alpha: 0.08),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  goal['icon'] as IconData,
                                  color:
                                      isSelected
                                          ? AppColors.primary
                                          : theme.colorScheme.onSurface
                                              .withValues(alpha: 0.5),
                                  size: 28,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  goal['title'] as String,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isSelected ? AppColors.primary : null,
                                  ),
                                ),
                                Text(
                                  goal['desc'] as String,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.4),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
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
