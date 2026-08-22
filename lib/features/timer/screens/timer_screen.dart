import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/constants/metabolic_phases.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/timer_provider.dart';
import '../providers/water_provider.dart';
import '../providers/fasting_session_provider.dart';
import '../widgets/fasting_ring.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/crisis_mode_sheet.dart';
import '../widgets/metabolic_journey.dart';
import '../../../services/admob_service.dart';
import '../../paywall/providers/subscription_provider.dart';
import '../../stats/providers/stats_provider.dart';
import '../../../shared/widgets/fasting_art_slot.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _PlanButton extends StatelessWidget {
  const _PlanButton({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: Material(
        color: theme.colorScheme.surface.withValues(alpha: .82),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: .08),
          ),
        ),
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIcons.clockCountdown(),
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 7),
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (enabled) ...[
                  const SizedBox(width: 5),
                  Icon(
                    PhosphorIcons.caretDown(),
                    size: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: .5),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  @override
  void initState() {
    super.initState();
    AdmobService().loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);
    final waterState = ref.watch(waterProvider);
    final streak = ref.watch(streakProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final plan = FastingPlans.getById(timerState.planId);

    final isActive = timerState.status == TimerStatus.running;

    // Bitiş zamanı hesapla
    DateTime? endTime;
    if (isActive && timerState.startTime != null) {
      endTime = timerState.startTime!.add(
        Duration(seconds: timerState.targetSeconds),
      );
    }

    // Oruç doğal tamamlandığında overlay göster
    ref.listen<TimerState>(timerProvider, (prev, next) {
      if (prev?.status == TimerStatus.running &&
          next.status == TimerStatus.completed &&
          next.progress >= 1.0) {
        ref.read(fastingSessionProvider.notifier).loadSessions();
        _invalidateStatsProviders(ref);
      }
    });

    final accent =
        isActive
            ? timerState.currentPhase.gradientColors.first
            : theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -100,
            child: IgnorePointer(
              child: Container(
                width: 310,
                height: 310,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(
                    alpha: theme.brightness == Brightness.dark ? .12 : .07,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontal = constraints.maxWidth >= 700;
                final gutter = horizontal ? 40.0 : 12.0;
                final ringSize = math.min(
                  horizontal ? 340.0 : 292.0,
                  constraints.maxWidth - gutter * 2 - (horizontal ? 64 : 16),
                );

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(gutter, 12, gutter, 32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 760),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _greeting(l10n),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: .56),
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      l10n.home_todayRhythm,
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -.7,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              _PlanButton(
                                label: plan.shortName,
                                enabled: !isActive,
                                onPressed:
                                    () => _showPlanSelector(context, ref),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              horizontal ? 32 : 8,
                              28,
                              horizontal ? 32 : 8,
                              24,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface.withValues(
                                alpha:
                                    theme.brightness == Brightness.dark
                                        ? .78
                                        : .92,
                              ),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: .06,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: accent.withValues(alpha: .07),
                                  blurRadius: 40,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                FastingRing(
                                  size: ringSize,
                                  progress: timerState.progress,
                                  elapsedHours: timerState.elapsedHours,
                                  targetHours: timerState.targetSeconds / 3600,
                                  phaseColors:
                                      isActive
                                          ? timerState
                                              .currentPhase
                                              .gradientColors
                                          : const [
                                            AppColors.primary,
                                            AppColors.primaryLight,
                                          ],
                                  child: TimerDisplay(
                                    elapsed: timerState.elapsedFormatted,
                                    remaining: timerState.remainingFormatted,
                                    phaseLabel:
                                        isActive
                                            ? _phaseName(
                                              l10n,
                                              timerState.currentPhase,
                                            )
                                            : plan.shortName,
                                    isRunning: isActive,
                                    progress: timerState.progress,
                                    endTime: endTime,
                                  ),
                                ),
                                if (isActive &&
                                    timerState.startTime != null) ...[
                                  const SizedBox(height: 2),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: .035),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _buildTimeLabel(
                                          context,
                                          label: l10n.timer_start,
                                          time: _formatTime(
                                            timerState.startTime!,
                                          ),
                                        ),
                                        Container(
                                          width: 42,
                                          height: 1,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                          ),
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: .12),
                                        ),
                                        if (endTime != null)
                                          _buildTimeLabel(
                                            context,
                                            label: l10n.timer_stop,
                                            time: _formatTime(endTime),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 22),
                                TimerControls(
                                  status: timerState.status,
                                  onStart: timerNotifier.startFasting,
                                  onStop: () => _confirmStop(context, ref),
                                  enabled: !timerState.isBusy,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          if (isActive) ...[
                            MetabolicJourney(
                              elapsedHours: timerState.elapsedHours,
                              targetHours: timerState.targetSeconds / 3600,
                              startTime: timerState.startTime!,
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton.icon(
                              onPressed: () => showCrisisMode(context),
                              icon: Icon(PhosphorIcons.heart()),
                              label: Text(
                                timerState.remainingSeconds <= 3600
                                    ? l10n.home_finalHourSupport
                                    : l10n.home_needSupport,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          if (!isActive || timerState.remainingSeconds > 3600)
                            QuickStatsRow(
                              streak: streak,
                              waterMl: waterState.totalMl,
                              waterGoalMl: waterState.goalMl,
                              onAddWater: () => _addWater(context, ref),
                            ),
                          const SizedBox(height: 14),
                          _buildMealsCard(context, l10n),
                          const SizedBox(height: 14),
                          _buildGuideCard(context, l10n),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greeting_morning;
    if (hour < 18) return l10n.greeting_afternoon;
    return l10n.greeting_evening;
  }

  Widget _buildGuideCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/explore'),
        borderRadius: BorderRadius.circular(24),
        child: FastingSplitArtCard(
          assetPath: 'assets/images/editorial/fasting-guide-hero.webp',
          minHeight: 146,
          artWidth: 174,
          semanticLabel: l10n.explore_guide,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  l10n.explore_guide,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: fastingArtForeground(context),
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.35,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.explore_guideDesc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: fastingArtMutedForeground(context),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealsCard(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/meals'),
        borderRadius: BorderRadius.circular(24),
        child: FastingSplitArtCard(
          assetPath: 'assets/images/editorial/tip-balanced-meal.webp',
          minHeight: 136,
          artWidth: 174,
          semanticLabel: l10n.meals_addMeal,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  l10n.meals_title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: fastingArtForeground(context),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: Colors.white, size: 17),
                      const SizedBox(width: 5),
                      Text(
                        l10n.meals_addMeal,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _phaseName(AppLocalizations l10n, MetabolicPhase phase) {
    return switch (phase.id) {
      'anabolic' => l10n.phase_anabolic,
      'catabolic' => l10n.phase_catabolic,
      'fatBurning' => l10n.phase_fatBurning,
      'ketosis' => l10n.phase_ketosis,
      _ => l10n.phase_autophagy,
    };
  }

  Widget _buildTimeLabel(
    BuildContext context, {
    required String label,
    required String time,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _invalidateStatsProviders(WidgetRef ref) {
    ref.invalidate(statsProvider(7));
    ref.invalidate(statsProvider(30));
    ref.invalidate(statsProvider(365));
    ref.invalidate(weightHistoryProvider);
    // heatmap will refresh when stats screen rebuilds
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showPlanSelector(BuildContext context, WidgetRef ref) {
    final isActive = ref.read(timerProvider).status == TimerStatus.running;
    if (isActive) return;
    final router = GoRouter.of(context);
    var selectedId = ref.read(timerProvider).planId;
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(builder: (context, setSheetState) {
        final theme = Theme.of(context);
        final l10n = AppLocalizations.of(context)!;
        final isPremium = ref.read(isPremiumProvider);
        final selected = FastingPlans.getById(selectedId);
        return SafeArea(
          top: false,
          child: FractionallySizedBox(
            heightFactor: .82,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 16, 12),
                  child: Row(children: [
                    Expanded(child: Text(l10n.timer_selectPlan, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900))),
                    IconButton(onPressed: () => Navigator.pop(sheetContext), icon: const Icon(Icons.close_rounded)),
                  ]),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: FastingPlans.all.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final plan = FastingPlans.all[index];
                      final locked = plan.isPremium && !isPremium;
                      final active = plan.id == selectedId;
                      return Material(
                        color: active ? theme.colorScheme.primaryContainer.withValues(alpha: .42) : theme.colorScheme.surfaceContainerLow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: active ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: .45), width: active ? 1.6 : 1),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            HapticFeedback.selectionClick();
                            if (locked) {
                              Navigator.pop(sheetContext);
                              router.push('/paywall');
                            } else {
                              setSheetState(() => selectedId = plan.id);
                            }
                          },
                          child: FastingSplitArtCard(
                            assetPath: 'assets/images/editorial/v3/plan-clock-${switch (plan.id) { 'eat_stop_eat' => 'ese', _ => plan.id.replaceAll('_', '-') }}.webp',
                            minHeight: 178,
                            artWidth: 148,
                            borderRadius: 19,
                            fit: BoxFit.cover,
                            semanticLabel: plan.name,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 15, 12, 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Flexible(child: Text(plan.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900))),
                                            if (locked) ...[
                                              const SizedBox(width: 7),
                                              Icon(Icons.lock_outline_rounded, size: 16, color: theme.colorScheme.primary),
                                            ],
                                          ]),
                                          const SizedBox(height: 3),
                                          Text(plan.description(l10n), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.25)),
                                          const SizedBox(height: 9),
                                          Row(children: [
                                            Expanded(flex: plan.fastingHours, child: Container(height: 5, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(9)))),
                                            if (plan.eatingHours > 0) Expanded(flex: plan.eatingHours, child: Container(height: 5, decoration: BoxDecoration(color: AppColors.success.withValues(alpha: .55), borderRadius: BorderRadius.circular(9)))),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(active ? Icons.check_circle_rounded : Icons.circle_outlined, color: active ? theme.colorScheme.primary : theme.colorScheme.outlineVariant),
                                  ],
                                ),
                              ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        ref.read(timerProvider.notifier).changePlan(selected.id);
                        Navigator.pop(sheetContext);
                      },
                      child: Text('${l10n.common_save} · ${selected.name}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _confirmStop(BuildContext context, WidgetRef ref) {
    final timerState = ref.read(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    showDialog(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx)!;
        return AlertDialog(
          title: Text(l10n.timer_stopTitle),
          content: Text(l10n.timer_stopConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.common_cancel),
            ),
            ElevatedButton(
              onPressed:
                  timerState.isBusy
                      ? null
                      : () async {
                        await timerNotifier.stopFasting();
                        await ref
                            .read(fastingSessionProvider.notifier)
                            .loadSessions();
                        _invalidateStatsProviders(ref);
                        if (!ctx.mounted) return;
                        Navigator.pop(ctx);
                      },
              child: Text(l10n.timer_confirmStop),
            ),
          ],
        );
      },
    );
  }

  void _addWater(BuildContext context, WidgetRef ref) {
    HapticFeedback.lightImpact();
    ref.read(waterProvider.notifier).addWater(250);
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.waterAdded),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
