import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

class MonthlyHeatmap extends StatelessWidget {
  final Map<DateTime, double> data; // date -> hours fasted
  final DateTime month;

  const MonthlyHeatmap({super.key, required this.data, required this.month});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final startWeekday = firstDay.weekday; // 1=Mon
    final totalDays = lastDay.day;

    final dayLabels = [
      l10n.day_short_mon,
      l10n.day_short_tue,
      l10n.day_short_wed,
      l10n.day_short_thu,
      l10n.day_short_fri,
      l10n.day_short_sat,
      l10n.day_short_sun,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month header with nav
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_monthName(context, month.month)} ${month.year}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                _buildLegendDot(context, l10n.heatmap_none, Colors.transparent),
                const SizedBox(width: 8),
                _buildLegendDot(
                  context,
                  l10n.heatmap_low,
                  AppColors.primary.withAlpha(60),
                ),
                const SizedBox(width: 8),
                _buildLegendDot(
                  context,
                  l10n.heatmap_good,
                  AppColors.primary.withAlpha(140),
                ),
                const SizedBox(width: 8),
                _buildLegendDot(context, l10n.heatmap_full, AppColors.primary),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Day labels row
        Row(
          children:
              dayLabels
                  .map(
                    (l) => Expanded(
                      child: Center(
                        child: Text(
                          l,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(100),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 4),

        // Calendar grid
        ...List.generate(_totalWeeks(startWeekday, totalDays), (weekIndex) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex - (startWeekday - 2);
                if (dayNumber < 1 || dayNumber > totalDays) {
                  return Expanded(child: Container());
                }

                final date = DateTime(month.year, month.month, dayNumber);
                final hours =
                    data[DateTime(date.year, date.month, date.day)] ?? 0;
                final isFuture = date.isAfter(DateTime.now());
                final now = DateTime.now();
                final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

                return Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        color:
                            isFuture
                                ? Colors.transparent
                                : _getHeatColor(hours, theme),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isToday ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withValues(alpha: isFuture ? .45 : .22),
                          width: isToday ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$dayNumber',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color:
                                hours >= 12
                                    ? Colors.white
                                    : theme.colorScheme.onSurface.withAlpha(
                                      isFuture ? 50 : 150,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  int _totalWeeks(int startWeekday, int totalDays) {
    return ((startWeekday - 1 + totalDays) / 7).ceil();
  }

  Color _getHeatColor(double hours, ThemeData theme) {
    if (hours <= 0) {
      return theme.brightness == Brightness.dark
          ? Colors.white.withAlpha(8)
          : Colors.black.withAlpha(8);
    }
    if (hours < 8) return AppColors.primary.withAlpha(50);
    if (hours < 14) return AppColors.primary.withAlpha(100);
    if (hours < 18) return AppColors.primary.withAlpha(160);
    return AppColors.primary;
  }

  Widget _buildLegendDot(BuildContext context, String label, Color color) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color:
                color == Colors.transparent
                    ? theme.colorScheme.onSurface.withAlpha(15)
                    : color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
        ),
      ],
    );
  }

  String _monthName(BuildContext context, int month) {
    final l10n = AppLocalizations.of(context)!;
    final names = [
      '',
      l10n.month_jan,
      l10n.month_feb,
      l10n.month_mar,
      l10n.month_apr,
      l10n.month_may,
      l10n.month_jun,
      l10n.month_jul,
      l10n.month_aug,
      l10n.month_sep,
      l10n.month_oct,
      l10n.month_nov,
      l10n.month_dec,
    ];
    return names[month];
  }
}
