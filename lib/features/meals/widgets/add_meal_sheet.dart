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
    {'name': 'Meyveli Yulaf', 'cal': 320, 'p': 12.0, 'c': 48.0, 'f': 9.0, 'art': 'assets/images/editorial/v4/quick/oats.webp'},
    {'name': 'Yaban Mersinli Yoğurt', 'cal': 240, 'p': 18.0, 'c': 26.0, 'f': 8.0, 'art': 'assets/images/editorial/v4/quick/yogurt.webp'},
    {'name': 'Yumurtalı Avokado Tost', 'cal': 390, 'p': 22.0, 'c': 32.0, 'f': 19.0, 'art': 'assets/images/editorial/v4/quick/egg-toast.webp'},
    {'name': 'Tavuklu Kinoa Kasesi', 'cal': 430, 'p': 42.0, 'c': 38.0, 'f': 11.0, 'art': 'assets/images/editorial/v4/quick/chicken-quinoa.webp'},
    {'name': 'Mercimek Çorbası', 'cal': 310, 'p': 18.0, 'c': 48.0, 'f': 6.0, 'art': 'assets/images/editorial/v4/quick/lentil.webp'},
    {'name': 'Somon ve Brokoli', 'cal': 520, 'p': 38.0, 'c': 42.0, 'f': 21.0, 'art': 'assets/images/editorial/v4/quick/salmon.webp'},
    {'name': 'Sebzeli Hindi Wrap', 'cal': 360, 'p': 32.0, 'c': 40.0, 'f': 9.0, 'art': 'assets/images/editorial/v4/quick/turkey-wrap.webp'},
    {'name': 'Nohutlu Tahin Kasesi', 'cal': 410, 'p': 19.0, 'c': 55.0, 'f': 14.0, 'art': 'assets/images/editorial/v4/quick/chickpea.webp'},
    {'name': 'Ton Balıklı Fasulye Salatası', 'cal': 350, 'p': 35.0, 'c': 28.0, 'f': 10.0, 'art': 'assets/images/editorial/v4/quick/tuna.webp'},
    {'name': 'Elmalı Lor Kasesi', 'cal': 230, 'p': 24.0, 'c': 25.0, 'f': 5.0, 'art': 'assets/images/editorial/v4/quick/cottage.webp'},
    {'name': 'Humus ve Çıtır Sebze', 'cal': 280, 'p': 12.0, 'c': 34.0, 'f': 12.0, 'art': 'assets/images/editorial/v4/quick/hummus.webp'},
    {'name': 'Kefirli Muz Kasesi', 'cal': 300, 'p': 15.0, 'c': 42.0, 'f': 9.0, 'art': 'assets/images/editorial/v4/quick/kefir.webp'},
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
                child: FastingSplitArtCard(
                  assetPath: 'assets/images/editorial/v6/meal-analysis.webp',
                  minHeight: 174,
                  artWidth: 122,
                  borderRadius: 24,
                  semanticLabel: l10n.foodScan_scanCta,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.foodScan_scanCta,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: fastingArtForeground(context),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          l10n.foodScan_scanCtaDesc,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: fastingArtMutedForeground(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            _scanAction(
                              icon: PhosphorIcons.camera(PhosphorIconsStyle.fill),
                              label: l10n.foodScan_takePhoto,
                            ),
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
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.9,
                children: [
                  _mealTypeCard('breakfast', l10n.meals_breakfast, Icons.wb_sunny_outlined, 'assets/images/editorial/v4/quick/oats.webp'),
                  _mealTypeCard('lunch', l10n.meals_lunch, Icons.light_mode_outlined, 'assets/images/editorial/v4/quick/chicken-quinoa.webp'),
                  _mealTypeCard('dinner', l10n.meals_dinner, Icons.nightlight_outlined, 'assets/images/editorial/v4/quick/salmon.webp'),
                  _mealTypeCard('snack', l10n.meals_snack, Icons.cookie_outlined, 'assets/images/editorial/v4/quick/yogurt.webp'),
                ],
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, l10n.meals_quickAdd, Icons.bolt_outlined),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _quickMeals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => _quickMealCard(
                  context,
                  _quickMeals[index],
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle(context, l10n.meals_manualEntry, PhosphorIcons.notepad()),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(24),
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
                        Expanded(child: _field(l10n.meals_calories, _caloriesController, TextInputType.number, suffix: 'kcal')),
                        const SizedBox(width: 10),
                        Expanded(child: _field(l10n.meals_protein, _proteinController, TextInputType.number, suffix: 'g')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _field(l10n.meals_carbohydrate, _carbsController, TextInputType.number, suffix: 'g')),
                        const SizedBox(width: 10),
                        Expanded(child: _field(l10n.meals_fat, _fatController, TextInputType.number, suffix: 'g')),
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

  Widget _scanAction({required IconData icon, required String label}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withValues(alpha: .14)
            : const Color(0xE65A3E50),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withValues(alpha: .16)
              : const Color(0xFF5A3E50),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 5),
          Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
  );

  void _openPhotoScan() {
    final router = GoRouter.of(context);
    Navigator.of(context).pop();
    router.push('/food-scan');
  }

  Widget _mealTypeCard(String value, String label, IconData icon, String artPath) {
    final selected = _mealType == value;
    return InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _mealType = value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.all(selected ? 2 : 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? AppColors.primary : Theme.of(context).dividerColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: FastingSplitArtCard(
            assetPath: artPath,
            minHeight: 76,
            artWidth: 56,
            borderRadius: 15,
            semanticLabel: label,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 21,
                    color: selected
                        ? AppColors.primary
                        : fastingArtForeground(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: fastingArtForeground(context),
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _quickMealCard(
    BuildContext context,
    Map<String, Object> meal,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _quickAdd(meal),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                themedEditorialAssetPath(
                  meal['art']! as String,
                  Theme.of(context).brightness,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 8, 9),
              child: Column(
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${meal['cal']} kcal',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.add_circle, color: AppColors.primary, size: 22),
                    ],
                  ),
                ],
              ),
            ),
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
  }) {
    final foreground = Theme.of(context).colorScheme.onSurface;
    return TextField(
      controller: controller,
      keyboardType: type,
      textInputAction: textInputAction,
      style: TextStyle(color: foreground, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: foreground.withValues(alpha: .68)),
        suffixText: suffix,
        prefixIcon: icon == null ? null : Icon(icon, size: 18, color: foreground.withValues(alpha: .72)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        isDense: false,
      ),
    );
  }

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
