import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../../profile/providers/settings_provider.dart';
import '../../stats/providers/stats_provider.dart';

class QuickStatsRow extends ConsumerWidget {
  const QuickStatsRow({
    super.key,
    required this.streak,
    required this.waterMl,
    required this.waterGoalMl,
    required this.onAddWater,
  });

  final int streak;
  final int waterMl;
  final int waterGoalMl;
  final VoidCallback onAddWater;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final latestWeight = ref.watch(latestWeightProvider).valueOrNull;
    final currentWeight = latestWeight ?? settings.weight;
    final targetWeight = settings.targetWeight;
    final waterProgress =
        waterGoalMl > 0 ? (waterMl / waterGoalMl).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: [
              Text(
                l10n.home_todaySummary,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.2,
                ),
              ),
              const Spacer(),
              Text(
                '${(waterProgress * 100).round()}%',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SummarySurface(
          artPath: 'assets/images/editorial/v3/quick-water.webp',
          height: 116,
          onTap: () => context.push('/water-tracker'),
          child: Column(
            children: [
              Row(
                children: [
                  _IconTile(
                    color: AppColors.tertiary,
                    icon: PhosphorIcons.drop(PhosphorIconsStyle.fill),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.water_title,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_formatWater(waterMl)} / ${_formatWater(waterGoalMl)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: .55,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filled(
                    tooltip: l10n.water_addWater,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      onAddWater();
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      foregroundColor: Colors.white,
                    ),
                    icon: Icon(PhosphorIcons.plus(), size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: waterProgress,
                  minHeight: 7,
                  backgroundColor: AppColors.tertiary.withValues(alpha: .1),
                  valueColor: const AlwaysStoppedAnimation(AppColors.tertiary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummarySurface(
                artPath: 'assets/images/editorial/v3/quick-streak.webp',
                height: 118,
                child: _Metric(
                  icon: PhosphorIcons.fire(PhosphorIconsStyle.fill),
                  color: AppColors.warning,
                  value: '$streak',
                  label: l10n.home_dayStreak,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummarySurface(
                artPath: 'assets/images/editorial/v3/quick-weight.webp',
                height: 118,
                onTap: () => context.push('/weight-tracker'),
                child: _Metric(
                  icon: PhosphorIcons.scales(),
                  color: theme.colorScheme.primary,
                  value:
                      currentWeight == null
                          ? '—'
                          : '${currentWeight.toStringAsFixed(1)} kg',
                  label:
                      targetWeight == null
                          ? l10n.stats_weightChange
                          : l10n.home_weightGoal(
                            targetWeight.toStringAsFixed(1),
                          ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatWater(int ml) =>
      ml >= 1000 ? '${(ml / 1000).toStringAsFixed(1)} L' : '$ml ml';
}

class _SummarySurface extends StatelessWidget {
  const _SummarySurface({
    required this.child,
    required this.artPath,
    required this.height,
    this.onTap,
  });

  final Widget child;
  final String artPath;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FastingArtSlot(
      assetPath: artPath,
      height: height,
      borderRadius: 22,
      alignment: Alignment.centerRight,
      variant: FastingArtVariant.card,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.all(16), child: child),
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: color.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Icon(icon, color: color, size: 23),
  );
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 86,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -.25,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .52),
            ),
          ),
        ],
      ),
    );
  }
}
