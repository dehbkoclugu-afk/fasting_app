import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';

final _lastChallengeHourProvider = FutureProvider<int?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('last_crisis_hour');
});

class MetabolicWeather extends ConsumerWidget {
  const MetabolicWeather({
    super.key,
    required this.waterProgress,
    required this.streak,
    required this.elapsedHours,
  });

  final double waterProgress;
  final int streak;
  final double elapsedHours;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final strong = waterProgress >= .5 && streak > 0;
    final icon = strong ? Icons.wb_sunny_outlined : Icons.cloud_outlined;
    final title = strong ? l10n.weather_steady : l10n.weather_gentle;
    final body =
        waterProgress < .35
            ? l10n.weather_water
            : elapsedHours >= 12
            ? l10n.weather_listen
            : l10n.weather_onPlan;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: (strong ? AppColors.warning : AppColors.tertiary).withValues(
          alpha: .09,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: strong ? AppColors.warning : AppColors.tertiary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall),
                Text(
                  ref.watch(_lastChallengeHourProvider).valueOrNull ==
                          DateTime.now().hour
                      ? l10n.weather_challenging
                      : body,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: .62),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
