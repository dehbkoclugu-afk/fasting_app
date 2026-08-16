import 'package:flutter/material.dart';

import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../services/food_vision_service.dart';
import '../../../shared/widgets/gradient_button.dart';

/// Correct one line of an AI estimate. The model gets portions wrong often
/// enough that saving without a way to fix them would be worse than useless.
///
/// Pops the edited [FoodItem], or null when dismissed.
class FoodItemEditSheet extends StatefulWidget {
  const FoodItemEditSheet({super.key, required this.item});

  final FoodItem item;

  @override
  State<FoodItemEditSheet> createState() => _FoodItemEditSheetState();
}

class _FoodItemEditSheetState extends State<FoodItemEditSheet> {
  late final _name = TextEditingController(text: widget.item.name);
  late final _portion = TextEditingController(text: widget.item.portion);
  late final _calories = TextEditingController(text: '${widget.item.calories}');
  late final _protein = TextEditingController(text: _g(widget.item.protein));
  late final _carbs = TextEditingController(text: _g(widget.item.carbs));
  late final _fat = TextEditingController(text: _g(widget.item.fat));

  static String _g(double value) =>
      value == value.roundToDouble()
          ? value.toStringAsFixed(0)
          : value.toStringAsFixed(1);

  @override
  void dispose() {
    _name.dispose();
    _portion.dispose();
    _calories.dispose();
    _protein.dispose();
    _carbs.dispose();
    _fat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.foodScan_editItem, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            _field(l10n.meals_mealName, _name, TextInputType.text),
            const SizedBox(height: 10),
            _field(l10n.foodScan_portion, _portion, TextInputType.text),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _field(
                    l10n.meals_calories,
                    _calories,
                    TextInputType.number,
                    'kcal',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _field(
                    l10n.meals_protein,
                    _protein,
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
                  child: _field(
                    l10n.meals_carbohydrate,
                    _carbs,
                    TextInputType.number,
                    'g',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _field(
                    l10n.meals_fat,
                    _fat,
                    TextInputType.number,
                    'g',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GradientButton(
              text: l10n.foodScan_saveEdit,
              width: double.infinity,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller,
    TextInputType type, [
    String? suffix,
  ]) {
    return TextField(
      controller: controller,
      keyboardType:
          type == TextInputType.number
              ? const TextInputType.numberWithOptions(decimal: true)
              : type,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        isDense: true,
      ),
    );
  }

  void _submit() {
    final name = _name.text.trim();
    Navigator.of(context).pop(
      widget.item.copyWith(
        name: name.isEmpty ? widget.item.name : name,
        portion: _portion.text.trim(),
        calories: int.tryParse(_calories.text.trim()) ?? widget.item.calories,
        protein: _parse(_protein.text) ?? widget.item.protein,
        carbs: _parse(_carbs.text) ?? widget.item.carbs,
        fat: _parse(_fat.text) ?? widget.item.fat,
      ),
    );
  }

  /// Accepts both "12.5" and the "12,5" a Turkish or German keyboard produces.
  static double? _parse(String raw) =>
      double.tryParse(raw.trim().replaceAll(',', '.'));
}
