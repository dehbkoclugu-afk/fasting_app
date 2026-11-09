import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/fasting_plans.dart';
import '../../../core/constants/metabolic_phases.dart';
import '../../../data/database/app_database.dart';
import '../../../services/analytics_service.dart';
import '../../../services/background_service.dart';
import '../../../services/fasting_elapsed_clock.dart';
import '../../../services/widget_service.dart';
import '../../paywall/providers/subscription_provider.dart';
import '../../profile/providers/settings_provider.dart';
import 'water_provider.dart';

enum TimerStatus { idle, running, completed }

typedef Clock = DateTime Function();
typedef TickerFactory = Timer Function(void Function() callback);

class TimerState {
  final TimerStatus status;
  final String planId;
  final DateTime? startTime;
  final int elapsedSeconds;
  final int targetSeconds;
  final MetabolicPhase currentPhase;
  final bool isBusy;
  final Object? error;

  TimerState({
    this.status = TimerStatus.idle,
    this.planId = '16_8',
    this.startTime,
    this.elapsedSeconds = 0,
    this.targetSeconds = 57600,
    MetabolicPhase? currentPhase,
    this.isBusy = false,
    this.error,
  }) : currentPhase = currentPhase ?? MetabolicPhases.all[0];

  double get progress =>
      targetSeconds <= 0 ? 0 : (elapsedSeconds / targetSeconds).clamp(0.0, 1.0);
  double get elapsedHours => elapsedSeconds / 3600;
  int get remainingSeconds =>
      (targetSeconds - elapsedSeconds).clamp(0, targetSeconds);
  String get elapsedFormatted => _format(elapsedSeconds);
  String get remainingFormatted => _format(remainingSeconds);

  static String _format(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  TimerState copyWith({
    TimerStatus? status,
    String? planId,
    DateTime? startTime,
    int? elapsedSeconds,
    int? targetSeconds,
    MetabolicPhase? currentPhase,
    bool? isBusy,
    Object? error,
    bool clearError = false,
  }) => TimerState(
    status: status ?? this.status,
    planId: planId ?? this.planId,
    startTime: startTime ?? this.startTime,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    targetSeconds: targetSeconds ?? this.targetSeconds,
    currentPhase: currentPhase ?? this.currentPhase,
    isBusy: isBusy ?? this.isBusy,
    error: clearError ? null : error ?? this.error,
  );
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier(
    this._db, {
    Clock? clock,
    BootClockReader? readBootClock,
    FastingTimerService? backgroundService,
    FastingWidgetService? widgetService,
    TickerFactory? tickerFactory,
    bool restoreOnCreate = true,
    String initialPlanId = '16_8',
    bool Function(FastingPlan plan)? canUsePlan,
  }) : _clock = clock ?? DateTime.now,
       _elapsedClock = FastingElapsedClock(
         _db,
         wallClock: clock ?? DateTime.now,
         readBootClock:
             readBootClock ??
             (clock != null ? () async => null : BootClockSnapshot.readAndroid),
       ),
       _canUsePlan = canUsePlan ?? ((_) => true),
       _backgroundService = backgroundService ?? BackgroundService(),
       _widgetService = widgetService ?? WidgetService(),
       _tickerFactory =
           tickerFactory ??
           ((callback) =>
               Timer.periodic(const Duration(seconds: 1), (_) => callback())),
       super(
         TimerState(
           planId: FastingPlans.getById(initialPlanId).id,
           targetSeconds:
               FastingPlans.getById(initialPlanId).fastingMinutes * 60,
         ),
       ) {
    if (restoreOnCreate) restoreActiveSession();
  }

  final AppDatabase _db;
  final Clock _clock;
  final FastingElapsedClock _elapsedClock;
  bool _tickInProgress = false;
  final bool Function(FastingPlan plan) _canUsePlan;
  final FastingTimerService _backgroundService;
  final FastingWidgetService _widgetService;
  final TickerFactory _tickerFactory;
  Timer? _timer;
  int? _activeSessionId;
  int _widgetUpdateCounter = 0;
  Future<void>? _pendingStart;
  Future<void>? _pendingRestore;
  Future<void>? _pendingFinish;
  Future<void>? _pendingStop;
  Future<void>? _pendingQuietEnd;

  Future<void> restoreActiveSession() async {
    if (_pendingQuietEnd != null) return;
    final pending = _pendingRestore;
    if (pending != null) return pending;
    final operation = _restoreActiveSession();
    _pendingRestore = operation;
    try {
      await operation;
    } finally {
      _pendingRestore = null;
    }
  }

  Future<void> _restoreActiveSession() async {
    try {
      final session = await _db.getActiveSession();
      if (session == null) return;
      _activeSessionId = session.id;
      await _setRunning(session);
      if (!mounted) return;
      if (state.elapsedSeconds >= state.targetSeconds) {
        await _finish(completed: true);
      } else {
        _startTicker();
        // Android drops alarms and work on force-stop or reboot.
        await _startOptionalServices(session);
      }
    } catch (error) {
      debugPrint('Active fasting session restore failed: $error');
      _activeSessionId = null;
      state = _idleForPlan(state.planId);
    }
  }

  Future<void> startFasting({String? planId}) async {
    if (_pendingQuietEnd != null) return;
    final pending = _pendingStart;
    if (pending != null) return pending;
    final operation = _startFasting(planId: planId);
    _pendingStart = operation;
    try {
      await operation;
    } finally {
      _pendingStart = null;
    }
  }

  Future<void> _startFasting({String? planId}) async {
    if (state.isBusy || state.status == TimerStatus.running) return;
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      final plan = FastingPlans.getById(planId ?? state.planId);
      // The saved plan outlives the subscription that unlocked it, so the
      // selector alone cannot enforce this.
      final requested = _canUsePlan(plan) ? plan : FastingPlans.getById('16_8');
      final session = await _db.createOrGetActiveSession(
        FastingSessionsCompanion(
          planType: Value(requested.id),
          startTime: Value(_clock()),
          targetMinutes: Value(requested.fastingMinutes),
        ),
      );
      _activeSessionId = session.id;
      await _setRunning(session, isBusy: true);
      if (!mounted) return;
      if (state.elapsedSeconds >= state.targetSeconds) {
        await _finish(completed: true);
        return;
      }
      AnalyticsService().track('fast_started', {'plan': requested.id});
      await _startOptionalServices(session);
      final elapsed = await _elapsedSince(session.startTime);
      if (!mounted) return;
      state = state.copyWith(
        elapsedSeconds: elapsed,
        currentPhase: MetabolicPhases.getPhaseForHours(elapsed / 3600),
      );
      if (elapsed >= state.targetSeconds) {
        await _finish(completed: true);
      } else {
        state = state.copyWith(isBusy: false);
        _startTicker();
      }
    } catch (error) {
      if (!mounted) return;
      state = _idleForPlan(state.planId).copyWith(error: error);
    }
  }

