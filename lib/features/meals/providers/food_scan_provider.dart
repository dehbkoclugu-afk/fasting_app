import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/build_config.dart';
import '../../../services/food_vision_service.dart';

enum FoodScanStatus { idle, analyzing, ready, failed }

/// Where the photo should come from.
enum PhotoSource { camera, gallery }

/// Gemini needs the real media type; Android gallery photos are often HEIC,
/// PNG or WebP even when the picker resized them.
String detectImageMimeType(
  Uint8List bytes, {
  String? reportedMimeType,
  String? path,
}) {
  bool startsWith(List<int> signature) {
    if (bytes.length < signature.length) return false;
    for (var i = 0; i < signature.length; i++) {
      if (bytes[i] != signature[i]) return false;
    }
    return true;
  }

  if (startsWith(const [0xFF, 0xD8, 0xFF])) return 'image/jpeg';
  if (startsWith(const [0x89, 0x50, 0x4E, 0x47])) return 'image/png';
  if (bytes.length >= 12 &&
      String.fromCharCodes(bytes.sublist(0, 4)) == 'RIFF' &&
      String.fromCharCodes(bytes.sublist(8, 12)) == 'WEBP') {
    return 'image/webp';
  }
  if (bytes.length >= 12 &&
      String.fromCharCodes(bytes.sublist(4, 8)) == 'ftyp') {
    final brand = String.fromCharCodes(bytes.sublist(8, 12)).toLowerCase();
    if (brand.startsWith('hei') || brand.startsWith('hev')) {
      return 'image/heic';
    }
    if (brand == 'mif1' || brand == 'msf1') return 'image/heif';
  }

  final reported = reportedMimeType?.split(';').first.trim().toLowerCase();
  if (const {
    'image/jpeg',
    'image/png',
    'image/webp',
    'image/heic',
    'image/heif',
  }.contains(reported)) {
    return reported!;
  }

  final lowerPath = path?.toLowerCase() ?? '';
  if (lowerPath.endsWith('.png')) return 'image/png';
  if (lowerPath.endsWith('.webp')) return 'image/webp';
  if (lowerPath.endsWith('.heic')) return 'image/heic';
  if (lowerPath.endsWith('.heif')) return 'image/heif';
  return 'image/jpeg';
}

/// Reject oversized picker fallbacks before allocating their complete contents.
/// The native picker normally returns a downscaled image, but unsupported
/// formats and recovery can return the original file.
Future<Uint8List> readFoodPhoto(XFile file) async {
  final length = await file.length();
  if (length <= 0 || length > FoodVisionService.maxImageBytes) {
    throw const FoodVisionException(FoodVisionError.unreadable);
  }
  final bytes = await file.readAsBytes();
  if (bytes.isEmpty || bytes.length > FoodVisionService.maxImageBytes) {
    throw const FoodVisionException(FoodVisionError.unreadable);
  }
  return bytes;
}

@immutable
class FoodScanState {
  const FoodScanState({
    this.status = FoodScanStatus.idle,
    this.imageBytes,
    this.imageMimeType = 'image/jpeg',
    this.analysis,
    this.error,
    this.scansLeftToday,
  });

  final FoodScanStatus status;

