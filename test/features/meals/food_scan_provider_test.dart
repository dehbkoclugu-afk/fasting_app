import 'dart:typed_data';

import 'package:fasting_app/features/meals/providers/food_scan_provider.dart';
import 'package:fasting_app/services/food_vision_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Answers with a canned result (or throws) instead of calling Gemini.
class FakeFoodVisionService extends FoodVisionService {
  FakeFoodVisionService({this.result, this.error}) : super(apiKey: 'test-key');

  final FoodAnalysis? result;
  final FoodVisionError? error;
  int calls = 0;

  @override
  Future<FoodAnalysis> analyze({
    required Uint8List imageBytes,
    required String languageCode,
    String mimeType = 'image/jpeg',
  }) async {
    calls++;
    if (error != null) throw FoodVisionException(error!);
    return result!;
  }

  @override
  void dispose() {}
}

FoodAnalysis analysisWith(int calories) => FoodAnalysis(
  dishName: 'Test plate',
  confidence: 0.9,
  items: [
    FoodItem(
      name: 'Test item',
      portion: '1 serving',
      calories: calories,
      protein: 10,
      carbs: 20,
      fat: 5,
    ),
  ],
);

final _bytes = Uint8List.fromList([9, 9, 9]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('a successful analysis lands in the ready state', () async {
    final notifier = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 0,
    );
    addTearDown(notifier.dispose);

    await notifier.analyzeBytes(_bytes);

    expect(notifier.state.status, FoodScanStatus.ready);
    expect(notifier.state.analysis!.totalCalories, 300);
    expect(notifier.state.imageBytes, _bytes);
    expect(notifier.state.error, isNull);
  });

  test(
    'a failure keeps the photo so retry does not re-open the picker',
    () async {
      final service = FakeFoodVisionService(error: FoodVisionError.network);
      final notifier = FoodScanNotifier(service: service, dailyLimit: 0);
      addTearDown(notifier.dispose);

      await notifier.analyzeBytes(_bytes);

      expect(notifier.state.status, FoodScanStatus.failed);
      expect(notifier.state.error, FoodVisionError.network);
      expect(notifier.state.imageBytes, _bytes);

      await notifier.retry();
      expect(service.calls, 2);
    },
  );

  test('editing an item re-totals the analysis', () async {
    final notifier = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 0,
    );
    addTearDown(notifier.dispose);
    await notifier.analyzeBytes(_bytes);

    notifier.updateItem(
      0,
      notifier.state.analysis!.items.first.copyWith(calories: 120, protein: 4),
    );

    expect(notifier.state.analysis!.totalCalories, 120);
    expect(notifier.state.analysis!.totalProtein, 4);
    // The name the user is editing must survive an item edit.
    expect(notifier.state.analysis!.dishName, 'Test plate');
  });

  test('removing an item drops it from the totals', () async {
    final notifier = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 0,
    );
    addTearDown(notifier.dispose);
    await notifier.analyzeBytes(_bytes);

    notifier.removeItem(0);

    expect(notifier.state.analysis!.items, isEmpty);
    expect(notifier.state.analysis!.totalCalories, 0);
  });

  test('the daily cap counts down and then blocks a scan', () async {
    final service = FakeFoodVisionService(result: analysisWith(300));
    final notifier = FoodScanNotifier(service: service, dailyLimit: 1);
    addTearDown(notifier.dispose);
    await Future<void>.delayed(Duration.zero); // quota load

    expect(notifier.state.scansLeftToday, 1);

    await notifier.analyzeBytes(_bytes);
    expect(notifier.state.scansLeftToday, 0);
    expect(notifier.state.hasQuotaLeft, isFalse);

    await notifier.scan(PhotoSource.camera);
    expect(notifier.state.status, FoodScanStatus.failed);
    expect(notifier.state.error, FoodVisionError.rateLimited);
    // Blocked before the picker or the network was touched.
    expect(service.calls, 1);
  });

  test('the cap is remembered across notifier instances', () async {
    final first = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 2,
    );
    await first.analyzeBytes(_bytes);
    first.dispose();

    final second = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 2,
    );
    addTearDown(second.dispose);
    await Future<void>.delayed(Duration.zero);

    expect(second.state.scansLeftToday, 1);
  });

  test('reset clears the result but keeps the remaining quota', () async {
    final notifier = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 5,
    );
    addTearDown(notifier.dispose);
    await notifier.analyzeBytes(_bytes);

    notifier.reset();

    expect(notifier.state.status, FoodScanStatus.idle);
    expect(notifier.state.analysis, isNull);
    expect(notifier.state.imageBytes, isNull);
    expect(notifier.state.scansLeftToday, 4);
  });
}
