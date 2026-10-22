import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/onboarding/screens/goal_screen.dart';
import '../../features/onboarding/screens/plan_select_screen.dart';
import '../../features/onboarding/screens/body_info_screen.dart';
import '../../features/onboarding/screens/permissions_screen.dart';
import '../../features/timer/screens/timer_screen.dart';
import '../../features/stats/screens/stats_screen.dart';
import '../../features/meals/screens/meals_screen.dart';
import '../../features/meals/screens/food_scan_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/paywall/screens/paywall_screen.dart';
import '../../features/profile/screens/body_metrics_screen.dart';
import '../../features/explore/screens/explore_screen.dart';
import '../../features/gamification/screens/gamification_dashboard_screen.dart';
import '../../features/water/screens/water_tracker_screen.dart';
import '../../features/weight/screens/weight_tracker_screen.dart';
import '../shell/main_shell.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router({
    required bool showOnboarding,
    Uint8List? recoveredFoodImage,
    String? recoveredFoodImageMimeType,
  }) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation:
          recoveredFoodImage != null
              ? '/food-scan'
              : (showOnboarding ? '/onboarding' : '/timer'),
      routes: [
        // Onboarding
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const WelcomeScreen(),
        ),
        GoRoute(
          path: '/onboarding/goals',
          builder: (context, state) => const GoalScreen(),
        ),
        GoRoute(
          path: '/onboarding/plan',
          builder: (context, state) => const PlanSelectScreen(),
        ),
        GoRoute(
          path: '/onboarding/body-info',
          builder: (context, state) => const BodyInfoScreen(),
        ),
        GoRoute(
          path: '/onboarding/permissions',
          builder: (context, state) => const PermissionsScreen(),
        ),

        // Main Shell (Bottom Nav - 5 tab)
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => MainShell(child: child),
          routes: [
            GoRoute(
              path: '/timer',
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: TimerScreen()),
            ),
            GoRoute(
              path: '/explore',
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: ExploreScreen()),
            ),
            GoRoute(
              path: '/stats',
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: StatsScreen()),
            ),
            GoRoute(
              path: '/achievements',
              pageBuilder:
                  (context, state) => const NoTransitionPage(
                    child: GamificationDashboardScreen(),
                  ),
            ),
            GoRoute(
              path: '/profile',
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: ProfileScreen()),
            ),
          ],
        ),

        // Paywall (Full screen modal)
        GoRoute(
          path: '/paywall',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const PaywallScreen(),
        ),

        // Body Metrics
        GoRoute(
          path: '/body-metrics',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const BodyMetricsScreen(),
        ),

        // Meals (accessible from other screens)
        GoRoute(
          path: '/meals',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const MealsScreen(),
        ),

        // AI food photo analysis (premium)
        GoRoute(
          path: '/food-scan',
          parentNavigatorKey: _rootNavigatorKey,
          builder:
              (context, state) => FoodScanScreen(
                initialImageBytes: recoveredFoodImage,
                initialImageMimeType: recoveredFoodImageMimeType,
              ),
        ),

        // Water Tracker
        GoRoute(
          path: '/water-tracker',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const WaterTrackerScreen(),
        ),

        // Weight Tracker
        GoRoute(
          path: '/weight-tracker',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const WeightTrackerScreen(),
        ),
      ],
    );
  }
}
