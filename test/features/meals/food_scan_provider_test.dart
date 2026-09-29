import 'dart:async';
import 'dart:typed_data';

import 'package:fasting_app/features/meals/providers/food_scan_provider.dart';
import 'package:fasting_app/services/food_vision_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Answers with a canned result (or throws) instead of calling Gemini.
class FakeFoodVisionService extends FoodVisionService {
  FakeFoodVisionService({this.result, this.error}) : super(apiKey: 'test-key');

  final FoodAnalysis? result;
  final FoodVisionError? error;
  int calls = 0;
  String? lastMimeType;

  @override
  Future<FoodAnalysis> analyze({
    required Uint8List imageBytes,
    required String languageCode,
    String mimeType = 'image/jpeg',
  }) async {
    calls++;
    lastMimeType = mimeType;
    if (error != null) throw FoodVisionException(error!);
    return result!;
  }

  @override
  void dispose() {}
}

class DeferredFoodVisionService extends FakeFoodVisionService {
  final pending = Completer<FoodAnalysis>();
  @override
  Future<FoodAnalysis> analyze({
    required Uint8List imageBytes,
    required String languageCode,
    String mimeType = 'image/jpeg',
  }) {
    calls++;
    return pending.future;
  }
}

class OversizedPhoto extends XFile {
  OversizedPhoto() : super('/oversized.jpg');
  bool read = false;
  @override
  Future<int> length() async => FoodVisionService.maxImageBytes + 1;
  @override
  Future<Uint8List> readAsBytes() async {
    read = true;
    throw StateError('oversized file must not be read');
  }
}

class DeferredPicker extends ImagePicker {
  final pending = Completer<XFile?>();
  final opened = Completer<void>();
  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) {
    opened.complete();
    return pending.future;
  }
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

  test('oversized files are rejected before reading their bytes', () async {
    final file = OversizedPhoto();
    await expectLater(readFoodPhoto(file), throwsA(isA<FoodVisionException>()));
    expect(file.read, isFalse);
  });

  test('oversized byte input never reaches preview state or the API', () async {
    final service = FakeFoodVisionService(result: analysisWith(300));
    final notifier = FoodScanNotifier(service: service, dailyLimit: 0);
    addTearDown(notifier.dispose);
    await notifier.analyzeBytes(Uint8List(FoodVisionService.maxImageBytes + 1));
    expect(service.calls, 0);
    expect(notifier.state.imageBytes, isNull);
    expect(notifier.state.status, FoodScanStatus.failed);
  });

  test(
    'disposing during initial quota await does not touch dead state',
    () async {
      final service = FakeFoodVisionService(result: analysisWith(300));
      final notifier = FoodScanNotifier(service: service, dailyLimit: 0);
      final operation = notifier.analyzeBytes(_bytes);
      notifier.dispose();
      await operation;
      expect(service.calls, 0);
    },
  );

  test(
    'camera result after screen disposal is neither read nor analysed',
    () async {
      final picker = DeferredPicker();
      final service = FakeFoodVisionService(result: analysisWith(300));
      final notifier = FoodScanNotifier(
        service: service,
        picker: picker,
        dailyLimit: 0,
      );
      final operation = notifier.scan(PhotoSource.camera);
      await picker.opened.future;
      notifier.dispose();
      final photo = OversizedPhoto();
      picker.pending.complete(photo);
      await operation;
      expect(photo.read, isFalse);
      expect(service.calls, 0);
    },
  );

  test('simultaneous analysis requests make only one API call', () async {
    final service = DeferredFoodVisionService();
    final notifier = FoodScanNotifier(service: service, dailyLimit: 0);
    addTearDown(notifier.dispose);
    final first = notifier.analyzeBytes(_bytes);
    final second = notifier.analyzeBytes(_bytes);
    await Future<void>.delayed(Duration.zero);
    expect(service.calls, 1);
    service.pending.complete(analysisWith(300));
    await Future.wait([first, second]);
    expect(notifier.state.status, FoodScanStatus.ready);
  });

  test('late analysis result after disposal is ignored', () async {
    final service = DeferredFoodVisionService();
    final notifier = FoodScanNotifier(service: service, dailyLimit: 0);
    final operation = notifier.analyzeBytes(_bytes);
    await Future<void>.delayed(Duration.zero);
    notifier.dispose();
    service.pending.complete(analysisWith(300));
    await operation;
    expect(service.calls, 1);
  });

  test('exhausted quota refreshes at midnight without reopening', () async {
    var now = DateTime(2026, 9, 27, 23, 59);
    final service = FakeFoodVisionService(result: analysisWith(300));
    final notifier = FoodScanNotifier(
      service: service,
      dailyLimit: 1,
      clock: () => now,
    );
    addTearDown(notifier.dispose);
    await notifier.analyzeBytes(_bytes);
    expect(notifier.state.scansLeftToday, 0);
    now = DateTime(2026, 9, 28, 0, 1);
    await notifier.analyzeBytes(_bytes);
    expect(service.calls, 2);
    expect(notifier.state.status, FoodScanStatus.ready);
  });

  group('image MIME detection', () {
    test('recognizes JPEG, PNG and WebP signatures', () {
      expect(
        detectImageMimeType(Uint8List.fromList([0xFF, 0xD8, 0xFF, 0x00])),
        'image/jpeg',
      );
      expect(
        detectImageMimeType(Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 0x00])),
        'image/png',
      );
      expect(
        detectImageMimeType(
          Uint8List.fromList([
            0x52,
            0x49,
            0x46,
            0x46,
            0,
            0,
            0,
            0,
            0x57,
            0x45,
            0x42,
            0x50,
          ]),
        ),
        'image/webp',
      );
    });

    test('recognizes Samsung HEIC photos and respects file metadata', () {
      expect(
        detectImageMimeType(
          Uint8List.fromList([
            0,
            0,
            0,
            0,
            0x66,
            0x74,
            0x79,
            0x70,
            0x68,
            0x65,
            0x69,
            0x63,
          ]),
        ),
        'image/heic',
      );
      expect(
        detectImageMimeType(
          Uint8List.fromList([1, 2, 3]),
          reportedMimeType: 'image/png',
        ),
        'image/png',
      );
    });
  });

  test('a successful analysis lands in the ready state', () async {
    final notifier = FoodScanNotifier(
      service: FakeFoodVisionService(result: analysisWith(300)),
      dailyLimit: 0,
    );
    addTearDown(notifier.dispose);

    await notifier.analyzeBytes(_bytes, mimeType: 'image/png');

    expect(notifier.state.status, FoodScanStatus.ready);
    expect(notifier.state.analysis!.totalCalories, 300);
    expect(notifier.state.imageBytes, _bytes);
    expect(notifier.state.error, isNull);
    expect(notifier.state.imageMimeType, 'image/png');
  });

  test(
    'a failure keeps the photo so retry does not re-open the picker',
    () async {
      final service = FakeFoodVisionService(error: FoodVisionError.network);
      final notifier = FoodScanNotifier(service: service, dailyLimit: 0);
      addTearDown(notifier.dispose);

      await notifier.analyzeBytes(_bytes, mimeType: 'image/webp');

      expect(notifier.state.status, FoodScanStatus.failed);
      expect(notifier.state.error, FoodVisionError.network);
      expect(notifier.state.imageBytes, _bytes);

      await notifier.retry();
      expect(service.calls, 2);
      expect(service.lastMimeType, 'image/webp');
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
