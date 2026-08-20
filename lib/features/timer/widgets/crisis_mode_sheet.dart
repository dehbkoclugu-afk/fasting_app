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
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
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
    final guidance = _guidance(l10n);
    final current = _step == 0
        ? (
            l10n.crisis_nameTitle,
            l10n.crisis_nameDesc,
            Icons.favorite_outline,
            '',
            l10n.onboarding_next,
          )
        : guidance;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
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
          Icon(
            _step == 0 ? Icons.favorite_outline : current.$3,
            color: AppColors.primary,
            size: 40,
          ),
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
          if (_step == 1) ...[
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                current.$4,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
            ),
          ],
          const SizedBox(height: 26),
          FilledButton(
            onPressed: _step == 0 && _reason == null
                ? null
                : () async {
                    HapticFeedback.selectionClick();
                    if (_step == 0) {
                      setState(() => _step++);
                      return;
                    }
                    await _finish();
                  },
            child: Text(
              _step == 0 ? l10n.onboarding_next : current.$5,
            ),
          ),
          if (_step == 1) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.timer_stopTitle),
            ),
            Text(
              l10n.crisis_delayDesc,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          ],
        ),
      ),
    );
  }

  (String, String, IconData, String, String) _guidance(AppLocalizations l10n) {
    if (_reason == l10n.crisis_habit) {
      return (
        l10n.crisis_habit,
        l10n.crisis_nameDesc,
        Icons.route_outlined,
        l10n.crisis_delayTitle,
        l10n.onboarding_next,
      );
    }
    if (_reason == l10n.crisis_stress) {
      return (
        l10n.crisis_stress,
        l10n.crisis_waterDesc,
        Icons.air_outlined,
        l10n.crisis_waterTitle,
        l10n.crisis_tenMore,
      );
    }
    return (
      l10n.crisis_hunger,
      l10n.crisis_delayDesc,
      Icons.monitor_heart_outlined,
      '${l10n.crisis_waterTitle}. ${l10n.crisis_waterDesc}',
      l10n.crisis_tenMore,
    );
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'crisis_support_count',
      (prefs.getInt('crisis_support_count') ?? 0) + 1,
    );
    await prefs.setInt('last_crisis_hour', DateTime.now().hour);
    if (_reason != null) await prefs.setString('last_crisis_reason', _reason!);
    if (mounted) Navigator.pop(context);
  }
}
