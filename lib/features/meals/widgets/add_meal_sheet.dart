import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
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
      initialChildSize: .94,
      maxChildSize: .97,
      minChildSize: .68,
      expand: false,
      builder: (context, scrollController) => SafeArea(
        top: false,
        child: SingleChildScrollView(
          controller: scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
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
                        letterSpacing: -.4,
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: _openPhotoScan,
                child: FastingArtSlot(
                  assetPath: 'assets/images/editorial/v2/meal-scan.webp',
                  height: 164,
                  borderRadius: 24,
                  variant: FastingArtVariant.hero,
                  semanticLabel: l10n.foodScan_scanCta,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 128, 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.foodScan_scanCta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
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
                            color: Colors.white.withValues(alpha: .75),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _scanAction(
                              icon: PhosphorIcons.camera(PhosphorIconsStyle.fill),
                              label: l10n.foodScan_takePhoto,
                            ),
                            const SizedBox(width: 8),
                            _scanAction(
                              icon: PhosphorIcons.images(PhosphorIconsStyle.fill),
                              label: l10n.foodScan_chooseFromGallery,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, l10n.meals_mealType, Icons.schedule_outlined),
              const SizedBox(height: 10),
              SizedBox(
                height: 72,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _mealTypeCard('breakfast', l10n.meals_breakfast, Icons.wb_sunny_outlined),
                    _mealTypeCard('lunch', l10n.meals_lunch, Icons.light_mode_outlined),
                    _mealTypeCard('dinner', l10n.meals_dinner, Icons.nightlight_outlined),
                    _mealTypeCard('snack', l10n.meals_snack, Icons.cookie_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, l10n.meals_quickAdd, Icons.bolt_outlined),
              const SizedBox(height: 10),
              SizedBox(
                height: 86,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _quickMeals.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) => _quickMealCard(
                    context,
                    _quickMeals[index],
                    index,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FastingArtSlot(
                assetPath: 'assets/images/editorial/v4/meal-manual-entry.webp',
                height: 126,
                borderRadius: 24,
                variant: FastingArtVariant.row,
                alignment: Alignment.centerRight,
                semanticLabel: l10n.meals_manualEntry,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 150, 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(PhosphorIcons.notepad(), color: AppColors.primaryLight),
                      const SizedBox(height: 8),
                      Text(
                        l10n.meals_manualEntry,
                        maxLines: 2,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: .45),
                  ),
                ),
                child: Column(
                  children: [
                    _field(
                      l10n.meals_mealName,
                      _nameController,
                      TextInputType.text,
                      icon: PhosphorIcons.forkKnife(),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _field(l10n.meals_calories, _caloriesController, TextInputType.number, suffix: 'kcal', icon: PhosphorIcons.fire())),
                        const SizedBox(width: 10),
                        Expanded(child: _field(l10n.meals_protein, _proteinController, TextInputType.number, suffix: 'g', icon: PhosphorIcons.barbell())),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _field(l10n.meals_carbohydrate, _carbsController, TextInputType.number, suffix: 'g', icon: PhosphorIcons.bread())),
                        const SizedBox(width: 10),
                        Expanded(child: _field(l10n.meals_fat, _fatController, TextInputType.number, suffix: 'g', icon: PhosphorIcons.drop())),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GradientButton(text: l10n.meals_add, onPressed: _saveMeal),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title, IconData icon) => Row(
    children: [
      Icon(icon, size: 19, color: AppColors.primary),
      const SizedBox(width: 8),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );

  Widget _scanAction({required IconData icon, required String label}) => Flexible(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: .16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  void _openPhotoScan() {
    final router = GoRouter.of(context);
    Navigator.of(context).pop();
    router.push('/food-scan');
  }

  Widget _mealTypeCard(String value, String label, IconData icon) {
    final selected = _mealType == value;
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _mealType = value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 112,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: .16)
                : Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.primary : Theme.of(context).dividerColor,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: selected ? AppColors.primary : null),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickMealCard(
    BuildContext context,
    Map<String, Object> meal,
    int index,
  ) {
    final icons = [
      Icons.breakfast_dining_rounded,
      Icons.set_meal_rounded,
      Icons.rice_bowl_rounded,
      Icons.egg_alt_rounded,
      Icons.eco_rounded,
      Icons.local_drink_rounded,
    ];
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _quickAdd(meal),
      child: Container(
        width: 176,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icons[index], color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal['name']! as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${meal['cal']} kcal',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.add_circle, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller,
    TextInputType type, {
    String? suffix,
    IconData? icon,
    TextInputAction textInputAction = TextInputAction.next,
  }) => TextField(
    controller: controller,
    keyboardType: type,
    textInputAction: textInputAction,
    decoration: InputDecoration(
      labelText: label,
      suffixText: suffix,
      prefixIcon: icon == null ? null : Icon(icon, size: 18),
      filled: true,
      isDense: false,
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
