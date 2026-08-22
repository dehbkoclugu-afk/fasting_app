import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/banner_ad_widget.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../providers/stats_provider.dart';
import '../widgets/monthly_heatmap.dart';
import '../widgets/streak_card.dart';
import '../widgets/weight_chart.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  int _selectedPeriod = 0; // 0: Hafta, 1: Ay, 2: Yıl
  DateTime _heatmapMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final periods = [l10n.stats_week, l10n.stats_month, l10n.stats_year];
    final dayLabels = [
      l10n.day_mon,
      l10n.day_tue,
      l10n.day_wed,
      l10n.day_thu,
      l10n.day_fri,
      l10n.day_sat,
      l10n.day_sun,
    ];
    final selectedDays = [7, 30, 365][_selectedPeriod];
    final selectedStats =
        ref.watch(statsProvider(selectedDays)).valueOrNull ?? const StatsData();
    final story = selectedStats.totalSessions == 0
        ? l10n.stats_storyEmpty
        : l10n.stats_story(
            selectedStats.totalSessions,
            selectedStats.totalFastingHours,
            (selectedStats.completionRate * 100).round(),
          );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                l10n.stats_title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              FastingSplitArtCard(
                assetPath: 'assets/images/editorial/stats-progress.webp',
                minHeight: 190,
                artWidth: 168,
                alignment: Alignment.bottomRight,
                semanticLabel: l10n.stats_storyTitle,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.insights_outlined, color: theme.colorScheme.primary),
                      const SizedBox(height: 8),
                      Text(l10n.stats_storyTitle, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 7),
                      Text(story, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.35)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Period selector
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<int>(
                  segments: List.generate(
                    periods.length,
                    (index) => ButtonSegment(
                      value: index,
                      label: Text(periods[index]),
                    ),
                  ),
                  selected: {_selectedPeriod},
                  showSelectedIcon: false,
                  onSelectionChanged:
                      (selection) =>
                          setState(() => _selectedPeriod = selection.first),
                ),
              ),
              const SizedBox(height: 24),

              // Summary cards with real data
              Builder(
                builder: (context) {
                  final periodDays = [7, 30, 365][_selectedPeriod];
                  final statsAsync = ref.watch(statsProvider(periodDays));
                  final stats = statsAsync.valueOrNull ?? const StatsData();

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              context,
                              title: l10n.stats_totalFasts,
                              value: '${stats.totalSessions}',
                              subtitle: periods[_selectedPeriod].toLowerCase(),
                              artPath: 'assets/images/editorial/v3/stats-total.webp',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              context,
                              title: l10n.stats_average,
                              value:
                                  _formatHours(context, stats.averageDurationHours),
                              subtitle: l10n.stats_fastDuration,
                              artPath: 'assets/images/editorial/v3/stats-average.webp',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              context,
                              title: l10n.stats_streak,
                              value: '${stats.currentStreak}',
                              subtitle: l10n.stats_daysConsecutive,
                              artPath: 'assets/images/editorial/v3/stats-streak.webp',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              context,
                              title: l10n.stats_success,
                              value: '%${(stats.completionRate * 100).round()}',
                              subtitle: l10n.stats_completion,
                              artPath: 'assets/images/editorial/v3/stats-success.webp',
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Weekly chart
              SectionHeader(title: l10n.stats_weeklyFasting),
              Builder(
                builder: (context) {
                  final weekStatsAsync = ref.watch(statsProvider(7));
                  final weekStats =
                      weekStatsAsync.valueOrNull ?? const StatsData();
                  final peak = weekStats.weeklyHours.fold<double>(
                    0,
                    math.max,
                  );
                  final chartMax = math
                      .max(1.0, (peak * 1.2).ceilToDouble())
                      .toDouble();
                  final interval = chartMax <= 4 ? 1.0 : chartMax / 3;
                  return Container(
                    height: 236,
                    decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(24), border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: .45))),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: chartMax,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      dayLabels[value.toInt()],
                                      style: TextStyle(
                                        color: theme.colorScheme.onSurfaceVariant,
                                        fontSize: 11,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  if (value > 0 && (value / interval - (value / interval).round()).abs() > .08) return const SizedBox();
                                  return Text(
                                    value == 0 ? '0' : _formatHours(context, value),
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      fontSize: 10,
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
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: interval,
                            getDrawingHorizontalLine:
                                (value) => FlLine(
                                  color: theme.colorScheme.outlineVariant,
                                  strokeWidth: 1,
                                ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(
                            7,
                            (i) => _makeBarGroup(i, weekStats.weeklyHours[i]),
                          ),
                        ),
                      ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Streak card
              Builder(
                builder: (context) {
                  final periodDays = [7, 30, 365][_selectedPeriod];
                  final statsAsync = ref.watch(statsProvider(periodDays));
                  final stats = statsAsync.valueOrNull ?? const StatsData();
                  return StreakCard(
                    currentStreak: stats.currentStreak,
                    longestStreak: stats.longestStreak,
                    totalSessions: stats.totalSessions,
                  );
                },
              ),
              const SizedBox(height: 24),

              // Monthly heatmap with navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.stats_monthlyView,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, size: 20),
                        onPressed: () {
                          setState(() {
                            _heatmapMonth = DateTime(
                              _heatmapMonth.year,
                              _heatmapMonth.month - 1,
                            );
                          });
                        },
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, size: 20),
                        onPressed:
                            _heatmapMonth.month == DateTime.now().month &&
                                    _heatmapMonth.year == DateTime.now().year
                                ? null
                                : () {
                                  setState(() {
                                    _heatmapMonth = DateTime(
                                      _heatmapMonth.year,
                                      _heatmapMonth.month + 1,
                                    );
                                  });
                                },
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  final heatmapAsync = ref.watch(
                    heatmapProvider(_heatmapMonth),
                  );
                  final heatmapData = heatmapAsync.valueOrNull ?? const {};
                  return Container(
                    constraints: const BoxConstraints(minHeight: 300),
                    decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(24), border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: .45))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: MonthlyHeatmap(
                        data: heatmapData,
                        month: _heatmapMonth,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Weight chart
              SectionHeader(title: l10n.stats_weightChange),
              Builder(
                builder: (context) {
                  final weightAsync = ref.watch(weightHistoryProvider);
                  final weightData = weightAsync.valueOrNull ?? [];
                  return WeightChart(weightData: weightData);
                },
              ),

              const SizedBox(height: 16),
              const BannerAdWidget(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          gradient:
              y > 0
                  ? const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.primary, AppColors.primaryLight],
                  )
                  : null,
          color: y <= 0 ? Colors.transparent : null,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required String artPath,
  }) {
    final theme = Theme.of(context);
    return FastingArtSlot(
      assetPath: artPath,
      height: 158,
      borderRadius: 22,
      variant: FastingArtVariant.card,
      alignment: Alignment.bottomRight,
      fit: BoxFit.contain,
      semanticLabel: title,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.surface.withValues(alpha: .98), theme.colorScheme.surface.withValues(alpha: .78), Colors.transparent],
            stops: const [0, .58, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 62, 15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  value,
                  maxLines: 1,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }

  String _formatHours(BuildContext context, double hours) {
    final language = Localizations.localeOf(context).languageCode;
    if (hours <= 0) return language == 'tr' ? '0 sa' : '0 hr';
    if (hours < 1) {
      final minutes = (hours * 60).round();
      return language == 'tr' ? '$minutes dk' : '$minutes min';
    }
    final value = hours == hours.roundToDouble()
        ? hours.round().toString()
        : hours.toStringAsFixed(1);
    return language == 'tr' ? '$value sa' : '$value hr';
  }
}
