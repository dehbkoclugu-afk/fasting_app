import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/database/app_database.dart';
import '../widgets/bmi_gauge_painter.dart';
import '../../profile/providers/settings_provider.dart';
import '../../timer/providers/water_provider.dart';
import '../../stats/providers/stats_provider.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';

class WeightTrackerScreen extends ConsumerStatefulWidget {
  const WeightTrackerScreen({super.key});

  @override
  ConsumerState<WeightTrackerScreen> createState() =>
      _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends ConsumerState<WeightTrackerScreen> {
  final _weightController = TextEditingController();
  List<Map<String, dynamic>> _weightHistory = [];
  double? _latestWeight;
  int _selectedPeriod = 0; // 0=Weekly, 1=Monthly, 2=Yearly
  int _loadGeneration = 0;
  bool _savingWeight = false;

  @override
  void initState() {
    super.initState();
    _loadWeightHistory();
  }

  Future<void> _loadWeightHistory() async {
    final generation = ++_loadGeneration;
    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: [7, 30, 365][_selectedPeriod] - 1));
    final entries = await (db.select(
      db.bodyMetrics,
    )..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
    if (!mounted || generation != _loadGeneration) return;
    final weighted = entries.where((e) => e.weight != null).toList();
    setState(() {
      _latestWeight = weighted.isEmpty ? null : weighted.first.weight;
      _weightHistory = weighted
          .where((e) => !e.date.isBefore(start))
          .map((e) => {'date': e.date, 'weight': e.weight!})
          .toList();
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);

    // bodyMetrics tablosundan en son kilo, yoksa settings'den
    final currentWeight = _latestWeight ?? settings.weight;
    final heightCm = settings.height ?? 170;
    final targetWeight = settings.targetWeight ?? 70.0;

    double? bmi;
    if (currentWeight != null && heightCm > 0) {
      bmi = currentWeight / ((heightCm / 100) * (heightCm / 100));
    }

    final weightChange = _weightHistory.length >= 2
        ? ((_weightHistory.first['weight'] as double) -
              (_weightHistory.last['weight'] as double))
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.stats_weightChange)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding.copyWith(bottom: AppSpacing.lg),
          child: Column(
            children: [
              EditorialScreenHero(
                assetPath: 'assets/images/editorial/profile-progress.webp',
                title: l10n.stats_weightChange,
                subtitle: l10n.bodyMetrics_target,
                icon: Icons.monitor_weight_outlined,
              ),
              const SizedBox(height: 20),
              // Period toggle
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<int>(
                  segments: [
                    ButtonSegment(value: 0, label: Text(l10n.stats_week)),
                    ButtonSegment(value: 1, label: Text(l10n.stats_month)),
                    ButtonSegment(value: 2, label: Text(l10n.stats_year)),
                  ],
                  selected: {_selectedPeriod},
                  showSelectedIcon: false,
                  onSelectionChanged: (selection) {
                    setState(() => _selectedPeriod = selection.first);
                    _loadWeightHistory();
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Summary kartları
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      title: l10n.bodyMetrics_weight,
                      value: currentWeight != null
                          ? '${currentWeight.toStringAsFixed(1)} kg'
                          : '--',
                      icon: PhosphorIcons.scales(PhosphorIconsStyle.fill),
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      title: l10n.bodyMetrics_target,
                      value: '${targetWeight.toStringAsFixed(1)} kg',
                      icon: PhosphorIcons.target(PhosphorIconsStyle.fill),
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),

              if (weightChange != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: .065,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        weightChange < 0
                            ? PhosphorIcons.trendDown()
                            : PhosphorIcons.trendUp(),
                        color: weightChange < 0
                            ? AppColors.success
                            : AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${weightChange > 0 ? '+' : ''}${weightChange.toStringAsFixed(1)} kg',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: weightChange < 0
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // BMI Gauge
              if (bmi != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: .065,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'BMI',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 200,
                        height: 110,
                        child: CustomPaint(painter: BmiGaugePainter(bmi: bmi)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bmi.toStringAsFixed(1),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        _bmiCategory(bmi),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _bmiColor(bmi),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Kilo Geçmişi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: .065),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.bodyMetrics_history,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_weightHistory.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            l10n.bodyMetrics_noData,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      ...(_weightHistory.take(10).map((entry) {
                        final date = entry['date'] as DateTime;
                        final weight = entry['weight'] as double;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${date.day}/${date.month}/${date.year}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                              Text(
                                '${weight.toStringAsFixed(1)} kg',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Log Weight butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddWeightDialog(context),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.bodyMetrics_addWeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: .065),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _bmiColor(double bmi) {
    if (bmi < 18.5) return AppColors.tertiary;
    if (bmi < 25) return AppColors.success;
    if (bmi < 30) return AppColors.warning;
    return AppColors.error;
  }

  void _showAddWeightDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.bodyMetrics_addWeight),
        content: TextField(
          controller: _weightController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            onPressed: () async {
              final weight = double.tryParse(
                _weightController.text.trim().replaceAll(',', '.'),
              );
              if (weight == null ||
                  !weight.isFinite ||
                  weight <= 0 ||
                  _savingWeight)
                return;
              _savingWeight = true;
              try {
                final db = ref.read(databaseProvider);
                await db
                    .into(db.bodyMetrics)
                    .insert(
                      BodyMetricsCompanion.insert(
                        date: DateTime.now(),
                        weight: Value(weight),
                      ),
                    );
                if (!mounted) return;
                ref.read(settingsProvider.notifier).setBodyInfo(weight: weight);
                ref.invalidate(latestWeightProvider);
                ref.invalidate(weightHistoryProvider);
                _weightController.clear();
                if (ctx.mounted) Navigator.pop(ctx);
                await _loadWeightHistory();
              } catch (error) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(l10n.common_retry)));
                }
              } finally {
                _savingWeight = false;
              }
            },
            child: Text(l10n.bodyMetrics_save),
          ),
        ],
      ),
    );
  }
}
