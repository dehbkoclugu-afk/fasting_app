import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/build_config.dart';
import '../../../services/food_vision_service.dart';

enum FoodScanStatus { idle, analyzing, ready, failed }

/// Where the photo should come from.
enum PhotoSource { camera, gallery }

@immutable
class FoodScanState {
  const FoodScanState({
    this.status = FoodScanStatus.idle,
    this.imageBytes,
    this.analysis,
    this.error,
    this.scansLeftToday,
  });

  final FoodScanStatus status;

  /// The photo under analysis, kept so the result screen can show it next to
  /// the numbers.
  final Uint8List? imageBytes;

  /// Present in [FoodScanStatus.ready]. Edits from the review sheet are
  /// applied here before saving.
  final FoodAnalysis? analysis;

  final FoodVisionError? error;

  /// Remaining scans under the daily cap, or null when the cap is off.
  final int? scansLeftToday;

  bool get isBusy => status == FoodScanStatus.analyzing;

  bool get hasQuotaLeft => scansLeftToday == null || scansLeftToday! > 0;

  FoodScanState copyWith({
    FoodScanStatus? status,
    Uint8List? imageBytes,
    FoodAnalysis? analysis,
    FoodVisionError? error,
    int? scansLeftToday,
    bool clearError = false,
    bool clearAnalysis = false,
  }) {
    return FoodScanState(
      status: status ?? this.status,
      imageBytes: imageBytes ?? this.imageBytes,
      analysis: clearAnalysis ? null : (analysis ?? this.analysis),
      error: clearError ? null : (error ?? this.error),
      scansLeftToday: scansLeftToday ?? this.scansLeftToday,
    );
  }
}

class FoodScanNotifier extends StateNotifier<FoodScanState> {
  FoodScanNotifier({
    FoodVisionService? service,
    ImagePicker? picker,
    int? dailyLimit,
  }) : _service = service ?? FoodVisionService(),
       _picker = picker ?? ImagePicker(),
       _dailyLimit = dailyLimit ?? BuildConfig.geminiDailyScanLimit,
       super(const FoodScanState()) {
    _loadQuota();
  }

  final FoodVisionService _service;
  final ImagePicker _picker;
  final int _dailyLimit;

  static const _countKey = 'food_scan_count';
  static const _dayKey = 'food_scan_day';

  /// Downscaled on the device: the estimate does not get better above this,
  /// and a 12 MP original would make the upload slow on mobile data.
  static const _maxImageDimension = 1024.0;
  static const _jpegQuality = 85;

  Future<void> _loadQuota() async {
    if (_dailyLimit <= 0) return;
    final used = await _usedToday();
    if (mounted) {
      state = state.copyWith(
        scansLeftToday: (_dailyLimit - used).clamp(0, _dailyLimit),
      );
    }
  }

  Future<int> _usedToday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dayKey) == _todayKey()
        ? (prefs.getInt(_countKey) ?? 0)
        : 0;
  }

  Future<void> _recordScan() async {
    if (_dailyLimit <= 0) return;
    final prefs = await SharedPreferences.getInstance();
    final used =
        prefs.getString(_dayKey) == _todayKey()
            ? (prefs.getInt(_countKey) ?? 0)
            : 0;
    await prefs.setString(_dayKey, _todayKey());
    await prefs.setInt(_countKey, used + 1);
    if (mounted) {
      state = state.copyWith(
        scansLeftToday: (_dailyLimit - used - 1).clamp(0, _dailyLimit),
      );
    }
  }

  static String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  /// Picks a photo and analyses it. Does nothing if the user backs out of the
  /// picker — that is not an error worth showing.
  Future<void> scan(PhotoSource source, {String languageCode = 'en'}) async {
    if (!state.hasQuotaLeft) {
      state = state.copyWith(
        status: FoodScanStatus.failed,
        error: FoodVisionError.rateLimited,
      );
      return;
    }

    XFile? file;
    try {
      file = await _picker.pickImage(
        source:
            source == PhotoSource.camera
                ? ImageSource.camera
                : ImageSource.gallery,
        maxWidth: _maxImageDimension,
        maxHeight: _maxImageDimension,
        imageQuality: _jpegQuality,
      );
    } catch (e) {
      // Thrown when the camera permission was denied at the OS level.
      debugPrint('Image pick failed: $e');
      state = state.copyWith(
        status: FoodScanStatus.failed,
        error: FoodVisionError.unreadable,
      );
      return;
    }
    if (file == null) return;

    final bytes = await file.readAsBytes();
    await analyzeBytes(bytes, languageCode: languageCode);
  }

  /// Split out from [scan] so the retry button can re-run the same photo
  /// without sending the user back through the picker.
  Future<void> analyzeBytes(
    Uint8List bytes, {
    String languageCode = 'en',
  }) async {
    state = FoodScanState(
      status: FoodScanStatus.analyzing,
      imageBytes: bytes,
      scansLeftToday: state.scansLeftToday,
    );
    try {
      final analysis = await _service.analyze(
        imageBytes: bytes,
        languageCode: languageCode,
      );
      await _recordScan();
      if (!mounted) return;
      state = state.copyWith(
        status: FoodScanStatus.ready,
        analysis: analysis,
        clearError: true,
      );
    } on FoodVisionException catch (e) {
      debugPrint('Food scan failed: $e');
      if (!mounted) return;
      state = state.copyWith(status: FoodScanStatus.failed, error: e.error);
    } catch (e) {
      debugPrint('Food scan failed: $e');
      if (!mounted) return;
      state = state.copyWith(
        status: FoodScanStatus.failed,
        error: FoodVisionError.unreadable,
      );
    }
  }

  /// Re-runs the analysis on the photo already in state.
  Future<void> retry({String languageCode = 'en'}) async {
    final bytes = state.imageBytes;
    if (bytes == null) return;
    await analyzeBytes(bytes, languageCode: languageCode);
  }

  /// Applies a user edit from the review sheet.
  void updateItem(int index, FoodItem item) {
    final analysis = state.analysis;
    if (analysis == null || index < 0 || index >= analysis.items.length) return;
    final items = [...analysis.items]..[index] = item;
    state = state.copyWith(analysis: analysis.copyWith(items: items));
  }

  void removeItem(int index) {
    final analysis = state.analysis;
    if (analysis == null || index < 0 || index >= analysis.items.length) return;
    final items = [...analysis.items]..removeAt(index);
    state = state.copyWith(analysis: analysis.copyWith(items: items));
  }

  void reset() {
    state = FoodScanState(scansLeftToday: state.scansLeftToday);
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}

final foodScanProvider =
    StateNotifierProvider.autoDispose<FoodScanNotifier, FoodScanState>((ref) {
      return FoodScanNotifier();
    });
