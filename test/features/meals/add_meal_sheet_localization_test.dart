import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/meals/widgets/add_meal_sheet.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget mealApp(AppDatabase db, ValueNotifier<Locale> locale) => ProviderScope(
  overrides: [databaseProvider.overrideWithValue(db)],
  child: ValueListenableBuilder<Locale>(
    valueListenable: locale,
    builder: (context, selected, child) => MaterialApp(
      locale: selected,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (_) => const AddMealSheet(),
            ),
            child: const Text('open sheet'),
          ),
        ),
      ),
    ),
  ),
);

Future<void> openSheet(
  WidgetTester tester,
  AppDatabase db,
  ValueNotifier<Locale> locale,
) async {
  await tester.pumpWidget(mealApp(db, locale));
  await tester.pumpAndSettle();
  await tester.tap(find.text('open sheet'));
  await tester.pumpAndSettle();
}

Future<void> savePreset(WidgetTester tester, String title) async {
  await tester.ensureVisible(find.text(title));
  await tester.pumpAndSettle();
  await tester.runAsync(() async {
    await tester.tap(find.text(title));
    await pumpEventQueue();
  });
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('English preset saves the displayed name and original nutrients', (
    tester,
  ) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final locale = ValueNotifier(const Locale('en'));
    addTearDown(db.close);
    addTearDown(locale.dispose);
    await openSheet(tester, db, locale);
    expect(find.text('Fruit oatmeal'), findsOneWidget);
    expect(find.text('Meyveli Yulaf'), findsNothing);

    await savePreset(tester, 'Fruit oatmeal');

    final meals = (await tester.runAsync(() => db.select(db.meals).get()))!;
    expect(meals, hasLength(1));
    expect(meals.single.name, 'Fruit oatmeal');
    expect(meals.single.calories, 320);
    expect(meals.single.protein, 12.0);
    expect(meals.single.carbs, 48.0);
    expect(meals.single.fat, 9.0);
    expect(meals.single.mealType, 'lunch');
    expect(find.byType(AddMealSheet), findsNothing);
  });

  testWidgets('an open sheet follows a locale change before saving', (
    tester,
  ) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final locale = ValueNotifier(const Locale('en'));
    addTearDown(db.close);
    addTearDown(locale.dispose);
    await openSheet(tester, db, locale);

    locale.value = const Locale('de');
    await tester.pumpAndSettle();
    expect(find.text('Fruit oatmeal'), findsNothing);
    expect(find.text('Haferflocken mit Obst'), findsOneWidget);
    await savePreset(tester, 'Haferflocken mit Obst');

    final meals = (await tester.runAsync(() => db.select(db.meals).get()))!;
    expect(meals, hasLength(1));
    expect(meals.single.name, 'Haferflocken mit Obst');
    expect(meals.single.calories, 320);
  });

  testWidgets('Turkish preset names remain available', (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final locale = ValueNotifier(const Locale('tr'));
    addTearDown(db.close);
    addTearDown(locale.dispose);
    await openSheet(tester, db, locale);
    expect(find.text('Meyveli Yulaf'), findsOneWidget);
    expect(find.text('Nohutlu Tahin Kasesi'), findsOneWidget);
    expect(find.text('Kefirli Muz Kasesi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Arabic preset labels render in a narrow RTL sheet', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final locale = ValueNotifier(const Locale('ar'));
    addTearDown(db.close);
    addTearDown(locale.dispose);
    await openSheet(tester, db, locale);
    final title = find.text('شوفان بالفواكه');
    expect(title, findsOneWidget);
    await tester.ensureVisible(title);
    await tester.pumpAndSettle();
    expect(Directionality.of(tester.element(title)), TextDirection.rtl);
    expect(find.text('Meyveli Yulaf'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
