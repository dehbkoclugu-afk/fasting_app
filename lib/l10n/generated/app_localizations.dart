import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'FastTrack'**
  String get appTitle;

  /// No description provided for @greeting_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greeting_morning;

  /// No description provided for @greeting_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greeting_afternoon;

  /// No description provided for @greeting_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greeting_evening;

  /// No description provided for @tab_timer.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tab_timer;

  /// No description provided for @tab_explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get tab_explore;

  /// No description provided for @tab_stats.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get tab_stats;

  /// No description provided for @tab_meals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get tab_meals;

  /// No description provided for @tab_achievements.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get tab_achievements;

  /// No description provided for @tab_profile.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get tab_profile;

  /// No description provided for @timer_fasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting Time'**
  String get timer_fasting;

  /// No description provided for @timer_remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get timer_remaining;

  /// No description provided for @timer_elapsed.
  ///
  /// In en, this message translates to:
  /// **'Elapsed'**
  String get timer_elapsed;

  /// No description provided for @timer_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get timer_start;

  /// No description provided for @timer_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get timer_stop;

  /// No description provided for @timer_completed.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get timer_completed;

  /// No description provided for @timer_completedMessage.
  ///
  /// In en, this message translates to:
  /// **'You completed your fast successfully!'**
  String get timer_completedMessage;

  /// No description provided for @timer_selectPlan.
  ///
  /// In en, this message translates to:
  /// **'Select Fasting Plan'**
  String get timer_selectPlan;

  /// No description provided for @timer_stopConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to end the fast early?'**
  String get timer_stopConfirm;

  /// No description provided for @timer_stopTitle.
  ///
  /// In en, this message translates to:
  /// **'End Fast'**
  String get timer_stopTitle;

  /// No description provided for @timer_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get timer_cancel;

  /// No description provided for @timer_confirmStop.
  ///
  /// In en, this message translates to:
  /// **'Yes, End'**
  String get timer_confirmStop;

  /// No description provided for @phase_anabolic.
  ///
  /// In en, this message translates to:
  /// **'Anabolic'**
  String get phase_anabolic;

  /// No description provided for @phase_anabolicDesc.
  ///
  /// In en, this message translates to:
  /// **'Digestion in progress'**
  String get phase_anabolicDesc;

  /// No description provided for @phase_catabolic.
  ///
  /// In en, this message translates to:
  /// **'Catabolic'**
  String get phase_catabolic;

  /// No description provided for @phase_catabolicDesc.
  ///
  /// In en, this message translates to:
  /// **'Energy transition'**
  String get phase_catabolicDesc;

  /// No description provided for @phase_fatBurning.
  ///
  /// In en, this message translates to:
  /// **'Fat Burning'**
  String get phase_fatBurning;

  /// No description provided for @phase_fatBurningDesc.
  ///
  /// In en, this message translates to:
  /// **'Fat burning started'**
  String get phase_fatBurningDesc;

  /// No description provided for @phase_ketosis.
  ///
  /// In en, this message translates to:
  /// **'Ketosis'**
  String get phase_ketosis;

  /// No description provided for @phase_ketosisDesc.
  ///
  /// In en, this message translates to:
  /// **'Ketone production active'**
  String get phase_ketosisDesc;

  /// No description provided for @phase_autophagy.
  ///
  /// In en, this message translates to:
  /// **'Autophagy'**
  String get phase_autophagy;

  /// No description provided for @phase_autophagyDesc.
  ///
  /// In en, this message translates to:
  /// **'Cell renewal'**
  String get phase_autophagyDesc;

  /// No description provided for @stats_title.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats_title;

  /// No description provided for @stats_week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get stats_week;

  /// No description provided for @stats_month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get stats_month;

  /// No description provided for @stats_year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get stats_year;

  /// No description provided for @stats_totalFasts.
  ///
  /// In en, this message translates to:
  /// **'Total Fasts'**
  String get stats_totalFasts;

  /// No description provided for @stats_average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get stats_average;

  /// No description provided for @stats_fastDuration.
  ///
  /// In en, this message translates to:
  /// **'fast duration'**
  String get stats_fastDuration;

  /// No description provided for @stats_streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get stats_streak;

  /// No description provided for @stats_daysConsecutive.
  ///
  /// In en, this message translates to:
  /// **'consecutive days'**
  String get stats_daysConsecutive;

  /// No description provided for @stats_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get stats_success;

  /// No description provided for @stats_completion.
  ///
  /// In en, this message translates to:
  /// **'completion'**
  String get stats_completion;

  /// No description provided for @stats_weeklyFasting.
  ///
  /// In en, this message translates to:
  /// **'Weekly Fasting'**
  String get stats_weeklyFasting;

  /// No description provided for @stats_monthlyView.
  ///
  /// In en, this message translates to:
  /// **'Monthly View'**
  String get stats_monthlyView;

  /// No description provided for @stats_weightChange.
  ///
  /// In en, this message translates to:
  /// **'Weight Change'**
  String get stats_weightChange;

  /// No description provided for @heatmap_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get heatmap_none;

  /// No description provided for @heatmap_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get heatmap_low;

  /// No description provided for @heatmap_good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get heatmap_good;

  /// No description provided for @heatmap_full.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get heatmap_full;

  /// No description provided for @meals_title.
  ///
  /// In en, this message translates to:
  /// **'Meal Planner'**
  String get meals_title;

  /// No description provided for @meals_eatingWindow.
  ///
  /// In en, this message translates to:
  /// **'Eating Window'**
  String get meals_eatingWindow;

  /// No description provided for @meals_windowOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get meals_windowOpen;

  /// No description provided for @meals_windowFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get meals_windowFasting;

  /// No description provided for @meals_calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get meals_calories;

  /// No description provided for @meals_protein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get meals_protein;

  /// No description provided for @meals_carbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get meals_carbs;

  /// No description provided for @meals_fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get meals_fat;

  /// No description provided for @meals_todayMeals.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Meals'**
  String get meals_todayMeals;

  /// No description provided for @meals_noMeals.
  ///
  /// In en, this message translates to:
  /// **'No meals added yet'**
  String get meals_noMeals;

  /// No description provided for @meals_breakfastSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Break-Fast Suggestions'**
  String get meals_breakfastSuggestions;

  /// No description provided for @meals_addMeal.
  ///
  /// In en, this message translates to:
  /// **'Add Meal'**
  String get meals_addMeal;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get profile_user;

  /// No description provided for @profile_planActive.
  ///
  /// In en, this message translates to:
  /// **'{plan} Plan active'**
  String profile_planActive(String plan);

  /// No description provided for @profile_upgradePremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get profile_upgradePremium;

  /// No description provided for @profile_premiumDesc.
  ///
  /// In en, this message translates to:
  /// **'Every fasting plan, with no ads'**
  String get profile_premiumDesc;

  /// No description provided for @profile_bodyMetrics.
  ///
  /// In en, this message translates to:
  /// **'Body Metrics'**
  String get profile_bodyMetrics;

  /// No description provided for @profile_height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get profile_height;

  /// No description provided for @profile_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get profile_weight;

  /// No description provided for @profile_targetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target Weight'**
  String get profile_targetWeight;

  /// No description provided for @profile_bmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get profile_bmi;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profile_settings;

  /// No description provided for @profile_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profile_notifications;

  /// No description provided for @profile_darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get profile_darkTheme;

  /// No description provided for @profile_waterReminder.
  ///
  /// In en, this message translates to:
  /// **'Water Reminder'**
  String get profile_waterReminder;

  /// No description provided for @profile_phaseNotifications.
  ///
  /// In en, this message translates to:
  /// **'Phase Notifications'**
  String get profile_phaseNotifications;

  /// No description provided for @profile_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profile_language;

  /// No description provided for @profile_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profile_about;

  /// No description provided for @profile_rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get profile_rateApp;

  /// No description provided for @profile_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get profile_share;

  /// No description provided for @profile_privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get profile_privacyPolicy;

  /// No description provided for @profile_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get profile_version;

  /// No description provided for @onboarding_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboarding_welcome;

  /// No description provided for @onboarding_welcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Take control of your\nintermittent fasting journey'**
  String get onboarding_welcomeDesc;

  /// No description provided for @onboarding_featureTimer.
  ///
  /// In en, this message translates to:
  /// **'Smart fasting timer'**
  String get onboarding_featureTimer;

  /// No description provided for @onboarding_featureStats.
  ///
  /// In en, this message translates to:
  /// **'Detailed statistics and charts'**
  String get onboarding_featureStats;

  /// No description provided for @onboarding_featureMeals.
  ///
  /// In en, this message translates to:
  /// **'Meal planner and recipe suggestions'**
  String get onboarding_featureMeals;

  /// No description provided for @onboarding_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_getStarted;

  /// No description provided for @onboarding_selectGoal.
  ///
  /// In en, this message translates to:
  /// **'What\'s your goal?'**
  String get onboarding_selectGoal;

  /// No description provided for @onboarding_selectGoalDesc.
  ///
  /// In en, this message translates to:
  /// **'You can select multiple'**
  String get onboarding_selectGoalDesc;

  /// No description provided for @onboarding_goalWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get onboarding_goalWeight;

  /// No description provided for @onboarding_goalWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Healthy weight loss'**
  String get onboarding_goalWeightDesc;

  /// No description provided for @onboarding_goalHealth.
  ///
  /// In en, this message translates to:
  /// **'Improve Health'**
  String get onboarding_goalHealth;

  /// No description provided for @onboarding_goalHealthDesc.
  ///
  /// In en, this message translates to:
  /// **'General health and immunity'**
  String get onboarding_goalHealthDesc;

  /// No description provided for @onboarding_goalEnergy.
  ///
  /// In en, this message translates to:
  /// **'More Energy'**
  String get onboarding_goalEnergy;

  /// No description provided for @onboarding_goalEnergyDesc.
  ///
  /// In en, this message translates to:
  /// **'Energy throughout the day'**
  String get onboarding_goalEnergyDesc;

  /// No description provided for @onboarding_goalMental.
  ///
  /// In en, this message translates to:
  /// **'Mental Clarity'**
  String get onboarding_goalMental;

  /// No description provided for @onboarding_goalMentalDesc.
  ///
  /// In en, this message translates to:
  /// **'Focus and clarity'**
  String get onboarding_goalMentalDesc;

  /// No description provided for @onboarding_goalLongevity.
  ///
  /// In en, this message translates to:
  /// **'Longevity'**
  String get onboarding_goalLongevity;

  /// No description provided for @onboarding_goalLongevityDesc.
  ///
  /// In en, this message translates to:
  /// **'Cell renewal and anti-aging'**
  String get onboarding_goalLongevityDesc;

  /// No description provided for @onboarding_goalDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Discipline'**
  String get onboarding_goalDiscipline;

  /// No description provided for @onboarding_goalDisciplineDesc.
  ///
  /// In en, this message translates to:
  /// **'Build self-discipline'**
  String get onboarding_goalDisciplineDesc;

  /// No description provided for @onboarding_selectPlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get onboarding_selectPlan;

  /// No description provided for @onboarding_selectPlanDesc.
  ///
  /// In en, this message translates to:
  /// **'Select the best fasting plan for you'**
  String get onboarding_selectPlanDesc;

  /// No description provided for @onboarding_bodyInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Info'**
  String get onboarding_bodyInfo;

  /// No description provided for @onboarding_bodyInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'For personalized recommendations'**
  String get onboarding_bodyInfoDesc;

  /// No description provided for @onboarding_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get onboarding_gender;

  /// No description provided for @onboarding_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get onboarding_male;

  /// No description provided for @onboarding_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get onboarding_female;

  /// No description provided for @onboarding_age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get onboarding_age;

  /// No description provided for @onboarding_bodyInfoDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This information is stored only on your device and used for calorie calculations.'**
  String get onboarding_bodyInfoDisclaimer;

  /// No description provided for @onboarding_permissions.
  ///
  /// In en, this message translates to:
  /// **'Final Step'**
  String get onboarding_permissions;

  /// No description provided for @onboarding_permissionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable permissions for the best experience'**
  String get onboarding_permissionsDesc;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboarding_next;

  /// No description provided for @onboarding_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get onboarding_start;

  /// No description provided for @onboarding_skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Set up later'**
  String get onboarding_skipForNow;

  /// No description provided for @waterAdded.
  ///
  /// In en, this message translates to:
  /// **'+250ml water added'**
  String get waterAdded;

  /// No description provided for @languageSelect.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelect;

  /// No description provided for @languageTurkish.
  ///
  /// In en, this message translates to:
  /// **'Türkçe'**
  String get languageTurkish;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @paywall_title.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get paywall_title;

  /// No description provided for @paywall_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock every fasting plan and remove ads'**
  String get paywall_subtitle;

  /// No description provided for @paywall_allPlans.
  ///
  /// In en, this message translates to:
  /// **'All fasting plans'**
  String get paywall_allPlans;

  /// No description provided for @paywall_advancedStats.
  ///
  /// In en, this message translates to:
  /// **'Advanced statistics'**
  String get paywall_advancedStats;

  /// No description provided for @paywall_mealPlanner.
  ///
  /// In en, this message translates to:
  /// **'Meal planner'**
  String get paywall_mealPlanner;

  /// No description provided for @paywall_themes.
  ///
  /// In en, this message translates to:
  /// **'Theme customization'**
  String get paywall_themes;

  /// No description provided for @paywall_noAds.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get paywall_noAds;

  /// No description provided for @paywall_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get paywall_weekly;

  /// No description provided for @paywall_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get paywall_monthly;

  /// No description provided for @paywall_yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get paywall_yearly;

  /// No description provided for @paywall_bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get paywall_bestValue;

  /// No description provided for @paywall_freeTrial.
  ///
  /// In en, this message translates to:
  /// **'Free Trial (3 Days)'**
  String get paywall_freeTrial;

  /// No description provided for @paywall_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get paywall_restore;

  /// No description provided for @paywall_premiumActive.
  ///
  /// In en, this message translates to:
  /// **'Premium Active!'**
  String get paywall_premiumActive;

  /// No description provided for @paywall_premiumActiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Every fasting plan is unlocked and ads are off'**
  String get paywall_premiumActiveDesc;

  /// No description provided for @water_title.
  ///
  /// In en, this message translates to:
  /// **'Water Intake'**
  String get water_title;

  /// No description provided for @water_addWater.
  ///
  /// In en, this message translates to:
  /// **'Add Water'**
  String get water_addWater;

  /// No description provided for @water_goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get water_goal;

  /// No description provided for @water_ml.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get water_ml;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @common_hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get common_hours;

  /// No description provided for @common_minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get common_minutes;

  /// No description provided for @common_days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get common_days;

  /// No description provided for @common_enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get common_enable;

  /// No description provided for @streakCard_currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get streakCard_currentStreak;

  /// No description provided for @streakCard_longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get streakCard_longestStreak;

  /// No description provided for @streakCard_totalSessions.
  ///
  /// In en, this message translates to:
  /// **'Total Fasts'**
  String get streakCard_totalSessions;

  /// No description provided for @meals_mealType.
  ///
  /// In en, this message translates to:
  /// **'Meal Type'**
  String get meals_mealType;

  /// No description provided for @meals_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get meals_breakfast;

  /// No description provided for @meals_lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get meals_lunch;

  /// No description provided for @meals_dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get meals_dinner;

  /// No description provided for @meals_snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get meals_snack;

  /// No description provided for @meals_carbohydrate.
  ///
  /// In en, this message translates to:
  /// **'Carbohydrate'**
  String get meals_carbohydrate;

  /// No description provided for @meals_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get meals_add;

  /// No description provided for @meals_mealName.
  ///
  /// In en, this message translates to:
  /// **'Meal name'**
  String get meals_mealName;

  /// No description provided for @bodyMetrics_title.
  ///
  /// In en, this message translates to:
  /// **'Body Metrics'**
  String get bodyMetrics_title;

  /// No description provided for @bodyMetrics_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get bodyMetrics_weight;

  /// No description provided for @bodyMetrics_target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get bodyMetrics_target;

  /// No description provided for @bodyMetrics_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get bodyMetrics_save;

  /// No description provided for @bodyMetrics_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get bodyMetrics_history;

  /// No description provided for @bodyMetrics_bmiValue.
  ///
  /// In en, this message translates to:
  /// **'BMI: {value}'**
  String bodyMetrics_bmiValue(String value);

  /// No description provided for @bodyMetrics_noData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get bodyMetrics_noData;

  /// No description provided for @meals_quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get meals_quickAdd;

  /// No description provided for @meals_manualEntry.
  ///
  /// In en, this message translates to:
  /// **'Manual Entry'**
  String get meals_manualEntry;

  /// No description provided for @meals_added.
  ///
  /// In en, this message translates to:
  /// **'{name} added'**
  String meals_added(String name);

  /// No description provided for @meals_nameCalorieRequired.
  ///
  /// In en, this message translates to:
  /// **'Name and calories are required'**
  String get meals_nameCalorieRequired;

  /// No description provided for @bodyMetrics_addWeight.
  ///
  /// In en, this message translates to:
  /// **'Add Weight'**
  String get bodyMetrics_addWeight;

  /// No description provided for @bodyMetrics_hintWeight.
  ///
  /// In en, this message translates to:
  /// **'e.g. 74.5'**
  String get bodyMetrics_hintWeight;

  /// No description provided for @bodyMetrics_invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight'**
  String get bodyMetrics_invalidWeight;

  /// No description provided for @bodyMetrics_weightSaved.
  ///
  /// In en, this message translates to:
  /// **'{value} kg saved'**
  String bodyMetrics_weightSaved(String value);

  /// No description provided for @completion_duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get completion_duration;

  /// No description provided for @completion_plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get completion_plan;

  /// No description provided for @completion_lastPhase.
  ///
  /// In en, this message translates to:
  /// **'Last Phase'**
  String get completion_lastPhase;

  /// No description provided for @timer_remainingTime.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time'**
  String get timer_remainingTime;

  /// No description provided for @timer_ready.
  ///
  /// In en, this message translates to:
  /// **'Ready to Start'**
  String get timer_ready;

  /// No description provided for @streak_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get streak_status;

  /// No description provided for @streak_startToday.
  ///
  /// In en, this message translates to:
  /// **'Start today!'**
  String get streak_startToday;

  /// No description provided for @streak_goodStart.
  ///
  /// In en, this message translates to:
  /// **'Good start!'**
  String get streak_goodStart;

  /// No description provided for @streak_goingGreat.
  ///
  /// In en, this message translates to:
  /// **'Going great!'**
  String get streak_goingGreat;

  /// No description provided for @streak_superb.
  ///
  /// In en, this message translates to:
  /// **'Superb!'**
  String get streak_superb;

  /// No description provided for @streak_legendary.
  ///
  /// In en, this message translates to:
  /// **'Legendary!'**
  String get streak_legendary;

  /// No description provided for @streak_incredible.
  ///
  /// In en, this message translates to:
  /// **'Incredible!'**
  String get streak_incredible;

  /// No description provided for @weight_noRecord.
  ///
  /// In en, this message translates to:
  /// **'No weight records yet\nAdd from Profile > Body Metrics'**
  String get weight_noRecord;

  /// No description provided for @day_mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get day_mon;

  /// No description provided for @day_tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get day_tue;

  /// No description provided for @day_wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get day_wed;

  /// No description provided for @day_thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get day_thu;

  /// No description provided for @day_fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get day_fri;

  /// No description provided for @day_sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get day_sat;

  /// No description provided for @day_sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get day_sun;

  /// No description provided for @day_short_mon.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get day_short_mon;

  /// No description provided for @day_short_tue.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get day_short_tue;

  /// No description provided for @day_short_wed.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get day_short_wed;

  /// No description provided for @day_short_thu.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get day_short_thu;

  /// No description provided for @day_short_fri.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get day_short_fri;

  /// No description provided for @day_short_sat.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get day_short_sat;

  /// No description provided for @day_short_sun.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get day_short_sun;

  /// No description provided for @month_jan.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get month_jan;

  /// No description provided for @month_feb.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get month_feb;

  /// No description provided for @month_mar.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get month_mar;

  /// No description provided for @month_apr.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get month_apr;

  /// No description provided for @month_may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get month_may;

  /// No description provided for @month_jun.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get month_jun;

  /// No description provided for @month_jul.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get month_jul;

  /// No description provided for @month_aug.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get month_aug;

  /// No description provided for @month_sep.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get month_sep;

  /// No description provided for @month_oct.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get month_oct;

  /// No description provided for @month_nov.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get month_nov;

  /// No description provided for @month_dec.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get month_dec;

  /// No description provided for @meals_fastingWindow.
  ///
  /// In en, this message translates to:
  /// **'Fasting ({hours}h)'**
  String meals_fastingWindow(String hours);

  /// No description provided for @meals_eatingWindowHours.
  ///
  /// In en, this message translates to:
  /// **'Eating ({hours}h)'**
  String meals_eatingWindowHours(String hours);

  /// No description provided for @recipe_oatSmoothie.
  ///
  /// In en, this message translates to:
  /// **'Oat Smoothie'**
  String get recipe_oatSmoothie;

  /// No description provided for @recipe_avocadoToast.
  ///
  /// In en, this message translates to:
  /// **'Avocado Toast'**
  String get recipe_avocadoToast;

  /// No description provided for @recipe_yogurtBowl.
  ///
  /// In en, this message translates to:
  /// **'Yogurt Bowl'**
  String get recipe_yogurtBowl;

  /// No description provided for @elapsed_time.
  ///
  /// In en, this message translates to:
  /// **'Elapsed Time'**
  String get elapsed_time;

  /// No description provided for @fast_ends_on.
  ///
  /// In en, this message translates to:
  /// **'Your fast ends at'**
  String get fast_ends_on;

  /// No description provided for @end_fasting.
  ///
  /// In en, this message translates to:
  /// **'End Fasting'**
  String get end_fasting;

  /// No description provided for @start_fasting.
  ///
  /// In en, this message translates to:
  /// **'Start Fasting'**
  String get start_fasting;

  /// No description provided for @water_tracker.
  ///
  /// In en, this message translates to:
  /// **'Water Tracker'**
  String get water_tracker;

  /// No description provided for @weight_tracker.
  ///
  /// In en, this message translates to:
  /// **'Weight Tracker'**
  String get weight_tracker;

  /// No description provided for @drink.
  ///
  /// In en, this message translates to:
  /// **'Drink'**
  String get drink;

  /// No description provided for @log_weight.
  ///
  /// In en, this message translates to:
  /// **'Log Weight'**
  String get log_weight;

  /// No description provided for @bmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmi;

  /// No description provided for @weight_lost.
  ///
  /// In en, this message translates to:
  /// **'Weight Lost'**
  String get weight_lost;

  /// No description provided for @current_weight.
  ///
  /// In en, this message translates to:
  /// **'Current Weight'**
  String get current_weight;

  /// No description provided for @goal_weight.
  ///
  /// In en, this message translates to:
  /// **'Goal Weight'**
  String get goal_weight;

  /// No description provided for @daily_goal.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get daily_goal;

  /// No description provided for @completed_percent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Completed'**
  String completed_percent(String percent);

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @profile_theme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profile_theme;

  /// No description provided for @theme_select.
  ///
  /// In en, this message translates to:
  /// **'Choose appearance'**
  String get theme_select;

  /// No description provided for @theme_system.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get theme_system;

  /// No description provided for @theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_dark;

  /// No description provided for @language_system.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get language_system;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languagePortugueseBrazil.
  ///
  /// In en, this message translates to:
  /// **'Português (Brasil)'**
  String get languagePortugueseBrazil;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @profile_completionSound.
  ///
  /// In en, this message translates to:
  /// **'Completion sound'**
  String get profile_completionSound;

  /// No description provided for @profile_calmGamification.
  ///
  /// In en, this message translates to:
  /// **'Calm gamification'**
  String get profile_calmGamification;

  /// No description provided for @profile_calmGamificationDesc.
  ///
  /// In en, this message translates to:
  /// **'Reduces league and season pressure'**
  String get profile_calmGamificationDesc;

  /// No description provided for @profile_editName.
  ///
  /// In en, this message translates to:
  /// **'Edit your name'**
  String get profile_editName;

  /// No description provided for @profile_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profile_name;

  /// No description provided for @circle_title.
  ///
  /// In en, this message translates to:
  /// **'Fasting Circle'**
  String get circle_title;

  /// No description provided for @circle_you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get circle_you;

  /// No description provided for @circle_tagline.
  ///
  /// In en, this message translates to:
  /// **'Together, without pressure.'**
  String get circle_tagline;

  /// No description provided for @circle_privacy.
  ///
  /// In en, this message translates to:
  /// **'Weight and private metrics stay hidden. Only progress and support are visible.'**
  String get circle_privacy;

  /// No description provided for @circle_sendSupport.
  ///
  /// In en, this message translates to:
  /// **'Send support · {count}'**
  String circle_sendSupport(int count);

  /// No description provided for @circle_inviteCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite code copied'**
  String get circle_inviteCopied;

  /// No description provided for @circle_createInvite.
  ///
  /// In en, this message translates to:
  /// **'Create private invite'**
  String get circle_createInvite;

  /// No description provided for @crisis_nameTitle.
  ///
  /// In en, this message translates to:
  /// **'First, name what is happening'**
  String get crisis_nameTitle;

  /// No description provided for @crisis_nameDesc.
  ///
  /// In en, this message translates to:
  /// **'It may be hunger, habit, or emotion.'**
  String get crisis_nameDesc;

  /// No description provided for @crisis_waterTitle.
  ///
  /// In en, this message translates to:
  /// **'Drink a glass of water'**
  String get crisis_waterTitle;

  /// No description provided for @crisis_waterDesc.
  ///
  /// In en, this message translates to:
  /// **'Then take three slow breaths.'**
  String get crisis_waterDesc;

  /// No description provided for @crisis_delayTitle.
  ///
  /// In en, this message translates to:
  /// **'Delay the decision for 10 minutes'**
  String get crisis_delayTitle;

  /// No description provided for @crisis_delayDesc.
  ///
  /// In en, this message translates to:
  /// **'If you feel unwell, ending the fast is not failure.'**
  String get crisis_delayDesc;

  /// No description provided for @crisis_hunger.
  ///
  /// In en, this message translates to:
  /// **'Hunger'**
  String get crisis_hunger;

  /// No description provided for @crisis_habit.
  ///
  /// In en, this message translates to:
  /// **'Habit'**
  String get crisis_habit;

  /// No description provided for @crisis_stress.
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get crisis_stress;

  /// No description provided for @crisis_tenMore.
  ///
  /// In en, this message translates to:
  /// **'Give it 10 minutes'**
  String get crisis_tenMore;

  /// No description provided for @stats_storyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your first fast will begin your personal story.'**
  String get stats_storyEmpty;

  /// No description provided for @stats_story.
  ///
  /// In en, this message translates to:
  /// **'You fasted {sessions} times this period, kept your rhythm for {hours} hours, and reached a {rate}% completion rate.'**
  String stats_story(int sessions, int hours, int rate);

  /// No description provided for @stats_storyTitle.
  ///
  /// In en, this message translates to:
  /// **'The story of your rhythm'**
  String get stats_storyTitle;

  /// No description provided for @home_todayRhythm.
  ///
  /// In en, this message translates to:
  /// **'Today’s rhythm'**
  String get home_todayRhythm;

  /// No description provided for @home_finalHourSupport.
  ///
  /// In en, this message translates to:
  /// **'Final-hour support'**
  String get home_finalHourSupport;

  /// No description provided for @home_needSupport.
  ///
  /// In en, this message translates to:
  /// **'I need a little support'**
  String get home_needSupport;

  /// No description provided for @home_todaySummary.
  ///
  /// In en, this message translates to:
  /// **'Today at a glance'**
  String get home_todaySummary;

  /// No description provided for @home_dayStreak.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get home_dayStreak;

  /// No description provided for @home_weightGoal.
  ///
  /// In en, this message translates to:
  /// **'goal {weight} kg'**
  String home_weightGoal(String weight);

  /// No description provided for @weather_steady.
  ///
  /// In en, this message translates to:
  /// **'Your rhythm is steady'**
  String get weather_steady;

  /// No description provided for @weather_gentle.
  ///
  /// In en, this message translates to:
  /// **'A gentle day'**
  String get weather_gentle;

  /// No description provided for @weather_water.
  ///
  /// In en, this message translates to:
  /// **'A glass of water may help.'**
  String get weather_water;

  /// No description provided for @weather_listen.
  ///
  /// In en, this message translates to:
  /// **'You have come far; listen to your body.'**
  String get weather_listen;

  /// No description provided for @weather_onPlan.
  ///
  /// In en, this message translates to:
  /// **'Today’s pace matches your plan.'**
  String get weather_onPlan;

  /// No description provided for @weather_challenging.
  ///
  /// In en, this message translates to:
  /// **'This hour was challenging before; support mode is ready.'**
  String get weather_challenging;

  /// No description provided for @replay_copied.
  ///
  /// In en, this message translates to:
  /// **'Fasting Replay copied'**
  String get replay_copied;

  /// No description provided for @replay_button.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get replay_button;

  /// No description provided for @replay_text.
  ///
  /// In en, this message translates to:
  /// **'I completed my {plan} fast in {hours}h {minutes}m · {phase}'**
  String replay_text(String plan, int hours, int minutes, String phase);

  /// No description provided for @journey_label.
  ///
  /// In en, this message translates to:
  /// **'Metabolic journey'**
  String get journey_label;

  /// No description provided for @journey_now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get journey_now;

  /// No description provided for @journey_next.
  ///
  /// In en, this message translates to:
  /// **'{time} until {phase}'**
  String journey_next(String time, String phase);

  /// No description provided for @phase_estimateShort.
  ///
  /// In en, this message translates to:
  /// **'Phase timing is a general estimate, not a medical measurement.'**
  String get phase_estimateShort;

  /// No description provided for @phase_hours.
  ///
  /// In en, this message translates to:
  /// **'Hours {start}–{end}'**
  String phase_hours(int start, int end);

  /// No description provided for @phase_estimateLong.
  ///
  /// In en, this message translates to:
  /// **'This timing is a general estimate. Metabolic responses can vary between people.'**
  String get phase_estimateLong;

  /// No description provided for @bmi_underweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmi_underweight;

  /// No description provided for @bmi_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmi_normal;

  /// No description provided for @bmi_overweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmi_overweight;

  /// No description provided for @bmi_obese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get bmi_obese;

  /// No description provided for @notification_halfwayTitle.
  ///
  /// In en, this message translates to:
  /// **'Halfway There! 💪'**
  String get notification_halfwayTitle;

  /// No description provided for @notification_halfwayBody.
  ///
  /// In en, this message translates to:
  /// **'You completed half of your {plan} fast. Keep going!'**
  String notification_halfwayBody(String plan);

  /// No description provided for @notification_phaseCatabolic.
  ///
  /// In en, this message translates to:
  /// **'Entered Catabolic phase 📉'**
  String get notification_phaseCatabolic;

  /// No description provided for @notification_phaseFatBurning.
  ///
  /// In en, this message translates to:
  /// **'Fat Burning started! 🔥'**
  String get notification_phaseFatBurning;

  /// No description provided for @notification_phaseKetosis.
  ///
  /// In en, this message translates to:
  /// **'You’re in Ketosis ⚡'**
  String get notification_phaseKetosis;

  /// No description provided for @notification_phaseAutophagy.
  ///
  /// In en, this message translates to:
  /// **'Autophagy active! 🔄'**
  String get notification_phaseAutophagy;

  /// No description provided for @notification_completedBody.
  ///
  /// In en, this message translates to:
  /// **'You completed your {plan} fast! Your eating window is open.'**
  String notification_completedBody(String plan);

  /// No description provided for @notification_waterTitle.
  ///
  /// In en, this message translates to:
  /// **'Drink Water 💧'**
  String get notification_waterTitle;

  /// No description provided for @notification_waterBody.
  ///
  /// In en, this message translates to:
  /// **'Don’t forget to drink plenty of water while fasting!'**
  String get notification_waterBody;

  /// No description provided for @notification_windowTitle.
  ///
  /// In en, this message translates to:
  /// **'Eating Window Closing ⏰'**
  String get notification_windowTitle;

  /// No description provided for @notification_windowBody.
  ///
  /// In en, this message translates to:
  /// **'Your eating window will close in 30 minutes.'**
  String get notification_windowBody;

  /// No description provided for @notification_streakTitle.
  ///
  /// In en, this message translates to:
  /// **'{days} Day Streak! 🔥'**
  String notification_streakTitle(int days);

  /// No description provided for @notification_streakBody.
  ///
  /// In en, this message translates to:
  /// **'You’re doing great! Keep it up today.'**
  String get notification_streakBody;

  /// No description provided for @notification_ongoingTitle.
  ///
  /// In en, this message translates to:
  /// **'Fasting In Progress - {phase}'**
  String notification_ongoingTitle(String phase);

  /// No description provided for @notification_remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {time}'**
  String notification_remaining(String time);

  /// No description provided for @notification_started.
  ///
  /// In en, this message translates to:
  /// **'Fasting Started - {plan}'**
  String notification_started(String plan);

  /// No description provided for @notification_target.
  ///
  /// In en, this message translates to:
  /// **'Target: {hours} hours'**
  String notification_target(int hours);

  /// No description provided for @notification_time.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String notification_time(int hours, int minutes);

  /// No description provided for @explore_guide.
  ///
  /// In en, this message translates to:
  /// **'Fasting Guide'**
  String get explore_guide;

  /// No description provided for @explore_guideDesc.
  ///
  /// In en, this message translates to:
  /// **'Everything you need to know about intermittent fasting'**
  String get explore_guideDesc;

  /// No description provided for @explore_circleDesc.
  ///
  /// In en, this message translates to:
  /// **'Share quiet support with your private group.'**
  String get explore_circleDesc;

  /// No description provided for @explore_faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get explore_faq;

  /// No description provided for @explore_education.
  ///
  /// In en, this message translates to:
  /// **'This content is for general education only and is not medical diagnosis or treatment advice.'**
  String get explore_education;

  /// No description provided for @explore_safety.
  ///
  /// In en, this message translates to:
  /// **'Health and safety'**
  String get explore_safety;

  /// No description provided for @explore_safetyDesc.
  ///
  /// In en, this message translates to:
  /// **'If you have a medical condition, take regular medication, have concerning symptoms, are pregnant, or are breastfeeding, consult a qualified health professional before fasting. Stop if you feel unwell.'**
  String get explore_safetyDesc;

  /// No description provided for @explore_sources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get explore_sources;

  /// No description provided for @explore_sourcesDesc.
  ///
  /// In en, this message translates to:
  /// **'Content is simplified from the public-health references below.'**
  String get explore_sourcesDesc;

  /// No description provided for @explore_sourceError.
  ///
  /// In en, this message translates to:
  /// **'The source could not be opened'**
  String get explore_sourceError;

  /// No description provided for @explore_rules.
  ///
  /// In en, this message translates to:
  /// **'Important Rules'**
  String get explore_rules;

  /// No description provided for @explore_rule1.
  ///
  /// In en, this message translates to:
  /// **'Don’t consume caloric foods during fasting'**
  String get explore_rule1;

  /// No description provided for @explore_rule2.
  ///
  /// In en, this message translates to:
  /// **'Drink plenty of water and fluids'**
  String get explore_rule2;

  /// No description provided for @explore_rule3.
  ///
  /// In en, this message translates to:
  /// **'Eat balanced during your eating window'**
  String get explore_rule3;

  /// No description provided for @explore_rule4.
  ///
  /// In en, this message translates to:
  /// **'Stop fasting if you feel unwell'**
  String get explore_rule4;

  /// No description provided for @explore_rule5.
  ///
  /// In en, this message translates to:
  /// **'Pregnant or breastfeeding women should not fast'**
  String get explore_rule5;

  /// No description provided for @explore_rule6.
  ///
  /// In en, this message translates to:
  /// **'Consult your doctor if you have chronic conditions'**
  String get explore_rule6;

  /// No description provided for @tip_water.
  ///
  /// In en, this message translates to:
  /// **'Stay Hydrated'**
  String get tip_water;

  /// No description provided for @tip_waterDesc.
  ///
  /// In en, this message translates to:
  /// **'Drink water when thirsty and include fluids with meals. Needs can vary with health, weather, and activity.'**
  String get tip_waterDesc;

  /// No description provided for @tip_food.
  ///
  /// In en, this message translates to:
  /// **'Eat Right'**
  String get tip_food;

  /// No description provided for @tip_foodDesc.
  ///
  /// In en, this message translates to:
  /// **'During eating windows, choose protein-rich foods with fiber and healthy fats. Avoid processed foods.'**
  String get tip_foodDesc;

  /// No description provided for @tip_sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep Well'**
  String get tip_sleep;

  /// No description provided for @tip_sleepDesc.
  ///
  /// In en, this message translates to:
  /// **'Regular, sufficient sleep supports general wellbeing. Schedule fasting so it does not disrupt your sleep.'**
  String get tip_sleepDesc;

  /// No description provided for @tip_exercise.
  ///
  /// In en, this message translates to:
  /// **'Light Exercise'**
  String get tip_exercise;

  /// No description provided for @tip_exerciseDesc.
  ///
  /// In en, this message translates to:
  /// **'You can do light walking or yoga while fasting. Avoid heavy exercise, especially during the first weeks until your body adapts.'**
  String get tip_exerciseDesc;

  /// No description provided for @tip_drinks.
  ///
  /// In en, this message translates to:
  /// **'Allowed Drinks'**
  String get tip_drinks;

  /// No description provided for @tip_drinksDesc.
  ///
  /// In en, this message translates to:
  /// **'During fasting, you can consume water, plain tea, and black coffee (no sugar, no milk). These drinks won’t break your fast.'**
  String get tip_drinksDesc;

  /// No description provided for @faq_drinks.
  ///
  /// In en, this message translates to:
  /// **'What can I drink during fasting?'**
  String get faq_drinks;

  /// No description provided for @faq_drinksAnswer.
  ///
  /// In en, this message translates to:
  /// **'You can drink water, plain tea, and black coffee (no sugar/milk). Caloric drinks break the fast.'**
  String get faq_drinksAnswer;

  /// No description provided for @faq_plan.
  ///
  /// In en, this message translates to:
  /// **'Which fasting plan should I choose?'**
  String get faq_plan;

  /// No description provided for @faq_planAnswer.
  ///
  /// In en, this message translates to:
  /// **'If you’re new, start with 12:12 or 14:10. If experienced, try 16:8 or 18:6. 20:4 and OMAD are for advanced fasters.'**
  String get faq_planAnswer;

  /// No description provided for @faq_exercise.
  ///
  /// In en, this message translates to:
  /// **'Can I exercise while fasting?'**
  String get faq_exercise;

  /// No description provided for @faq_exerciseAnswer.
  ///
  /// In en, this message translates to:
  /// **'Yes, but avoid intense workouts. Light cardio, walking, and yoga are ideal. If lifting weights, schedule near your eating window.'**
  String get faq_exerciseAnswer;

  /// No description provided for @faq_weight.
  ///
  /// In en, this message translates to:
  /// **'Does fasting help with weight loss?'**
  String get faq_weight;

  /// No description provided for @faq_weightAnswer.
  ///
  /// In en, this message translates to:
  /// **'For some people, limiting eating time may reduce total energy intake. Results vary, and long-term effects are still being studied.'**
  String get faq_weightAnswer;

  /// No description provided for @plan_12_desc.
  ///
  /// In en, this message translates to:
  /// **'Beginner level'**
  String get plan_12_desc;

  /// No description provided for @plan_12_detail.
  ///
  /// In en, this message translates to:
  /// **'Ideal for beginners. Fast 12 hours including your sleep time.'**
  String get plan_12_detail;

  /// No description provided for @plan_16_desc.
  ///
  /// In en, this message translates to:
  /// **'Most popular plan'**
  String get plan_16_desc;

  /// No description provided for @plan_16_detail.
  ///
  /// In en, this message translates to:
  /// **'The most common IF plan. 16 hours fasting, 8 hours eating window. Usually lunch to dinner.'**
  String get plan_16_detail;

  /// No description provided for @plan_18_desc.
  ///
  /// In en, this message translates to:
  /// **'Intermediate level'**
  String get plan_18_desc;

  /// No description provided for @plan_18_detail.
  ///
  /// In en, this message translates to:
  /// **'18 hours fasting, 6 hours eating window. Longer fat burning duration.'**
  String get plan_18_detail;

  /// No description provided for @plan_20_desc.
  ///
  /// In en, this message translates to:
  /// **'Advanced level'**
  String get plan_20_desc;

  /// No description provided for @plan_20_detail.
  ///
  /// In en, this message translates to:
  /// **'20 hours fasting, 4 hours eating window. Ideal for reaching ketosis and autophagy.'**
  String get plan_20_detail;

  /// No description provided for @plan_omad_desc.
  ///
  /// In en, this message translates to:
  /// **'One meal a day'**
  String get plan_omad_desc;

  /// No description provided for @plan_omad_detail.
  ///
  /// In en, this message translates to:
  /// **'One Meal A Day. 23 hours fasting, 1 hour eating window. Expert level.'**
  String get plan_omad_detail;

  /// No description provided for @plan_52_desc.
  ///
  /// In en, this message translates to:
  /// **'2 days per week'**
  String get plan_52_desc;

  /// No description provided for @plan_52_detail.
  ///
  /// In en, this message translates to:
  /// **'Eat normally 5 days, only ~500 calories on 2 days. An alternative approach.'**
  String get plan_52_detail;

  /// No description provided for @plan_ese_desc.
  ///
  /// In en, this message translates to:
  /// **'24 hour fast'**
  String get plan_ese_desc;

  /// No description provided for @plan_ese_detail.
  ///
  /// In en, this message translates to:
  /// **'Fast for 24 hours 1–2 times per week. For advanced users.'**
  String get plan_ese_detail;

  /// No description provided for @plan_warrior_desc.
  ///
  /// In en, this message translates to:
  /// **'Warrior diet'**
  String get plan_warrior_desc;

  /// No description provided for @plan_warrior_detail.
  ///
  /// In en, this message translates to:
  /// **'Eat light during the day (fruits, veggies), have your main meal in a 4-hour evening window.'**
  String get plan_warrior_detail;

  /// No description provided for @award_first_title.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get award_first_title;

  /// No description provided for @award_first_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first fast'**
  String get award_first_desc;

  /// No description provided for @award_rhythm3_title.
  ///
  /// In en, this message translates to:
  /// **'3-Day Rhythm'**
  String get award_rhythm3_title;

  /// No description provided for @award_rhythm3_desc.
  ///
  /// In en, this message translates to:
  /// **'Keep your rhythm for three days'**
  String get award_rhythm3_desc;

  /// No description provided for @award_hours24_title.
  ///
  /// In en, this message translates to:
  /// **'24 Hours'**
  String get award_hours24_title;

  /// No description provided for @award_hours24_desc.
  ///
  /// In en, this message translates to:
  /// **'Fast for 24 hours in total'**
  String get award_hours24_desc;

  /// No description provided for @award_week_title.
  ///
  /// In en, this message translates to:
  /// **'One-Week Rhythm'**
  String get award_week_title;

  /// No description provided for @award_week_desc.
  ///
  /// In en, this message translates to:
  /// **'Build a seven-day streak'**
  String get award_week_desc;

  /// No description provided for @award_fasts10_title.
  ///
  /// In en, this message translates to:
  /// **'10 Fasts'**
  String get award_fasts10_title;

  /// No description provided for @award_fasts10_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete ten fasts'**
  String get award_fasts10_desc;

  /// No description provided for @award_hours100_title.
  ///
  /// In en, this message translates to:
  /// **'100 Hours'**
  String get award_hours100_title;

  /// No description provided for @award_hours100_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach 100 total hours'**
  String get award_hours100_desc;

  /// No description provided for @award_rhythm30_title.
  ///
  /// In en, this message translates to:
  /// **'30-Day Rhythm'**
  String get award_rhythm30_title;

  /// No description provided for @award_rhythm30_desc.
  ///
  /// In en, this message translates to:
  /// **'Build a thirty-day streak'**
  String get award_rhythm30_desc;

  /// No description provided for @award_fasts50_title.
  ///
  /// In en, this message translates to:
  /// **'50 Fasts'**
  String get award_fasts50_title;

  /// No description provided for @award_fasts50_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete fifty fasts'**
  String get award_fasts50_desc;

  /// No description provided for @award_hours500_title.
  ///
  /// In en, this message translates to:
  /// **'500 Hours'**
  String get award_hours500_title;

  /// No description provided for @award_hours500_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach 500 total hours'**
  String get award_hours500_desc;

  /// No description provided for @award_fasts100_title.
  ///
  /// In en, this message translates to:
  /// **'100 Fasts'**
  String get award_fasts100_title;

  /// No description provided for @award_fasts100_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete one hundred fasts'**
  String get award_fasts100_desc;

  /// No description provided for @award_rhythm90_title.
  ///
  /// In en, this message translates to:
  /// **'90-Day Rhythm'**
  String get award_rhythm90_title;

  /// No description provided for @award_rhythm90_desc.
  ///
  /// In en, this message translates to:
  /// **'Build a ninety-day streak'**
  String get award_rhythm90_desc;

  /// No description provided for @award_year_title.
  ///
  /// In en, this message translates to:
  /// **'One-Year Journey'**
  String get award_year_title;

  /// No description provided for @award_year_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 365-day rhythm'**
  String get award_year_desc;

  /// No description provided for @awards_loadError.
  ///
  /// In en, this message translates to:
  /// **'Progress could not load'**
  String get awards_loadError;

  /// No description provided for @awards_journeyComplete.
  ///
  /// In en, this message translates to:
  /// **'Journey complete'**
  String get awards_journeyComplete;

  /// No description provided for @awards_nextGoal.
  ///
  /// In en, this message translates to:
  /// **'Next goal'**
  String get awards_nextGoal;

  /// No description provided for @awards_allYours.
  ///
  /// In en, this message translates to:
  /// **'Every achievement is yours'**
  String get awards_allYours;

  /// No description provided for @awards_dayStreak.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get awards_dayStreak;

  /// No description provided for @awards_fasts.
  ///
  /// In en, this message translates to:
  /// **'fasts'**
  String get awards_fasts;

  /// No description provided for @awards_total.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get awards_total;

  /// No description provided for @awards_stageStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get awards_stageStart;

  /// No description provided for @awards_stageRhythm.
  ///
  /// In en, this message translates to:
  /// **'Rhythm'**
  String get awards_stageRhythm;

  /// No description provided for @awards_stageEndurance.
  ///
  /// In en, this message translates to:
  /// **'Endurance'**
  String get awards_stageEndurance;

  /// No description provided for @awards_stageMastery.
  ///
  /// In en, this message translates to:
  /// **'Mastery'**
  String get awards_stageMastery;

  /// No description provided for @awards_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get awards_completed;

  /// No description provided for @awards_fastsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} fasts to go'**
  String awards_fastsRemaining(int count);

  /// No description provided for @awards_daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} days to go'**
  String awards_daysRemaining(int count);

  /// No description provided for @awards_hoursRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} hours to go'**
  String awards_hoursRemaining(int count);

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get common_retry;

  /// No description provided for @game_title.
  ///
  /// In en, this message translates to:
  /// **'Progress Hub'**
  String get game_title;

  /// No description provided for @game_quests.
  ///
  /// In en, this message translates to:
  /// **'Today’s quests'**
  String get game_quests;

  /// No description provided for @game_questsDesc.
  ///
  /// In en, this message translates to:
  /// **'Small steps, sustainable rhythm.'**
  String get game_questsDesc;

  /// No description provided for @game_season.
  ///
  /// In en, this message translates to:
  /// **'30-step season'**
  String get game_season;

  /// No description provided for @game_seasonDesc.
  ///
  /// In en, this message translates to:
  /// **'A collectible seal every fifth step.'**
  String get game_seasonDesc;

  /// No description provided for @game_badges.
  ///
  /// In en, this message translates to:
  /// **'Badge collection'**
  String get game_badges;

  /// No description provided for @game_shields.
  ///
  /// In en, this message translates to:
  /// **'{count} rhythm shields'**
  String game_shields(int count);

  /// No description provided for @game_shieldsDesc.
  ///
  /// In en, this message translates to:
  /// **'Earned every seven completions. A missed day never erases your progress.'**
  String get game_shieldsDesc;

  /// No description provided for @game_league.
  ///
  /// In en, this message translates to:
  /// **'Private weekly league'**
  String get game_league;

  /// No description provided for @game_leagueDesc.
  ///
  /// In en, this message translates to:
  /// **'Your rhythm score is in the {percent}th percentile of a private local model. Weight and extreme fasting are never ranked.'**
  String game_leagueDesc(int percent);

  /// No description provided for @game_levelSemantics.
  ///
  /// In en, this message translates to:
  /// **'Level {level}, {xp} experience points'**
  String game_levelSemantics(int level, int xp);

  /// No description provided for @game_explorer.
  ///
  /// In en, this message translates to:
  /// **'Rhythm Explorer'**
  String get game_explorer;

  /// No description provided for @game_streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get game_streak;

  /// No description provided for @game_targets.
  ///
  /// In en, this message translates to:
  /// **'Targets'**
  String get game_targets;

  /// No description provided for @game_best.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get game_best;

  /// No description provided for @quest_rhythm.
  ///
  /// In en, this message translates to:
  /// **'Build today’s rhythm'**
  String get quest_rhythm;

  /// No description provided for @quest_hydrate.
  ///
  /// In en, this message translates to:
  /// **'Reach half your water goal'**
  String get quest_hydrate;

  /// No description provided for @quest_steady.
  ///
  /// In en, this message translates to:
  /// **'Protect your streak'**
  String get quest_steady;

  /// No description provided for @badge_first_title.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get badge_first_title;

  /// No description provided for @badge_first_desc.
  ///
  /// In en, this message translates to:
  /// **'Log your first fast'**
  String get badge_first_desc;

  /// No description provided for @badge_rhythm7_title.
  ///
  /// In en, this message translates to:
  /// **'Rhythm Keeper'**
  String get badge_rhythm7_title;

  /// No description provided for @badge_rhythm7_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 7-day streak'**
  String get badge_rhythm7_desc;

  /// No description provided for @badge_rhythm3_title.
  ///
  /// In en, this message translates to:
  /// **'Three-Day Rhythm'**
  String get badge_rhythm3_title;

  /// No description provided for @badge_rhythm3_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 3-day streak'**
  String get badge_rhythm3_desc;

  /// No description provided for @badge_target1_title.
  ///
  /// In en, this message translates to:
  /// **'First Target'**
  String get badge_target1_title;

  /// No description provided for @badge_target1_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first target fast'**
  String get badge_target1_desc;

  /// No description provided for @badge_target3_title.
  ///
  /// In en, this message translates to:
  /// **'Three Steps'**
  String get badge_target3_title;

  /// No description provided for @badge_target3_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 3 targets'**
  String get badge_target3_desc;

  /// No description provided for @badge_water_title.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get badge_water_title;

  /// No description provided for @badge_water_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete the daily water goal'**
  String get badge_water_desc;

  /// No description provided for @badge_support_title.
  ///
  /// In en, this message translates to:
  /// **'Self Aware'**
  String get badge_support_title;

  /// No description provided for @badge_support_desc.
  ///
  /// In en, this message translates to:
  /// **'Use support mode'**
  String get badge_support_desc;

  /// No description provided for @badge_hours10_title.
  ///
  /// In en, this message translates to:
  /// **'10 Hours'**
  String get badge_hours10_title;

  /// No description provided for @badge_hours10_desc.
  ///
  /// In en, this message translates to:
  /// **'Log 10 total hours'**
  String get badge_hours10_desc;

  /// No description provided for @badge_target10_title.
  ///
  /// In en, this message translates to:
  /// **'Ten Strong'**
  String get badge_target10_title;

  /// No description provided for @badge_target10_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 10 targets'**
  String get badge_target10_desc;

  /// No description provided for @badge_target20_title.
  ///
  /// In en, this message translates to:
  /// **'Twenty Targets'**
  String get badge_target20_title;

  /// No description provided for @badge_target20_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 20 targets'**
  String get badge_target20_desc;

  /// No description provided for @badge_fast16_title.
  ///
  /// In en, this message translates to:
  /// **'16 Hours'**
  String get badge_fast16_title;

  /// No description provided for @badge_fast16_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach 16 hours in one fast'**
  String get badge_fast16_desc;

  /// No description provided for @badge_hours50_title.
  ///
  /// In en, this message translates to:
  /// **'50 Hours'**
  String get badge_hours50_title;

  /// No description provided for @badge_hours50_desc.
  ///
  /// In en, this message translates to:
  /// **'Log 50 total hours'**
  String get badge_hours50_desc;

  /// No description provided for @badge_hours100_title.
  ///
  /// In en, this message translates to:
  /// **'Hundred Hours'**
  String get badge_hours100_title;

  /// No description provided for @badge_hours100_desc.
  ///
  /// In en, this message translates to:
  /// **'Log 100 total hours'**
  String get badge_hours100_desc;

  /// No description provided for @badge_target30_title.
  ///
  /// In en, this message translates to:
  /// **'Thirty Targets'**
  String get badge_target30_title;

  /// No description provided for @badge_target30_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 30 targets'**
  String get badge_target30_desc;

  /// No description provided for @badge_rhythm30_title.
  ///
  /// In en, this message translates to:
  /// **'30-Day Rhythm'**
  String get badge_rhythm30_title;

  /// No description provided for @badge_rhythm30_desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a 30-day streak'**
  String get badge_rhythm30_desc;

  /// No description provided for @paywall_restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored!'**
  String get paywall_restoreSuccess;

  /// No description provided for @fasting_progressSemantics.
  ///
  /// In en, this message translates to:
  /// **'Fasting progress {percent} percent'**
  String fasting_progressSemantics(int percent);

  /// No description provided for @phase_hourMarker.
  ///
  /// In en, this message translates to:
  /// **'{hour}h'**
  String phase_hourMarker(int hour);

  /// No description provided for @paywall_lifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get paywall_lifetime;

  /// No description provided for @paywall_once.
  ///
  /// In en, this message translates to:
  /// **'one-time'**
  String get paywall_once;

  /// No description provided for @paywall_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing…'**
  String get paywall_processing;

  /// No description provided for @paywall_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get paywall_continue;

  /// No description provided for @paywall_productsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Purchases are not available right now. Please try again later.'**
  String get paywall_productsUnavailable;

  /// No description provided for @paywall_purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'The purchase could not be completed.'**
  String get paywall_purchaseFailed;

  /// No description provided for @paywall_nothingToRestore.
  ///
  /// In en, this message translates to:
  /// **'No previous purchase was found.'**
  String get paywall_nothingToRestore;

  /// No description provided for @paywall_restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchases could not be restored.'**
  String get paywall_restoreFailed;

  /// No description provided for @paywall_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get paywall_terms;

  /// No description provided for @permission_notificationDesc.
  ///
  /// In en, this message translates to:
  /// **'Fasting reminders, phase updates and completion notifications'**
  String get permission_notificationDesc;

  /// No description provided for @profile_privacyChoices.
  ///
  /// In en, this message translates to:
  /// **'Privacy choices'**
  String get profile_privacyChoices;

  /// No description provided for @paywall_autoRenewInfo.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period. Manage or cancel anytime in your App Store settings.'**
  String get paywall_autoRenewInfo;

  /// No description provided for @paywall_perMonth.
  ///
  /// In en, this message translates to:
  /// **'{price} / month'**
  String paywall_perMonth(String price);

  /// No description provided for @paywall_savePercent.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String paywall_savePercent(int percent);

  /// No description provided for @paywall_freeTrialDays.
  ///
  /// In en, this message translates to:
  /// **'{days}-day free trial'**
  String paywall_freeTrialDays(int days);

  /// No description provided for @paywall_startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start free trial'**
  String get paywall_startFreeTrial;

  /// No description provided for @paywall_retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get paywall_retry;

  /// No description provided for @paywall_alreadyOwned.
  ///
  /// In en, this message translates to:
  /// **'You already own this subscription. Tap “Restore purchases”.'**
  String get paywall_alreadyOwned;

  /// No description provided for @paywall_storeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the store right now. Check your connection and try again.'**
  String get paywall_storeUnavailable;

  /// No description provided for @paywall_secureNote.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. Payment is charged to your store account.'**
  String get paywall_secureNote;

  /// No description provided for @paywall_autoRenewInfoPlay.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period. Manage or cancel anytime in Google Play > Subscriptions.'**
  String get paywall_autoRenewInfoPlay;

  /// No description provided for @paywall_allPlansDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlocks 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat and Warrior'**
  String get paywall_allPlansDesc;

  /// No description provided for @paywall_noAdsDesc.
  ///
  /// In en, this message translates to:
  /// **'Banner and interstitial ads are turned off completely'**
  String get paywall_noAdsDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'pt',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