  Future<void> stopFasting() async {
    final pending = _pendingStop;
    if (pending != null) return pending;
    final operation = _stopFasting();
    _pendingStop = operation;
    try {
      await operation;
    } finally {
      _pendingStop = null;
    }
  }

  Future<void> _stopFasting() async {
    if (!mounted || state.isBusy || state.status != TimerStatus.running) return;
    final sessionId = _activeSessionId;
    final elapsed = state.startTime == null
        ? state.elapsedSeconds
        : await _elapsedSince(state.startTime!);
    if (!mounted ||
        state.isBusy ||
        _activeSessionId != sessionId ||
        state.status != TimerStatus.running) {
      return;
    }
    return _finish(completed: elapsed >= state.targetSeconds);
  }

  /// Ends any running fast and returns straight to idle, skipping the
  /// completion overlay and the ad behind it. For safety exits.
  Future<void> endFastQuietly() async {
    final pending = _pendingQuietEnd;
    if (pending != null) return pending;
    final operation = _endFastQuietly();
    _pendingQuietEnd = operation;
    try {
      await operation;
    } finally {
      _pendingQuietEnd = null;
    }
  }

  Future<void> _endFastQuietly() async {
    // A safety exit must not be dropped by stopFasting's busy guard. Also
    // drain service startup/cleanup before data erasure can invalidate us.
    await _pendingRestore;
    await _pendingStart;
    await _pendingFinish;
    await stopFasting();
    if (state.status == TimerStatus.running || state.isBusy) {
      throw state.error ?? StateError('The active fast could not be ended.');
    }
    await resetTimer();
  }

  Future<void> resetTimer() async {
    if (state.status == TimerStatus.running || state.isBusy) return;
    _timer?.cancel();
    state = _idleForPlan(state.planId);
    await _stopOptionalServices();
  }

  void changePlan(String planId) {
    if (state.status == TimerStatus.running || state.isBusy) return;
    final plan = FastingPlans.getById(planId);
    state = _idleForPlan(plan.id);
  }

  TimerState _idleForPlan(String planId) {
    final plan = FastingPlans.getById(planId);
    return TimerState(planId: plan.id, targetSeconds: plan.fastingMinutes * 60);
  }

  Future<void> _setRunning(
    FastingSession session, {
    bool isBusy = false,
  }) async {
    final elapsed = await _elapsedClock.attach(session);
    if (!mounted) return;
    state = TimerState(
      status: TimerStatus.running,
      planId: session.planType,
      startTime: session.startTime,
      elapsedSeconds: elapsed,
      targetSeconds: session.targetMinutes * 60,
      currentPhase: MetabolicPhases.getPhaseForHours(elapsed / 3600),
      isBusy: isBusy,
    );
  }

  Future<int> _elapsedSince(DateTime start) =>
      _elapsedClock.elapsedSince(start);

