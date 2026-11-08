import 'dart:async';

import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/timer/providers/timer_provider.dart';
import 'package:fasting_app/services/background_service.dart';
import 'package:fasting_app/services/widget_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DateTime now;
  late FakeFastingTimerService service;
  late FakeFastingWidgetService widgetService;
  late void Function() tick;
  late TimerNotifier notifier;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    now = DateTime(2026, 7, 17, 12);
    service = FakeFastingTimerService();
    widgetService = FakeFastingWidgetService();
    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (callback) {
        tick = callback;
        return FakeTimer();
      },
      restoreOnCreate: false,
    );
  });

  tearDown(() async {
    notifier.dispose();
    await db.close();
  });

  test(
    'start creates one active session and repeated start reuses it',
    () async {
      await notifier.startFasting();
      await notifier.startFasting();

      final sessions = await db.getAllSessions();
      expect(sessions, hasLength(1));
      expect(sessions.single.endTime, isNull);
      expect(notifier.state.status, TimerStatus.running);
    },
  );

  test('manual end records actual duration as incomplete', () async {
    await notifier.startFasting();
    now = now.add(const Duration(minutes: 42, seconds: 30));
    await notifier.stopFasting();

    final session = (await db.getAllSessions()).single;
    expect(session.actualMinutes, 42);
    expect(session.completed, isFalse);
    expect(session.endTime, now);
  });

  test('ticker naturally completes the active session', () async {
    await notifier.startFasting(planId: '12_12');
    now = now.add(const Duration(hours: 12));
    tick();
    await pumpEventQueue();

    final session = (await db.getAllSessions()).single;
    expect(session.actualMinutes, 12 * 60);
    expect(session.completed, isTrue);
    expect(notifier.state.status, TimerStatus.completed);
  });

  test('restore resumes an unfinished session', () async {
    await notifier.startFasting();
    notifier.dispose();
    now = now.add(const Duration(hours: 2));

    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (callback) {
        tick = callback;
        return FakeTimer();
      },
      restoreOnCreate: false,
    );
    await notifier.restoreActiveSession();

    expect(notifier.state.status, TimerStatus.running);
    expect(notifier.state.elapsedSeconds, 2 * 60 * 60);
    expect((await db.getAllSessions()).single.endTime, isNull);
  });

  test('restore finalizes an overdue session exactly once', () async {
    await notifier.startFasting(planId: '12_12');
    notifier.dispose();
    now = now.add(const Duration(hours: 13));

    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (_) => FakeTimer(),
      restoreOnCreate: false,
    );
    await notifier.restoreActiveSession();
    await notifier.restoreActiveSession();

    final sessions = await db.getAllSessions();
    expect(sessions, hasLength(1));
    expect(sessions.single.completed, isTrue);
    expect(sessions.single.actualMinutes, 12 * 60);
    expect(
      sessions.single.endTime,
      now.subtract(const Duration(hours: 1)),
    );
  });

  test('lapsed subscription falls back to the free plan on start', () async {
    notifier.dispose();
    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (_) => FakeTimer(),
      restoreOnCreate: false,
      initialPlanId: '20_4',
      canUsePlan: (plan) => !plan.isPremium,
    );

    await notifier.startFasting();

    final session = (await db.getAllSessions()).single;
    expect(session.planType, '16_8');
    expect(session.targetMinutes, 16 * 60);
  });

  test('an active subscription keeps the premium plan', () async {
    notifier.dispose();
    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (_) => FakeTimer(),
      restoreOnCreate: false,
      initialPlanId: '20_4',
      canUsePlan: (_) => true,
    );

    await notifier.startFasting();

    expect((await db.getAllSessions()).single.planType, '20_4');
  });

  test('duplicate finish calls do not rewrite history', () async {
    await notifier.startFasting();
    now = now.add(const Duration(minutes: 5));
    await Future.wait([notifier.stopFasting(), notifier.stopFasting()]);
    final first = (await db.getAllSessions()).single;

    now = now.add(const Duration(minutes: 5));
    await notifier.stopFasting();
    final sessions = await db.getAllSessions();

    expect(sessions, hasLength(1));
    expect(sessions.single.endTime, first.endTime);
    expect(sessions.single.actualMinutes, 5);
  });

  test('manual end at the target records the session as completed', () async {
    await notifier.startFasting(planId: '12_12');
    now = now.add(const Duration(hours: 12));
    await notifier.stopFasting();

    final session = (await db.getAllSessions()).single;
    expect(session.completed, isTrue);
  });

  test('start stays guarded until optional services finish', () async {
    service.startGate = Completer<void>();

    final start = notifier.startFasting();
    await pumpEventQueue();

    expect(notifier.state.isBusy, isTrue);
    await notifier.stopFasting();
    expect((await db.getAllSessions()).single.endTime, isNull);

    service.startGate!.complete();
    await start;
    expect(notifier.state.isBusy, isFalse);
  });


  test('quiet exit drains startup before data can be erased', () async {
    service.startGate = Completer<void>();
    final start = notifier.startFasting();
    await service.startEntered.future;

    var erased = false;
    final exit = notifier.endFastQuietly().then((_) async {
      await db.deleteAllUserData();
      erased = true;
    });
    await pumpEventQueue();
    expect(erased, isFalse);

    service.startGate!.complete();
    await Future.wait([start, exit]);

    expect(notifier.state.status, TimerStatus.idle);
    expect(await db.getAllSessions(), isEmpty);
    expect(service.stopCount, greaterThan(0));
    expect(widgetService.idleCount, greaterThan(0));
  });

  test('quiet exit drains restoration before stopping the restored fast', () async {
    await notifier.startFasting();
    notifier.dispose();
    service = FakeFastingTimerService()..startGate = Completer<void>();
    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (_) => FakeTimer(),
      restoreOnCreate: false,
    );
    final restore = notifier.restoreActiveSession();
    await service.startEntered.future;
    final exit = notifier.endFastQuietly();
    service.startGate!.complete();
    await Future.wait([restore, exit]);

    expect(await db.getActiveSession(), isNull);
    expect(notifier.state.status, TimerStatus.idle);
    expect(service.stopCount, greaterThan(0));
  });

  test('quiet exit waits for cleanup and blocks a new fast until it ends', () async {
    await notifier.startFasting();
    service.stopGate = Completer<void>();
    final stop = notifier.stopFasting();
    await service.stopEntered.future;

    var ended = false;
    final exit = notifier.endFastQuietly().then((_) => ended = true);
    await notifier.startFasting();
    await pumpEventQueue();
    expect(ended, isFalse);
    expect(await db.getAllSessions(), hasLength(1));

    service.stopGate!.complete();
    await Future.wait([stop, exit]);
    expect(notifier.state.status, TimerStatus.idle);
    expect(await db.getActiveSession(), isNull);
  });

  test('a failed safety exit cannot proceed to data erasure', () async {
    notifier.dispose();
    await db.close();
    db = FailingFinalizeDatabase();
    notifier = TimerNotifier(
      db,
      clock: () => now,
      backgroundService: service,
      widgetService: widgetService,
      tickerFactory: (_) => FakeTimer(),
      restoreOnCreate: false,
    );
    await notifier.startFasting();
    final erase = notifier.endFastQuietly().then((_) => db.deleteAllUserData());

    await expectLater(erase, throwsStateError);
    expect(await db.getActiveSession(), isNotNull);
    expect(notifier.state.status, TimerStatus.running);
  });

  test('optional start failure keeps the active database session', () async {
    service.failStart = true;

    await notifier.startFasting();

    final session = (await db.getAllSessions()).single;
    expect(session.endTime, isNull);
    expect(notifier.state.status, TimerStatus.running);
    expect(widgetService.updateCount, 1);
  });

  test('optional stop failure still clears the widget', () async {
    await notifier.startFasting();
    service.failStop = true;

    await notifier.stopFasting();

    final session = (await db.getAllSessions()).single;
    expect(session.endTime, isNotNull);
    expect(widgetService.idleCount, 1);
  });

  test('restore after database close leaves the timer idle', () async {
    await db.close();

    await notifier.restoreActiveSession();

    expect(notifier.state.status, TimerStatus.idle);
    expect(notifier.state.error, isNull);
  });
}

