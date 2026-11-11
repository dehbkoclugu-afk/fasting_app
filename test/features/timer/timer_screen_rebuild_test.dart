import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:fasting_app/features/timer/providers/fasting_session_provider.dart';
import 'package:fasting_app/features/timer/providers/timer_provider.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:fasting_app/features/timer/screens/timer_screen.dart';
import 'package:fasting_app/features/timer/widgets/quick_stats_row.dart';
import 'package:fasting_app/features/timer/widgets/timer_display.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestTimer extends TimerNotifier {
  _TestTimer(super.database) : super(restoreOnCreate: false) {
    state = TimerState(
      status: TimerStatus.running,
      startTime: DateTime(2026, 11, 9, 8),
    );
  }

  void tick(int elapsed) => state = state.copyWith(elapsedSeconds: elapsed);
}

void main() {
  testWidgets('timer ticks update the display without rebuilding quick stats', (
    tester,
  ) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final timer = _TestTimer(db);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          timerProvider.overrideWith((ref) => timer),
          streakProvider.overrideWithValue(0),
          isPremiumProvider.overrideWithValue(true),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const TimerScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final quickStats = find.byType(QuickStatsRow);
    final initial = tester.widget<QuickStatsRow>(quickStats);

    timer.tick(1);
    await tester.pump();
    expect(
      tester.widget<TimerDisplay>(find.byType(TimerDisplay)).elapsed,
      '00:00:01',
    );
    expect(tester.widget<QuickStatsRow>(quickStats), same(initial));

    timer.tick(15 * 3600);
    await tester.pump();
    expect(quickStats, findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
