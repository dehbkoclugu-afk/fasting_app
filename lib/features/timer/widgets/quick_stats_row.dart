import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../shared/widgets/glass_card.dart';

class QuickStatsRow extends StatefulWidget {
  final int streak;
  final int waterMl;
  final int waterGoalMl;
  final VoidCallback onAddWater;

  const QuickStatsRow({
    super.key,
    required this.streak,
    required this.waterMl,
    required this.waterGoalMl,
    required this.onAddWater,
  });

  @override
  State<QuickStatsRow> createState() => _QuickStatsRowState();
}

class _QuickStatsRowState extends State<QuickStatsRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _waterBounceController;
  late Animation<double> _waterBounceAnimation;

  @override
  void initState() {
    super.initState();
    _waterBounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _waterBounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _waterBounceController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void didUpdateWidget(QuickStatsRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waterMl != widget.waterMl && widget.waterMl > oldWidget.waterMl) {
      _waterBounceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _waterBounceController.dispose();
    super.dispose();
  }

  void _handleAddWater() {
    HapticFeedback.lightImpact();
    widget.onAddWater();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final waterProgress = widget.waterGoalMl > 0
        ? (widget.waterMl / widget.waterGoalMl).clamp(0.0, 1.0)
        : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Streak
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.streak}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.stats_streak,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Water
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              onTap: _handleAddWater,
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: _waterBounceAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _waterBounceAnimation.value,
                        child: child,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Water progress circle
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: CircularProgressIndicator(
                            value: waterProgress,
                            strokeWidth: 2.5,
                            backgroundColor: Colors.blue.withValues(alpha: 0.1),
                            valueColor: const AlwaysStoppedAnimation(Colors.blue),
                          ),
                        ),
                        PhosphorIcon(
                          PhosphorIcons.drop(PhosphorIconsStyle.fill),
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatWater(widget.waterMl),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '/ ${_formatWater(widget.waterGoalMl)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue.withValues(alpha: 0.5),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatWater(int ml) {
    if (ml >= 1000) {
      return '${(ml / 1000).toStringAsFixed(1)}L';
    }
    return '${ml}ml';
  }
}
