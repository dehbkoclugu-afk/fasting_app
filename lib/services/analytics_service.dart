import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/config/build_config.dart';

/// Opt-in product events, sent straight to PostHog's capture API.
///
/// Off by default and off in any build without `POSTHOG_KEY`. Events must never
/// carry health data: no weights, meals, durations or body metrics. The id is
/// random, not tied to the device, and deleted on opt-out.
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService _instance = AnalyticsService._();
  factory AnalyticsService() => _instance;

  static const optInKey = 'analytics_opt_in';
  static const _idKey = 'analytics_id';
  static final _endpoint = Uri.parse('https://eu.i.posthog.com/capture/');

  @visibleForTesting
  http.Client client = http.Client();
  @visibleForTesting
  String apiKey = BuildConfig.posthogKey;

  String? _distinctId;

  bool get isActive => _distinctId != null && apiKey.isNotEmpty;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _distinctId = prefs.getBool(optInKey) == true ? prefs.getString(_idKey) : null;
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(optInKey, enabled);
    if (enabled) {
      final random = Random.secure();
      _distinctId =
          prefs.getString(_idKey) ??
          List.generate(
            16,
            (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
          ).join();
      await prefs.setString(_idKey, _distinctId!);
    } else {
      _distinctId = null;
      await prefs.remove(_idKey);
    }
  }

  void track(String event, [Map<String, Object> properties = const {}]) {
    if (!isActive) return;
    unawaited(_send(event, properties));
  }

  Future<void> _send(String event, Map<String, Object> properties) async {
    try {
      await client
          .post(
            _endpoint,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode({
              'api_key': apiKey,
              'event': event,
              'distinct_id': _distinctId,
              'properties': {
                ...properties,
                r'$process_person_profile': false,
                r'$geoip_disable': true,
              },
            }),
          )
          .timeout(const Duration(seconds: 5));
    } catch (error) {
      debugPrint('Analytics event dropped: $error');
    }
  }
}
