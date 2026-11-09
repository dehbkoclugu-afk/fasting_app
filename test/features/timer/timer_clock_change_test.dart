import 'dart:async';

import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/timer/providers/timer_provider.dart';
import 'package:fasting_app/services/fasting_elapsed_clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'providers/timer_provider_test.dart'
    show FakeFastingTimerService, FakeFastingWidgetService, FakeTimer;

void main() {
  late AppDatabase db;
  late DateTime now;
  late int uptime;
  late TimerNotifier timer;
  late void Function() tick;
  Completer<BootClockSnapshot?>? pendingSnapshot;
  var readCount = 0;

  TimerNotifier createTimer() => TimerNotifier(
    db,
    clock: () => now,
    readBootClock: () async {
      readCount++;
      if (pendingSnapshot != null) return pendingSnapshot!.future;
      return BootClockSnapshot(
        wallMilliseconds: now.millisecondsSinceEpoch,
        uptimeMilliseconds: uptime,
        bootCount: 7,
      );
    },
    backgroundService: FakeFastingTimerService(),
    widgetService: FakeFastingWidgetService(),
    tickerFactory: (callback) {
      tick = callback;
      return FakeTimer();
    },
    restoreOnCreate: false,
  );

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    now = DateTime(2026, 11, 9, 8);
    uptime = const Duration(days: 3).inMilliseconds;
    pendingSnapshot = null;
    readCount = 0;
    timer = createTimer();
  });

  tearDown(() async {
    timer.dispose();
    await db.close();
  });

  test('ticks do not overlap or write state after disposal', () async {
    await timer.startFasting();
    final baseline = readCount;
    pendingSnapshot = Completer<BootClockSnapshot?>();
    tick();
    tick();
    await pumpEventQueue();
    expect(readCount, baseline + 1);
    timer.dispose();
    pendingSnapshot!.complete(
      BootClockSnapshot(
        wallMilliseconds: now.millisecondsSinceEpoch,
        uptimeMilliseconds: uptime + 1000,
        bootCount: 7,
      ),
    );
    await pumpEventQueue();
    expect((await db.getAllSessions()).single.endTime, isNull);
    timer = createTimer();
  });

  test('a safety exit drains an already pending native-clock stop', () async {
    await timer.startFasting();
    uptime += const Duration(minutes: 1).inMilliseconds;
    pendingSnapshot = Completer<BootClockSnapshot?>();
    final ending = Future.wait([timer.stopFasting(), timer.endFastQuietly()]);
    await pumpEventQueue();
    pendingSnapshot!.complete(
      BootClockSnapshot(
        wallMilliseconds: now.millisecondsSinceEpoch,
        uptimeMilliseconds: uptime,
        bootCount: 7,
      ),
    );
    await ending;
    expect(timer.state.status, TimerStatus.idle);
    final session = (await db.getAllSessions()).single;
    expect(session.actualMinutes, 1);
    expect(session.completed, isFalse);
  });

  test(
    'moving the wall clock forward cannot complete or reward a fast',
    () async {
      await timer.startFasting(planId: '12_12');
      now = now.add(const Duration(days: 2));
      uptime += const Duration(minutes: 5).inMilliseconds;
      tick();
      await pumpEventQueue();

      expect(timer.state.status, TimerStatus.running);
      expect(timer.state.elapsedSeconds, 300);
      await timer.stopFasting();
      final session = (await db.getAllSessions()).single;
      expect(session.completed, isFalse);
      expect(session.actualMinutes, 5);
      expect(
        session.endTime,
        session.startTime.add(const Duration(minutes: 5)),
      );
    },
  );

  test(
    'moving the wall clock backward preserves elapsed time and history',
    () async {
      await timer.startFasting();
      now = now.subtract(const Duration(days: 1));
      uptime += const Duration(minutes: 42).inMilliseconds;
      await timer.stopFasting();

      final session = (await db.getAllSessions()).single;
      expect(session.actualMinutes, 42);
      expect(
        session.endTime,
        session.startTime.add(const Duration(minutes: 42)),
      );
      expect(session.completed, isFalse);
    },
  );

  test(
    'process restart keeps the saved boot reference after clock changes',
    () async {
      await timer.startFasting(planId: '12_12');
      timer.dispose();
      now = now.add(const Duration(days: 1));
      uptime += const Duration(hours: 2).inMilliseconds;
      timer = createTimer();
      await timer.restoreActiveSession();

      expect(timer.state.status, TimerStatus.running);
      expect(timer.state.elapsedSeconds, 7200);
      expect((await db.getAllSessions()).single.endTime, isNull);

      uptime += const Duration(hours: 10).inMilliseconds;
      tick();
      await pumpEventQueue();
      final session = (await db.getAllSessions()).single;
      expect(session.completed, isTrue);
      expect(session.actualMinutes, 720);
      expect(timer.state.status, TimerStatus.completed);
    },
  );
}
