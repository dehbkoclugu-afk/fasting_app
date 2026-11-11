import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/services/fasting_elapsed_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DateTime now;
  late int uptime;
  late int boot;
  late bool available;
  late FastingSession session;

  FastingElapsedClock createClock() => FastingElapsedClock(
    db,
    wallClock: () => now,
    readBootClock: () async => available
        ? BootClockSnapshot(
            wallMilliseconds: now.millisecondsSinceEpoch,
            uptimeMilliseconds: uptime,
            bootCount: boot,
          )
        : null,
  );

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    now = DateTime(2026, 11, 9, 8);
    uptime = const Duration(days: 3).inMilliseconds;
    boot = 1;
    available = true;
    session = await db.createOrGetActiveSession(
      FastingSessionsCompanion(
        planType: const Value('16_8'),
        startTime: Value(now),
        targetMinutes: const Value(960),
      ),
    );
  });
  tearDown(() => db.close());

  test(
    'temporary native failure keeps the latest duration then catches up',
    () async {
      final clock = createClock();
      await clock.attach(session);
      uptime += const Duration(hours: 2).inMilliseconds;
      expect(await clock.elapsedSince(session.startTime), 7200);
      available = false;
      now = now.add(const Duration(days: 10));
      expect(await clock.elapsedSince(session.startTime), 7200);
      available = true;
      uptime += const Duration(minutes: 1).inMilliseconds;
      expect(await clock.elapsedSince(session.startTime), 7260);
    },
  );

  test(
    'an old session gains a reference without losing elapsed time',
    () async {
      now = now.add(const Duration(hours: 2));
      final clock = createClock();
      expect(await clock.attach(session), 7200);
      now = now.subtract(const Duration(days: 1));
      uptime += const Duration(minutes: 1).inMilliseconds;
      expect(await clock.elapsedSince(session.startTime), 7260);
    },
  );

  test(
    'device reboot uses compatibility recovery then creates a new reference',
    () async {
      await createClock().attach(session);
      boot++;
      uptime = const Duration(minutes: 1).inMilliseconds;
      now = now.add(const Duration(hours: 2));
      final clock = createClock();
      expect(await clock.attach(session), 7200);
      now = now.add(const Duration(days: 5));
      uptime += const Duration(minutes: 1).inMilliseconds;
      expect(await clock.elapsedSince(session.startTime), 7260);
    },
  );

  test('a reference from another session is ignored', () async {
    await createClock().attach(session);
    await db.finalizeActiveSession(
      id: session.id,
      endTime: now,
      actualMinutes: 0,
      completed: false,
    );
    now = now.add(const Duration(hours: 1));
    uptime += const Duration(hours: 1).inMilliseconds;
    final next = await db.createOrGetActiveSession(
      FastingSessionsCompanion(
        planType: const Value('16_8'),
        startTime: Value(now),
        targetMinutes: const Value(960),
      ),
    );
    expect(await createClock().attach(next), 0);
  });

  test('corrupt or incomplete metadata cannot strand an active fast', () async {
    now = now.add(const Duration(minutes: 30));
    for (final invalid in ['not-json', '{}', '[]', '{"sessionId":"bad"}']) {
      await db.setSetting(FastingElapsedClock.settingKey, invalid);
      expect(await createClock().attach(session), 1800);
    }
  });

  test('unsupported platforms preserve wall-clock restoration', () async {
    available = false;
    final clock = createClock();
    expect(await clock.attach(session), 0);
    now = now.add(const Duration(hours: 2));
    expect(await clock.elapsedSince(session.startTime), 7200);
  });

  test('full data erasure also removes the saved clock reference', () async {
    await createClock().attach(session);
    expect(await db.getSetting(FastingElapsedClock.settingKey), isNotNull);
    await db.deleteAllUserData();
    expect(await db.getSetting(FastingElapsedClock.settingKey), isNull);
  });
}
