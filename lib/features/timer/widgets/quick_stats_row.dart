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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: AppColors.tertiary.withValues(alpha: .12), borderRadius: BorderRadius.circular(99)),
                child: Text('${(waterProgress * 100).round()}%', style: theme.textTheme.labelSmall?.copyWith(color: AppColors.tertiary, fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _SummarySurface(
          artPath: 'assets/images/editorial/v3/quick-water.webp',
          height: 158,
          onTap: () => context.push('/water-tracker'),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.water_title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_formatWater(waterMl)} / ${_formatWater(waterGoalMl)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: .62),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: waterProgress,
                    minHeight: 7,
                    backgroundColor: AppColors.tertiary.withValues(alpha: .1),
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.tertiary,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      onAddWater();
                    },
                    icon: Icon(PhosphorIcons.plus(), size: 17),
                    label: const Text('+250 ml'),
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
                  value:
                      currentWeight == null
                          ? '—'
                          : '${currentWeight.toStringAsFixed(1)} kg',
                  label:
                      targetWeight == null
                          ? l10n.stats_weightChange
                          : l10n.home_weightGoal(
                            targetWeight.toStringAsFixed(1),
                          ).replaceFirst(' ', '\n'),
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, height >= 150 ? 112 : 58, 16),
              child: child,
            ),
          ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 86,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -.25,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .72),
                fontWeight: FontWeight.w700,
                height: 1.12,
              ),
            ),
          ],
      ),
    );
  }
}
