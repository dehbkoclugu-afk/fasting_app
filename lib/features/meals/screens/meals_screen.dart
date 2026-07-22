import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../providers/meal_provider.dart';
import '../widgets/add_meal_sheet.dart';
import '../../timer/providers/timer_provider.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealState = ref.watch(mealProvider);
    final timerState = ref.watch(timerProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final isEatingWindow = timerState.status == TimerStatus.idle;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                l10n.meals_title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),

              // Eating window bar
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.meals_eatingWindow,
                          style: theme.textTheme.titleSmall,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (isEatingWindow
                                    ? AppColors.success
                                    : AppColors.primary)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isEatingWindow
                                ? l10n.meals_windowOpen
                                : l10n.meals_windowFasting,
                            style: TextStyle(
                              color:
                                  isEatingWindow
                                      ? AppColors.success
                                      : AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        height: 32,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: Container(
                                color: AppColors.primary.withValues(
                                  alpha: 0.15,
                                ),
                                child: Center(
                                  child: Text(
                                    l10n.meals_fastingWindow('16'),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                color: AppColors.success.withValues(
                                  alpha: 0.15,
                                ),
                                child: Center(
                                  child: Text(
                                    l10n.meals_eatingWindowHours('8'),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Calorie summary from real data
              Row(
                children: [
                  Expanded(
                    child: _buildNutrientCard(
                      context,
                      label: l10n.meals_calories,
                      value: '${mealState.totalCalories}',
                      target: '${mealState.calorieGoal}',
                      color: AppColors.secondary,
                      icon: PhosphorIcons.fire(PhosphorIconsStyle.fill),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildNutrientCard(
                      context,
                      label: l10n.meals_protein,
                      value: '${mealState.totalProtein.toStringAsFixed(0)}g',
                      target: '120g',
                      color: Colors.blue,
                      icon: PhosphorIcons.barbell(PhosphorIconsStyle.fill),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildNutrientCard(
                      context,
                      label: l10n.meals_carbs,
                      value: '${mealState.totalCarbs.toStringAsFixed(0)}g',
                      target: '200g',
                      color: Colors.orange,
                      icon: PhosphorIcons.bread(PhosphorIconsStyle.fill),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildNutrientCard(
                      context,
                      label: l10n.meals_fat,
                      value: '${mealState.totalFat.toStringAsFixed(0)}g',
                      target: '65g',
                      color: Colors.purple,
                      icon: PhosphorIcons.drop(PhosphorIconsStyle.fill),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Today's meals from DB
              SectionHeader(title: l10n.meals_todayMeals),
              if (mealState.meals.isEmpty)
                GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          PhosphorIcons.forkKnife(),
                          size: 40,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.meals_noMeals,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...mealState.meals.map((meal) {
                  final mealIcon = _getMealIcon(meal.mealType);
                  final mealColor = _getMealColor(meal.mealType);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Dismissible(
                      key: Key('meal_${meal.id}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: AppSpacing.borderRadiusMd,
                        ),
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                      onDismissed: (_) {
                        ref.read(mealProvider.notifier).removeMeal(meal.id);
                      },
                      child: _buildMealItem(
                        context,
                        time:
                            '${meal.dateTime_.hour.toString().padLeft(2, '0')}:${meal.dateTime_.minute.toString().padLeft(2, '0')}',
                        name: meal.name,
                        description:
                            'P:${meal.protein.toStringAsFixed(0)}g K:${meal.carbs.toStringAsFixed(0)}g Y:${meal.fat.toStringAsFixed(0)}g',
                        calories: meal.calories,
                        icon: mealIcon,
                        color: mealColor,
                      ),
                    ),
                  );
                }),

              const SizedBox(height: 24),

              // Suggestions
              SectionHeader(title: l10n.meals_breakfastSuggestions),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildRecipeCard(
                      context,
                      l10n.recipe_oatSmoothie,
                      '280 kcal',
                      Icons.blender_outlined,
                    ),
                    const SizedBox(width: 12),
                    _buildRecipeCard(
                      context,
                      l10n.recipe_avocadoToast,
                      '350 kcal',
                      Icons.breakfast_dining_outlined,
                    ),
                    const SizedBox(width: 12),
                    _buildRecipeCard(
                      context,
                      l10n.recipe_yogurtBowl,
                      '220 kcal',
                      Icons.rice_bowl_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (_) => const AddMealSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  IconData _getMealIcon(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return PhosphorIcons.sun(PhosphorIconsStyle.fill);
      case 'lunch':
        return PhosphorIcons.sun(PhosphorIconsStyle.fill);
      case 'dinner':
        return PhosphorIcons.moon(PhosphorIconsStyle.fill);
      case 'snack':
        return PhosphorIcons.cookie(PhosphorIconsStyle.fill);
      default:
        return PhosphorIcons.forkKnife(PhosphorIconsStyle.fill);
    }
  }

  Color _getMealColor(String mealType) {
    switch (mealType) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.orange;
      case 'dinner':
        return AppColors.primary;
      case 'snack':
        return Colors.brown;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildNutrientCard(
    BuildContext context, {
    required String label,
    required String value,
    required String target,
    required Color color,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '/ $target',
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealItem(
    BuildContext context, {
    required String time,
    required String name,
    required String description,
    required int calories,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleSmall),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$calories kcal',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                time,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(
    BuildContext context,
    String title,
    String cal,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        width: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              cal,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
