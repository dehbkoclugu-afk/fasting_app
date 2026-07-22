import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/fasting_plans.dart';
import '../../../core/constants/metabolic_phases.dart';
import '../../../data/database/app_database.dart';
import '../../../services/background_service.dart';
import '../../../services/widget_service.dart';
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
    FastingTimerService? backgroundService,
    FastingWidgetService? widgetService,
    TickerFactory? tickerFactory,
    bool restoreOnCreate = true,
  }) : _clock = clock ?? DateTime.now,
       _backgroundService = backgroundService ?? BackgroundService(),
       _widgetService = widgetService ?? WidgetService(),
       _tickerFactory =
           tickerFactory ??
           ((callback) =>
               Timer.periodic(const Duration(seconds: 1), (_) => callback())),
       super(TimerState()) {
    if (restoreOnCreate) restoreActiveSession();
  }

  final AppDatabase _db;
  final Clock _clock;
  final FastingTimerService _backgroundService;
  final FastingWidgetService _widgetService;
  final TickerFactory _tickerFactory;
  Timer? _timer;
  int? _activeSessionId;
  int _widgetUpdateCounter = 0;
  bool _finishing = false;

  Future<void> restoreActiveSession() async {
    try {
      final session = await _db.getActiveSession();
      if (session == null) return;
      _activeSessionId = session.id;
      _setRunning(session);
      if (state.elapsedSeconds >= state.targetSeconds) {
        await _finish(completed: true);
      } else {
        _startTicker();
      }
    } catch (error) {
      state = TimerState(error: error);
    }
  }

  Future<void> startFasting({String? planId}) async {
    if (state.isBusy || state.status == TimerStatus.running) return;
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      final requested = FastingPlans.getById(planId ?? state.planId);
      final session = await _db.createOrGetActiveSession(
        FastingSessionsCompanion(
          planType: Value(requested.id),
          startTime: Value(_clock()),
          targetMinutes: Value(requested.fastingMinutes),
        ),
      );
      _activeSessionId = session.id;
      _setRunning(session, isBusy: true);
      if (state.elapsedSeconds >= state.targetSeconds) {
        await _finish(completed: true);
        return;
      }
      await _startOptionalServices(session);
      final elapsed = _elapsedSince(session.startTime);
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
      state = TimerState(planId: state.planId, error: error);
    }
  }

  Future<void> stopFasting() {
    if (state.isBusy) return Future.value();
    final elapsed =
        state.startTime == null
            ? state.elapsedSeconds
            : _elapsedSince(state.startTime!);
    return _finish(completed: elapsed >= state.targetSeconds);
  }

  Future<void> resetTimer() async {
    if (state.status == TimerStatus.running || state.isBusy) return;
    _timer?.cancel();
    state = TimerState(planId: state.planId);
    await _stopOptionalServices();
  }

  void changePlan(String planId) {
    if (state.status == TimerStatus.running || state.isBusy) return;
    final plan = FastingPlans.getById(planId);
    state = TimerState(
      planId: plan.id,
      targetSeconds: plan.fastingMinutes * 60,
    );
  }

  void _setRunning(FastingSession session, {bool isBusy = false}) {
    final elapsed = _elapsedSince(session.startTime);
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

  int _elapsedSince(DateTime start) =>
      _clock().difference(start).inSeconds.clamp(0, 1 << 31);

  void _startTicker() {
    _timer?.cancel();
    _timer = _tickerFactory(_tick);
  }

  void _tick() {
    if (state.status != TimerStatus.running || state.startTime == null) return;
    final elapsed = _elapsedSince(state.startTime!);
    state = state.copyWith(
      elapsedSeconds: elapsed,
      currentPhase: MetabolicPhases.getPhaseForHours(elapsed / 3600),
    );
    if (elapsed >= state.targetSeconds) {
      _finish(completed: true);
    } else if (++_widgetUpdateCounter % 30 == 0) {
      unawaited(_updateHomeWidget());
    }
  }

  Future<void> _startOptionalServices(FastingSession session) async {
    try {
      await _backgroundService.startFastingTimer(
        startTime: session.startTime,
        targetMinutes: session.targetMinutes,
        planName: FastingPlans.getById(session.planType).name,
      );
    } catch (error) {
      debugPrint('Fasting background start failed: $error');
    }
    await _updateHomeWidget();
  }

  Future<void> _finish({required bool completed}) async {
    if (_finishing || _activeSessionId == null) return;
    _finishing = true;
    _timer?.cancel();
    state = state.copyWith(isBusy: true, clearError: true);
    try {
      final elapsed =
          state.startTime == null
              ? state.elapsedSeconds
              : _elapsedSince(state.startTime!);
      await _db.finalizeActiveSession(
        id: _activeSessionId!,
        endTime: _clock(),
        actualMinutes: elapsed ~/ 60,
        completed: completed,
      );
      _activeSessionId = null;
      state = state.copyWith(
        status: TimerStatus.completed,
        elapsedSeconds: elapsed,
        currentPhase: MetabolicPhases.getPhaseForHours(elapsed / 3600),
        isBusy: false,
      );
      await _stopOptionalServices();
    } catch (error) {
      state = state.copyWith(isBusy: false, error: error);
      if (state.status == TimerStatus.running) _startTicker();
    } finally {
      _finishing = false;
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
        remainingTime: state.remainingFormatted,
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
  return TimerNotifier(ref.watch(databaseProvider));
});
