import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../data/database/app_database.dart';

typedef BootClockReader = Future<BootClockSnapshot?> Function();

class BootClockSnapshot {
  const BootClockSnapshot({
    required this.wallMilliseconds,
    required this.uptimeMilliseconds,
    required this.bootCount,
  });

  final int wallMilliseconds;
  final int uptimeMilliseconds;
  final int bootCount;

  static Future<BootClockSnapshot?> readAndroid() async {
    if (!Platform.isAndroid) return null;
    final values = await const MethodChannel(
      'fasttrack/clock',
    ).invokeMapMethod<String, int>('snapshot');
    if (values == null) return null;
    return BootClockSnapshot(
      wallMilliseconds: values['wallMilliseconds']!,
      uptimeMilliseconds: values['uptimeMilliseconds']!,
      bootCount: values['bootCount']!,
    );
  }
}

/// Anchors elapsed time to Android's sleep-inclusive monotonic clock. The
/// database reference survives process death; it is scoped to one boot/session.
/// Old sessions, other platforms and device reboots retain wall-clock recovery.
class FastingElapsedClock {
  FastingElapsedClock(
    this._db, {
    required DateTime Function() wallClock,
    required BootClockReader readBootClock,
  }) : _wallClock = wallClock,
       _readBootClock = readBootClock;

  static const settingKey = 'fasting_clock_anchor_v1';
  final AppDatabase _db;
  final DateTime Function() _wallClock;
  final BootClockReader _readBootClock;
  _ClockAnchor? _anchor;
  int _lastElapsedSeconds = 0;

  Future<BootClockSnapshot?> _snapshot() async {
    try {
      return await _readBootClock().timeout(const Duration(seconds: 2));
    } catch (error) {
      // A missing/broken optional native bridge must not strand an active fast.
      debugPrint('Fasting system clock unavailable: $error');
      return null;
    }
  }

  Future<int> attach(FastingSession session) async {
    final snapshot = await _snapshot();
    _anchor = null;
    if (snapshot == null) return _wallElapsed(session.startTime);
    final encoded = await _db.getSetting(settingKey);
    if (encoded != null) {
      try {
        final saved = _ClockAnchor.fromJson(
          jsonDecode(encoded) as Map<String, dynamic>,
        );
        if (saved.sessionId == session.id &&
            saved.startMilliseconds ==
                session.startTime.millisecondsSinceEpoch &&
            saved.bootCount == snapshot.bootCount &&
            saved.uptimeMilliseconds <= snapshot.uptimeMilliseconds &&
            saved.elapsedMilliseconds >= 0) {
          _anchor = saved;
        }
      } on FormatException {
        // Recover older/corrupt local metadata without discarding the fast.
      } on TypeError {
        // Treat incomplete metadata in the same way as a missing anchor.
      }
    }
    _anchor ??= _ClockAnchor(
      sessionId: session.id,
      startMilliseconds: session.startTime.millisecondsSinceEpoch,
      bootCount: snapshot.bootCount,
      uptimeMilliseconds: snapshot.uptimeMilliseconds,
      elapsedMilliseconds:
          (snapshot.wallMilliseconds - session.startTime.millisecondsSinceEpoch)
              .clamp(0, 1 << 51),
    );
    await _db.setSetting(settingKey, jsonEncode(_anchor!.toJson()));
    return _elapsed(snapshot, session.startTime);
  }

  Future<int> elapsedSince(DateTime start) async {
    final anchor = _anchor;
    if (anchor == null) return _wallElapsed(start);
    final snapshot = await _snapshot();
    if (snapshot == null ||
        snapshot.bootCount != anchor.bootCount ||
        snapshot.uptimeMilliseconds < anchor.uptimeMilliseconds) {
      // Never silently convert a known protected session back to mutable wall
      // time mid-process. Retry on the next tick; stopping remains available.
      return _lastElapsedSeconds;
    }
    return _elapsed(snapshot, start);
  }

  int _elapsed(BootClockSnapshot snapshot, DateTime start) {
    final anchor = _anchor;
    if (anchor == null) return _wallElapsed(start);
    final elapsed =
        anchor.elapsedMilliseconds +
        snapshot.uptimeMilliseconds -
        anchor.uptimeMilliseconds;
    _lastElapsedSeconds = (elapsed ~/ 1000).clamp(0, 1 << 31);
    return _lastElapsedSeconds;
  }

  int _wallElapsed(DateTime start) =>
      _wallClock().difference(start).inSeconds.clamp(0, 1 << 31);
}

class _ClockAnchor {
  const _ClockAnchor({
    required this.sessionId,
    required this.startMilliseconds,
    required this.bootCount,
    required this.uptimeMilliseconds,
    required this.elapsedMilliseconds,
  });

  _ClockAnchor.fromJson(Map<String, dynamic> value)
    : sessionId = value['sessionId'] as int,
      startMilliseconds = value['startMilliseconds'] as int,
      bootCount = value['bootCount'] as int,
      uptimeMilliseconds = value['uptimeMilliseconds'] as int,
      elapsedMilliseconds = value['elapsedMilliseconds'] as int;

  final int sessionId;
  final int startMilliseconds;
  final int bootCount;
  final int uptimeMilliseconds;
  final int elapsedMilliseconds;

  Map<String, int> toJson() => {
    'sessionId': sessionId,
    'startMilliseconds': startMilliseconds,
    'bootCount': bootCount,
    'uptimeMilliseconds': uptimeMilliseconds,
    'elapsedMilliseconds': elapsedMilliseconds,
  };
}
