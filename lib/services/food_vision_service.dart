import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/config/build_config.dart';

/// One recognised component of a photographed meal, with the macros the model
/// estimated for the portion it believes it is looking at.
@immutable
class FoodItem {
  const FoodItem({
    required this.name,
    required this.portion,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  final String name;

  /// Free text as the model phrased it, e.g. "1 bowl (250 g)". Shown next to
  /// the name so the user can judge whether the estimate matches their plate.
  final String portion;

  final int calories;
  final double protein;
  final double carbs;
  final double fat;

  FoodItem copyWith({
    String? name,
    String? portion,
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
  }) {
    return FoodItem(
      name: name ?? this.name,
      portion: portion ?? this.portion,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
    );
  }

  static FoodItem? fromJson(Map<String, dynamic> json) {
    final name = (json['name'] as String?)?.trim() ?? '';
    if (name.isEmpty) return null;
    return FoodItem(
      name: name,
      portion: (json['portion'] as String?)?.trim() ?? '',
      calories: _asInt(json['calories']),
      protein: _asDouble(json['protein']),
      carbs: _asDouble(json['carbs']),
      fat: _asDouble(json['fat']),
    );
  }
}

/// The full result of analysing one photo.
@immutable
class FoodAnalysis {
  const FoodAnalysis({
    required this.dishName,
    required this.items,
    required this.confidence,
    this.note = '',
  });

  /// A name for the plate as a whole, used as the meal name on save.
  final String dishName;

  final List<FoodItem> items;

  /// 0–1, as reported by the model. Drives the "estimate, not a measurement"
  /// warning shown for low-confidence reads.
  final double confidence;

  /// Optional caveat from the model ("sauce not identifiable" and the like).
  final String note;

  int get totalCalories => items.fold(0, (sum, i) => sum + i.calories);
  double get totalProtein => items.fold(0.0, (sum, i) => sum + i.protein);
  double get totalCarbs => items.fold(0.0, (sum, i) => sum + i.carbs);
  double get totalFat => items.fold(0.0, (sum, i) => sum + i.fat);

  bool get isLowConfidence => confidence > 0 && confidence < 0.5;

  FoodAnalysis copyWith({String? dishName, List<FoodItem>? items}) {
    return FoodAnalysis(
      dishName: dishName ?? this.dishName,
      items: items ?? this.items,
      confidence: confidence,
      note: note,
    );
  }
}

/// Why an analysis failed, so the UI can say something useful instead of
/// dumping an HTTP status on the user.
enum FoodVisionError {
  /// The build carried no `GEMINI_API_KEY`.
  notConfigured,

  /// No connection, DNS failure, or the request timed out.
  network,

  /// 401/403 — key missing, revoked, or not allowed to call the API.
  auth,

  /// 429 or an exhausted free-tier quota. Retryable later.
  rateLimited,

  /// 5xx on Google's side.
  server,

  /// The model answered, but there is no food in the picture.
  noFoodFound,

  /// The model answered with something we could not turn into macros.
  unreadable,
}

class FoodVisionException implements Exception {
  const FoodVisionException(this.error, [this.detail]);

  final FoodVisionError error;
  final String? detail;

  @override
  String toString() => 'FoodVisionException(${error.name}: $detail)';
}

/// Sends a meal photo to Gemini and gets calories and macros back.
///
/// Uses the Generative Language API directly over HTTP rather than a Dart SDK:
/// it is a single request, and it keeps the dependency list to `http`.
///
/// The response is constrained with a JSON schema (`responseSchema`), so the
/// model cannot answer with prose that then needs to be scraped — either it
/// returns the shape below or the request fails outright.
class FoodVisionService {
  FoodVisionService({http.Client? client, String? apiKey, String? model})
    : _client = client ?? http.Client(),
      _apiKey = apiKey ?? BuildConfig.geminiApiKey,
      _model = model ?? BuildConfig.geminiModel;

  final http.Client _client;
  final String _apiKey;
  final String _model;

  static const _host = 'generativelanguage.googleapis.com';
  static const _timeout = Duration(seconds: 45);

  /// Photos are downscaled before they get here; this is the backstop that
  /// keeps a pathological image off the wire. 4 MB of JPEG is far more detail
  /// than the estimate needs.
  static const maxImageBytes = 4 * 1024 * 1024;

  bool get isConfigured => _apiKey.isNotEmpty;

  /// Analyses [imageBytes] and returns the estimate.
  ///
  /// [languageCode] is the app's current locale — the item names come back in
  /// that language so they read naturally in the meal list.
  ///
  /// Throws [FoodVisionException] for every failure path.
  Future<FoodAnalysis> analyze({
    required Uint8List imageBytes,
    required String languageCode,
    String mimeType = 'image/jpeg',
  }) async {
    if (!isConfigured) {
      throw const FoodVisionException(FoodVisionError.notConfigured);
    }
    if (imageBytes.length > maxImageBytes) {
      throw const FoodVisionException(
        FoodVisionError.unreadable,
        'image too large',
      );
    }

    final uri = Uri.https(_host, '/v1beta/models/$_model:generateContent');
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': _prompt(languageCode)},
            {
              'inline_data': {
                'mime_type': mimeType,
                'data': base64Encode(imageBytes),
              },
            },
          ],
        },
      ],
      'generationConfig': {
        'temperature': 0.2,
        'responseMimeType': 'application/json',
        'responseSchema': _responseSchema,
        // The estimate does not benefit from a reasoning pass, and thinking
        // tokens are the expensive part of the free tier's budget.
        'thinkingConfig': {'thinkingBudget': 0},
      },
      // Food photos are harmless, but a plated dish occasionally trips the
      // stricter default thresholds and comes back with no candidate at all.
      'safetySettings': [
        for (final category in const [
          'HARM_CATEGORY_HARASSMENT',
          'HARM_CATEGORY_HATE_SPEECH',
          'HARM_CATEGORY_SEXUALLY_EXPLICIT',
          'HARM_CATEGORY_DANGEROUS_CONTENT',
        ])
          {'category': category, 'threshold': 'BLOCK_ONLY_HIGH'},
      ],
    });

    late final http.Response response;
    try {
      response = await _client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': _apiKey,
            },
            body: body,
          )
          .timeout(_timeout);
    } on TimeoutException {
      throw const FoodVisionException(FoodVisionError.network, 'timeout');
    } catch (e) {
      throw FoodVisionException(FoodVisionError.network, '$e');
    }

    if (response.statusCode != 200) {
      throw FoodVisionException(
        _errorForStatus(response.statusCode),
        'HTTP ${response.statusCode}: ${_truncate(response.body)}',
      );
    }

    return _parse(response.body);
  }

  void dispose() => _client.close();

  static FoodVisionError _errorForStatus(int status) {
    if (status == 429) return FoodVisionError.rateLimited;
    if (status == 401 || status == 403) return FoodVisionError.auth;
    if (status == 404) return FoodVisionError.server;
    // 400 is almost always a bad or restricted key in a shipped build — the
    // request shape itself is fixed and covered by tests.
    if (status == 400) return FoodVisionError.auth;
    if (status >= 500) return FoodVisionError.server;
    return FoodVisionError.unreadable;
  }

  /// Pulls the model's JSON out of the API envelope and validates it.
  @visibleForTesting
  static FoodAnalysis parseResponse(String responseBody) =>
      _parse(responseBody);

  static FoodAnalysis _parse(String responseBody) {
    final Map<String, dynamic> envelope;
    try {
      envelope = jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      throw FoodVisionException(FoodVisionError.unreadable, 'bad envelope: $e');
    }

    final candidates = envelope['candidates'];
    if (candidates is! List || candidates.isEmpty) {
      // Happens when every candidate was filtered; promptFeedback says why.
      throw const FoodVisionException(
        FoodVisionError.unreadable,
        'no candidates',
      );
    }

    final parts =
        ((candidates.first as Map<String, dynamic>)['content']
                as Map<String, dynamic>?)?['parts']
            as List?;
    final text = parts
        ?.whereType<Map<String, dynamic>>()
        .map((p) => p['text'])
        .whereType<String>()
        .join();
    if (text == null || text.trim().isEmpty) {
      throw const FoodVisionException(FoodVisionError.unreadable, 'empty text');
    }

    final Map<String, dynamic> result;
    try {
      result = _decodeModelJson(text);
    } catch (e) {
      throw FoodVisionException(FoodVisionError.unreadable, 'bad payload: $e');
    }

    if (result['isFood'] == false) {
      throw const FoodVisionException(FoodVisionError.noFoodFound);
    }

    final items = (result['items'] as List? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(FoodItem.fromJson)
        .whereType<FoodItem>()
        .toList();

    // An empty list with isFood true is the model hedging; treat it the same
    // as "no food" so the user gets the retry hint rather than an empty form.
    if (items.isEmpty) {
      throw const FoodVisionException(FoodVisionError.noFoodFound);
    }

    final dishName = (result['dishName'] as String?)?.trim();
    return FoodAnalysis(
      dishName: dishName == null || dishName.isEmpty
          ? items.first.name
          : dishName,
      items: items,
      confidence: _asDouble(result['confidence']).clamp(0.0, 1.0),
      note: (result['note'] as String?)?.trim() ?? '',
    );
  }

  static String _prompt(String languageCode) =>
      '''
You are a nutrition estimator. Look at the photo and identify every food and
drink on it.

Rules:
- Estimate the portion actually visible, using plate, cutlery and hand size as
  scale references. Do not assume a standard serving when the photo shows more
  or less than one.
- Give one entry per distinct food. Do not merge a whole plate into one entry
  unless it is a single mixed dish.
- calories are kcal for the visible portion; protein, carbs and fat are grams
  for the same portion. They must be consistent with each other
  (4 kcal/g protein, 4 kcal/g carbs, 9 kcal/g fat, within ~15%).
- confidence is your own 0-1 estimate of how reliable this reading is. Use a
  low value for blurry photos, hidden ingredients or unclear portion sizes.
- If the photo has no food or drink in it, set isFood to false and return an
  empty items list.
- Write dishName, every name, portion and note in the language with the
  IETF code "$languageCode". Numbers stay numbers.
- note is at most one short sentence, and only when something material is
  uncertain. Otherwise leave it empty.''';

  static const _responseSchema = {
    'type': 'OBJECT',
    'properties': {
      'isFood': {'type': 'BOOLEAN'},
      'dishName': {'type': 'STRING'},
      'confidence': {'type': 'NUMBER'},
      'items': {
        'type': 'ARRAY',
        'items': {
          'type': 'OBJECT',
          'properties': {
            'name': {'type': 'STRING'},
            'portion': {'type': 'STRING'},
            'calories': {'type': 'INTEGER'},
            'protein': {'type': 'NUMBER'},
            'carbs': {'type': 'NUMBER'},
            'fat': {'type': 'NUMBER'},
          },
          'required': [
            'name',
            'portion',
            'calories',
            'protein',
            'carbs',
            'fat',
          ],
        },
      },
      'note': {'type': 'STRING'},
    },
    'required': ['isFood', 'dishName', 'confidence', 'items'],
  };

  static Map<String, dynamic> _decodeModelJson(String text) {
    var normalized = text.trim();
    if (normalized.startsWith('```')) {
      final firstLineEnd = normalized.indexOf('\n');
      if (firstLineEnd >= 0) {
        normalized = normalized.substring(firstLineEnd + 1).trim();
      }
      if (normalized.endsWith('```')) {
        normalized = normalized.substring(0, normalized.length - 3).trim();
      }
    }

    try {
      return jsonDecode(normalized) as Map<String, dynamic>;
    } catch (_) {
      // Some model versions may add a short sentence around JSON despite JSON
      // mode. Recover the object rather than rejecting a valid food analysis.
      final start = normalized.indexOf('{');
      final end = normalized.lastIndexOf('}');
      if (start < 0 || end <= start) rethrow;
      return jsonDecode(normalized.substring(start, end + 1))
          as Map<String, dynamic>;
    }
  }

  static String _truncate(String s) =>
      s.length <= 200 ? s : '${s.substring(0, 200)}…';
}

int _asInt(Object? value) => _asDouble(value).clamp(0, 100000).round();

double _asDouble(Object? value) {
  final parsed = switch (value) {
    num v => v.toDouble(),
    String v => double.tryParse(v.trim().replaceAll(',', '.')),
    _ => null,
  };
  if (parsed == null || !parsed.isFinite || parsed < 0) return 0;
  return parsed.clamp(0, 100000).toDouble();
}
