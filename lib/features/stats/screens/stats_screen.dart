import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/banner_ad_widget.dart';
import '../../../shared/widgets/section_header.dart';
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
    final dayLabels = [l10n.day_mon, l10n.day_tue, l10n.day_wed, l10n.day_thu, l10n.day_fri, l10n.day_sat, l10n.day_sun];

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
              const SizedBox(height: 20),

              // Period selector
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.05),
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: Row(
                  children: List.generate(periods.length, (i) {
                    final isSelected = i == _selectedPeriod;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedPeriod = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Text(
                            periods[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface.withValues(alpha:0.5),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
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
                              icon: Icons.timer_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              context,
                              title: l10n.stats_average,
                              value: '${stats.averageDurationHours.toStringAsFixed(1)}s',
                              subtitle: l10n.stats_fastDuration,
                              icon: Icons.analytics_outlined,
                              color: AppColors.tertiary,
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
                              icon: Icons.local_fire_department_outlined,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              context,
                              title: l10n.stats_success,
                              value: '%${(stats.completionRate * 100).round()}',
                              subtitle: l10n.stats_completion,
                              icon: Icons.emoji_events_outlined,
                              color: AppColors.success,
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
                  final weekStats = weekStatsAsync.valueOrNull ?? const StatsData();
                  return GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 24,
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
                                        color: theme.colorScheme.onSurface.withValues(alpha:0.5),
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
                                  if (value % 8 != 0) return const SizedBox();
                                  return Text(
                                    '${value.toInt()}s',
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurface.withValues(alpha:0.4),
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 8,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: theme.colorScheme.onSurface.withValues(alpha:0.05),
                              strokeWidth: 1,
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(7, (i) =>
                            _makeBarGroup(i, weekStats.weeklyHours[i]),
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
                        onPressed: _heatmapMonth.month == DateTime.now().month &&
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
                  final heatmapAsync = ref.watch(heatmapProvider(_heatmapMonth));
                  final heatmapData = heatmapAsync.valueOrNull ?? const {};
                  return GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: MonthlyHeatmap(
                      data: heatmapData,
                      month: _heatmapMonth,
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
          gradient: y > 0
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
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.5),
            ),
          ),
        ],
      ),
    );
  }
}
