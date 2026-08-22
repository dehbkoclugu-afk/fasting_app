import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../timer/providers/water_provider.dart';

class WaterTrackerScreen extends ConsumerWidget {
  const WaterTrackerScreen({super.key});

  static const _amounts = [150, 250, 350, 500];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final water = ref.watch(waterProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final progress = water.progress;
    final remaining = (water.goalMl - water.totalMl)
        .clamp(0, water.goalMl)
        .toInt();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.water_title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: .45),
              ),
            ),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_volume(water.totalMl)} / ${_volume(water.goalMl)}',
                            maxLines: 1,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -.8,
                            ),
                          ),
                        ),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.tertiary.withValues(alpha: .11),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: const Icon(
                            Icons.local_drink_outlined,
                            color: AppColors.tertiary,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${(progress * 100).round()}% ${l10n.stats_completion}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 9,
                        backgroundColor: theme.colorScheme.outlineVariant.withValues(alpha: .42),
                        color: AppColors.tertiary,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      remaining == 0
                          ? l10n.timer_completed
                          : '${l10n.timer_remaining}: ${_volume(remaining)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
              ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.water_addWater,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () => _showCustomAmount(context, ref),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text(l10n.water_ml),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (var index = 0; index < _amounts.length; index++) ...[
                Expanded(
                  child: _AmountButton(
                    amount: _amounts[index],
                    icon: _amountIcon(_amounts[index]),
                    onPressed: () => _add(ref, _amounts[index]),
                  ),
                ),
                if (index != _amounts.length - 1) const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.home_todaySummary,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '${water.entries.length} • ${_volume(water.totalMl)}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (water.entries.isEmpty)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l10n.water_addWater,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: .45),
                ),
              ),
              child: Column(
                children: [
                  for (
                    var index = 0;
                    index < water.entries.reversed.length;
                    index++
                  ) ...[
                    _WaterEntryTile(
                      entry: water.entries.reversed.elementAt(index),
                      onDelete: () => _delete(
                        context,
                        ref,
                        water.entries.reversed.elementAt(index),
                      ),
                    ),
                    if (index != water.entries.length - 1)
                      Divider(
                        height: 1,
                        indent: 54,
                        color: theme.dividerColor.withValues(alpha: .55),
                      ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  static String _volume(int ml) {
    if (ml < 1000) return '$ml ml';
    final liters = ml / 1000;
    final digits = liters.truncateToDouble() == liters ? 0 : 2;
    return '${liters.toStringAsFixed(digits).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '')} L';
  }

  static IconData _amountIcon(int amount) => switch (amount) {
    <= 150 => Icons.local_cafe_outlined,
    <= 350 => Icons.local_drink_outlined,
    _ => Icons.local_drink_outlined,
  };

  Future<void> _add(WidgetRef ref, int amount) async {
    HapticFeedback.mediumImpact();
    await ref.read(waterProvider.notifier).addWater(amount);
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    WaterIntakeData entry,
  ) async {
    await ref.read(waterProvider.notifier).deleteWater(entry.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('-${entry.amountMl} ml'),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.common_cancel,
          onPressed: () =>
              ref.read(waterProvider.notifier).addWater(entry.amountMl),
        ),
      ),
    );
  }

  Future<void> _showCustomAmount(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final amount = await showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.water_addWater),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            suffixText: AppLocalizations.of(context)!.water_ml,
          ),
          onSubmitted: (_) =>
              Navigator.pop(dialogContext, int.tryParse(controller.text)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.common_cancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, int.tryParse(controller.text)),
            child: Text(AppLocalizations.of(context)!.common_save),
          ),
        ],
      ),
    );
    controller.dispose();
    if (amount != null && amount > 0 && amount <= 5000) {
      await _add(ref, amount);
    }
  }
}

class _AmountButton extends StatelessWidget {
  const _AmountButton({required this.amount, required this.icon, required this.onPressed});

  final int amount;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 46,
    child: FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: AppColors.tertiary.withValues(alpha: .11),
        foregroundColor: AppColors.tertiary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 17),
          const SizedBox(height: 1),
          Text('$amount', style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    ),
  );
}

class _WaterEntryTile extends StatelessWidget {
  const _WaterEntryTile({required this.entry, required this.onDelete});

  final WaterIntakeData entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(entry.date),
    );
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0x194A9DFF),
        foregroundColor: AppColors.tertiary,
        child: Icon(_entryIcon(entry.amountMl), size: 19),
      ),
      title: Text(
        '+${entry.amountMl} ml',
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text(time),
      trailing: IconButton(
        tooltip: AppLocalizations.of(context)!.common_delete,
        onPressed: onDelete,
        icon: Icon(
          Icons.delete_outline_rounded,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  IconData _entryIcon(int amount) => switch (amount) {
    <= 150 => Icons.local_cafe_outlined,
    <= 350 => Icons.local_drink_outlined,
    _ => Icons.local_drink_outlined,
  };
}
