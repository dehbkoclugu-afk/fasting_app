import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/gamification/providers/gamification_provider.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('water award and XP survive a restart with no water today', () async {
    SharedPreferences.setMockInitialValues({});
    final firstDb = AppDatabase.forTesting(NativeDatabase.memory());
    final first = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(firstDb)],
    );
    first.read(gamificationProvider);
    await first.read(waterProvider.notifier).addWater(2500);
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final earned = first.read(gamificationProvider);
    expect(earned.xp, greaterThan(0));
    expect(
      earned.badges.firstWhere((badge) => badge.id == 'water').unlocked,
      isTrue,
    );
    first.dispose();
    await firstDb.close();

    final secondDb = AppDatabase.forTesting(NativeDatabase.memory());
    final second = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(secondDb)],
    );
    second.read(gamificationProvider);
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final restored = second.read(gamificationProvider);
    expect(restored.xp, greaterThanOrEqualTo(earned.xp));
    expect(
      restored.badges.firstWhere((badge) => badge.id == 'water').unlocked,
      isTrue,
    );
    second.dispose();
    await secondDb.close();
  });
}
