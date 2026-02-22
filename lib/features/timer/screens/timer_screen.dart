import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../providers/timer_provider.dart';
import '../providers/water_provider.dart';
import '../providers/fasting_session_provider.dart';
import '../widgets/fasting_ring.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';
import '../widgets/phase_indicator.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/completion_overlay.dart';
import '../../../services/admob_service.dart';
import '../../../shared/widgets/banner_ad_widget.dart';
import '../../paywall/providers/subscription_provider.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
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
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    final isActive = timerState.status == TimerStatus.running ||
        timerState.status == TimerStatus.paused;

    // Oruç doğal tamamlandığında overlay göster (progress >= 1.0)
    ref.listen<TimerState>(timerProvider, (prev, next) {
      if (prev?.status == TimerStatus.running &&
          next.status == TimerStatus.completed &&
          next.progress >= 1.0) {
        // Doğal tamamlama - session'ı kaydet ve kutla
        if (next.startTime != null) {
          ref.read(fastingSessionProvider.notifier).saveSession(
                planType: next.planId,
                startTime: next.startTime!,
                targetMinutes: next.targetSeconds ~/ 60,
                actualMinutes: next.elapsedSeconds ~/ 60,
                completed: true,
              );
        }
        setState(() => _showCompletion = true);
      }
    });

    return Scaffold(
      body: Stack(
      children: [
      SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intermittent Fasting',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getGreeting(l10n),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha:0.5),
                        ),
                      ),
                    ],
                  ),
                  // Plan selector
                  GestureDetector(
                    onTap: isActive
                        ? null
                        : () => _showPlanSelector(context, ref),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha:0.1),
                        borderRadius: AppSpacing.borderRadiusXl,
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(alpha:0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            plan.shortName,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          if (!isActive) ...[
                            const SizedBox(width: 4),
                            Icon(
                              PhosphorIcons.caretDown(),
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 1),

            // Fasting Ring
            FastingRing(
              progress: timerState.progress,
              phaseColors: isActive
                  ? timerState.currentPhase.gradientColors
                  : [AppColors.primary, AppColors.primaryDark],
              child: TimerDisplay(
                elapsed: timerState.elapsedFormatted,
                remaining: timerState.remainingFormatted,
                phaseLabel: isActive
                    ? (isTr ? timerState.currentPhase.nameTr : timerState.currentPhase.name)
                    : plan.shortName,
                isRunning: isActive,
              ),
            ),

            const SizedBox(height: 24),

            // Phase description
            if (isActive)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  isTr ? timerState.currentPhase.descriptionTr : timerState.currentPhase.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha:0.5),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Timer Controls
            TimerControls(
              status: timerState.status,
              onStart: () => timerNotifier.startFasting(),
              onPause: () => timerNotifier.pauseFasting(),
              onResume: () => timerNotifier.resumeFasting(),
              onStop: () => _confirmStop(context, ref),
            ),

            const Spacer(flex: 1),

            // Phase Indicator
            if (isActive)
              PhaseIndicator(
                elapsedHours: timerState.elapsedHours,
                targetHours: plan.fastingHours,
              ),

            if (isActive) const SizedBox(height: 16),

            // Quick Stats
            QuickStatsRow(
              streak: streak.valueOrNull ?? 0,
              waterMl: waterState.totalMl,
              waterGoalMl: waterState.goalMl,
              onAddWater: () => _addWater(context, ref),
            ),

            const SizedBox(height: 8),

            // Banner Ad
            const BannerAdWidget(),

            const SizedBox(height: 8),
          ],
        ),
      ),
      // Completion overlay
      if (_showCompletion)
        CompletionOverlay(
          durationMinutes: timerState.elapsedSeconds ~/ 60,
          planName: plan.name,
          phaseName: isTr ? timerState.currentPhase.nameTr : timerState.currentPhase.name,
          onDismiss: () {
            ref.read(timerProvider.notifier).resetTimer();
            setState(() => _showCompletion = false);
            // Premium değilse interstitial göster
            if (!ref.read(isPremiumProvider)) {
              AdmobService().showInterstitialAd();
            }
          },
        ),
      ],
      ),
    );
  }

  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greeting_morning;
    if (hour < 18) return l10n.greeting_afternoon;
    return l10n.greeting_evening;
  }

  void _showPlanSelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha:0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                      color: isLocked
                          ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)
                          : null,
                    ),
                    title: Text(
                      plan.name,
                      style: isLocked
                          ? TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                            )
                          : null,
                    ),
                    subtitle: Text(plan.description(Localizations.localeOf(context).languageCode)),
                    trailing: isLocked
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.secondary],
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
              onPressed: () {
                // Oturum kaydet
                if (timerState.startTime != null) {
                  ref.read(fastingSessionProvider.notifier).saveSession(
                        planType: timerState.planId,
                        startTime: timerState.startTime!,
                        targetMinutes: timerState.targetSeconds ~/ 60,
                        actualMinutes: timerState.elapsedSeconds ~/ 60,
                        completed: timerState.progress >= 1.0,
                      );
                }
                timerNotifier.stopFasting();
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
        content: Text('+250ml ${l10n.water_addWater}'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
