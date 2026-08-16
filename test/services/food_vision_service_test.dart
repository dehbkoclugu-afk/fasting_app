import 'dart:convert';
import 'dart:typed_data';

import 'package:fasting_app/services/food_vision_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Wraps [payload] the way the Generative Language API does: the model's JSON
/// arrives as text inside a candidate part.
String envelope(Object payload) => jsonEncode({
  'candidates': [
    {
      'content': {
        'parts': [
          {'text': jsonEncode(payload)},
        ],
      },
      'finishReason': 'STOP',
    },
  ],
});

const _goodPayload = {
  'isFood': true,
  'dishName': 'Grilled chicken with rice',
  'confidence': 0.82,
  'items': [
    {
      'name': 'Grilled chicken breast',
      'portion': '150 g',
      'calories': 230,
      'protein': 43.0,
      'carbs': 0.0,
      'fat': 5.0,
    },
    {
      'name': 'White rice',
      'portion': '1 cup',
      'calories': 200,
      'protein': 4.0,
      'carbs': 44.0,
      'fat': 1.0,
    },
  ],
  'note': '',
};

FoodVisionService serviceReturning(
  String body, {
  int status = 200,
  void Function(http.Request request)? onRequest,
}) {
  return FoodVisionService(
    apiKey: 'test-key',
    model: 'gemini-2.5-flash',
    client: MockClient((request) async {
      onRequest?.call(request);
      return http.Response(
        body,
        status,
        headers: {'content-type': 'application/json'},
      );
    }),
  );
}

Future<FoodAnalysis> analyzeWith(FoodVisionService service) => service.analyze(
  imageBytes: Uint8List.fromList([1, 2, 3]),
  languageCode: 'tr',
);

Future<FoodVisionError> errorFrom(FoodVisionService service) async {
  try {
    await analyzeWith(service);
    fail('expected a FoodVisionException');
  } on FoodVisionException catch (e) {
    return e.error;
  }
}

