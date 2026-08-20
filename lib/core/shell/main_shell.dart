import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/timer/providers/timer_provider.dart';
import '../../features/timer/widgets/completion_overlay.dart';
import '../../features/paywall/providers/subscription_provider.dart';
import '../../services/admob_service.dart';
import '../constants/fasting_plans.dart';
import '../utils/metabolic_phase_l10n.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/timer')) return 0;
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/stats')) return 2;
    if (location.startsWith('/achievements')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    HapticFeedback.selectionClick();
    switch (index) {
      case 0:
        context.go('/timer');
        return;
      case 1:
        context.go('/explore');
        return;
      case 2:
        context.go('/stats');
        return;
      case 3:
        context.go('/achievements');
        return;
      case 4:
        context.go('/profile');
        return;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = _currentIndex(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final completionVisible = ref.watch(
      timerProvider.select((timer) => timer.status == TimerStatus.completed),
    );
    final timer = ref.read(timerProvider);
    final destinations = <(IconData, IconData, String)>[
      (
        PhosphorIcons.house(),
        PhosphorIcons.house(PhosphorIconsStyle.fill),
        l10n.tab_timer,
      ),
      (
        PhosphorIcons.compass(),
        PhosphorIcons.compass(PhosphorIconsStyle.fill),
        l10n.tab_explore,
      ),
      (
        PhosphorIcons.chartBar(),
        PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
        l10n.tab_stats,
      ),
      (
        PhosphorIcons.trophy(),
        PhosphorIcons.trophy(PhosphorIconsStyle.fill),
        l10n.tab_achievements,
      ),
      (
        PhosphorIcons.user(),
        PhosphorIcons.user(PhosphorIconsStyle.fill),
        l10n.tab_profile,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          if (completionVisible)
            Positioned.fill(
              child: CompletionOverlay(
                durationMinutes: timer.elapsedSeconds ~/ 60,
                targetMinutes: timer.targetSeconds ~/ 60,
                planName: FastingPlans.getById(timer.planId).name,
                phaseName: metabolicPhaseName(l10n, timer.currentPhase),
                onDismiss: () {
                  ref.read(timerProvider.notifier).resetTimer();
                  if (!ref.read(isPremiumProvider)) {
                    AdmobService().showInterstitialAd();
                  }
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar:
          completionVisible
              ? null
              : SafeArea(
                top: false,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: theme.dividerColor.withValues(alpha: .45),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha:
                              theme.brightness == Brightness.dark ? .24 : .06,
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 68,
                    child: Row(
                      children: List.generate(destinations.length, (index) {
                        final selected = index == currentIndex;
                        final destination = destinations[index];
                        final color =
                            selected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface.withValues(
                                  alpha: .54,
                                );
                        return Expanded(
                          child: Semantics(
                            selected: selected,
                            button: true,
                            label: destination.$3,
                            child: InkResponse(
                              onTap: () => _onTap(context, index),
                              radius: 34,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    width: selected ? 22 : 0,
                                    height: 3,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                  ),
                                  PhosphorIcon(
                                    selected ? destination.$2 : destination.$1,
                                    size: 22,
                                    color: color,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    destination.$3,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: color,
                                      fontWeight:
                                          selected
                                              ? FontWeight.w800
                                              : FontWeight.w600,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
    );
  }
}
