import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({
    super.key,
    required this.weightData,
    this.targetWeight,
  });

  final List<Map<String, dynamic>> weightData;
  final double? targetWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (weightData.isEmpty) {
      return FastingSplitArtCard(
        assetPath: 'assets/images/editorial/v4/report-weight.webp',
        minHeight: 176,
        artWidth: 150,
        borderRadius: 24,
        alignment: Alignment.centerRight,
        semanticLabel: l10n.weight_noRecord,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                size: 30,
                color: AppColors.primaryLight,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.weight_noRecord,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: fastingArtForeground(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final spots = weightData.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value['weight'] as double);
    }).toList();
    final weights = weightData.map((data) => data['weight'] as double).toList();
    final minWeight = weights.reduce((a, b) => a < b ? a : b) - 2;
    final maxWeight = weights.reduce((a, b) => a > b ? a : b) + 2;

    return Container(
      height: 236,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: .45)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LineChart(
          LineChartData(
            minY: minWeight,
            maxY: maxWeight,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 2,
              getDrawingHorizontalLine: (_) => FlLine(
                color: fastingArtDivider(context),
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
                          color: fastingArtMutedForeground(context),
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
                  getTitlesWidget: (value, meta) => Text(
                    '${value.toInt()}',
                    style: TextStyle(
                      fontSize: 10,
                      color: fastingArtMutedForeground(context),
                    ),
                  ),
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
              LineChartBarData(
                spots: spots,
                isCurved: true,
                curveSmoothness: .3,
                color: AppColors.primaryLight,
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.primary,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withValues(alpha: .38),
                      AppColors.primary.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
              if (targetWeight != null)
                LineChartBarData(
                  spots: [
                    FlSpot(0, targetWeight!),
                    FlSpot(spots.length.toDouble() - 1, targetWeight!),
                  ],
                  isCurved: false,
                  color: AppColors.success.withValues(alpha: .75),
                  barWidth: 1,
                  dashArray: [5, 5],
                  dotData: const FlDotData(show: false),
                ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) => touchedSpots
                    .map(
                      (spot) => LineTooltipItem(
                        '${spot.y.toStringAsFixed(1)} kg',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
