import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/glass_card.dart';

class WeightChart extends StatelessWidget {
  final List<Map<String, dynamic>>
  weightData; // [{date: DateTime, weight: double}]
  final double? targetWeight;

  const WeightChart({super.key, required this.weightData, this.targetWeight});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final l10n = AppLocalizations.of(context)!;

    if (weightData.isEmpty) {
      return GlassCard(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 160,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.monitor_weight_outlined,
                  size: 40,
                  color: theme.colorScheme.onSurface.withAlpha(50),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.weight_noRecord,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final spots =
        weightData.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value['weight'] as double);
        }).toList();

    final weights = weightData.map((d) => d['weight'] as double).toList();
    final minWeight = weights.reduce((a, b) => a < b ? a : b) - 2;
    final maxWeight = weights.reduce((a, b) => a > b ? a : b) + 2;

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            minY: minWeight,
            maxY: maxWeight,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 2,
              getDrawingHorizontalLine:
                  (value) => FlLine(
                    color: theme.colorScheme.onSurface.withAlpha(12),
                    strokeWidth: 1,
                  ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  interval: (spots.length / 5).ceilToDouble().clamp(1, 10),
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= weightData.length) {
                      return const SizedBox();
                    }
                    final date = weightData[index]['date'] as DateTime;
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '${date.day}/${date.month}',
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.colorScheme.onSurface.withAlpha(100),
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 2,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}',
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.colorScheme.onSurface.withAlpha(100),
                      ),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              // Weight line
              LineChartBarData(
                spots: spots,
                isCurved: true,
                curveSmoothness: 0.3,
                color: AppColors.primary,
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: AppColors.primary,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withAlpha(60),
                      AppColors.primary.withAlpha(0),
                    ],
                  ),
                ),
              ),
              // Target weight line
              if (targetWeight != null)
                LineChartBarData(
                  spots: [
                    FlSpot(0, targetWeight!),
                    FlSpot(spots.length.toDouble() - 1, targetWeight!),
                  ],
                  isCurved: false,
                  color: AppColors.success.withAlpha(120),
                  barWidth: 1,
                  dashArray: [5, 5],
                  dotData: const FlDotData(show: false),
                ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y.toStringAsFixed(1)} kg',
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
