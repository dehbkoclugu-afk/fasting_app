import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../providers/timer_provider.dart';

class TimerControls extends StatelessWidget {
  const TimerControls({
    super.key,
    required this.status,
    required this.onStart,
    required this.onStop,
    this.enabled = true,
  });

  final TimerStatus status;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isIdle =
        status == TimerStatus.idle || status == TimerStatus.completed;

    return SizedBox(
      width: isIdle ? double.infinity : 190,
      height: 56,
      child: FilledButton.icon(
        onPressed:
            enabled
                ? () {
                  HapticFeedback.mediumImpact();
                  isIdle ? onStart() : onStop();
                }
                : null,
        style: FilledButton.styleFrom(
          backgroundColor:
              isIdle
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
          foregroundColor:
              isIdle
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.surface,
          textStyle: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        icon: Icon(
          isIdle
              ? PhosphorIcons.play(PhosphorIconsStyle.fill)
              : PhosphorIcons.stop(PhosphorIconsStyle.fill),
          size: 18,
        ),
        label: Text(isIdle ? l10n.timer_start : l10n.timer_stop),
      ),
    );
  }
}