  /// The photo under analysis, kept so the result screen can show it next to
  /// the numbers.
  final Uint8List? imageBytes;
  final String imageMimeType;

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
    String? imageMimeType,
    FoodAnalysis? analysis,
    FoodVisionError? error,
    int? scansLeftToday,
    bool clearError = false,
    bool clearAnalysis = false,
  }) {
    return FoodScanState(
      status: status ?? this.status,
      imageBytes: imageBytes ?? this.imageBytes,
      imageMimeType: imageMimeType ?? this.imageMimeType,
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
    DateTime Function()? clock,
  }) : _service = service ?? FoodVisionService(),
       _picker = picker ?? ImagePicker(),
       _dailyLimit = dailyLimit ?? BuildConfig.geminiDailyScanLimit,
       _clock = clock ?? DateTime.now,
       super(const FoodScanState()) {
    _quotaLoad = _loadQuota();
  }

  final FoodVisionService _service;
  final ImagePicker _picker;
  final int _dailyLimit;
  final DateTime Function() _clock;
  late final Future<void> _quotaLoad;
  bool _pickerInFlight = false;
  bool _analysisInFlight = false;

  static const _countKey = 'food_scan_count';
  static const _dayKey = 'food_scan_day';

  /// Downscaled on the device: the estimate does not get better above this,
  /// and a 12 MP original would make the upload slow on mobile data.
  static const _maxImageDimension = 1024.0;
  static const _jpegQuality = 85;

  Future<void> refreshQuota() async {
    if (!mounted || _pickerInFlight || _analysisInFlight) return;
    await _quotaLoad;
    if (mounted) await _loadQuota();
  }

  Future<void> _loadQuota() async {
    if (_dailyLimit <= 0) return;
    try {
      final used = await _usedToday();
      if (mounted) {
        state = state.copyWith(
          scansLeftToday: (_dailyLimit - used).clamp(0, _dailyLimit),
        );
      }
    } catch (error) {
      debugPrint('Food scan quota could not be loaded: $error');
      // Fail closed: a storage failure must not silently disable the
      // production quota and expose the shared API key to unlimited calls.
      if (mounted) {
        state = state.copyWith(scansLeftToday: 0);
      }
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
    final used = prefs.getString(_dayKey) == _todayKey()
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

  String _todayKey() {
    final now = _clock();
    return '${now.year}-${now.month}-${now.day}';
  }

  /// Picks a photo and analyses it. Does nothing if the user backs out of the
  /// picker — that is not an error worth showing.
  Future<void> scan(PhotoSource source, {String languageCode = 'en'}) async {
    if (!mounted || _pickerInFlight || _analysisInFlight) return;
    _pickerInFlight = true;
    try {
      await _quotaLoad;
      if (!mounted) return;
      await _loadQuota();
      if (!mounted) return;
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
          source: source == PhotoSource.camera
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: _maxImageDimension,
          maxHeight: _maxImageDimension,
          imageQuality: _jpegQuality,
        );
      } catch (error) {
        debugPrint('Image pick failed: $error');
        if (mounted) {
          state = state.copyWith(
            status: FoodScanStatus.failed,
            error: FoodVisionError.unreadable,
          );
        }
        return;
      }
      if (!mounted || file == null) return;

      try {
        final bytes = await readFoodPhoto(file);
        if (!mounted) return;
        await analyzeBytes(
          bytes,
          languageCode: languageCode,
          mimeType: detectImageMimeType(
            bytes,
            reportedMimeType: file.mimeType,
            path: file.path,
          ),
        );
      } catch (error) {
        debugPrint('Picked image could not be read: $error');
        if (!mounted) return;
        state = state.copyWith(
          status: FoodScanStatus.failed,
          error: FoodVisionError.unreadable,
        );
      }
    } finally {
      _pickerInFlight = false;
    }
  }

  /// Split out from [scan] so the retry button can re-run the same photo
  /// without sending the user back through the picker.
  Future<void> analyzeBytes(
    Uint8List bytes, {
    String languageCode = 'en',
    String? mimeType,
  }) async {
    if (!mounted || _analysisInFlight) return;
    _analysisInFlight = true;
    try {
      await _quotaLoad;
      if (!mounted) return;
      await _loadQuota();
      if (!mounted) return;
      if (!state.hasQuotaLeft) {
        state = state.copyWith(
          status: FoodScanStatus.failed,
          error: FoodVisionError.rateLimited,
        );
        return;
      }
      // Check before publishing bytes to Image.memory, not just before HTTP.
      if (bytes.isEmpty || bytes.length > FoodVisionService.maxImageBytes) {
        state = FoodScanState(
          status: FoodScanStatus.failed,
          error: FoodVisionError.unreadable,
          scansLeftToday: state.scansLeftToday,
        );
        return;
      }
      final resolvedMimeType = mimeType ?? detectImageMimeType(bytes);
      state = FoodScanState(
        status: FoodScanStatus.analyzing,
        imageBytes: bytes,
        imageMimeType: resolvedMimeType,
        scansLeftToday: state.scansLeftToday,
      );
      final analysis = await _service.analyze(
        imageBytes: bytes,
        languageCode: languageCode,
        mimeType: resolvedMimeType,
      );
      await _recordScan();
      if (!mounted) return;
      state = state.copyWith(
        status: FoodScanStatus.ready,
        analysis: analysis,
        clearError: true,
      );
    } on FoodVisionException catch (error) {
      debugPrint('Food scan failed: $error');
      if (!mounted) return;
      state = state.copyWith(status: FoodScanStatus.failed, error: error.error);
    } catch (error) {
      debugPrint('Food scan failed: $error');
      if (!mounted) return;
      state = state.copyWith(
        status: FoodScanStatus.failed,
        error: FoodVisionError.unreadable,
      );
    } finally {
      _analysisInFlight = false;
    }
  }

  /// Re-runs the analysis on the photo already in state.
  Future<void> retry({String languageCode = 'en'}) async {
    if (!mounted) return;
    final bytes = state.imageBytes;
    if (bytes == null) return;
    await analyzeBytes(
      bytes,
      languageCode: languageCode,
      mimeType: state.imageMimeType,
    );
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
    if (!mounted || _analysisInFlight || _pickerInFlight) return;
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
