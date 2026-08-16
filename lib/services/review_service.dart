import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database/app_database.dart';

/// Asks for a store rating at the one moment the user is most likely to be
/// happy: right after they finish a fast.
///
/// The store sheet is shown by the OS, so there is nothing to translate here —
/// Play and the App Store render it in the device language themselves.
class ReviewService {
  static final ReviewService _instance = ReviewService._();
  factory ReviewService() => _instance;
  ReviewService._();

  /// Set once a request has been *sent*, not once a rating has been left:
  /// neither store tells us whether the user actually rated, and both throttle
  /// the sheet on their own (the App Store allows three prompts a year), so
  /// "we asked" is the only signal we can trust.
  static const _askedKey = 'review_requested';

  /// Completed fasts required before asking. Three is enough for someone to
  /// have an opinion, and early enough that the habit is still forming.
  static const _minCompletedFasts = 3;

  /// Requests the native review sheet when this user has earned it and has
  /// never been asked before.
  ///
  /// Returns true when a request was actually sent, so the caller can hold
  /// back anything else that would fight it for the screen.
  Future<bool> maybeRequestReview(AppDatabase db) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(_askedKey) ?? false) return false;

      final completed = await db.getCompletedSessions();
      if (completed.length < _minCompletedFasts) return false;

      final inAppReview = InAppReview.instance;
      // False on devices without Play Services and on sideloaded builds, where
      // requestReview() would throw.
      if (!await inAppReview.isAvailable()) return false;

      await inAppReview.requestReview();
      await prefs.setBool(_askedKey, true);
      debugPrint('Review request sent after ${completed.length} fasts.');
      return true;
    } catch (e) {
      // A rating prompt is never worth breaking the completion flow over.
      debugPrint('Review request failed: $e');
      return false;
    }
  }
}
