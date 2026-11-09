import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/profile/providers/settings_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const legacyPrefs = <String, Object>{
  'height': 172.5,
  'weight': 81.5,
  'targetWeight': 72.0,
  'age': 34,
  'userName': 'Sam',
};

AppDatabase unavailable() => throw StateError('database unavailable');

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<SettingsNotifier> load(AppDatabase Function() database) async {
    final notifier = SettingsNotifier(database);
    addTearDown(notifier.dispose);
    await notifier.profileSettled;
    return notifier;
  }

  test('older preference values move into the database', () async {
    SharedPreferences.setMockInitialValues(legacyPrefs);

    final notifier = await load(() => db);

    expect(notifier.state.height, 172.5);
    expect(notifier.state.weight, 81.5);
    expect(notifier.state.targetWeight, 72.0);
    expect(notifier.state.age, 34);
    expect(notifier.state.userName, 'Sam');
    expect(await db.getSetting('profile_height'), '172.5');
    expect(await db.getSetting('profile_age'), '34');
    expect(await db.getSetting('profile_userName'), 'Sam');

    final prefs = await SharedPreferences.getInstance();
    for (final key in ['userName', 'height', 'weight', 'targetWeight', 'age']) {
      expect(prefs.containsKey(key), isFalse, reason: key);
    }

    final reloaded = await load(() => db);
    expect(reloaded.state.height, 172.5);
    expect(reloaded.state.age, 34);
    expect(reloaded.state.userName, 'Sam');
  });

  test('values nothing reads are deleted from older installs', () async {
    SharedPreferences.setMockInitialValues({
      'last_crisis_hour': 3,
      'last_crisis_reason': 'dizzy',
      'isMale': false,
      'crisis_support_count': 2,
    });

    await load(() => db);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey('last_crisis_hour'), isFalse);
    expect(prefs.containsKey('last_crisis_reason'), isFalse);
    expect(prefs.containsKey('isMale'), isFalse);
    expect(prefs.getInt('crisis_support_count'), 2);
  });

  test('a name goes to the database and survives a failed save', () async {
    SharedPreferences.setMockInitialValues({});
    final online = await load(() => db);
    online.setUserName('Alex');
    await online.profileSettled;
    expect(await db.getSetting('profile_userName'), 'Alex');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey('userName'), isFalse);

    final offline = await load(unavailable);
    offline.setUserName('Robin');
    await offline.profileSettled;
    expect(prefs.getString('userName'), 'Robin');

    final recovered = await load(() => db);
    expect(recovered.state.userName, 'Robin');
    expect(await db.getSetting('profile_userName'), 'Robin');
    expect(prefs.containsKey('userName'), isFalse);
  });

  test('unavailable database keeps preference values usable', () async {
    SharedPreferences.setMockInitialValues(legacyPrefs);

    final offline = await load(unavailable);
    expect(offline.state.weight, 81.5);
    expect((await SharedPreferences.getInstance()).getDouble('weight'), 81.5);

    final recovered = await load(() => db);
    expect(recovered.state.weight, 81.5);
    expect(await db.getSetting('profile_weight'), '81.5');
    expect(
      (await SharedPreferences.getInstance()).containsKey('weight'),
      isFalse,
    );
  });

  test('saves go to the database, not preferences', () async {
    SharedPreferences.setMockInitialValues({});
    final notifier = await load(() => db);

    notifier.setBodyInfo(height: 180.0, weight: 90.0, age: 40);
    notifier.setBodyInfo(weight: 88.5);
    await notifier.profileSettled;

    expect(await db.getSetting('profile_weight'), '88.5');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey('height'), isFalse);
    expect(prefs.containsKey('weight'), isFalse);
    expect(prefs.containsKey('age'), isFalse);

    final reloaded = await load(() => db);
    expect(reloaded.state.height, 180.0);
    expect(reloaded.state.weight, 88.5);
    expect(reloaded.state.age, 40);
  });

  test('a value set during loading beats the older stored value', () async {
    SharedPreferences.setMockInitialValues({'weight': 81.5});

    final notifier = SettingsNotifier(() => db);
    addTearDown(notifier.dispose);
    notifier.setBodyInfo(weight: 79.0);
    await notifier.profileSettled;

    expect(notifier.state.weight, 79.0);
    expect(await db.getSetting('profile_weight'), '79.0');
  });

  test('a failed save survives in preferences and moves later', () async {
    SharedPreferences.setMockInitialValues({});
    final offline = await load(unavailable);

    offline.setBodyInfo(weight: 77.5, age: 29);
    await offline.profileSettled;
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getDouble('weight'), 77.5);
    expect(prefs.getInt('age'), 29);

    await db.setSetting('profile_weight', '90.0');
    final recovered = await load(() => db);
    expect(recovered.state.weight, 77.5);
    expect(recovered.state.age, 29);
    expect(await db.getSetting('profile_weight'), '77.5');
  });

  test('erasing the database leaves no body info behind', () async {
    SharedPreferences.setMockInitialValues(legacyPrefs);
    await load(() => db);

    await db.deleteAllUserData();

    final reloaded = await load(() => db);
    expect(reloaded.state.height, isNull);
    expect(reloaded.state.weight, isNull);
    expect(reloaded.state.targetWeight, isNull);
    expect(reloaded.state.age, isNull);
  });
}
