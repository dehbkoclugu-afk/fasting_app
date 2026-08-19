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
import '../widgets/completion_overlay.dart';
import '../widgets/crisis_mode_sheet.dart';
import '../widgets/metabolic_journey.dart';
import '../widgets/metabolic_weather.dart';
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
  bool _showCompletion = false;

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
        setState(() => _showCompletion = true);
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
                  horizontal ? 340.0 : 318.0,
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
                            MetabolicWeather(
                              waterProgress: waterState.progress,
                              streak: streak,
                              elapsedHours: timerState.elapsedHours,
                            ),
                            const SizedBox(height: 12),
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
          // Completion overlay
          if (_showCompletion)
            CompletionOverlay(
              durationMinutes: timerState.elapsedSeconds ~/ 60,
              planName: plan.name,
              phaseName: _phaseName(l10n, timerState.currentPhase),
              targetMinutes: timerState.targetSeconds ~/ 60,
              onDismiss: () {
                ref.read(timerProvider.notifier).resetTimer();
                setState(() => _showCompletion = false);
                if (!ref.read(isPremiumProvider)) {
                  AdmobService().showInterstitialAd();
                }
              },
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
        child: FastingArtSlot(
          assetPath: 'assets/images/editorial/fasting-guide-hero.webp',
          height: 146,
          variant: FastingArtVariant.card,
          semanticLabel: l10n.explore_guide,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 110, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.explore_guide,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.35,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.explore_guideDesc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: .9),
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
        child: FastingArtSlot(
          assetPath: 'assets/images/editorial/tip-balanced-meal.webp',
          height: 136,
          variant: FastingArtVariant.row,
          alignment: Alignment.centerRight,
          semanticLabel: l10n.meals_addMeal,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 122, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: .25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        PhosphorIcons.forkKnife(
                          PhosphorIconsStyle.fill,
                        ),
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      l10n.meals_title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.timer_selectPlan,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ...FastingPlans.all.map((plan) {
                final isPremium = ref.read(isPremiumProvider);
                final isLocked = plan.isPremium && !isPremium;
                return ListTile(
                  leading: Icon(
                    plan.icon,
                    color:
                        isLocked
                            ? Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.3)
                            : null,
                  ),
                  title: Text(
                    plan.name,
                    style:
                        isLocked
                            ? TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.4),
                            )
                            : null,
                  ),
                  subtitle: Text(
                    plan.description(AppLocalizations.of(context)!),
                  ),
                  trailing:
                      isLocked
                          ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  AppColors.secondary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'PRO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                          : null,
                  onTap: () {
                    if (isLocked) {
                      Navigator.pop(context);
                      context.push('/paywall');
                      return;
                    }
                    HapticFeedback.selectionClick();
                    ref.read(timerProvider.notifier).changePlan(plan.id);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
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