class FakeFastingTimerService implements FastingTimerService {
  Completer<void>? startGate;
  Completer<void>? stopGate;
  final startEntered = Completer<void>();
  final stopEntered = Completer<void>();
  int stopCount = 0;
  bool failStart = false;
  bool failStop = false;

  @override
  Future<void> startFastingTimer({
    required DateTime startTime,
    required int targetMinutes,
    required String planName,
  }) async {
    if (!startEntered.isCompleted) startEntered.complete();
    await startGate?.future;
    if (failStart) throw StateError('start failed');
  }

  @override
  Future<void> stopFastingTimer() async {
    stopCount++;
    if (!stopEntered.isCompleted) stopEntered.complete();
    await stopGate?.future;
    if (failStop) throw StateError('stop failed');
  }
}

class FakeFastingWidgetService implements FastingWidgetService {
  int updateCount = 0;
  int idleCount = 0;

  @override
  Future<void> updateIdleWidget() async => idleCount++;

  @override
  Future<void> updateWidget({
    required bool isFasting,
    required String planName,
    required String remainingTime,
    required double progress,
    required String phaseName,
  }) async => updateCount++;
}

class FakeTimer implements Timer {
  var _active = true;

  @override
  bool get isActive => _active;

  @override
  int get tick => 0;

  @override
  void cancel() => _active = false;
}

class FailingFinalizeDatabase extends AppDatabase {
  FailingFinalizeDatabase() : super.forTesting(NativeDatabase.memory());

  @override
  Future<bool> finalizeActiveSession({
    required int id,
    required DateTime endTime,
    required int actualMinutes,
    required bool completed,
  }) async {
    throw StateError('write failed');
  }
}
