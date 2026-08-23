import 'dart:async';

import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/timer/providers/timer_provider.dart';
import 'package:fasting_app/services/background_service.dart';
import 'package:fasting_app/services/widget_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DateTime now;

  TimerNotifier notifier({
    FastingTimerService? background,
    FastingWidgetService? widget,
  }) {
    return TimerNotifier(
      database,
      clock: () => now,
      backgroundService: background ?? _NoopBackground(),
      widgetService: widget ?? _NoopWidget(),
      tickerFactory: (callback) =>
          Timer(const Duration(days: 1), callback),
      restoreOnCreate: false,
    );
  }

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    now = DateTime(2026, 8, 23, 10);
  });

  tearDown(() => database.close());

  test('concurrent starts create exactly one active session', () async {
    final timer = notifier();

    await Future.wait([
      timer.startFasting(),
      timer.startFasting(),
    ]);

    expect(timer.state.status, TimerStatus.running);
    expect(await database.getAllSessions(), hasLength(1));
    expect(await database.getActiveSession(), isNotNull);
    timer.dispose();
  });

  test('early stop is persisted as incomplete', () async {
    final timer = notifier();
    await timer.startFasting();
    now = now.add(const Duration(hours: 1));

    await timer.stopFasting();

    final sessions = await database.getAllSessions();
    expect(sessions, hasLength(1));
    expect(sessions.single.completed, isFalse);
    expect(sessions.single.actualMinutes, 60);
    timer.dispose();
  });

  test('target-time stop is persisted as complete', () async {
    final timer = notifier();
    await timer.startFasting();
    now = now.add(const Duration(hours: 16));

    await timer.stopFasting();

    final sessions = await database.getAllSessions();
    expect(sessions.single.completed, isTrue);
    expect(sessions.single.actualMinutes, 16 * 60);
    timer.dispose();
  });

  test('optional service failures do not lose the session', () async {
    final timer = notifier(
      background: _ThrowingBackground(),
      widget: _ThrowingWidget(),
    );

    await timer.startFasting();

    expect(timer.state.status, TimerStatus.running);
    expect(timer.state.error, isNull);
    expect(await database.getActiveSession(), isNotNull);
    timer.dispose();
  });
}

class _NoopBackground implements FastingTimerService {
  @override
  Future<void> startFastingTimer({
    required DateTime startTime,
    required int targetMinutes,
    required String planName,
  }) async {}

  @override
  Future<void> stopFastingTimer() async {}
}

class _ThrowingBackground implements FastingTimerService {
  @override
  Future<void> startFastingTimer({
    required DateTime startTime,
    required int targetMinutes,
    required String planName,
  }) async {
    throw StateError('background unavailable');
  }

  @override
  Future<void> stopFastingTimer() async {
    throw StateError('background unavailable');
  }
}

class _NoopWidget implements FastingWidgetService {
  @override
  Future<void> updateWidget({
    required bool isFasting,
    required String planName,
    required String remainingTime,
    required double progress,
    required String phaseName,
  }) async {}

  @override
  Future<void> updateIdleWidget() async {}
}

class _ThrowingWidget implements FastingWidgetService {
  @override
  Future<void> updateWidget({
    required bool isFasting,
    required String planName,
    required String remainingTime,
    required double progress,
    required String phaseName,
  }) async {
    throw StateError('widget unavailable');
  }

  @override
  Future<void> updateIdleWidget() async {
    throw StateError('widget unavailable');
  }
}
