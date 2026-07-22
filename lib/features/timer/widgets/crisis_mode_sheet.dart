import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';

Future<void> showCrisisMode(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _CrisisModeSheet(),
  );
}

class _CrisisModeSheet extends StatefulWidget {
  const _CrisisModeSheet();

  @override
  State<_CrisisModeSheet> createState() => _CrisisModeSheetState();
}

class _CrisisModeSheetState extends State<_CrisisModeSheet> {
  int _step = 0;
  String? _reason;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final steps = [
      (l10n.crisis_nameTitle, l10n.crisis_nameDesc),
      (l10n.crisis_waterTitle, l10n.crisis_waterDesc),
      (l10n.crisis_delayTitle, l10n.crisis_delayDesc),
    ];
    final current = steps[_step];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Icon(Icons.favorite_outline, color: AppColors.primary, size: 36),
          const SizedBox(height: 16),
          Text(
            current.$1,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            current.$2,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .65),
            ),
          ),
          if (_step == 0) ...[
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                for (final reason in [
                  l10n.crisis_hunger,
                  l10n.crisis_habit,
                  l10n.crisis_stress,
                ])
                  ChoiceChip(
                    label: Text(reason),
                    selected: _reason == reason,
                    onSelected: (_) => setState(() => _reason = reason),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 26),
          FilledButton(
            onPressed: () async {
              HapticFeedback.selectionClick();
              if (_step < steps.length - 1) {
                setState(() => _step++);
                return;
              }
              final prefs = await SharedPreferences.getInstance();
              await prefs.setInt(
                'crisis_support_count',
                (prefs.getInt('crisis_support_count') ?? 0) + 1,
              );
              await prefs.setInt('last_crisis_hour', DateTime.now().hour);
              if (_reason != null) {
                await prefs.setString('last_crisis_reason', _reason!);
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(
              _step == steps.length - 1
                  ? l10n.crisis_tenMore
                  : l10n.onboarding_next,
            ),
          ),
        ],
      ),
    );
  }
}
