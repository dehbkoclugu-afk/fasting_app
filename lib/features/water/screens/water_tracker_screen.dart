import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../../timer/providers/water_provider.dart';

class WaterTrackerScreen extends ConsumerWidget {
  const WaterTrackerScreen({super.key});

  static const _amounts = [150, 250, 350, 500];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final water = ref.watch(waterProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final progress = water.progress;
    final remaining = (water.goalMl - water.totalMl).clamp(0, water.goalMl);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.water_title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
          FastingArtSlot(
            assetPath: 'assets/images/editorial/tip-hydration.webp',
            height: 178,
            borderRadius: 28,
            alignment: Alignment.centerRight,
            variant: FastingArtVariant.hero,
            semanticLabel: l10n.water_title,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 172, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.water_title, style: theme.textTheme.headlineSmall?.copyWith(color: fastingArtForeground(context), fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text('${water.totalMl} / ${water.goalMl} ml', style: theme.textTheme.titleMedium?.copyWith(color: fastingArtMutedForeground(context), fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: theme.dividerColor.withValues(alpha: .45)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 112,
                  height: 112,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(end: progress),
                        duration: MediaQuery.of(context).disableAnimations ? Duration.zero : const Duration(milliseconds: 650),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, _) => CircularProgressIndicator(
                          value: value,
                          strokeWidth: 11,
                          strokeCap: StrokeCap.round,
                          backgroundColor: AppColors.tertiary.withValues(alpha: .12),
                          color: AppColors.tertiary,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${(progress * 100).round()}%', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: AppColors.tertiary)),
                          Text(l10n.water_goal, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(remaining == 0 ? l10n.timer_completed : '$remaining ml', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(remaining == 0 ? l10n.timer_completedMessage : l10n.water_goal, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(value: progress, minHeight: 7, backgroundColor: AppColors.tertiary.withValues(alpha: .12), color: AppColors.tertiary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Text(l10n.water_addWater, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _amounts.map((amount) => _AmountButton(
              amount: amount,
              onPressed: () async {
                HapticFeedback.mediumImpact();
                await ref.read(waterProvider.notifier).addWater(amount);
              },
            )).toList(),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            decoration: BoxDecoration(color: AppColors.tertiary.withValues(alpha: .09), borderRadius: BorderRadius.circular(22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.history_rounded, size: 20, color: AppColors.tertiary),
                  const SizedBox(width: 8),
                  Text(l10n.home_todaySummary, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Text('${water.entries.length}', style: theme.textTheme.labelLarge?.copyWith(color: AppColors.tertiary, fontWeight: FontWeight.w800)),
                ]),
                const SizedBox(height: 12),
                if (water.entries.isEmpty)
                  Text(l10n.water_addWater, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: water.entries.reversed.take(8).map((entry) => Chip(label: Text('+${entry.amountMl} ml'), visualDensity: VisualDensity.compact)).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountButton extends StatelessWidget {
  const _AmountButton({required this.amount, required this.onPressed});
  final int amount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 50) / 2;
    return SizedBox(
      width: width,
      height: 58,
      child: FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: Text('$amount ml', style: const TextStyle(fontWeight: FontWeight.w800)),
        style: FilledButton.styleFrom(backgroundColor: AppColors.tertiary.withValues(alpha: .12), foregroundColor: AppColors.tertiary),
      ),
    );
  }
}
