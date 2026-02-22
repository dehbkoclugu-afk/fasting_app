import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/constants/metabolic_phases.dart';
import '../../../services/background_service.dart';
import '../../../services/widget_service.dart';

enum TimerStatus { idle, running, paused, completed }

class TimerState {
  final TimerStatus status;
  final String planId;
  final DateTime? startTime;
  final int elapsedSeconds;
  final int targetSeconds;
  final MetabolicPhase currentPhase;

  TimerState({
    this.status = TimerStatus.idle,
    this.planId = '16_8',
    this.startTime,
    this.elapsedSeconds = 0,
    this.targetSeconds = 57600, // 16 hours
    MetabolicPhase? currentPhase,
  }) : currentPhase = currentPhase ?? MetabolicPhases.all[0];

  double get progress {
    if (targetSeconds <= 0) return 0;
    return (elapsedSeconds / targetSeconds).clamp(0.0, 1.0);
  }

  double get elapsedHours => elapsedSeconds / 3600;

  int get remainingSeconds => (targetSeconds - elapsedSeconds).clamp(0, targetSeconds);

  String get elapsedFormatted {
    final h = elapsedSeconds ~/ 3600;
    final m = (elapsedSeconds % 3600) ~/ 60;
    final s = elapsedSeconds % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  String get remainingFormatted {
    final rem = remainingSeconds;
    final h = rem ~/ 3600;
    final m = (rem % 3600) ~/ 60;
    final s = rem % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  TimerState copyWith({
    TimerStatus? status,
    String? planId,
    DateTime? startTime,
    int? elapsedSeconds,
    int? targetSeconds,
    MetabolicPhase? currentPhase,
  }) {
    return TimerState(
      status: status ?? this.status,
      planId: planId ?? this.planId,
      startTime: startTime ?? this.startTime,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      targetSeconds: targetSeconds ?? this.targetSeconds,
      currentPhase: currentPhase ?? this.currentPhase,
    );
  }
}

class TimerNotifier extends StateNotifier<TimerState> {
  Timer? _timer;
  final _backgroundService = BackgroundService();
  final _widgetService = WidgetService();
  int _widgetUpdateCounter = 0;

  TimerNotifier() : super(TimerState()) {
    _restoreActiveSession();
  }

  Future<void> _restoreActiveSession() async {
    final active = await _backgroundService.getActiveFasting();
    if (active == null) return;

    final startTime = active['startTime'] as DateTime;
    final targetMinutes = active['targetMinutes'] as int;
    final elapsed = DateTime.now().difference(startTime);
    final elapsedSeconds = elapsed.inSeconds;
    final targetSeconds = targetMinutes * 60;

    if (elapsedSeconds >= targetSeconds) {
      // Oruç tamamlanmış, bitir
      await _backgroundService.stopFastingTimer();
      state = state.copyWith(status: TimerStatus.completed);
      return;
    }

    final hours = elapsedSeconds / 3600;
    state = TimerState(
      status: TimerStatus.running,
      startTime: startTime,
      elapsedSeconds: elapsedSeconds,
      targetSeconds: targetSeconds,
      currentPhase: MetabolicPhases.getPhaseForHours(hours),
    );
    _startTicker();
  }

  Future<void> startFasting({String? planId}) async {
    final plan = FastingPlans.getById(planId ?? state.planId);
    final now = DateTime.now();

    state = state.copyWith(
      status: TimerStatus.running,
      planId: plan.id,
      startTime: now,
      elapsedSeconds: 0,
      targetSeconds: plan.fastingMinutes * 60,
      currentPhase: MetabolicPhases.getPhaseForHours(0),
    );

    _startTicker();

    // Background service ve bildirimleri başlat
    await _backgroundService.startFastingTimer(
      startTime: now,
      targetMinutes: plan.fastingMinutes,
      planName: plan.name,
    );

    _updateHomeWidget();
  }

  void pauseFasting() {
    _timer?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  void resumeFasting() {
    state = state.copyWith(status: TimerStatus.running);
    _startTicker();
  }

  Future<void> stopFasting() async {
    _timer?.cancel();
    state = state.copyWith(status: TimerStatus.completed);
    await _backgroundService.stopFastingTimer();
  }

  Future<void> resetTimer() async {
    _timer?.cancel();
    state = TimerState();
    await _backgroundService.stopFastingTimer();
    _widgetService.updateIdleWidget();
  }

  void changePlan(String planId) {
    if (state.status == TimerStatus.running || state.status == TimerStatus.paused) {
      return;
    }
    final plan = FastingPlans.getById(planId);
    state = state.copyWith(
      planId: plan.id,
      targetSeconds: plan.fastingMinutes * 60,
    );
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.status != TimerStatus.running) return;

      final newElapsed = state.startTime != null
          ? DateTime.now().difference(state.startTime!).inSeconds
          : state.elapsedSeconds + 1;
      final hours = newElapsed / 3600;
      final phase = MetabolicPhases.getPhaseForHours(hours);

      if (newElapsed >= state.targetSeconds) {
        _timer?.cancel();
        state = state.copyWith(
          elapsedSeconds: newElapsed,
          currentPhase: phase,
          status: TimerStatus.completed,
        );
        _backgroundService.stopFastingTimer();
        return;
      }

      state = state.copyWith(
        elapsedSeconds: newElapsed,
        currentPhase: phase,
      );

      // Update home widget every 30 seconds
      _widgetUpdateCounter++;
      if (_widgetUpdateCounter % 30 == 0) {
        _updateHomeWidget();
      }
    });
  }

  void _updateHomeWidget() {
    final plan = FastingPlans.getById(state.planId);
    _widgetService.updateWidget(
      isFasting: state.status == TimerStatus.running,
      planName: plan.name,
      remainingTime: state.remainingFormatted,
      progress: state.progress,
      phaseName: state.currentPhase.name,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});