  void _startTicker() {
    _timer?.cancel();
    _timer = _tickerFactory(_tick);
  }

  Future<void> _tick() async {
    if (_tickInProgress ||
        !mounted ||
        state.isBusy ||
        state.status != TimerStatus.running ||
        state.startTime == null) {
      return;
    }
    _tickInProgress = true;
    final sessionId = _activeSessionId;
    try {
      final elapsed = await _elapsedSince(state.startTime!);
      if (!mounted ||
          state.isBusy ||
          state.status != TimerStatus.running ||
          _activeSessionId != sessionId) {
        return;
      }
      state = state.copyWith(
        elapsedSeconds: elapsed,
        currentPhase: MetabolicPhases.getPhaseForHours(elapsed / 3600),
      );
      if (elapsed >= state.targetSeconds) {
        await _finish(completed: true);
      } else if (++_widgetUpdateCounter % 30 == 0) {
        unawaited(_updateHomeWidget());
      }
    } finally {
      _tickInProgress = false;
    }
  }

  Future<void> _startOptionalServices(FastingSession session) async {
    try {
      final elapsed = await _elapsedSince(session.startTime);
      await _backgroundService.startFastingTimer(
        // Rebase scheduled reminders when reopening after a wall-clock change.
        startTime: _clock().subtract(Duration(seconds: elapsed)),
        targetMinutes: session.targetMinutes,
        planName: FastingPlans.getById(session.planType).name,
      );
    } catch (error) {
      debugPrint('Fasting background start failed: $error');
    }
    await _updateHomeWidget();
  }

  Future<void> _finish({required bool completed}) async {
    final pending = _pendingFinish;
    if (pending != null) return pending;
    final operation = _finishSession(completed: completed);
    _pendingFinish = operation;
    try {
      await operation;
    } finally {
      _pendingFinish = null;
    }
  }

  Future<void> _finishSession({required bool completed}) async {
    if (_activeSessionId == null) return;
    _timer?.cancel();
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      final start = state.startTime;
      // A completed fast ends at its target. Time the app spent closed after
      // that is not fasting, and must not inflate totals or records.
      final elapsed = completed
          ? state.targetSeconds
          : (start == null ? state.elapsedSeconds : await _elapsedSince(start));
      await _db.finalizeActiveSession(
        id: _activeSessionId!,
        endTime: start != null
            ? start.add(Duration(seconds: elapsed))
            : _clock(),
        actualMinutes: elapsed ~/ 60,
        completed: completed,
      );
      _activeSessionId = null;
      AnalyticsService().track('fast_finished', {'completed': completed});
      if (mounted) {
        state = state.copyWith(
          status: TimerStatus.completed,
          elapsedSeconds: elapsed,
          currentPhase: MetabolicPhases.getPhaseForHours(elapsed / 3600),
          isBusy: false,
        );
      }
      await _stopOptionalServices();
    } catch (error) {
      if (!mounted) return;
      state = state.copyWith(isBusy: false, error: error);
      if (state.status == TimerStatus.running) _startTicker();
    }
  }

  Future<void> _stopOptionalServices() async {
    try {
      await _backgroundService.stopFastingTimer();
    } catch (error) {
      debugPrint('Fasting background stop failed: $error');
    }
    try {
      await _widgetService.updateIdleWidget();
    } catch (error) {
      debugPrint('Fasting widget stop failed: $error');
    }
  }

  Future<void> _updateHomeWidget() async {
    final plan = FastingPlans.getById(state.planId);
    try {
      await _widgetService.updateWidget(
        isFasting: state.status == TimerStatus.running,
        planName: plan.name,
        remainingTime: widgetTime(Duration(seconds: state.remainingSeconds)),
        progress: state.progress,
        phaseName: state.currentPhase.id,
      );
    } catch (error) {
      debugPrint('Fasting widget update failed: $error');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  final notifier = TimerNotifier(
    ref.watch(databaseProvider),
    initialPlanId: ref.read(settingsProvider).selectedPlanId,
    // Unverified is not lapsed: a paying user must keep their plan offline.
    canUsePlan: (plan) {
      if (!plan.isPremium) return true;
      final subscription = ref.read(subscriptionProvider);
      return subscription.isPremium || !subscription.entitlementVerified;
    },
  );
  ref.listen<SubscriptionState>(subscriptionProvider, (previous, next) {
    final selected = ref.read(settingsProvider).selectedPlanId;
    if (next.entitlementVerified &&
        !next.isPremium &&
        FastingPlans.getById(selected).isPremium) {
      ref.read(settingsProvider.notifier).setSelectedPlan('16_8');
    }
  });
  ref.listen<AppSettings>(settingsProvider, (previous, next) {
    if (previous?.selectedPlanId != next.selectedPlanId) {
      notifier.changePlan(next.selectedPlanId);
    }
  });
  return notifier;
});
