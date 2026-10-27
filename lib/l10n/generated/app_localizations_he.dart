// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'בוקר טוב';

  @override
  String get greeting_afternoon => 'צהריים טובים';

  @override
  String get greeting_evening => 'ערב טוב';

  @override
  String get tab_timer => 'בית';

  @override
  String get tab_explore => 'גילוי';

  @override
  String get tab_stats => 'דוח';

  @override
  String get tab_meals => 'ארוחות';

  @override
  String get tab_achievements => 'הישגים';

  @override
  String get tab_profile => 'חשבון';

  @override
  String get timer_fasting => 'זמן הצום';

  @override
  String get timer_remaining => 'נותר';

  @override
  String get timer_elapsed => 'חלף';

  @override
  String get timer_start => 'התחלה';

  @override
  String get timer_stop => 'עצירה';

  @override
  String get timer_completed => 'כל הכבוד!';

  @override
  String get timer_completedMessage => 'השלמת את הצום בהצלחה!';

  @override
  String get timer_selectPlan => 'בחירת תוכנית צום';

  @override
  String get timer_stopConfirm => 'האם לסיים את הצום מוקדם?';

  @override
  String get timer_stopTitle => 'סיום הצום';

  @override
  String get timer_cancel => 'ביטול';

  @override
  String get timer_confirmStop => 'כן, לסיים';

  @override
  String get phase_anabolic => 'שלב אנבולי';

  @override
  String get phase_anabolicDesc => 'העיכול בתהליך';

  @override
  String get phase_catabolic => 'שלב קטבולי';

  @override
  String get phase_catabolicDesc => 'מעבר אנרגיה';

  @override
  String get phase_fatBurning => 'שריפת שומן';

  @override
  String get phase_fatBurningDesc => 'שריפת השומן החלה';

  @override
  String get phase_ketosis => 'קטוזיס';

  @override
  String get phase_ketosisDesc => 'ייצור הקטונים פעיל';

  @override
  String get phase_autophagy => 'אוטופגיה';

  @override
  String get phase_autophagyDesc => 'התחדשות תאים';

  @override
  String get stats_title => 'סטטיסטיקות';

  @override
  String get stats_week => 'שבוע';

  @override
  String get stats_month => 'חודש';

  @override
  String get stats_year => 'שנה';

  @override
  String get stats_totalFasts => 'סך הצומות';

  @override
  String get stats_average => 'ממוצע';

  @override
  String get stats_fastDuration => 'משך הצום';

  @override
  String get stats_streak => 'רצף';

  @override
  String get stats_daysConsecutive => 'ימים רצופים';

  @override
  String get stats_success => 'הצלחה';

  @override
  String get stats_completion => 'השלמה';

  @override
  String get stats_weeklyFasting => 'צום שבועי';

  @override
  String get stats_monthlyView => 'תצוגה חודשית';

  @override
  String get stats_weightChange => 'שינוי במשקל';

  @override
  String get heatmap_none => 'ללא';

  @override
  String get heatmap_low => 'נמוך';

  @override
  String get heatmap_good => 'טוב';

  @override
  String get heatmap_full => 'מלא';

  @override
  String get meals_title => 'מתכנן ארוחות';

  @override
  String get meals_eatingWindow => 'חלון אכילה';

  @override
  String get meals_windowOpen => 'פתוח';

  @override
  String get meals_windowFasting => 'בצום';

  @override
  String get meals_calories => 'קלוריות';

  @override
  String get meals_protein => 'חלבון';

  @override
  String get meals_carbs => 'פחמימות';

  @override
  String get meals_fat => 'שומן';

  @override
  String get meals_todayMeals => 'הארוחות של היום';

  @override
  String get meals_noMeals => 'טרם נוספו ארוחות';

  @override
  String get meals_breakfastSuggestions => 'הצעות לשבירת הצום';

  @override
  String get meals_addMeal => 'הוספת ארוחה';

  @override
  String get profile_title => 'פרופיל';

  @override
  String get profile_user => 'משתמש';

  @override
  String profile_planActive(String plan) {
    return 'תוכנית $plan פעילה';
  }

  @override
  String get profile_upgradePremium => 'שדרוג ל-Premium';

  @override
  String get profile_premiumDesc => 'כל תוכניות הצום, ללא פרסומות';

  @override
  String get profile_bodyMetrics => 'מדדי גוף';

  @override
  String get profile_height => 'גובה';

  @override
  String get profile_weight => 'משקל';

  @override
  String get profile_targetWeight => 'משקל יעד';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'הגדרות';

  @override
  String get profile_notifications => 'התראות';

  @override
  String get profile_darkTheme => 'ערכת נושא כהה';

  @override
  String get profile_waterReminder => 'תזכורת מים';

  @override
  String get profile_phaseNotifications => 'התראות שלבים';

  @override
  String get profile_language => 'שפה';

  @override
  String get profile_about => 'אודות';

  @override
  String get profile_rateApp => 'דירוג האפליקציה';

  @override
  String get profile_share => 'שיתוף';

  @override
  String get profile_privacyPolicy => 'מדיניות פרטיות';

  @override
  String get profile_version => 'גרסה';

  @override
  String get onboarding_welcome => 'ברוכים הבאים';

  @override
  String get onboarding_welcomeDesc => 'קחו שליטה על מסע\nהצום לסירוגין שלכם';

  @override
  String get onboarding_featureTimer => 'טיימר צום חכם';

  @override
  String get onboarding_featureStats => 'סטטיסטיקות ותרשימים מפורטים';

  @override
  String get onboarding_featureMeals => 'מתכנן ארוחות והצעות למתכונים';

  @override
  String get onboarding_getStarted => 'מתחילים';

  @override
  String get onboarding_selectGoal => 'מה היעד שלך?';

  @override
  String get onboarding_selectGoalDesc => 'אפשר לבחור כמה';

  @override
  String get onboarding_goalWeight => 'ירידה במשקל';

  @override
  String get onboarding_goalWeightDesc => 'ירידה בריאה במשקל';

  @override
  String get onboarding_goalHealth => 'שיפור הבריאות';

  @override
  String get onboarding_goalHealthDesc => 'בריאות כללית וחסינות';

  @override
  String get onboarding_goalEnergy => 'יותר אנרגיה';

  @override
  String get onboarding_goalEnergyDesc => 'אנרגיה לאורך כל היום';

  @override
  String get onboarding_goalMental => 'בהירות מחשבתית';

  @override
  String get onboarding_goalMentalDesc => 'מיקוד ובהירות';

  @override
  String get onboarding_goalLongevity => 'אריכות ימים';

  @override
  String get onboarding_goalLongevityDesc => 'התחדשות תאים והזדקנות בריאה';

  @override
  String get onboarding_goalDiscipline => 'משמעת';

  @override
  String get onboarding_goalDisciplineDesc => 'פיתוח משמעת עצמית';

  @override
  String get onboarding_selectPlan => 'בחירת התוכנית';

  @override
  String get onboarding_selectPlanDesc => 'בחרו את תוכנית הצום המתאימה ביותר';

  @override
  String get onboarding_bodyInfo => 'הזנת פרטים';

  @override
  String get onboarding_bodyInfoDesc => 'לקבלת המלצות אישיות';

  @override
  String get onboarding_gender => 'מגדר';

  @override
  String get onboarding_male => 'זכר';

  @override
  String get onboarding_female => 'נקבה';

  @override
  String get onboarding_age => 'גיל';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'מידע זה נשמר במכשיר בלבד ומשמש לחישוב קלוריות.';

  @override
  String get onboarding_permissions => 'שלב אחרון';

  @override
  String get onboarding_permissionsDesc => 'הפעילו הרשאות לחוויה הטובה ביותר';

  @override
  String get onboarding_next => 'המשך';

  @override
  String get onboarding_start => 'בואו נתחיל!';

  @override
  String get onboarding_skipForNow => 'הגדרה מאוחר יותר';

  @override
  String get waterAdded => 'נוספו 250 מ״ל מים';

  @override
  String get languageSelect => 'בחירת שפה';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'שדרוג ל-Premium';

  @override
  String get paywall_subtitle => 'פתיחת כל תוכניות הצום והסרת פרסומות';

  @override
  String get paywall_allPlans => 'כל תוכניות הצום';

  @override
  String get paywall_advancedStats => 'סטטיסטיקות מתקדמות';

  @override
  String get paywall_mealPlanner => 'מתכנן ארוחות';

  @override
  String get paywall_themes => 'התאמת ערכת נושא';

  @override
  String get paywall_noAds => 'ללא פרסומות';

  @override
  String get paywall_weekly => 'שבועי';

  @override
  String get paywall_monthly => 'חודשי';

  @override
  String get paywall_yearly => 'שנתי';

  @override
  String get paywall_bestValue => 'הכי משתלם';

  @override
  String get paywall_freeTrial => 'ניסיון חינם (3 ימים)';

  @override
  String get paywall_restore => 'שחזור רכישות';

  @override
  String get paywall_premiumActive => 'Premium פעיל!';

  @override
  String get paywall_premiumActiveDesc =>
      'כל תוכניות הצום פתוחות והפרסומות כבויות';

  @override
  String get water_title => 'צריכת מים';

  @override
  String get water_addWater => 'הוספת מים';

  @override
  String get water_goal => 'יעד';

  @override
  String get water_ml => 'מ״ל';

  @override
  String get common_ok => 'אישור';

  @override
  String get common_cancel => 'ביטול';

  @override
  String get common_save => 'שמירה';

  @override
  String get common_delete => 'מחיקה';

  @override
  String get common_hours => 'שעות';

  @override
  String get common_minutes => 'דקות';

  @override
  String get common_days => 'ימים';

  @override
  String get common_enable => 'הפעלה';

  @override
  String get streakCard_currentStreak => 'הרצף הנוכחי';

  @override
  String get streakCard_longestStreak => 'הרצף הארוך ביותר';

  @override
  String get streakCard_totalSessions => 'סך הצומות';

  @override
  String get meals_mealType => 'סוג הארוחה';

  @override
  String get meals_breakfast => 'ארוחת בוקר';

  @override
  String get meals_lunch => 'ארוחת צהריים';

  @override
  String get meals_dinner => 'ארוחת ערב';

  @override
  String get meals_snack => 'חטיף';

  @override
  String get meals_carbohydrate => 'פחמימות';

  @override
  String get meals_add => 'הוספה';

  @override
  String get meals_mealName => 'שם הארוחה';

  @override
  String get bodyMetrics_title => 'מדדי גוף';

  @override
  String get bodyMetrics_weight => 'משקל';

  @override
  String get bodyMetrics_target => 'יעד';

  @override
  String get bodyMetrics_save => 'שמירה';

  @override
  String get bodyMetrics_history => 'היסטוריה';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'אין עדיין נתונים';

  @override
  String get meals_quickAdd => 'הוספה מהירה';

  @override
  String get meals_manualEntry => 'הזנה ידנית';

  @override
  String meals_added(String name) {
    return '$name נוסף';
  }

  @override
  String get meals_nameCalorieRequired => 'נדרשים שם וקלוריות';

  @override
  String get bodyMetrics_addWeight => 'הוספת משקל';

  @override
  String get bodyMetrics_hintWeight => 'למשל 74.5';

  @override
  String get bodyMetrics_invalidWeight => 'יש להזין משקל תקין';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value ק״ג נשמרו';
  }

  @override
  String get completion_duration => 'משך';

  @override
  String get completion_plan => 'תוכנית';

  @override
  String get completion_lastPhase => 'שלב אחרון';

  @override
  String get completion_earlyTitle => 'הצום הסתיים';

  @override
  String get completion_earlyMessage =>
      'משך הזמן של היום נשמר. הרצף וההתקדמות בהישגים לא השתנו מכיוון שהיעד לא הושלם.';

  @override
  String get timer_remainingTime => 'זמן שנותר';

  @override
  String get timer_ready => 'מוכן להתחלה';

  @override
  String get streak_status => 'מצב';

  @override
  String get streak_startToday => 'מתחילים היום!';

  @override
  String get streak_goodStart => 'התחלה טובה!';

  @override
  String get streak_goingGreat => 'הולך מצוין!';

  @override
  String get streak_superb => 'מעולה!';

  @override
  String get streak_legendary => 'אגדי!';

  @override
  String get streak_incredible => 'מדהים!';

  @override
  String get weight_noRecord =>
      'אין עדיין רישומי משקל\nאפשר להוסיף בפרופיל > מדדי גוף';

  @override
  String get day_mon => 'ב׳';

  @override
  String get day_tue => 'ג׳';

  @override
  String get day_wed => 'ד׳';

  @override
  String get day_thu => 'ה׳';

  @override
  String get day_fri => 'ו׳';

  @override
  String get day_sat => 'ש׳';

  @override
  String get day_sun => 'א׳';

  @override
  String get day_short_mon => 'ב';

  @override
  String get day_short_tue => 'ג';

  @override
  String get day_short_wed => 'ד';

  @override
  String get day_short_thu => 'ה';

  @override
  String get day_short_fri => 'ו';

  @override
  String get day_short_sat => 'ש';

  @override
  String get day_short_sun => 'א';

  @override
  String get month_jan => 'ינואר';

  @override
  String get month_feb => 'פברואר';

  @override
  String get month_mar => 'מרץ';

  @override
  String get month_apr => 'אפריל';

  @override
  String get month_may => 'מאי';

  @override
  String get month_jun => 'יוני';

  @override
  String get month_jul => 'יולי';

  @override
  String get month_aug => 'אוגוסט';

  @override
  String get month_sep => 'ספטמבר';

  @override
  String get month_oct => 'אוקטובר';

  @override
  String get month_nov => 'נובמבר';

  @override
  String get month_dec => 'דצמבר';

  @override
  String meals_fastingWindow(String hours) {
    return 'צום ($hours ש׳)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'אכילה ($hours ש׳)';
  }

  @override
  String get recipe_oatSmoothie => 'שייק שיבולת שועל';

  @override
  String get recipe_avocadoToast => 'טוסט אבוקדו';

  @override
  String get recipe_yogurtBowl => 'קערת יוגורט';

  @override
  String get elapsed_time => 'זמן שחלף';

  @override
  String get fast_ends_on => 'הצום מסתיים בשעה';

  @override
  String get end_fasting => 'סיום הצום';

  @override
  String get start_fasting => 'התחלת צום';

  @override
  String get water_tracker => 'מעקב מים';

  @override
  String get weight_tracker => 'מעקב משקל';

  @override
  String get drink => 'שתייה';

  @override
  String get log_weight => 'רישום משקל';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'משקל שירד';

  @override
  String get current_weight => 'משקל נוכחי';

  @override
  String get goal_weight => 'משקל יעד';

  @override
  String get daily_goal => 'יעד יומי';

  @override
  String completed_percent(String percent) {
    return '$percent% הושלמו';
  }

  @override
  String get explore => 'גילוי';

  @override
  String get achievements => 'הישגים';

  @override
  String get profile_theme => 'מראה';

  @override
  String get theme_select => 'בחירת מראה';

  @override
  String get theme_system => 'ברירת מחדל של המערכת';

  @override
  String get theme_light => 'בהיר';

  @override
  String get theme_dark => 'כהה';

  @override
  String get language_system => 'שפת המערכת';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'צליל השלמה';

  @override
  String get profile_calmGamification => 'משחקיות רגועה';

  @override
  String get profile_calmGamificationDesc => 'מפחית לחץ מליגות ועונות';

  @override
  String get profile_editName => 'עריכת השם';

  @override
  String get profile_name => 'שם';

  @override
  String get circle_title => 'מעגל הצום';

  @override
  String get circle_you => 'אתם';

  @override
  String get circle_tagline => 'ביחד, בלי לחץ.';

  @override
  String get circle_privacy =>
      'המשקל והמדדים הפרטיים נשארים מוסתרים. רק ההתקדמות והתמיכה גלויות.';

  @override
  String circle_sendSupport(int count) {
    return 'שליחת תמיכה · $count';
  }

  @override
  String get circle_inviteCopied => 'קוד ההזמנה הועתק';

  @override
  String get circle_createInvite => 'יצירת הזמנה פרטית';

  @override
  String get crisis_nameTitle => 'ראשית, תנו שם למה שקורה';

  @override
  String get crisis_nameDesc => 'ייתכן שזה רעב, הרגל או רגש.';

  @override
  String get crisis_waterTitle => 'שתו כוס מים';

  @override
  String get crisis_waterDesc => 'ואז קחו שלוש נשימות איטיות.';

  @override
  String get crisis_delayTitle => 'דחו את ההחלטה ב-10 דקות';

  @override
  String get crisis_delayDesc => 'אם אינכם מרגישים טוב, סיום הצום אינו כישלון.';

  @override
  String get crisis_hunger => 'רעב';

  @override
  String get crisis_habit => 'הרגל';

  @override
  String get crisis_stress => 'לחץ';

  @override
  String get crisis_tenMore => 'תנו לזה 10 דקות';

  @override
  String get stats_storyEmpty => 'הצום הראשון יתחיל את הסיפור האישי שלכם.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'צמתם $sessions פעמים בתקופה זו, שמרתם על הקצב במשך $hours שעות והגעתם לשיעור השלמה של $rate%.';
  }

  @override
  String get stats_storyTitle => 'סיפור הקצב שלכם';

  @override
  String get home_todayRhythm => 'הקצב של היום';

  @override
  String get home_finalHourSupport => 'תמיכה לשעה האחרונה';

  @override
  String get home_needSupport => 'אני צריך קצת תמיכה';

  @override
  String get home_todaySummary => 'היום במבט אחד';

  @override
  String get home_dayStreak => 'ימי רצף';

  @override
  String home_weightGoal(String weight) {
    return 'יעד $weight ק״ג';
  }

  @override
  String get weather_steady => 'הקצב שלכם יציב';

  @override
  String get weather_gentle => 'יום רגוע';

  @override
  String get weather_water => 'כוס מים עשויה לעזור.';

  @override
  String get weather_listen => 'הגעתם רחוק; הקשיבו לגוף.';

  @override
  String get weather_onPlan => 'הקצב היום תואם לתוכנית.';

  @override
  String get weather_challenging =>
      'השעה הזאת הייתה מאתגרת בעבר; מצב התמיכה מוכן.';

  @override
  String get replay_copied => 'סיכום הצום הועתק';

  @override
  String get replay_button => 'הצגה חוזרת';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'השלמתי צום $plan בתוך $hoursש׳ $minutesדק׳ · $phase';
  }

  @override
  String get journey_label => 'המסע המטבולי';

  @override
  String get journey_now => 'עכשיו';

  @override
  String journey_next(String time, String phase) {
    return '$time עד $phase';
  }

  @override
  String get phase_estimateShort =>
      'תזמון השלב הוא הערכה כללית, לא מדידה רפואית.';

  @override
  String phase_hours(int start, int end) {
    return 'שעות $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'תזמון זה הוא הערכה כללית. התגובות המטבוליות עשויות להשתנות בין אנשים.';

  @override
  String get bmi_underweight => 'תת-משקל';

  @override
  String get bmi_normal => 'תקין';

  @override
  String get bmi_overweight => 'עודף משקל';

  @override
  String get bmi_obese => 'השמנה';

  @override
  String get notification_halfwayTitle => 'הגעתם לחצי! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'השלמתם חצי מצום $plan. המשיכו כך!';
  }

  @override
  String get notification_phaseCatabolic => 'נכנסתם לשלב הקטבולי 📉';

  @override
  String get notification_phaseFatBurning => 'שריפת השומן החלה! 🔥';

  @override
  String get notification_phaseKetosis => 'אתם בקטוזיס ⚡';

  @override
  String get notification_phaseAutophagy => 'האוטופגיה פעילה! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'השלמתם צום $plan! חלון האכילה פתוח.';
  }

  @override
  String get notification_waterTitle => 'שתו מים 💧';

  @override
  String get notification_waterBody => 'אל תשכחו לשתות מספיק מים בזמן הצום!';

  @override
  String get notification_windowTitle => 'חלון האכילה נסגר בקרוב ⏰';

  @override
  String get notification_windowBody => 'חלון האכילה ייסגר בעוד 30 דקות.';

  @override
  String notification_streakTitle(int days) {
    return 'רצף של $days ימים! 🔥';
  }

  @override
  String get notification_streakBody =>
      'אתם עושים עבודה נהדרת! המשיכו גם היום.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'הצום בתהליך - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'נותר: $time';
  }

  @override
  String notification_started(String plan) {
    return 'הצום התחיל - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'יעד: $hours שעות';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hoursש׳ $minutesדק׳';
  }

  @override
  String get explore_guide => 'מדריך הצום';

  @override
  String get explore_guideDesc => 'כל מה שצריך לדעת על צום לסירוגין';

  @override
  String get explore_circleDesc => 'שתפו תמיכה שקטה עם הקבוצה הפרטית שלכם.';

  @override
  String get explore_faq => 'שאלות נפוצות';

  @override
  String get explore_education =>
      'תוכן זה מיועד להשכלה כללית בלבד ואינו אבחון רפואי או ייעוץ טיפולי.';

  @override
  String get explore_safety => 'בריאות ובטיחות';

  @override
  String get explore_safetyDesc =>
      'אם יש לכם מצב רפואי, אתם נוטלים תרופות בקביעות, יש תסמינים מדאיגים, או שאתן בהיריון או מניקות, התייעצו עם איש מקצוע רפואי מוסמך לפני הצום. הפסיקו אם אינכם מרגישים טוב.';

  @override
  String get explore_sources => 'מקורות';

  @override
  String get explore_sourcesDesc =>
      'התוכן פושט מתוך מקורות בריאות הציבור שלהלן.';

  @override
  String get explore_sourceError => 'לא ניתן לפתוח את המקור';

  @override
  String get explore_rules => 'כללים חשובים';

  @override
  String get explore_rule1 => 'אין לצרוך מזון עם קלוריות בזמן הצום';

  @override
  String get explore_rule2 => 'שתו הרבה מים ונוזלים';

  @override
  String get explore_rule3 => 'אכלו באופן מאוזן בחלון האכילה';

  @override
  String get explore_rule4 => 'הפסיקו לצום אם אינכם מרגישים טוב';

  @override
  String get explore_rule5 => 'נשים בהיריון או מניקות לא צריכות לצום';

  @override
  String get explore_rule6 => 'התייעצו עם רופא אם יש לכם מחלה כרונית';

  @override
  String get tip_water => 'שמרו על נוזלים';

  @override
  String get tip_waterDesc =>
      'שתו מים כשאתם צמאים ושלבו נוזלים בארוחות. הצורך משתנה לפי הבריאות, מזג האוויר והפעילות.';

  @override
  String get tip_food => 'אכלו נכון';

  @override
  String get tip_foodDesc =>
      'בחלונות האכילה בחרו מזונות עשירים בחלבון עם סיבים ושומנים בריאים. הימנעו ממזון מעובד.';

  @override
  String get tip_sleep => 'שנו היטב';

  @override
  String get tip_sleepDesc =>
      'שינה סדירה ומספקת תומכת בבריאות הכללית. תזמנו את הצום כך שלא יפגע בשינה.';

  @override
  String get tip_exercise => 'פעילות קלה';

  @override
  String get tip_exerciseDesc =>
      'אפשר לצאת להליכה קלה או לעשות יוגה בזמן הצום. הימנעו מפעילות מאומצת, במיוחד בשבועות הראשונים עד שהגוף מסתגל.';

  @override
  String get tip_drinks => 'משקאות מותרים';

  @override
  String get tip_drinksDesc =>
      'בזמן הצום אפשר לשתות מים, תה ללא תוספות וקפה שחור (ללא סוכר או חלב). משקאות אלה לא ישברו את הצום.';

  @override
  String get faq_drinks => 'מה אפשר לשתות בזמן הצום?';

  @override
  String get faq_drinksAnswer =>
      'אפשר לשתות מים, תה ללא תוספות וקפה שחור (ללא סוכר/חלב). משקאות עם קלוריות שוברים את הצום.';

  @override
  String get faq_plan => 'באיזו תוכנית צום כדאי לבחור?';

  @override
  String get faq_planAnswer =>
      'אם אתם מתחילים, התחילו ב-12:12 או 14:10. אם יש לכם ניסיון, נסו 16:8 או 18:6. תוכניות 20:4 ו-OMAD מיועדות למתקדמים.';

  @override
  String get faq_exercise => 'אפשר להתאמן בזמן הצום?';

  @override
  String get faq_exerciseAnswer =>
      'כן, אך הימנעו מאימונים עצימים. פעילות אירובית קלה, הליכה ויוגה מתאימות. תזמנו אימוני כוח סמוך לחלון האכילה.';

  @override
  String get faq_weight => 'האם צום מסייע בירידה במשקל?';

  @override
  String get faq_weightAnswer =>
      'אצל חלק מהאנשים, הגבלת שעות האכילה עשויה להפחית את צריכת האנרגיה הכוללת. התוצאות משתנות וההשפעות לטווח ארוך עדיין נחקרות.';

  @override
  String get plan_12_desc => 'רמת מתחילים';

  @override
  String get plan_12_detail => 'מתאים למתחילים. צמים 12 שעות, כולל זמן השינה.';

  @override
  String get plan_16_desc => 'התוכנית הפופולרית ביותר';

  @override
  String get plan_16_detail =>
      'תוכנית הצום לסירוגין הנפוצה ביותר. 16 שעות צום ו-8 שעות אכילה, בדרך כלל מצהריים עד הערב.';

  @override
  String get plan_18_desc => 'רמת ביניים';

  @override
  String get plan_18_detail =>
      '18 שעות צום ו-6 שעות אכילה. משך שריפת שומן ארוך יותר.';

  @override
  String get plan_20_desc => 'רמה מתקדמת';

  @override
  String get plan_20_detail =>
      '20 שעות צום ו-4 שעות אכילה. מתאים להגעה לקטוזיס ולאוטופגיה.';

  @override
  String get plan_omad_desc => 'ארוחה אחת ביום';

  @override
  String get plan_omad_detail =>
      'ארוחה אחת ביום. 23 שעות צום ושעת אכילה אחת. רמת מומחים.';

  @override
  String get plan_52_desc => 'יומיים בשבוע';

  @override
  String get plan_52_detail =>
      'אוכלים כרגיל 5 ימים ורק כ-500 קלוריות ביומיים. גישה חלופית.';

  @override
  String get plan_ese_desc => 'צום של 24 שעות';

  @override
  String get plan_ese_detail =>
      'צמים 24 שעות פעם או פעמיים בשבוע. למשתמשים מתקדמים.';

  @override
  String get plan_warrior_desc => 'דיאטת הלוחם';

  @override
  String get plan_warrior_detail =>
      'אוכלים קל במהלך היום (פירות וירקות) ואת הארוחה העיקרית בחלון ערב של 4 שעות.';

  @override
  String get award_first_title => 'צעד ראשון';

  @override
  String get award_first_desc => 'השלמת הצום הראשון';

  @override
  String get award_rhythm3_title => 'קצב של 3 ימים';

  @override
  String get award_rhythm3_desc => 'שמירה על הקצב במשך שלושה ימים';

  @override
  String get award_hours24_title => '24 שעות';

  @override
  String get award_hours24_desc => 'צום של 24 שעות בסך הכול';

  @override
  String get award_week_title => 'קצב של שבוע';

  @override
  String get award_week_desc => 'בניית רצף של שבעה ימים';

  @override
  String get award_fasts10_title => '10 צומות';

  @override
  String get award_fasts10_desc => 'השלמת עשרה צומות';

  @override
  String get award_hours100_title => '100 שעות';

  @override
  String get award_hours100_desc => 'הגעה ל-100 שעות בסך הכול';

  @override
  String get award_rhythm30_title => 'קצב של 30 יום';

  @override
  String get award_rhythm30_desc => 'בניית רצף של שלושים יום';

  @override
  String get award_fasts50_title => '50 צומות';

  @override
  String get award_fasts50_desc => 'השלמת חמישים צומות';

  @override
  String get award_hours500_title => '500 שעות';

  @override
  String get award_hours500_desc => 'הגעה ל-500 שעות בסך הכול';

  @override
  String get award_fasts100_title => '100 צומות';

  @override
  String get award_fasts100_desc => 'השלמת מאה צומות';

  @override
  String get award_rhythm90_title => 'קצב של 90 יום';

  @override
  String get award_rhythm90_desc => 'בניית רצף של תשעים יום';

  @override
  String get award_year_title => 'מסע של שנה';

  @override
  String get award_year_desc => 'הגעה לקצב של 365 ימים';

  @override
  String get awards_loadError => 'לא ניתן לטעון את ההתקדמות';

  @override
  String get awards_journeyComplete => 'המסע הושלם';

  @override
  String get awards_nextGoal => 'היעד הבא';

  @override
  String get awards_allYours => 'כל ההישגים שלכם';

  @override
  String get awards_dayStreak => 'ימי רצף';

  @override
  String get awards_fasts => 'צומות';

  @override
  String get awards_total => 'סך הכול';

  @override
  String get awards_stageStart => 'התחלה';

  @override
  String get awards_stageRhythm => 'קצב';

  @override
  String get awards_stageEndurance => 'סיבולת';

  @override
  String get awards_stageMastery => 'שליטה';

  @override
  String get awards_completed => 'הושלם';

  @override
  String awards_fastsRemaining(int count) {
    return 'נותרו $count צומות';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'נותרו $count ימים';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'נותרו $count שעות';
  }

  @override
  String get common_retry => 'ניסיון חוזר';

  @override
  String get game_title => 'מרכז ההתקדמות';

  @override
  String get game_quests => 'המשימות של היום';

  @override
  String get game_questsDesc => 'צעדים קטנים, קצב בר-קיימא.';

  @override
  String get game_season => 'עונה של 30 צעדים';

  @override
  String get game_seasonDesc => 'חותמת לאוסף בכל צעד חמישי.';

  @override
  String get game_badges => 'אוסף תגים';

  @override
  String game_shields(int count) {
    return '$count מגני קצב';
  }

  @override
  String get game_shieldsDesc =>
      'מתקבלים בכל שבע השלמות. יום שהוחמץ לעולם לא מוחק את ההתקדמות.';

  @override
  String get game_league => 'ליגה שבועית פרטית';

  @override
  String game_leagueDesc(int percent) {
    return 'ציון הקצב שלכם נמצא באחוזון $percent של מודל מקומי פרטי. משקל וצום קיצוני לעולם אינם מדורגים.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'רמה $level, ‏$xp נקודות ניסיון';
  }

  @override
  String get game_explorer => 'חוקר הקצב';

  @override
  String get game_streak => 'רצף';

  @override
  String get game_targets => 'יעדים';

  @override
  String get game_best => 'הטוב ביותר';

  @override
  String get quest_rhythm => 'בניית הקצב של היום';

  @override
  String get quest_hydrate => 'הגעה למחצית מיעד המים';

  @override
  String get quest_steady => 'שמירה על הרצף';

  @override
  String get badge_first_title => 'צעד ראשון';

  @override
  String get badge_first_desc => 'רישום הצום הראשון';

  @override
  String get badge_rhythm7_title => 'שומר הקצב';

  @override
  String get badge_rhythm7_desc => 'הגעה לרצף של 7 ימים';

  @override
  String get badge_rhythm3_title => 'קצב של שלושה ימים';

  @override
  String get badge_rhythm3_desc => 'הגעה לרצף של 3 ימים';

  @override
  String get badge_target1_title => 'יעד ראשון';

  @override
  String get badge_target1_desc => 'השלמת צום היעד הראשון';

  @override
  String get badge_target3_title => 'שלושה צעדים';

  @override
  String get badge_target3_desc => 'השלמת 3 יעדים';

  @override
  String get badge_water_title => 'מאוזן';

  @override
  String get badge_water_desc => 'השלמת יעד המים היומי';

  @override
  String get badge_support_title => 'מודעות עצמית';

  @override
  String get badge_support_desc => 'שימוש במצב התמיכה';

  @override
  String get badge_hours10_title => '10 שעות';

  @override
  String get badge_hours10_desc => 'רישום 10 שעות בסך הכול';

  @override
  String get badge_target10_title => 'עשר בעוצמה';

  @override
  String get badge_target10_desc => 'השלמת 10 יעדים';

  @override
  String get badge_target20_title => 'עשרים יעדים';

  @override
  String get badge_target20_desc => 'השלמת 20 יעדים';

  @override
  String get badge_fast16_title => '16 שעות';

  @override
  String get badge_fast16_desc => 'הגעה ל-16 שעות בצום אחד';

  @override
  String get badge_hours50_title => '50 שעות';

  @override
  String get badge_hours50_desc => 'רישום 50 שעות בסך הכול';

  @override
  String get badge_hours100_title => 'מאה שעות';

  @override
  String get badge_hours100_desc => 'רישום 100 שעות בסך הכול';

  @override
  String get badge_target30_title => 'שלושים יעדים';

  @override
  String get badge_target30_desc => 'השלמת 30 יעדים';

  @override
  String get badge_rhythm30_title => 'קצב של 30 יום';

  @override
  String get badge_rhythm30_desc => 'הגעה לרצף של 30 יום';

  @override
  String get paywall_restoreSuccess => 'הרכישות שוחזרו!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'התקדמות הצום $percent אחוז';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hourש׳';
  }

  @override
  String get paywall_lifetime => 'לכל החיים';

  @override
  String get paywall_once => 'חד-פעמי';

  @override
  String get paywall_processing => 'בעיבוד…';

  @override
  String get paywall_continue => 'המשך';

  @override
  String get paywall_productsUnavailable =>
      'הרכישות אינן זמינות כרגע. נסו שוב מאוחר יותר.';

  @override
  String get paywall_purchaseFailed => 'לא ניתן להשלים את הרכישה.';

  @override
  String get paywall_nothingToRestore => 'לא נמצאה רכישה קודמת.';

  @override
  String get paywall_restoreFailed => 'לא ניתן לשחזר את הרכישות.';

  @override
  String get paywall_terms => 'תנאי שימוש';

  @override
  String get permission_notificationDesc =>
      'תזכורות צום, עדכוני שלבים והתראות השלמה';

  @override
  String get profile_privacyChoices => 'אפשרויות פרטיות';

  @override
  String get paywall_autoRenewInfo =>
      'המינויים מתחדשים אוטומטית אלא אם מבטלים לפחות 24 שעות לפני תום התקופה. אפשר לנהל או לבטל בכל עת בהגדרות ה-App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / חודש';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'חיסכון של $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'ניסיון חינם ל-$days ימים';
  }

  @override
  String get paywall_startFreeTrial => 'התחלת ניסיון חינם';

  @override
  String get paywall_retry => 'ניסיון חוזר';

  @override
  String get paywall_alreadyOwned =>
      'המינוי הזה כבר בבעלותכם. הקישו על ״שחזור רכישות״.';

  @override
  String get paywall_storeUnavailable =>
      'לא ניתן להגיע לחנות כרגע. בדקו את החיבור ונסו שוב.';

  @override
  String get paywall_secureNote =>
      'אפשר לבטל בכל עת. התשלום מחויב בחשבון החנות.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'המינויים מתחדשים אוטומטית אלא אם מבטלים לפחות 24 שעות לפני תום התקופה. אפשר לנהל או לבטל בכל עת ב-Google Play > מינויים.';

  @override
  String get paywall_allPlansDesc =>
      'פותח את 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat ו-Warrior';

  @override
  String get paywall_noAdsDesc => 'פרסומות באנר ופרסומות מעבר מושבתות לחלוטין';

  @override
  String get foodScan_title => 'סריקת מזון ב-AI';

  @override
  String get foodScan_scanCta => 'סריקת ארוחה';

  @override
  String get foodScan_scanCtaDesc => 'צלמו את הצלחת וקבלו קלוריות ומאקרו';

  @override
  String get foodScan_introTitle => 'צלמו את הצלחת';

  @override
  String get foodScan_introDesc =>
      'ה-AI קורא את התמונה ומעריך קלוריות, חלבון, פחמימות ושומן.';

  @override
  String get foodScan_tipLight => 'תאורה טובה ואחידה מספקת הערכה טובה יותר';

  @override
  String get foodScan_tipFrame => 'הכניסו את כל הצלחת למסגרת';

  @override
  String get foodScan_tipScale => 'כללו סכו״ם או יד כדי לאמוד את גודל המנות';

  @override
  String get foodScan_takePhoto => 'צילום תמונה';

  @override
  String get foodScan_chooseFromGallery => 'בחירה מהגלריה';

  @override
  String foodScan_scansLeft(int count) {
    return 'נותרו $count סריקות היום';
  }

  @override
  String get foodScan_quotaReached =>
      'השתמשתם בכל הסריקות של היום. נסו שוב מחר.';

  @override
  String get foodScan_privacyNote =>
      'התמונה נשלחת ל-Gemini API של Google לניתוח ואינה נשמרת בשרתים שלנו.';

  @override
  String get foodScan_consentTitle => 'לשלוח תמונות ל-Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'כדי להעריך קלוריות ומאקרו, כל תמונת ארוחה שתצלמו או תבחרו נשלחת לשירות הבינה המלאכותית Gemini של Google. התמונה משמשת רק לניתוח הזה ואינה נשמרת בשרתים שלנו.';

  @override
  String get foodScan_consentAgree => 'אישור והמשך';

  @override
  String get foodScan_analyzing => 'הארוחה בניתוח…';

  @override
  String get foodScan_analyzingHint => 'התהליך נמשך בדרך כלל כמה שניות';

  @override
  String get foodScan_detectedItems => 'פריטים שזוהו';

  @override
  String get foodScan_disclaimer =>
      'הערכות AI הן בקירוב. הקישו על פריט כדי לתקן אותו.';

  @override
  String get foodScan_lowConfidence =>
      'המודל אינו בטוח לגבי התמונה. בדקו את המספרים לפני השמירה.';

  @override
  String get foodScan_save => 'הוספה לארוחות';

  @override
  String get foodScan_retake => 'תמונה חדשה';

  @override
  String get foodScan_retry => 'ניסיון חוזר';

  @override
  String get foodScan_editItem => 'עריכת פריט';

  @override
  String get foodScan_portion => 'מנה';

  @override
  String get foodScan_saveEdit => 'שמירה';

  @override
  String get foodScan_premiumTitle => 'תכונת Premium';

  @override
  String get foodScan_premiumDesc => 'ניתוח קלוריות מתמונה כלול ב-Premium.';

  @override
  String get foodScan_upgrade => 'הצגת Premium';

  @override
  String get foodScan_errorNetwork => 'אין חיבור. בדקו את האינטרנט ונסו שוב.';

  @override
  String get foodScan_errorRateLimited =>
      'יש יותר מדי סריקות כרגע. נסו שוב בעוד כמה דקות.';

  @override
  String get foodScan_errorUnavailable => 'ניתוח תמונות אינו זמין כרגע.';

  @override
  String get foodScan_errorServer => 'שירות הניתוח נתקל בבעיה. נסו שוב בקרוב.';

  @override
  String get foodScan_errorNoFood =>
      'לא נמצא מזון בתמונה. נסו צילום ברור יותר של הצלחת.';

  @override
  String get foodScan_errorUnreadable =>
      'לא ניתן לנתח את התמונה. נסו תמונה אחרת.';

  @override
  String get paywall_aiFoodScan => 'סריקת מזון ב-AI';

  @override
  String get paywall_aiFoodScanDesc =>
      'צלמו ארוחה ורשמו קלוריות ומאקרו בתוך שניות';
}
