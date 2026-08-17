import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../providers/meal_provider.dart';
import '../widgets/add_meal_sheet.dart';
import '../../paywall/providers/subscription_provider.dart';
import '../../timer/providers/timer_provider.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealState = ref.watch(mealProvider);
    final timerState = ref.watch(timerProvider);
    final isPremium = ref.watch(isPremiumProvider);
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
              InkWell(
                onTap: () => context.push('/food-scan'),
                borderRadius: BorderRadius.circular(24),
                child: FastingArtSlot(
                  assetPath: 'assets/images/editorial/v2/meal-planner.webp',
                  height: 196,
                  variant: FastingArtVariant.hero,
                  semanticLabel: l10n.foodScan_scanCta,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 132, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          l10n.meals_title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -.45,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          l10n.foodScan_scanCtaDesc,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: .8),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 11),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPremium
                                    ? PhosphorIcons.camera(
                                      PhosphorIconsStyle.fill,
                                    )
                                    : PhosphorIcons.lockKey(
                                      PhosphorIconsStyle.fill,
                                    ),
                                color: Colors.white,
                                size: 17,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                l10n.foodScan_scanCta,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
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
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showAddMealSheet(context),
                  icon: Icon(PhosphorIcons.pencilSimple(), size: 18),
                  label: Text(l10n.meals_manualEntry),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.25,
                children: [
                  _buildNutrientCard(
                    context,
                    label: l10n.meals_calories,
                    value: '${mealState.totalCalories}',
                    target: '${mealState.calorieGoal}',
                    progress: mealState.calorieGoal <= 0
                        ? 0
                        : mealState.totalCalories / mealState.calorieGoal,
                    color: AppColors.secondary,
                    icon: PhosphorIcons.fire(PhosphorIconsStyle.fill),
                  ),
                  _buildNutrientCard(
                    context,
                    label: l10n.meals_protein,
                    value: '${mealState.totalProtein.toStringAsFixed(0)}g',
                    target: '120g',
                    progress: mealState.totalProtein / 120,
                    color: Colors.blue,
                    icon: PhosphorIcons.barbell(PhosphorIconsStyle.fill),
                  ),
                  _buildNutrientCard(
                    context,
                    label: l10n.meals_carbs,
                    value: '${mealState.totalCarbs.toStringAsFixed(0)}g',
                    target: '200g',
                    progress: mealState.totalCarbs / 200,
                    color: Colors.orange,
                    icon: PhosphorIcons.bread(PhosphorIconsStyle.fill),
                  ),
                  _buildNutrientCard(
                    context,
                    label: l10n.meals_fat,
                    value: '${mealState.totalFat.toStringAsFixed(0)}g',
                    target: '65g',
                    progress: mealState.totalFat / 65,
                    color: Colors.purple,
                    icon: PhosphorIcons.drop(PhosphorIconsStyle.fill),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Today's meals from DB
              SectionHeader(title: l10n.meals_todayMeals),
              if (mealState.meals.isEmpty)
                InkWell(
                  onTap: () => context.push('/food-scan'),
                  borderRadius: BorderRadius.circular(22),
                  child: FastingArtSlot(
                    assetPath: 'assets/images/editorial/v2/meal-empty.webp',
                    height: 132,
                    borderRadius: 22,
                    variant: FastingArtVariant.row,
                    semanticLabel: l10n.meals_noMeals,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 16, 150, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            PhosphorIcons.camera(PhosphorIconsStyle.fill),
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.meals_noMeals,
                            maxLines: 2,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            l10n.foodScan_scanCta,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: .72),
                            ),
                          ),
                        ],
                      ),
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
                height: 168,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildRecipeCard(
                      context,
                      l10n.recipe_oatSmoothie,
                      '280 kcal',
                      'assets/images/editorial/v2/recipe-smoothie.webp',
                    ),
                    const SizedBox(width: 12),
                    _buildRecipeCard(
                      context,
                      l10n.recipe_avocadoToast,
                      '350 kcal',
                      'assets/images/editorial/v2/recipe-toast.webp',
                    ),
                    const SizedBox(width: 12),
                    _buildRecipeCard(
                      context,
                      l10n.recipe_yogurtBowl,
                      '220 kcal',
                      'assets/images/editorial/v2/recipe-yogurt.webp',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'meals_scan_fab',
            onPressed: () => context.push('/food-scan'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: Icon(
              isPremium
                  ? PhosphorIcons.camera(PhosphorIconsStyle.fill)
                  : PhosphorIcons.lockKey(PhosphorIconsStyle.fill),
              size: 20,
            ),
            label: Text(l10n.foodScan_scanCta),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'meals_add_fab',
            onPressed: () => _showAddMealSheet(context),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showAddMealSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const AddMealSheet(),
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
    required double progress,
    required Color color,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: .55),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: value,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                        text: ' / $target',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: .4),
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: progress.clamp(0, 1).toDouble(),
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(4),
                  backgroundColor: color.withValues(alpha: .12),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ],
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
    String artPath,
  ) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 156,
      child: FastingArtSlot(
        assetPath: artPath,
        height: 168,
        borderRadius: 20,
        variant: FastingArtVariant.card,
        semanticLabel: title,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                cal,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: .75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
