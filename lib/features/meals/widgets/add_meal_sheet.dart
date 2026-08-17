import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../../../shared/widgets/glass_card.dart';
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

  final _quickMeals = const [
    {'name': 'Yulaf Ezmesi', 'cal': 280, 'p': 10.0, 'c': 48.0, 'f': 6.0},
    {'name': 'Tavuk Göğsü (150g)', 'cal': 230, 'p': 43.0, 'c': 0.0, 'f': 5.0},
    {'name': 'Pilav (1 porsiyon)', 'cal': 200, 'p': 4.0, 'c': 44.0, 'f': 1.0},
    {'name': 'Yumurta (2 adet)', 'cal': 155, 'p': 13.0, 'c': 1.0, 'f': 11.0},
    {'name': 'Salata', 'cal': 120, 'p': 3.0, 'c': 12.0, 'f': 7.0},
    {'name': 'Yoğurt (200g)', 'cal': 120, 'p': 7.0, 'c': 8.0, 'f': 6.0},
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
      initialChildSize: .92,
      maxChildSize: .97,
      minChildSize: .62,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.meals_addMeal,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 12),
            InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: _openPhotoScan,
              child: FastingArtSlot(
                assetPath: 'assets/images/editorial/v2/meal-scan.webp',
                height: 154,
                borderRadius: 22,
                variant: FastingArtVariant.hero,
                semanticLabel: l10n.foodScan_scanCta,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 142, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          PhosphorIcons.camera(PhosphorIconsStyle.fill),
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        l10n.foodScan_scanCta,
                        maxLines: 1,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        l10n.foodScan_scanCtaDesc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: .78),
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
                onPressed: _openPhotoScan,
                icon: Icon(PhosphorIcons.camera(), size: 18),
                label: Text(l10n.foodScan_takePhoto),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(46),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openPhotoScan,
                icon: Icon(PhosphorIcons.images(), size: 18),
                label: Text(l10n.foodScan_chooseFromGallery),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(46),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(l10n.meals_mealType, style: theme.textTheme.titleSmall),
            const SizedBox(height: 9),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _mealTypeChip('breakfast', l10n.meals_breakfast, Icons.wb_sunny_outlined),
                _mealTypeChip('lunch', l10n.meals_lunch, Icons.wb_cloudy_outlined),
                _mealTypeChip('dinner', l10n.meals_dinner, Icons.nightlight_outlined),
                _mealTypeChip('snack', l10n.meals_snack, Icons.cookie_outlined),
              ],
            ),
            const SizedBox(height: 22),
            Text(l10n.meals_quickAdd, style: theme.textTheme.titleSmall),
            const SizedBox(height: 9),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final meal in _quickMeals)
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 16),
                    label: Text(
                      '${meal['name']} · ${meal['cal']} kcal',
                      style: const TextStyle(fontSize: 11),
                    ),
                    onPressed: () => _quickAdd(meal),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            Text(l10n.meals_manualEntry, style: theme.textTheme.titleSmall),
            const SizedBox(height: 9),
            GlassCard(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _field(l10n.meals_mealName, _nameController, TextInputType.text),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _field(l10n.meals_calories, _caloriesController, TextInputType.number, 'kcal')),
                      const SizedBox(width: 10),
                      Expanded(child: _field(l10n.meals_protein, _proteinController, TextInputType.number, 'g')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _field(l10n.meals_carbohydrate, _carbsController, TextInputType.number, 'g')),
                      const SizedBox(width: 10),
                      Expanded(child: _field(l10n.meals_fat, _fatController, TextInputType.number, 'g')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GradientButton(text: l10n.meals_add, onPressed: _saveMeal),
          ],
        ),
      ),
    );
  }

  void _openPhotoScan() {
    final router = GoRouter.of(context);
    Navigator.of(context).pop();
    router.push('/food-scan');
  }

  Widget _mealTypeChip(String value, String label, IconData icon) => ChoiceChip(
    selected: _mealType == value,
    avatar: Icon(icon, size: 18),
    label: Text(label),
    onSelected: (_) {
      HapticFeedback.selectionClick();
      setState(() => _mealType = value);
    },
  );

  Widget _field(
    String label,
    TextEditingController controller,
    TextInputType type, [
    String? suffix,
  ]) => TextField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      labelText: label,
      suffixText: suffix,
      isDense: true,
    ),
  );

  void _quickAdd(Map<String, Object> meal) {
    ref.read(mealProvider.notifier).addMeal(
      name: meal['name']! as String,
      calories: meal['cal']! as int,
      protein: meal['p']! as double,
      carbs: meal['c']! as double,
      fat: meal['f']! as double,
      mealType: _mealType,
    );
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    HapticFeedback.lightImpact();
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.meals_added(meal['name']! as String))),
    );
  }

  void _saveMeal() {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final calories = int.tryParse(_caloriesController.text) ?? 0;
    if (name.isEmpty || calories <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.meals_nameCalorieRequired)),
      );
      return;
    }

    ref.read(mealProvider.notifier).addMeal(
      name: name,
      calories: calories,
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
