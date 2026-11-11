import 'dart:convert';

import 'package:fasting_app/services/analytics_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late List<Map<String, dynamic>> sent;
  final analytics = AnalyticsService();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sent = [];
    analytics
      ..apiKey = 'test-key'
      ..client = MockClient((request) async {
        sent.add(jsonDecode(request.body) as Map<String, dynamic>);
        return http.Response('{}', 200);
      });
    await analytics.setEnabled(false);
  });

  test('sends nothing without opt-in', () async {
    analytics.track('fast_started');
    await Future<void>.delayed(Duration.zero);
    expect(sent, isEmpty);
  });

  test('sends nothing without a project key', () async {
    await analytics.setEnabled(true);
    analytics.apiKey = '';
    analytics.track('fast_started');
    await Future<void>.delayed(Duration.zero);
    expect(sent, isEmpty);
  });

  test('sends an anonymous event after opt-in', () async {
    await analytics.setEnabled(true);
    analytics.track('fast_started', {'plan': '16_8'});
    await Future<void>.delayed(Duration.zero);
    expect(sent.single['event'], 'fast_started');
    expect(sent.single['distinct_id'], hasLength(32));
    final properties = sent.single['properties'] as Map<String, dynamic>;
    expect(properties[r'$process_person_profile'], isFalse);
    expect(properties[r'$geoip_disable'], isTrue);
  });

  test('opting out forgets the id', () async {
    await analytics.setEnabled(true);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('analytics_id'), isNotNull);
    await analytics.setEnabled(false);
    expect(prefs.getString('analytics_id'), isNull);
    expect(analytics.isActive, isFalse);
  });

  test('a failed send never reaches the caller', () async {
    await analytics.setEnabled(true);
    analytics.client = MockClient((_) async => throw Exception('offline'));
    analytics.track('fast_started');
    await Future<void>.delayed(Duration.zero);
  });
}
