import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/config/build_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../providers/meal_provider.dart';

class AddMealSheet extends ConsumerStatefulWidget {
  const AddMealSheet({super.key});

  @override
  ConsumerState<AddMealSheet> createState() => _AddMealSheetState();
}

class _AddMealSheetState extends ConsumerState<AddMealSheet> {
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  String _mealType = 'lunch';

  final _quickMeals = [
    {'name': 'Yulaf Ezmesi', 'cal': 280, 'p': 10.0, 'c': 48.0, 'f': 6.0},
    {'name': 'Tavuk Göğsü (150g)', 'cal': 230, 'p': 43.0, 'c': 0.0, 'f': 5.0},
    {'name': 'Pilav (1 porsiyon)', 'cal': 200, 'p': 4.0, 'c': 44.0, 'f': 1.0},
    {'name': 'Yumurta (2 adet)', 'cal': 155, 'p': 13.0, 'c': 1.0, 'f': 11.0},
    {'name': 'Salata', 'cal': 120, 'p': 3.0, 'c': 12.0, 'f': 7.0},
    {'name': 'Yoğurt (200g)', 'cal': 120, 'p': 7.0, 'c': 8.0, 'f': 6.0},
    {'name': 'Muz', 'cal': 105, 'p': 1.3, 'c': 27.0, 'f': 0.4},
    {'name': 'Elma', 'cal': 95, 'p': 0.5, 'c': 25.0, 'f': 0.3},
    {'name': 'Somon (150g)', 'cal': 310, 'p': 34.0, 'c': 0.0, 'f': 18.0},
    {'name': 'Avokado (yarım)', 'cal': 160, 'p': 2.0, 'c': 9.0, 'f': 15.0},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.meals_addMeal, style: theme.textTheme.titleLarge),
              const SizedBox(height: 20),

              // Shortcut into the AI scan — the sheet is where a user lands
              // when they want to log a meal, so the faster path belongs here.
              if (BuildConfig.isFoodScanEnabled) ...[
                _buildScanBanner(context, l10n),
                const SizedBox(height: 20),
              ],

              // Meal type selector
              Text(l10n.meals_mealType, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildMealTypeChip(
                    'breakfast',
                    l10n.meals_breakfast,
                    Icons.wb_sunny_outlined,
                  ),
                  _buildMealTypeChip(
                    'lunch',
                    l10n.meals_lunch,
                    Icons.wb_cloudy_outlined,
                  ),
                  _buildMealTypeChip(
                    'dinner',
                    l10n.meals_dinner,
                    Icons.nightlight_outlined,
                  ),
                  _buildMealTypeChip(
                    'snack',
                    l10n.meals_snack,
                    Icons.cookie_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Quick add
              Text(l10n.meals_quickAdd, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _quickMeals.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    final meal = _quickMeals[index];
                    return ActionChip(
                      label: Text(
                        '${meal['name']} (${meal['cal']} kcal)',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onPressed: () => _quickAdd(meal),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Manual entry
              Text(l10n.meals_manualEntry, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              _buildField(
                l10n.meals_mealName,
                _nameController,
                TextInputType.text,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      l10n.meals_calories,
                      _caloriesController,
                      TextInputType.number,
                      'kcal',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildField(
                      l10n.meals_protein,
                      _proteinController,
                      TextInputType.number,
                      'g',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      l10n.meals_carbohydrate,
                      _carbsController,
                      TextInputType.number,
                      'g',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildField(
                      l10n.meals_fat,
                      _fatController,
                      TextInputType.number,
                      'g',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GradientButton(text: l10n.meals_add, onPressed: _saveMeal),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScanBanner(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: AppSpacing.borderRadiusMd,
      onTap: () {
        Navigator.of(context).pop();
        context.push('/food-scan');
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: .14),
              AppColors.secondary.withValues(alpha: .08),
            ],
          ),
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(color: AppColors.primary.withValues(alpha: .2)),
        ),
        child: Row(
          children: [
            Icon(
              PhosphorIcons.camera(PhosphorIconsStyle.fill),
              color: AppColors.primary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.foodScan_scanCta,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    l10n.foodScan_scanCtaDesc,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .55),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: .35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTypeChip(String value, String label, IconData icon) {
    final isSelected = _mealType == value;
    return ChoiceChip(
      selected: isSelected,
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onSelected: (_) {
        HapticFeedback.selectionClick();
        setState(() => _mealType = value);
      },
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    TextInputType type, [
    String? suffix,
  ]) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        isDense: true,
      ),
    );
  }

  void _quickAdd(Map<String, dynamic> meal) {
    ref
        .read(mealProvider.notifier)
        .addMeal(
          name: meal['name'] as String,
          calories: meal['cal'] as int,
          protein: meal['p'] as double,
          carbs: meal['c'] as double,
          fat: meal['f'] as double,
          mealType: _mealType,
        );
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    HapticFeedback.lightImpact();
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.meals_added(meal['name'] as String))),
    );
  }

  void _saveMeal() {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final cal = int.tryParse(_caloriesController.text) ?? 0;
    if (name.isEmpty || cal <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.meals_nameCalorieRequired)));
      return;
    }

    ref
        .read(mealProvider.notifier)
        .addMeal(
          name: name,
          calories: cal,
          protein: double.tryParse(_proteinController.text) ?? 0,
          carbs: double.tryParse(_carbsController.text) ?? 0,
          fat: double.tryParse(_fatController.text) ?? 0,
          mealType: _mealType,
        );

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    HapticFeedback.lightImpact();
    navigator.pop();
    messenger.showSnackBar(SnackBar(content: Text(l10n.meals_added(name))));
  }
}
