import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/calculations.dart';
import '../../../data/database/app_database.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../stats/widgets/weight_chart.dart';
import '../../timer/providers/water_provider.dart';
import '../providers/settings_provider.dart';
import '../../stats/providers/stats_provider.dart';

class BodyMetricsScreen extends ConsumerStatefulWidget {
  const BodyMetricsScreen({super.key});

  @override
  ConsumerState<BodyMetricsScreen> createState() => _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends ConsumerState<BodyMetricsScreen> {
  final _weightController = TextEditingController();
  List<Map<String, dynamic>> _weightHistory = [];

  @override
  void initState() {
    super.initState();
    _loadWeightHistory();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _loadWeightHistory() async {
    final db = ref.read(databaseProvider);
    final metrics = await db.getAllMetrics();
    setState(() {
      _weightHistory =
          metrics
              .where((m) => m.weight != null)
              .map((m) => {'date': m.date, 'weight': m.weight!})
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final bmi =
        (settings.weight != null && settings.height != null)
            ? Calculations.calculateBMI(settings.weight!, settings.height!)
            : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.bodyMetrics_title)),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Current stats
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    label: l10n.bodyMetrics_weight,
                    value:
                        settings.weight != null
                            ? '${settings.weight!.toStringAsFixed(1)} kg'
                            : '-- kg',
                    icon: Icons.monitor_weight_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    borderRadius: AppSpacing.borderRadiusMd,
                    onTap:
                        () => _showTargetWeightDialog(settings.targetWeight),
                    child: _buildMetricCard(
                      context,
                      label: l10n.bodyMetrics_target,
                      value:
                          settings.targetWeight != null
                              ? '${settings.targetWeight!.toStringAsFixed(1)} kg'
                              : '-- kg',
                      icon: Icons.flag_outlined,
                      color: AppColors.success,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    label: l10n.bmi,
                    value: bmi != null ? bmi.toStringAsFixed(1) : '--',
                    icon: Icons.favorite_outline,
                    color: _getBmiColor(bmi),
                    subtitle:
                        bmi != null
                            ? Calculations.getBMICategory(bmi, l10n)
                            : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add weight
            Text(
              l10n.bodyMetrics_addWeight,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.bodyMetrics_hintWeight,
                      suffixText: 'kg',
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withAlpha(8),
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(
                          color: theme.colorScheme.onSurface.withAlpha(20),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                        borderSide: BorderSide(
                          color: theme.colorScheme.onSurface.withAlpha(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 52,
                  child: GradientButton(
                    text: l10n.bodyMetrics_save,
                    width: 100,
                    onPressed: _saveWeight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Weight chart
            Text(l10n.stats_weightChange, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            WeightChart(
              weightData: _weightHistory,
              targetWeight: settings.targetWeight,
            ),

            const SizedBox(height: 24),

            // Weight history list
            if (_weightHistory.isNotEmpty) ...[
              Text(
                l10n.bodyMetrics_history,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...List.generate(
                _weightHistory.length > 10 ? 10 : _weightHistory.length,
                (i) {
                  final entry = _weightHistory[_weightHistory.length - 1 - i];
                  final date = entry['date'] as DateTime;
                  final weight = entry['weight'] as double;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${date.day}.${date.month}.${date.year}',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          Text(
                            '${weight.toStringAsFixed(1)} kg',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _saveWeight() async {
    final text = _weightController.text.trim().replaceAll(',', '.');
    final weight = double.tryParse(text);
    if (weight == null || weight <= 0 || weight > 500) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.bodyMetrics_invalidWeight)));
      return;
    }

    final db = ref.read(databaseProvider);
    final settings = ref.read(settingsProvider);
    final bmi =
        settings.height != null
            ? Calculations.calculateBMI(weight, settings.height!)
            : null;

    await db.insertMetric(
      BodyMetricsCompanion(
        weight: Value(weight),
        height: Value(settings.height),
        bmi: Value(bmi),
        date: Value(DateTime.now()),
      ),
    );

    ref.read(settingsProvider.notifier).setBodyInfo(weight: weight);
    ref.invalidate(latestWeightProvider);
    ref.invalidate(weightHistoryProvider);
    _weightController.clear();
    await _loadWeightHistory();

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bodyMetrics_weightSaved(weight.toStringAsFixed(1)),
          ),
        ),
      );
    }
  }

  Future<void> _showTargetWeightDialog(double? current) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(
      text: current != null ? current.toStringAsFixed(1) : '',
    );
    await showDialog<void>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.profile_targetWeight),
            content: TextField(
              controller: controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: l10n.bodyMetrics_hintWeight,
                suffixText: 'kg',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.common_cancel),
              ),
              FilledButton(
                onPressed: () {
                  final target = double.tryParse(
                    controller.text.trim().replaceAll(',', '.'),
                  );
                  if (target == null || target <= 0 || target > 500) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text(l10n.bodyMetrics_invalidWeight)),
                    );
                    return;
                  }
                  ref
                      .read(settingsProvider.notifier)
                      .setBodyInfo(targetWeight: target);
                  Navigator.pop(ctx);
                },
                child: Text(l10n.bodyMetrics_save),
              ),
            ],
          ),
    );
  }

  Color _getBmiColor(double? bmi) {
    if (bmi == null) return AppColors.primary;
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return AppColors.success;
    if (bmi < 30) return AppColors.warning;
    return AppColors.error;
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
  }) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(120),
            ),
          ),
        ],
      ),
    );
  }
}
