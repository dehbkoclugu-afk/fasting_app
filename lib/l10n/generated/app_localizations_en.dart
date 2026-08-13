// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Good morning';

  @override
  String get greeting_afternoon => 'Good afternoon';

  @override
  String get greeting_evening => 'Good evening';

  @override
  String get tab_timer => 'Home';

  @override
  String get tab_explore => 'Explore';

  @override
  String get tab_stats => 'Report';

  @override
  String get tab_meals => 'Meals';

  @override
  String get tab_achievements => 'Awards';

  @override
  String get tab_profile => 'Account';

  @override
  String get timer_fasting => 'Fasting Time';

  @override
  String get timer_remaining => 'Remaining';

  @override
  String get timer_elapsed => 'Elapsed';

  @override
  String get timer_start => 'Start';

  @override
  String get timer_stop => 'Stop';

  @override
  String get timer_completed => 'Congratulations!';

  @override
  String get timer_completedMessage => 'You completed your fast successfully!';

  @override
  String get timer_selectPlan => 'Select Fasting Plan';

  @override
  String get timer_stopConfirm =>
      'Are you sure you want to end the fast early?';

  @override
  String get timer_stopTitle => 'End Fast';

  @override
  String get timer_cancel => 'Cancel';

  @override
  String get timer_confirmStop => 'Yes, End';

  @override
  String get phase_anabolic => 'Anabolic';

  @override
  String get phase_anabolicDesc => 'Digestion in progress';

  @override
  String get phase_catabolic => 'Catabolic';

  @override
  String get phase_catabolicDesc => 'Energy transition';

  @override
  String get phase_fatBurning => 'Fat Burning';

  @override
  String get phase_fatBurningDesc => 'Fat burning started';

  @override
  String get phase_ketosis => 'Ketosis';

  @override
  String get phase_ketosisDesc => 'Ketone production active';

  @override
  String get phase_autophagy => 'Autophagy';

  @override
  String get phase_autophagyDesc => 'Cell renewal';

  @override
  String get stats_title => 'Statistics';

  @override
  String get stats_week => 'Week';

  @override
  String get stats_month => 'Month';

  @override
  String get stats_year => 'Year';

  @override
  String get stats_totalFasts => 'Total Fasts';

  @override
  String get stats_average => 'Average';

  @override
  String get stats_fastDuration => 'fast duration';

  @override
  String get stats_streak => 'Streak';

  @override
  String get stats_daysConsecutive => 'consecutive days';

  @override
  String get stats_success => 'Success';

  @override
  String get stats_completion => 'completion';

  @override
  String get stats_weeklyFasting => 'Weekly Fasting';

  @override
  String get stats_monthlyView => 'Monthly View';

  @override
  String get stats_weightChange => 'Weight Change';

  @override
  String get heatmap_none => 'None';

  @override
  String get heatmap_low => 'Low';

  @override
  String get heatmap_good => 'Good';

  @override
  String get heatmap_full => 'Full';

  @override
  String get meals_title => 'Meal Planner';

  @override
  String get meals_eatingWindow => 'Eating Window';

  @override
  String get meals_windowOpen => 'Open';

  @override
  String get meals_windowFasting => 'Fasting';

  @override
  String get meals_calories => 'Calories';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Carbs';

  @override
  String get meals_fat => 'Fat';

  @override
  String get meals_todayMeals => 'Today\'s Meals';

  @override
  String get meals_noMeals => 'No meals added yet';

  @override
  String get meals_breakfastSuggestions => 'Break-Fast Suggestions';

  @override
  String get meals_addMeal => 'Add Meal';

  @override
  String get profile_title => 'Profile';

  @override
  String get profile_user => 'User';

  @override
  String profile_planActive(String plan) {
    return '$plan Plan active';
  }

  @override
  String get profile_upgradePremium => 'Upgrade to Premium';

  @override
  String get profile_premiumDesc => 'All plans, advanced stats, and more';

  @override
  String get profile_bodyMetrics => 'Body Metrics';

  @override
  String get profile_height => 'Height';

  @override
  String get profile_weight => 'Weight';

  @override
  String get profile_targetWeight => 'Target Weight';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Settings';

  @override
  String get profile_notifications => 'Notifications';

  @override
  String get profile_darkTheme => 'Dark Theme';

  @override
  String get profile_waterReminder => 'Water Reminder';

  @override
  String get profile_phaseNotifications => 'Phase Notifications';

  @override
  String get profile_language => 'Language';

  @override
  String get profile_about => 'About';

  @override
  String get profile_rateApp => 'Rate App';

  @override
  String get profile_share => 'Share';

  @override
  String get profile_privacyPolicy => 'Privacy Policy';

  @override
  String get profile_version => 'Version';

  @override
  String get onboarding_welcome => 'Welcome';

  @override
  String get onboarding_welcomeDesc =>
      'Take control of your\nintermittent fasting journey';

  @override
  String get onboarding_featureTimer => 'Smart fasting timer';

  @override
  String get onboarding_featureStats => 'Detailed statistics and charts';

  @override
  String get onboarding_featureMeals => 'Meal planner and recipe suggestions';

  @override
  String get onboarding_getStarted => 'Get Started';

  @override
  String get onboarding_selectGoal => 'What\'s your goal?';

  @override
  String get onboarding_selectGoalDesc => 'You can select multiple';

  @override
  String get onboarding_goalWeight => 'Lose Weight';

  @override
  String get onboarding_goalWeightDesc => 'Healthy weight loss';

  @override
  String get onboarding_goalHealth => 'Improve Health';

  @override
  String get onboarding_goalHealthDesc => 'General health and immunity';

  @override
  String get onboarding_goalEnergy => 'More Energy';

  @override
  String get onboarding_goalEnergyDesc => 'Energy throughout the day';

  @override
  String get onboarding_goalMental => 'Mental Clarity';

  @override
  String get onboarding_goalMentalDesc => 'Focus and clarity';

  @override
  String get onboarding_goalLongevity => 'Longevity';

  @override
  String get onboarding_goalLongevityDesc => 'Cell renewal and anti-aging';

  @override
  String get onboarding_goalDiscipline => 'Discipline';

  @override
  String get onboarding_goalDisciplineDesc => 'Build self-discipline';

  @override
  String get onboarding_selectPlan => 'Choose Your Plan';

  @override
  String get onboarding_selectPlanDesc =>
      'Select the best fasting plan for you';

  @override
  String get onboarding_bodyInfo => 'Enter Your Info';

  @override
  String get onboarding_bodyInfoDesc => 'For personalized recommendations';

  @override
  String get onboarding_gender => 'Gender';

  @override
  String get onboarding_male => 'Male';

  @override
  String get onboarding_female => 'Female';

  @override
  String get onboarding_age => 'Age';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'This information is stored only on your device and used for calorie calculations.';

  @override
  String get onboarding_permissions => 'Final Step';

  @override
  String get onboarding_permissionsDesc =>
      'Enable permissions for the best experience';

  @override
  String get onboarding_next => 'Continue';

  @override
  String get onboarding_start => 'Let\'s Go!';

  @override
  String get onboarding_skipForNow => 'Set up later';

  @override
  String get waterAdded => '+250ml water added';

  @override
  String get languageSelect => 'Select Language';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Upgrade to Premium';

  @override
  String get paywall_subtitle => 'Unlock all features';

  @override
  String get paywall_allPlans => 'All fasting plans';

  @override
  String get paywall_advancedStats => 'Advanced statistics';

  @override
  String get paywall_mealPlanner => 'Meal planner';

  @override
  String get paywall_healthKit => 'HealthKit integration';

  @override
  String get paywall_themes => 'Theme customization';

  @override
  String get paywall_noAds => 'No ads';

  @override
  String get paywall_weekly => 'Weekly';

  @override
  String get paywall_monthly => 'Monthly';

  @override
  String get paywall_yearly => 'Yearly';

  @override
  String get paywall_bestValue => 'Best';

  @override
  String get paywall_freeTrial => 'Free Trial (3 Days)';

  @override
  String get paywall_restore => 'Restore purchases';

  @override
  String get paywall_premiumActive => 'Premium Active!';

  @override
  String get paywall_premiumActiveDesc => 'You unlocked all features';

  @override
  String get water_title => 'Water Intake';

  @override
  String get water_addWater => 'Add Water';

  @override
  String get water_goal => 'Goal';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_save => 'Save';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_hours => 'hours';

  @override
  String get common_minutes => 'minutes';

  @override
  String get common_days => 'days';

  @override
  String get common_enable => 'Enable';

  @override
  String get streakCard_currentStreak => 'Current Streak';

  @override
  String get streakCard_longestStreak => 'Longest Streak';

  @override
  String get streakCard_totalSessions => 'Total Fasts';

  @override
  String get meals_mealType => 'Meal Type';

  @override
  String get meals_breakfast => 'Breakfast';

  @override
  String get meals_lunch => 'Lunch';

  @override
  String get meals_dinner => 'Dinner';

  @override
  String get meals_snack => 'Snack';

  @override
  String get meals_carbohydrate => 'Carbohydrate';

  @override
  String get meals_add => 'Add';

  @override
  String get meals_mealName => 'Meal name';

  @override
  String get bodyMetrics_title => 'Body Metrics';

  @override
  String get bodyMetrics_weight => 'Weight';

  @override
  String get bodyMetrics_target => 'Target';

  @override
  String get bodyMetrics_save => 'Save';

  @override
  String get bodyMetrics_history => 'History';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'No data yet';

  @override
  String get meals_quickAdd => 'Quick Add';

  @override
  String get meals_manualEntry => 'Manual Entry';

  @override
  String meals_added(String name) {
    return '$name added';
  }

  @override
  String get meals_nameCalorieRequired => 'Name and calories are required';

  @override
  String get bodyMetrics_addWeight => 'Add Weight';

  @override
  String get bodyMetrics_hintWeight => 'e.g. 74.5';

  @override
  String get bodyMetrics_invalidWeight => 'Enter a valid weight';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg saved';
  }

  @override
  String get completion_duration => 'Duration';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Last Phase';

  @override
  String get timer_remainingTime => 'Remaining Time';

  @override
  String get timer_ready => 'Ready to Start';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Start today!';

  @override
  String get streak_goodStart => 'Good start!';

  @override
  String get streak_goingGreat => 'Going great!';

  @override
  String get streak_superb => 'Superb!';

  @override
  String get streak_legendary => 'Legendary!';

  @override
  String get streak_incredible => 'Incredible!';

  @override
  String get weight_noRecord =>
      'No weight records yet\nAdd from Profile > Body Metrics';

  @override
  String get day_mon => 'Mon';

  @override
  String get day_tue => 'Tue';

  @override
  String get day_wed => 'Wed';

  @override
  String get day_thu => 'Thu';

  @override
  String get day_fri => 'Fri';

  @override
  String get day_sat => 'Sat';

  @override
  String get day_sun => 'Sun';

  @override
  String get day_short_mon => 'M';

  @override
  String get day_short_tue => 'T';

  @override
  String get day_short_wed => 'W';

  @override
  String get day_short_thu => 'T';

  @override
  String get day_short_fri => 'F';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'S';

  @override
  String get month_jan => 'January';

  @override
  String get month_feb => 'February';

  @override
  String get month_mar => 'March';

  @override
  String get month_apr => 'April';

  @override
  String get month_may => 'May';

  @override
  String get month_jun => 'June';

  @override
  String get month_jul => 'July';

  @override
  String get month_aug => 'August';

  @override
  String get month_sep => 'September';

  @override
  String get month_oct => 'October';

  @override
  String get month_nov => 'November';

  @override
  String get month_dec => 'December';

  @override
  String meals_fastingWindow(String hours) {
    return 'Fasting (${hours}h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Eating (${hours}h)';
  }

  @override
  String get recipe_oatSmoothie => 'Oat Smoothie';

  @override
  String get recipe_avocadoToast => 'Avocado Toast';

  @override
  String get recipe_yogurtBowl => 'Yogurt Bowl';

  @override
  String get elapsed_time => 'Elapsed Time';

  @override
  String get fast_ends_on => 'Your fast ends at';

  @override
  String get end_fasting => 'End Fasting';

  @override
  String get start_fasting => 'Start Fasting';

  @override
  String get water_tracker => 'Water Tracker';

  @override
  String get weight_tracker => 'Weight Tracker';

  @override
  String get drink => 'Drink';

  @override
  String get log_weight => 'Log Weight';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Weight Lost';

  @override
  String get current_weight => 'Current Weight';

  @override
  String get goal_weight => 'Goal Weight';

  @override
  String get daily_goal => 'Daily Goal';

  @override
  String completed_percent(String percent) {
    return '$percent% Completed';
  }

  @override
  String get explore => 'Explore';

  @override
  String get achievements => 'Achievements';

  @override
  String get profile_theme => 'Appearance';

  @override
  String get theme_select => 'Choose appearance';

  @override
  String get theme_system => 'System default';

  @override
  String get theme_light => 'Light';

  @override
  String get theme_dark => 'Dark';

  @override
  String get language_system => 'System language';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Completion sound';

  @override
  String get profile_calmGamification => 'Calm gamification';

  @override
  String get profile_calmGamificationDesc =>
      'Reduces league and season pressure';

  @override
  String get profile_editName => 'Edit your name';

  @override
  String get profile_name => 'Name';

  @override
  String get circle_title => 'Fasting Circle';

  @override
  String get circle_you => 'You';

  @override
  String get circle_tagline => 'Together, without pressure.';

  @override
  String get circle_privacy =>
      'Weight and private metrics stay hidden. Only progress and support are visible.';

  @override
  String circle_sendSupport(int count) {
    return 'Send support · $count';
  }

  @override
  String get circle_inviteCopied => 'Invite code copied';

  @override
  String get circle_createInvite => 'Create private invite';

  @override
  String get crisis_nameTitle => 'First, name what is happening';

  @override
  String get crisis_nameDesc => 'It may be hunger, habit, or emotion.';

  @override
  String get crisis_waterTitle => 'Drink a glass of water';

  @override
  String get crisis_waterDesc => 'Then take three slow breaths.';

  @override
  String get crisis_delayTitle => 'Delay the decision for 10 minutes';

  @override
  String get crisis_delayDesc =>
      'If you feel unwell, ending the fast is not failure.';

  @override
  String get crisis_hunger => 'Hunger';

  @override
  String get crisis_habit => 'Habit';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Give it 10 minutes';

  @override
  String get stats_storyEmpty =>
      'Your first fast will begin your personal story.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'You fasted $sessions times this period, kept your rhythm for $hours hours, and reached a $rate% completion rate.';
  }

  @override
  String get stats_storyTitle => 'The story of your rhythm';

  @override
  String get home_todayRhythm => 'Today’s rhythm';

  @override
  String get home_finalHourSupport => 'Final-hour support';

  @override
  String get home_needSupport => 'I need a little support';

  @override
  String get home_todaySummary => 'Today at a glance';

  @override
  String get home_dayStreak => 'day streak';

  @override
  String home_weightGoal(String weight) {
    return 'goal $weight kg';
  }

  @override
  String get weather_steady => 'Your rhythm is steady';

  @override
  String get weather_gentle => 'A gentle day';

  @override
  String get weather_water => 'A glass of water may help.';

  @override
  String get weather_listen => 'You have come far; listen to your body.';

  @override
  String get weather_onPlan => 'Today’s pace matches your plan.';

  @override
  String get weather_challenging =>
      'This hour was challenging before; support mode is ready.';

  @override
  String get replay_copied => 'Fasting Replay copied';

  @override
  String get replay_button => 'Replay';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'I completed my $plan fast in ${hours}h ${minutes}m · $phase';
  }

  @override
  String get journey_label => 'Metabolic journey';

  @override
  String get journey_now => 'Now';

  @override
  String journey_next(String time, String phase) {
    return '$time until $phase';
  }

  @override
  String get phase_estimateShort =>
      'Phase timing is a general estimate, not a medical measurement.';

  @override
  String phase_hours(int start, int end) {
    return 'Hours $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'This timing is a general estimate. Metabolic responses can vary between people.';

  @override
  String get bmi_underweight => 'Underweight';

  @override
  String get bmi_normal => 'Normal';

  @override
  String get bmi_overweight => 'Overweight';

  @override
  String get bmi_obese => 'Obese';

  @override
  String get notification_halfwayTitle => 'Halfway There! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'You completed half of your $plan fast. Keep going!';
  }

  @override
  String get notification_phaseCatabolic => 'Entered Catabolic phase 📉';

  @override
  String get notification_phaseFatBurning => 'Fat Burning started! 🔥';

  @override
  String get notification_phaseKetosis => 'You’re in Ketosis ⚡';

  @override
  String get notification_phaseAutophagy => 'Autophagy active! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'You completed your $plan fast! Your eating window is open.';
  }

  @override
  String get notification_waterTitle => 'Drink Water 💧';

  @override
  String get notification_waterBody =>
      'Don’t forget to drink plenty of water while fasting!';

  @override
  String get notification_windowTitle => 'Eating Window Closing ⏰';

  @override
  String get notification_windowBody =>
      'Your eating window will close in 30 minutes.';

  @override
  String notification_streakTitle(int days) {
    return '$days Day Streak! 🔥';
  }

  @override
  String get notification_streakBody => 'You’re doing great! Keep it up today.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Fasting In Progress - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Remaining: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Fasting Started - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Target: $hours hours';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get explore_guide => 'Fasting Guide';

  @override
  String get explore_guideDesc =>
      'Everything you need to know about intermittent fasting';

  @override
  String get explore_circleDesc =>
      'Share quiet support with your private group.';

  @override
  String get explore_faq => 'Frequently Asked Questions';

  @override
  String get explore_education =>
      'This content is for general education only and is not medical diagnosis or treatment advice.';

  @override
  String get explore_safety => 'Health and safety';

  @override
  String get explore_safetyDesc =>
      'If you have a medical condition, take regular medication, have concerning symptoms, are pregnant, or are breastfeeding, consult a qualified health professional before fasting. Stop if you feel unwell.';

  @override
  String get explore_sources => 'Sources';

  @override
  String get explore_sourcesDesc =>
      'Content is simplified from the public-health references below.';

  @override
  String get explore_sourceError => 'The source could not be opened';

  @override
  String get explore_rules => 'Important Rules';

  @override
  String get explore_rule1 => 'Don’t consume caloric foods during fasting';

  @override
  String get explore_rule2 => 'Drink plenty of water and fluids';

  @override
  String get explore_rule3 => 'Eat balanced during your eating window';

  @override
  String get explore_rule4 => 'Stop fasting if you feel unwell';

  @override
  String get explore_rule5 => 'Pregnant or breastfeeding women should not fast';

  @override
  String get explore_rule6 =>
      'Consult your doctor if you have chronic conditions';

  @override
  String get tip_water => 'Stay Hydrated';

  @override
  String get tip_waterDesc =>
      'Drink water when thirsty and include fluids with meals. Needs can vary with health, weather, and activity.';

  @override
  String get tip_food => 'Eat Right';

  @override
  String get tip_foodDesc =>
      'During eating windows, choose protein-rich foods with fiber and healthy fats. Avoid processed foods.';

  @override
  String get tip_sleep => 'Sleep Well';

  @override
  String get tip_sleepDesc =>
      'Regular, sufficient sleep supports general wellbeing. Schedule fasting so it does not disrupt your sleep.';

  @override
  String get tip_exercise => 'Light Exercise';

  @override
  String get tip_exerciseDesc =>
      'You can do light walking or yoga while fasting. Avoid heavy exercise, especially during the first weeks until your body adapts.';

  @override
  String get tip_drinks => 'Allowed Drinks';

  @override
  String get tip_drinksDesc =>
      'During fasting, you can consume water, plain tea, and black coffee (no sugar, no milk). These drinks won’t break your fast.';

  @override
  String get faq_drinks => 'What can I drink during fasting?';

  @override
  String get faq_drinksAnswer =>
      'You can drink water, plain tea, and black coffee (no sugar/milk). Caloric drinks break the fast.';

  @override
  String get faq_plan => 'Which fasting plan should I choose?';

  @override
  String get faq_planAnswer =>
      'If you’re new, start with 12:12 or 14:10. If experienced, try 16:8 or 18:6. 20:4 and OMAD are for advanced fasters.';

  @override
  String get faq_exercise => 'Can I exercise while fasting?';

  @override
  String get faq_exerciseAnswer =>
      'Yes, but avoid intense workouts. Light cardio, walking, and yoga are ideal. If lifting weights, schedule near your eating window.';

  @override
  String get faq_weight => 'Does fasting help with weight loss?';

  @override
  String get faq_weightAnswer =>
      'For some people, limiting eating time may reduce total energy intake. Results vary, and long-term effects are still being studied.';

  @override
  String get plan_12_desc => 'Beginner level';

  @override
  String get plan_12_detail =>
      'Ideal for beginners. Fast 12 hours including your sleep time.';

  @override
  String get plan_16_desc => 'Most popular plan';

  @override
  String get plan_16_detail =>
      'The most common IF plan. 16 hours fasting, 8 hours eating window. Usually lunch to dinner.';

  @override
  String get plan_18_desc => 'Intermediate level';

  @override
  String get plan_18_detail =>
      '18 hours fasting, 6 hours eating window. Longer fat burning duration.';

  @override
  String get plan_20_desc => 'Advanced level';

  @override
  String get plan_20_detail =>
      '20 hours fasting, 4 hours eating window. Ideal for reaching ketosis and autophagy.';

  @override
  String get plan_omad_desc => 'One meal a day';

  @override
  String get plan_omad_detail =>
      'One Meal A Day. 23 hours fasting, 1 hour eating window. Expert level.';

  @override
  String get plan_52_desc => '2 days per week';

  @override
  String get plan_52_detail =>
      'Eat normally 5 days, only ~500 calories on 2 days. An alternative approach.';

  @override
  String get plan_ese_desc => '24 hour fast';

  @override
  String get plan_ese_detail =>
      'Fast for 24 hours 1–2 times per week. For advanced users.';

  @override
  String get plan_warrior_desc => 'Warrior diet';

  @override
  String get plan_warrior_detail =>
      'Eat light during the day (fruits, veggies), have your main meal in a 4-hour evening window.';

  @override
  String get award_first_title => 'First Step';

  @override
  String get award_first_desc => 'Complete your first fast';

  @override
  String get award_rhythm3_title => '3-Day Rhythm';

  @override
  String get award_rhythm3_desc => 'Keep your rhythm for three days';

  @override
  String get award_hours24_title => '24 Hours';

  @override
  String get award_hours24_desc => 'Fast for 24 hours in total';

  @override
  String get award_week_title => 'One-Week Rhythm';

  @override
  String get award_week_desc => 'Build a seven-day streak';

  @override
  String get award_fasts10_title => '10 Fasts';

  @override
  String get award_fasts10_desc => 'Complete ten fasts';

  @override
  String get award_hours100_title => '100 Hours';

  @override
  String get award_hours100_desc => 'Reach 100 total hours';

  @override
  String get award_rhythm30_title => '30-Day Rhythm';

  @override
  String get award_rhythm30_desc => 'Build a thirty-day streak';

  @override
  String get award_fasts50_title => '50 Fasts';

  @override
  String get award_fasts50_desc => 'Complete fifty fasts';

  @override
  String get award_hours500_title => '500 Hours';

  @override
  String get award_hours500_desc => 'Reach 500 total hours';

  @override
  String get award_fasts100_title => '100 Fasts';

  @override
  String get award_fasts100_desc => 'Complete one hundred fasts';

  @override
  String get award_rhythm90_title => '90-Day Rhythm';

  @override
  String get award_rhythm90_desc => 'Build a ninety-day streak';

  @override
  String get award_year_title => 'One-Year Journey';

  @override
  String get award_year_desc => 'Reach a 365-day rhythm';

  @override
  String get awards_loadError => 'Progress could not load';

  @override
  String get awards_journeyComplete => 'Journey complete';

  @override
  String get awards_nextGoal => 'Next goal';

  @override
  String get awards_allYours => 'Every achievement is yours';

  @override
  String get awards_dayStreak => 'day streak';

  @override
  String get awards_fasts => 'fasts';

  @override
  String get awards_total => 'total';

  @override
  String get awards_stageStart => 'Start';

  @override
  String get awards_stageRhythm => 'Rhythm';

  @override
  String get awards_stageEndurance => 'Endurance';

  @override
  String get awards_stageMastery => 'Mastery';

  @override
  String get awards_completed => 'Completed';

  @override
  String awards_fastsRemaining(int count) {
    return '$count fasts to go';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count days to go';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count hours to go';
  }

  @override
  String get common_retry => 'Try again';

  @override
  String get game_title => 'Progress Hub';

  @override
  String get game_quests => 'Today’s quests';

  @override
  String get game_questsDesc => 'Small steps, sustainable rhythm.';

  @override
  String get game_season => '30-step season';

  @override
  String get game_seasonDesc => 'A collectible seal every fifth step.';

  @override
  String get game_badges => 'Badge collection';

  @override
  String game_shields(int count) {
    return '$count rhythm shields';
  }

  @override
  String get game_shieldsDesc =>
      'Earned every seven completions. A missed day never erases your progress.';

  @override
  String get game_league => 'Private weekly league';

  @override
  String game_leagueDesc(int percent) {
    return 'Your rhythm score is in the ${percent}th percentile of a private local model. Weight and extreme fasting are never ranked.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Level $level, $xp experience points';
  }

  @override
  String get game_explorer => 'Rhythm Explorer';

  @override
  String get game_streak => 'Streak';

  @override
  String get game_targets => 'Targets';

  @override
  String get game_best => 'Best';

  @override
  String get quest_rhythm => 'Build today’s rhythm';

  @override
  String get quest_hydrate => 'Reach half your water goal';

  @override
  String get quest_steady => 'Protect your streak';

  @override
  String get badge_first_title => 'First Step';

  @override
  String get badge_first_desc => 'Log your first fast';

  @override
  String get badge_rhythm7_title => 'Rhythm Keeper';

  @override
  String get badge_rhythm7_desc => 'Reach a 7-day streak';

  @override
  String get badge_rhythm3_title => 'Three-Day Rhythm';

  @override
  String get badge_rhythm3_desc => 'Reach a 3-day streak';

  @override
  String get badge_target1_title => 'First Target';

  @override
  String get badge_target1_desc => 'Complete your first target fast';

  @override
  String get badge_target3_title => 'Three Steps';

  @override
  String get badge_target3_desc => 'Complete 3 targets';

  @override
  String get badge_water_title => 'Balanced';

  @override
  String get badge_water_desc => 'Complete the daily water goal';

  @override
  String get badge_support_title => 'Self Aware';

  @override
  String get badge_support_desc => 'Use support mode';

  @override
  String get badge_hours10_title => '10 Hours';

  @override
  String get badge_hours10_desc => 'Log 10 total hours';

  @override
  String get badge_target10_title => 'Ten Strong';

  @override
  String get badge_target10_desc => 'Complete 10 targets';

  @override
  String get badge_target20_title => 'Twenty Targets';

  @override
  String get badge_target20_desc => 'Complete 20 targets';

  @override
  String get badge_fast16_title => '16 Hours';

  @override
  String get badge_fast16_desc => 'Reach 16 hours in one fast';

  @override
  String get badge_hours50_title => '50 Hours';

  @override
  String get badge_hours50_desc => 'Log 50 total hours';

  @override
  String get badge_hours100_title => 'Hundred Hours';

  @override
  String get badge_hours100_desc => 'Log 100 total hours';

  @override
  String get badge_target30_title => 'Thirty Targets';

  @override
  String get badge_target30_desc => 'Complete 30 targets';

  @override
  String get badge_rhythm30_title => '30-Day Rhythm';

  @override
  String get badge_rhythm30_desc => 'Reach a 30-day streak';

  @override
  String get paywall_restoreSuccess => 'Purchases restored!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Fasting progress $percent percent';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}h';
  }

  @override
  String get paywall_lifetime => 'Lifetime';

  @override
  String get paywall_once => 'one-time';

  @override
  String get paywall_processing => 'Processing…';

  @override
  String get paywall_continue => 'Continue';

  @override
  String get paywall_productsUnavailable =>
      'Purchases are not available right now. Please try again later.';

  @override
  String get paywall_purchaseFailed => 'The purchase could not be completed.';

  @override
  String get paywall_nothingToRestore => 'No previous purchase was found.';

  @override
  String get paywall_restoreFailed => 'Purchases could not be restored.';

  @override
  String get paywall_terms => 'Terms of Use';

  @override
  String get permission_notificationDesc =>
      'Fasting reminders, phase updates and completion notifications';

  @override
  String get permission_healthTitle => 'Health Connect / HealthKit';

  @override
  String get permission_healthDesc =>
      'Sync steps, active calories and weight with your permission';

  @override
  String get profile_privacyChoices => 'Privacy choices';

  @override
  String get paywall_autoRenewInfo =>
      'Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period. Manage or cancel anytime in your App Store settings.';

  @override
  String paywall_perMonth(String price) {
    return '$price / month';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Save $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days-day free trial';
  }

  @override
  String get paywall_startFreeTrial => 'Start free trial';

  @override
  String get paywall_retry => 'Try again';

  @override
  String get paywall_alreadyOwned =>
      'You already own this subscription. Tap “Restore purchases”.';

  @override
  String get paywall_storeUnavailable =>
      'Can\'t reach the store right now. Check your connection and try again.';

  @override
  String get paywall_secureNote =>
      'Cancel anytime. Payment is charged to your store account.';
}
