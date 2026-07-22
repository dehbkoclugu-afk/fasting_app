import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../timer/providers/water_provider.dart';
import '../widgets/water_drop_painter.dart';

class WaterTrackerScreen extends ConsumerWidget {
  const WaterTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterState = ref.watch(waterProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final progress =
        waterState.goalMl > 0
            ? (waterState.totalMl / waterState.goalMl).clamp(0.0, 1.0)
            : 0.0;

    final now = DateTime.now();
    final weekday = now.weekday; // 1=Mon
    final weekStart = now.subtract(Duration(days: weekday - 1));
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.water_title)),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            // Hafta gün seçici
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (i) {
                final dayNum = i + 1;
                final isToday = dayNum == weekday;
                final date = weekStart.add(Duration(days: i));
                final dayLabel = DateFormat.E(locale).format(date);
                return Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isToday
                            ? AppColors.tertiary
                            : AppColors.tertiary.withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: Text(
                      dayLabel.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: isToday ? Colors.white : AppColors.tertiary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 32),

            // Büyük damla görseli
            SizedBox(
              width: 180,
              height: 240,
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: progress),
                duration:
                    MediaQuery.of(context).disableAnimations
                        ? Duration.zero
                        : const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder:
                    (context, value, _) => CustomPaint(
                      painter: WaterDropPainter(
                        fillPercent: value,
                        waterColor: AppColors.tertiary,
                      ),
                    ),
              ),
            ),

            const SizedBox(height: 20),

            // mL gösterge
            Text(
              '${waterState.totalMl} ml',
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.tertiary,
              ),
            ),
            Text(
              '${l10n.water_goal}: ${waterState.goalMl} ml',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),

            const SizedBox(height: 8),

            // % completed
            Text(
              '${(progress * 100).toInt()}%',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  ref.read(waterProvider.notifier).addWater(250);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.tertiary,
                ),
                icon: Icon(
                  PhosphorIcons.drop(PhosphorIconsStyle.fill),
                  size: 20,
                ),
                label: const Text('+250 ml'),
              ),
            ),

            const SizedBox(height: 32),

            // Daily goal progress bar
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.water_goal,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: AppColors.tertiary.withValues(
                        alpha: 0.1,
                      ),
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.tertiary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${waterState.totalMl} ml',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${waterState.goalMl} ml',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
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
}