void main() {
  group('request', () {
    test('posts the image and locale to the configured model', () async {
      late http.Request captured;
      final service = serviceReturning(
        envelope(_goodPayload),
        onRequest: (request) => captured = request,
      );

      await analyzeWith(service);

      expect(
        captured.url.path,
        '/v1beta/models/gemini-2.5-flash:generateContent',
      );
      expect(captured.headers['x-goog-api-key'], 'test-key');

      final body = jsonDecode(captured.body) as Map<String, dynamic>;
      final parts =
          ((body['contents'] as List).first as Map<String, dynamic>)['parts']
              as List;
      // The locale reaches the prompt, so item names come back translated.
      expect(parts.first['text'], contains('"tr"'));
      expect(parts.last['inline_data']['mime_type'], 'image/jpeg');
      expect(base64Decode(parts.last['inline_data']['data'] as String), [
        1,
        2,
        3,
      ]);
      // Answers are schema-constrained rather than scraped out of prose.
      expect(body['generationConfig']['responseMimeType'], 'application/json');
      expect(body['generationConfig']['responseSchema'], isA<Map>());
    });

    test('refuses an image above the size ceiling', () async {
      final service = serviceReturning(envelope(_goodPayload));
      await expectLater(
        service.analyze(
          imageBytes: Uint8List(FoodVisionService.maxImageBytes + 1),
          languageCode: 'en',
        ),
        throwsA(
          isA<FoodVisionException>().having(
            (e) => e.error,
            'error',
            FoodVisionError.unreadable,
          ),
        ),
      );
    });

    test('reports notConfigured when the build carried no key', () async {
      final service = FoodVisionService(
        apiKey: '',
        client: MockClient((_) async => fail('must not reach the network')),
      );
      expect(service.isConfigured, isFalse);
      expect(await errorFrom(service), FoodVisionError.notConfigured);
    });
  });

  group('parsing', () {
    test('sums macros across the detected items', () async {
      final analysis = await analyzeWith(
        serviceReturning(envelope(_goodPayload)),
      );

      expect(analysis.dishName, 'Grilled chicken with rice');
      expect(analysis.items, hasLength(2));
      expect(analysis.totalCalories, 430);
      expect(analysis.totalProtein, 47.0);
      expect(analysis.totalCarbs, 44.0);
      expect(analysis.totalFat, 6.0);
      expect(analysis.isLowConfidence, isFalse);
    });

    test('flags a low-confidence read', () async {
      final analysis = await analyzeWith(
        serviceReturning(envelope({..._goodPayload, 'confidence': 0.3})),
      );
      expect(analysis.isLowConfidence, isTrue);
    });

    test('clamps a confidence outside 0-1', () async {
      final analysis = await analyzeWith(
        serviceReturning(envelope({..._goodPayload, 'confidence': 8})),
      );
      expect(analysis.confidence, 1.0);
    });

    test('falls back to the first item when dishName is blank', () async {
      final analysis = await analyzeWith(
        serviceReturning(envelope({..._goodPayload, 'dishName': '  '})),
      );
      expect(analysis.dishName, 'Grilled chicken breast');
    });

    test('coerces numbers the model returned as strings', () async {
      final analysis = await analyzeWith(
        serviceReturning(
          envelope({
            'isFood': true,
            'dishName': 'Salad',
            'confidence': '0.7',
            'items': [
              {
                'name': 'Salad',
                'portion': 'bowl',
                'calories': '120',
                'protein': '3.5',
                'carbs': 12,
                'fat': 7.0,
              },
            ],
          }),
        ),
      );

      expect(analysis.totalCalories, 120);
      expect(analysis.totalProtein, 3.5);
      expect(analysis.totalCarbs, 12.0);
      expect(analysis.confidence, closeTo(0.7, 0.001));
    });

    test('drops items with no name instead of saving a blank row', () async {
      final analysis = await analyzeWith(
        serviceReturning(
          envelope({
            'isFood': true,
            'dishName': 'Breakfast',
            'confidence': 0.6,
            'items': [
              {'name': '', 'calories': 90},
              {
                'name': 'Egg',
                'portion': '2',
                'calories': 155,
                'protein': 13.0,
                'carbs': 1.0,
                'fat': 11.0,
              },
            ],
          }),
        ),
      );

      expect(analysis.items, hasLength(1));
      expect(analysis.totalCalories, 155);
    });

    test('negative macros are floored at zero', () async {
      final analysis = await analyzeWith(
        serviceReturning(
          envelope({
            'isFood': true,
            'dishName': 'Soup',
            'confidence': 0.5,
            'items': [
              {
                'name': 'Soup',
                'portion': 'bowl',
                'calories': -50,
                'protein': -2.0,
                'carbs': 10.0,
                'fat': 1.0,
              },
            ],
          }),
        ),
      );

      expect(analysis.totalCalories, 0);
      expect(analysis.totalProtein, 0);
    });

    test('reports noFoodFound when the photo has no food', () async {
      final service = serviceReturning(
        envelope({
          'isFood': false,
          'dishName': '',
          'confidence': 0.9,
          'items': <Object>[],
        }),
      );
      expect(await errorFrom(service), FoodVisionError.noFoodFound);
    });

    test('an empty item list is treated as no food', () async {
      final service = serviceReturning(
        envelope({
          'isFood': true,
          'dishName': 'Something',
          'confidence': 0.4,
          'items': <Object>[],
        }),
      );
      expect(await errorFrom(service), FoodVisionError.noFoodFound);
    });

    test('reports unreadable when every candidate was filtered', () async {
      final service = serviceReturning(
        jsonEncode({
          'promptFeedback': {'blockReason': 'SAFETY'},
        }),
      );
      expect(await errorFrom(service), FoodVisionError.unreadable);
    });

    test('reports unreadable on non-JSON model output', () async {
      final service = serviceReturning(
        jsonEncode({
          'candidates': [
            {
              'content': {
                'parts': [
                  {'text': 'I think this is a sandwich.'},
                ],
              },
            },
          ],
        }),
      );
      expect(await errorFrom(service), FoodVisionError.unreadable);
    });
  });

  group('http failures', () {
    test('429 maps to rateLimited', () async {
      final service = serviceReturning('{"error":{}}', status: 429);
      expect(await errorFrom(service), FoodVisionError.rateLimited);
    });

    test('403 maps to auth', () async {
      final service = serviceReturning('{"error":{}}', status: 403);
      expect(await errorFrom(service), FoodVisionError.auth);
    });

    test('400 maps to auth — in a shipped build it is a bad key', () async {
      final service = serviceReturning('{"error":{}}', status: 400);
      expect(await errorFrom(service), FoodVisionError.auth);
    });

    test('503 maps to server', () async {
      final service = serviceReturning('{"error":{}}', status: 503);
      expect(await errorFrom(service), FoodVisionError.server);
    });

    test('a thrown client error maps to network', () async {
      final service = FoodVisionService(
        apiKey: 'test-key',
        client: MockClient((_) async => throw const SocketishException()),
      );
      expect(await errorFrom(service), FoodVisionError.network);
    });
  });
}

/// Stands in for a dart:io SocketException, which test code cannot construct
/// on every platform.
class SocketishException implements Exception {
  const SocketishException();
}
