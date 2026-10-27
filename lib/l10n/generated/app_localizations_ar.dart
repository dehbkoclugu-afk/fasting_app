// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'صباح الخير';

  @override
  String get greeting_afternoon => 'مساء الخير';

  @override
  String get greeting_evening => 'مساء الخير';

  @override
  String get tab_timer => 'الرئيسية';

  @override
  String get tab_explore => 'استكشاف';

  @override
  String get tab_stats => 'التقرير';

  @override
  String get tab_meals => 'الوجبات';

  @override
  String get tab_achievements => 'الإنجازات';

  @override
  String get tab_profile => 'الحساب';

  @override
  String get timer_fasting => 'مدة الصيام';

  @override
  String get timer_remaining => 'المتبقي';

  @override
  String get timer_elapsed => 'المنقضي';

  @override
  String get timer_start => 'بدء';

  @override
  String get timer_stop => 'إيقاف';

  @override
  String get timer_completed => 'تهانينا!';

  @override
  String get timer_completedMessage => 'أتممت صيامك بنجاح!';

  @override
  String get timer_selectPlan => 'اختر خطة الصيام';

  @override
  String get timer_stopConfirm =>
      'هل أنت متأكد من رغبتك في إنهاء الصيام مبكرًا؟';

  @override
  String get timer_stopTitle => 'إنهاء الصيام';

  @override
  String get timer_cancel => 'إلغاء';

  @override
  String get timer_confirmStop => 'نعم، إنهاء';

  @override
  String get phase_anabolic => 'مرحلة البناء';

  @override
  String get phase_anabolicDesc => 'الهضم جارٍ';

  @override
  String get phase_catabolic => 'مرحلة الهدم';

  @override
  String get phase_catabolicDesc => 'انتقال الطاقة';

  @override
  String get phase_fatBurning => 'حرق الدهون';

  @override
  String get phase_fatBurningDesc => 'بدأ حرق الدهون';

  @override
  String get phase_ketosis => 'الكيتوزية';

  @override
  String get phase_ketosisDesc => 'إنتاج الكيتونات نشط';

  @override
  String get phase_autophagy => 'الالتهام الذاتي';

  @override
  String get phase_autophagyDesc => 'تجدد الخلايا';

  @override
  String get stats_title => 'الإحصاءات';

  @override
  String get stats_week => 'أسبوع';

  @override
  String get stats_month => 'شهر';

  @override
  String get stats_year => 'سنة';

  @override
  String get stats_totalFasts => 'إجمالي مرات الصيام';

  @override
  String get stats_average => 'المتوسط';

  @override
  String get stats_fastDuration => 'مدة الصيام';

  @override
  String get stats_streak => 'السلسلة';

  @override
  String get stats_daysConsecutive => 'أيام متتالية';

  @override
  String get stats_success => 'النجاح';

  @override
  String get stats_completion => 'الإكمال';

  @override
  String get stats_weeklyFasting => 'الصيام الأسبوعي';

  @override
  String get stats_monthlyView => 'العرض الشهري';

  @override
  String get stats_weightChange => 'تغير الوزن';

  @override
  String get heatmap_none => 'لا شيء';

  @override
  String get heatmap_low => 'منخفض';

  @override
  String get heatmap_good => 'جيد';

  @override
  String get heatmap_full => 'كامل';

  @override
  String get meals_title => 'مخطط الوجبات';

  @override
  String get meals_eatingWindow => 'نافذة الأكل';

  @override
  String get meals_windowOpen => 'مفتوحة';

  @override
  String get meals_windowFasting => 'صيام';

  @override
  String get meals_calories => 'السعرات الحرارية';

  @override
  String get meals_protein => 'البروتين';

  @override
  String get meals_carbs => 'الكربوهيدرات';

  @override
  String get meals_fat => 'الدهون';

  @override
  String get meals_todayMeals => 'وجبات اليوم';

  @override
  String get meals_noMeals => 'لم تُضف وجبات بعد';

  @override
  String get meals_breakfastSuggestions => 'اقتراحات الإفطار';

  @override
  String get meals_addMeal => 'إضافة وجبة';

  @override
  String get profile_title => 'الملف الشخصي';

  @override
  String get profile_user => 'المستخدم';

  @override
  String profile_planActive(String plan) {
    return 'خطة $plan نشطة';
  }

  @override
  String get profile_upgradePremium => 'الترقية إلى Premium';

  @override
  String get profile_premiumDesc => 'كل خطط الصيام بلا إعلانات';

  @override
  String get profile_bodyMetrics => 'قياسات الجسم';

  @override
  String get profile_height => 'الطول';

  @override
  String get profile_weight => 'الوزن';

  @override
  String get profile_targetWeight => 'الوزن المستهدف';

  @override
  String get profile_bmi => 'مؤشر كتلة الجسم';

  @override
  String get profile_settings => 'الإعدادات';

  @override
  String get profile_notifications => 'الإشعارات';

  @override
  String get profile_darkTheme => 'المظهر الداكن';

  @override
  String get profile_waterReminder => 'تذكير شرب الماء';

  @override
  String get profile_phaseNotifications => 'إشعارات المراحل';

  @override
  String get profile_language => 'اللغة';

  @override
  String get profile_about => 'حول';

  @override
  String get profile_rateApp => 'تقييم التطبيق';

  @override
  String get profile_share => 'مشاركة';

  @override
  String get profile_privacyPolicy => 'سياسة الخصوصية';

  @override
  String get profile_version => 'الإصدار';

  @override
  String get onboarding_welcome => 'مرحبًا';

  @override
  String get onboarding_welcomeDesc => 'تحكم في رحلة\nالصيام المتقطع الخاصة بك';

  @override
  String get onboarding_featureTimer => 'مؤقت صيام ذكي';

  @override
  String get onboarding_featureStats => 'إحصاءات ورسوم بيانية مفصلة';

  @override
  String get onboarding_featureMeals => 'مخطط وجبات واقتراحات وصفات';

  @override
  String get onboarding_getStarted => 'ابدأ';

  @override
  String get onboarding_selectGoal => 'ما هدفك؟';

  @override
  String get onboarding_selectGoalDesc => 'يمكنك اختيار أكثر من هدف';

  @override
  String get onboarding_goalWeight => 'خسارة الوزن';

  @override
  String get onboarding_goalWeightDesc => 'خسارة وزن صحية';

  @override
  String get onboarding_goalHealth => 'تحسين الصحة';

  @override
  String get onboarding_goalHealthDesc => 'الصحة العامة والمناعة';

  @override
  String get onboarding_goalEnergy => 'طاقة أكبر';

  @override
  String get onboarding_goalEnergyDesc => 'طاقة طوال اليوم';

  @override
  String get onboarding_goalMental => 'صفاء الذهن';

  @override
  String get onboarding_goalMentalDesc => 'التركيز والوضوح';

  @override
  String get onboarding_goalLongevity => 'طول العمر';

  @override
  String get onboarding_goalLongevityDesc => 'تجدد الخلايا والشيخوخة الصحية';

  @override
  String get onboarding_goalDiscipline => 'الانضباط';

  @override
  String get onboarding_goalDisciplineDesc => 'بناء الانضباط الذاتي';

  @override
  String get onboarding_selectPlan => 'اختر خطتك';

  @override
  String get onboarding_selectPlanDesc => 'اختر خطة الصيام الأنسب لك';

  @override
  String get onboarding_bodyInfo => 'أدخل معلوماتك';

  @override
  String get onboarding_bodyInfoDesc => 'للحصول على توصيات مخصصة';

  @override
  String get onboarding_gender => 'الجنس';

  @override
  String get onboarding_male => 'ذكر';

  @override
  String get onboarding_female => 'أنثى';

  @override
  String get onboarding_age => 'العمر';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'تُحفظ هذه المعلومات على جهازك فقط وتُستخدم لحساب السعرات الحرارية.';

  @override
  String get onboarding_permissions => 'الخطوة الأخيرة';

  @override
  String get onboarding_permissionsDesc => 'فعّل الأذونات لأفضل تجربة';

  @override
  String get onboarding_next => 'متابعة';

  @override
  String get onboarding_start => 'لنبدأ!';

  @override
  String get onboarding_skipForNow => 'الإعداد لاحقًا';

  @override
  String get waterAdded => 'تمت إضافة 250 مل من الماء';

  @override
  String get languageSelect => 'اختر اللغة';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'الترقية إلى Premium';

  @override
  String get paywall_subtitle => 'افتح جميع خطط الصيام وأزل الإعلانات';

  @override
  String get paywall_allPlans => 'جميع خطط الصيام';

  @override
  String get paywall_advancedStats => 'إحصاءات متقدمة';

  @override
  String get paywall_mealPlanner => 'مخطط الوجبات';

  @override
  String get paywall_themes => 'تخصيص المظهر';

  @override
  String get paywall_noAds => 'بلا إعلانات';

  @override
  String get paywall_weekly => 'أسبوعي';

  @override
  String get paywall_monthly => 'شهري';

  @override
  String get paywall_yearly => 'سنوي';

  @override
  String get paywall_bestValue => 'أفضل قيمة';

  @override
  String get paywall_freeTrial => 'تجربة مجانية (3 أيام)';

  @override
  String get paywall_restore => 'استعادة المشتريات';

  @override
  String get paywall_premiumActive => 'Premium نشط!';

  @override
  String get paywall_premiumActiveDesc =>
      'تم فتح جميع خطط الصيام وإيقاف الإعلانات';

  @override
  String get water_title => 'كمية الماء';

  @override
  String get water_addWater => 'إضافة ماء';

  @override
  String get water_goal => 'الهدف';

  @override
  String get water_ml => 'مل';

  @override
  String get common_ok => 'حسنًا';

  @override
  String get common_cancel => 'إلغاء';

  @override
  String get common_save => 'حفظ';

  @override
  String get common_delete => 'حذف';

  @override
  String get common_hours => 'ساعات';

  @override
  String get common_minutes => 'دقائق';

  @override
  String get common_days => 'أيام';

  @override
  String get common_enable => 'تفعيل';

  @override
  String get streakCard_currentStreak => 'السلسلة الحالية';

  @override
  String get streakCard_longestStreak => 'أطول سلسلة';

  @override
  String get streakCard_totalSessions => 'إجمالي مرات الصيام';

  @override
  String get meals_mealType => 'نوع الوجبة';

  @override
  String get meals_breakfast => 'الإفطار';

  @override
  String get meals_lunch => 'الغداء';

  @override
  String get meals_dinner => 'العشاء';

  @override
  String get meals_snack => 'وجبة خفيفة';

  @override
  String get meals_carbohydrate => 'الكربوهيدرات';

  @override
  String get meals_add => 'إضافة';

  @override
  String get meals_mealName => 'اسم الوجبة';

  @override
  String get bodyMetrics_title => 'قياسات الجسم';

  @override
  String get bodyMetrics_weight => 'الوزن';

  @override
  String get bodyMetrics_target => 'الهدف';

  @override
  String get bodyMetrics_save => 'حفظ';

  @override
  String get bodyMetrics_history => 'السجل';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'مؤشر كتلة الجسم: $value';
  }

  @override
  String get bodyMetrics_noData => 'لا توجد بيانات بعد';

  @override
  String get meals_quickAdd => 'إضافة سريعة';

  @override
  String get meals_manualEntry => 'إدخال يدوي';

  @override
  String meals_added(String name) {
    return 'تمت إضافة $name';
  }

  @override
  String get meals_nameCalorieRequired => 'الاسم والسعرات الحرارية مطلوبان';

  @override
  String get bodyMetrics_addWeight => 'إضافة وزن';

  @override
  String get bodyMetrics_hintWeight => 'مثلًا 74.5';

  @override
  String get bodyMetrics_invalidWeight => 'أدخل وزنًا صالحًا';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'تم حفظ $value كغ';
  }

  @override
  String get completion_duration => 'المدة';

  @override
  String get completion_plan => 'الخطة';

  @override
  String get completion_lastPhase => 'المرحلة الأخيرة';

  @override
  String get completion_earlyTitle => 'انتهى الصيام';

  @override
  String get completion_earlyMessage =>
      'تم حفظ مدة اليوم. لم تتغير السلسلة أو الإنجازات لأن الهدف لم يكتمل.';

  @override
  String get timer_remainingTime => 'الوقت المتبقي';

  @override
  String get timer_ready => 'جاهز للبدء';

  @override
  String get streak_status => 'الحالة';

  @override
  String get streak_startToday => 'ابدأ اليوم!';

  @override
  String get streak_goodStart => 'بداية جيدة!';

  @override
  String get streak_goingGreat => 'تقدم رائع!';

  @override
  String get streak_superb => 'ممتاز!';

  @override
  String get streak_legendary => 'أسطوري!';

  @override
  String get streak_incredible => 'مذهل!';

  @override
  String get weight_noRecord =>
      'لا توجد سجلات وزن بعد\nأضفها من الملف الشخصي > قياسات الجسم';

  @override
  String get day_mon => 'الاثنين';

  @override
  String get day_tue => 'الثلاثاء';

  @override
  String get day_wed => 'الأربعاء';

  @override
  String get day_thu => 'الخميس';

  @override
  String get day_fri => 'الجمعة';

  @override
  String get day_sat => 'السبت';

  @override
  String get day_sun => 'الأحد';

  @override
  String get day_short_mon => 'ن';

  @override
  String get day_short_tue => 'ث';

  @override
  String get day_short_wed => 'ر';

  @override
  String get day_short_thu => 'خ';

  @override
  String get day_short_fri => 'ج';

  @override
  String get day_short_sat => 'س';

  @override
  String get day_short_sun => 'ح';

  @override
  String get month_jan => 'يناير';

  @override
  String get month_feb => 'فبراير';

  @override
  String get month_mar => 'مارس';

  @override
  String get month_apr => 'أبريل';

  @override
  String get month_may => 'مايو';

  @override
  String get month_jun => 'يونيو';

  @override
  String get month_jul => 'يوليو';

  @override
  String get month_aug => 'أغسطس';

  @override
  String get month_sep => 'سبتمبر';

  @override
  String get month_oct => 'أكتوبر';

  @override
  String get month_nov => 'نوفمبر';

  @override
  String get month_dec => 'ديسمبر';

  @override
  String meals_fastingWindow(String hours) {
    return 'الصيام ($hours س)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'الأكل ($hours س)';
  }

  @override
  String get recipe_oatSmoothie => 'سموذي الشوفان';

  @override
  String get recipe_avocadoToast => 'خبز محمص بالأفوكادو';

  @override
  String get recipe_yogurtBowl => 'وعاء الزبادي';

  @override
  String get elapsed_time => 'الوقت المنقضي';

  @override
  String get fast_ends_on => 'ينتهي صيامك عند';

  @override
  String get end_fasting => 'إنهاء الصيام';

  @override
  String get start_fasting => 'بدء الصيام';

  @override
  String get water_tracker => 'متتبع الماء';

  @override
  String get weight_tracker => 'متتبع الوزن';

  @override
  String get drink => 'اشرب';

  @override
  String get log_weight => 'تسجيل الوزن';

  @override
  String get bmi => 'مؤشر كتلة الجسم';

  @override
  String get weight_lost => 'الوزن المفقود';

  @override
  String get current_weight => 'الوزن الحالي';

  @override
  String get goal_weight => 'الوزن المستهدف';

  @override
  String get daily_goal => 'الهدف اليومي';

  @override
  String completed_percent(String percent) {
    return 'اكتمل $percent%';
  }

  @override
  String get explore => 'استكشاف';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get profile_theme => 'المظهر';

  @override
  String get theme_select => 'اختر المظهر';

  @override
  String get theme_system => 'إعداد النظام';

  @override
  String get theme_light => 'فاتح';

  @override
  String get theme_dark => 'داكن';

  @override
  String get language_system => 'لغة النظام';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'صوت الإكمال';

  @override
  String get profile_calmGamification => 'تحفيز هادئ';

  @override
  String get profile_calmGamificationDesc => 'يقلل ضغط الدوري والموسم';

  @override
  String get profile_editName => 'تعديل اسمك';

  @override
  String get profile_name => 'الاسم';

  @override
  String get circle_title => 'دائرة الصيام';

  @override
  String get circle_you => 'أنت';

  @override
  String get circle_tagline => 'معًا، بلا ضغط.';

  @override
  String get circle_privacy =>
      'يظل الوزن والقياسات الخاصة مخفية. يظهر التقدم والدعم فقط.';

  @override
  String circle_sendSupport(int count) {
    return 'إرسال دعم · $count';
  }

  @override
  String get circle_inviteCopied => 'تم نسخ رمز الدعوة';

  @override
  String get circle_createInvite => 'إنشاء دعوة خاصة';

  @override
  String get crisis_nameTitle => 'أولًا، سمِّ ما يحدث';

  @override
  String get crisis_nameDesc => 'قد يكون جوعًا أو عادة أو شعورًا.';

  @override
  String get crisis_waterTitle => 'اشرب كوبًا من الماء';

  @override
  String get crisis_waterDesc => 'ثم خذ ثلاثة أنفاس بطيئة.';

  @override
  String get crisis_delayTitle => 'أجّل القرار 10 دقائق';

  @override
  String get crisis_delayDesc => 'إذا شعرت بتوعك، فإن إنهاء الصيام ليس فشلًا.';

  @override
  String get crisis_hunger => 'الجوع';

  @override
  String get crisis_habit => 'العادة';

  @override
  String get crisis_stress => 'التوتر';

  @override
  String get crisis_tenMore => 'امنحه 10 دقائق';

  @override
  String get stats_storyEmpty => 'سيبدأ صيامك الأول قصتك الشخصية.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'صمت $sessions مرات في هذه الفترة، وحافظت على إيقاعك $hours ساعة، وبلغ معدل إكمالك $rate%.';
  }

  @override
  String get stats_storyTitle => 'قصة إيقاعك';

  @override
  String get home_todayRhythm => 'إيقاع اليوم';

  @override
  String get home_finalHourSupport => 'دعم الساعة الأخيرة';

  @override
  String get home_needSupport => 'أحتاج إلى قليل من الدعم';

  @override
  String get home_todaySummary => 'لمحة عن اليوم';

  @override
  String get home_dayStreak => 'أيام متتالية';

  @override
  String home_weightGoal(String weight) {
    return 'الهدف $weight كغ';
  }

  @override
  String get weather_steady => 'إيقاعك مستقر';

  @override
  String get weather_gentle => 'يوم هادئ';

  @override
  String get weather_water => 'قد يساعد كوب من الماء.';

  @override
  String get weather_listen => 'لقد قطعت شوطًا طويلًا؛ استمع إلى جسدك.';

  @override
  String get weather_onPlan => 'وتيرة اليوم توافق خطتك.';

  @override
  String get weather_challenging =>
      'كانت هذه الساعة صعبة سابقًا؛ وضع الدعم جاهز.';

  @override
  String get replay_copied => 'تم نسخ ملخص الصيام';

  @override
  String get replay_button => 'إعادة العرض';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'أكملت صيام $plan خلال $hoursس $minutesد · $phase';
  }

  @override
  String get journey_label => 'رحلة الأيض';

  @override
  String get journey_now => 'الآن';

  @override
  String journey_next(String time, String phase) {
    return '$time حتى $phase';
  }

  @override
  String get phase_estimateShort =>
      'توقيت المرحلة تقدير عام وليس قياسًا طبيًا.';

  @override
  String phase_hours(int start, int end) {
    return 'الساعات $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'هذا التوقيت تقدير عام. قد تختلف استجابات الأيض بين الأشخاص.';

  @override
  String get bmi_underweight => 'نقص الوزن';

  @override
  String get bmi_normal => 'طبيعي';

  @override
  String get bmi_overweight => 'زيادة الوزن';

  @override
  String get bmi_obese => 'سمنة';

  @override
  String get notification_halfwayTitle => 'وصلت إلى المنتصف! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'أتممت نصف صيام $plan. واصل التقدم!';
  }

  @override
  String get notification_phaseCatabolic => 'دخلت مرحلة الهدم 📉';

  @override
  String get notification_phaseFatBurning => 'بدأ حرق الدهون! 🔥';

  @override
  String get notification_phaseKetosis => 'أنت في حالة الكيتوزية ⚡';

  @override
  String get notification_phaseAutophagy => 'الالتهام الذاتي نشط! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'أتممت صيام $plan! نافذة الأكل مفتوحة.';
  }

  @override
  String get notification_waterTitle => 'اشرب الماء 💧';

  @override
  String get notification_waterBody =>
      'لا تنس شرب كمية كافية من الماء أثناء الصيام!';

  @override
  String get notification_windowTitle => 'نافذة الأكل توشك على الإغلاق ⏰';

  @override
  String get notification_windowBody => 'ستغلق نافذة الأكل خلال 30 دقيقة.';

  @override
  String notification_streakTitle(int days) {
    return 'سلسلة $days أيام! 🔥';
  }

  @override
  String get notification_streakBody => 'أداء رائع! واصل اليوم.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'الصيام جارٍ - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'المتبقي: $time';
  }

  @override
  String notification_started(String plan) {
    return 'بدأ الصيام - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'الهدف: $hours ساعة';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hoursس $minutesد';
  }

  @override
  String get explore_guide => 'دليل الصيام';

  @override
  String get explore_guideDesc => 'كل ما تحتاج معرفته عن الصيام المتقطع';

  @override
  String get explore_circleDesc => 'شارك دعمًا هادئًا مع مجموعتك الخاصة.';

  @override
  String get explore_faq => 'الأسئلة الشائعة';

  @override
  String get explore_education =>
      'هذا المحتوى للتثقيف العام فقط وليس تشخيصًا طبيًا أو نصيحة علاجية.';

  @override
  String get explore_safety => 'الصحة والسلامة';

  @override
  String get explore_safetyDesc =>
      'إذا كنت تعاني حالة طبية أو تتناول دواءً بانتظام أو لديك أعراض مقلقة أو كنتِ حاملًا أو مرضعة، فاستشر مختصًا صحيًا مؤهلًا قبل الصيام. توقف إذا شعرت بتوعك.';

  @override
  String get explore_sources => 'المصادر';

  @override
  String get explore_sourcesDesc => 'المحتوى مبسط من مراجع الصحة العامة أدناه.';

  @override
  String get explore_sourceError => 'تعذر فتح المصدر';

  @override
  String get explore_rules => 'قواعد مهمة';

  @override
  String get explore_rule1 => 'لا تتناول أطعمة تحتوي سعرات أثناء الصيام';

  @override
  String get explore_rule2 => 'اشرب الكثير من الماء والسوائل';

  @override
  String get explore_rule3 => 'تناول طعامًا متوازنًا في نافذة الأكل';

  @override
  String get explore_rule4 => 'توقف عن الصيام إذا شعرت بتوعك';

  @override
  String get explore_rule5 => 'ينبغي ألا تصوم الحوامل أو المرضعات';

  @override
  String get explore_rule6 => 'استشر طبيبك إذا كانت لديك حالات مزمنة';

  @override
  String get tip_water => 'حافظ على الترطيب';

  @override
  String get tip_waterDesc =>
      'اشرب الماء عند العطش وتناول السوائل مع الوجبات. تختلف الحاجة حسب الصحة والطقس والنشاط.';

  @override
  String get tip_food => 'تناول طعامًا صحيًا';

  @override
  String get tip_foodDesc =>
      'اختر في نوافذ الأكل أطعمة غنية بالبروتين والألياف والدهون الصحية. تجنب الأطعمة المصنعة.';

  @override
  String get tip_sleep => 'نم جيدًا';

  @override
  String get tip_sleepDesc =>
      'يدعم النوم المنتظم والكافي الصحة العامة. نظّم الصيام بحيث لا يعطل نومك.';

  @override
  String get tip_exercise => 'تمارين خفيفة';

  @override
  String get tip_exerciseDesc =>
      'يمكنك المشي الخفيف أو ممارسة اليوغا أثناء الصيام. تجنب التمارين الشديدة، خصوصًا في الأسابيع الأولى حتى يتكيف جسمك.';

  @override
  String get tip_drinks => 'المشروبات المسموحة';

  @override
  String get tip_drinksDesc =>
      'أثناء الصيام يمكنك شرب الماء والشاي السادة والقهوة السوداء (من دون سكر أو حليب). لن تقطع هذه المشروبات صيامك.';

  @override
  String get faq_drinks => 'ماذا يمكنني أن أشرب أثناء الصيام؟';

  @override
  String get faq_drinksAnswer =>
      'يمكنك شرب الماء والشاي السادة والقهوة السوداء (من دون سكر أو حليب). المشروبات ذات السعرات تقطع الصيام.';

  @override
  String get faq_plan => 'أي خطة صيام أختار؟';

  @override
  String get faq_planAnswer =>
      'إن كنت مبتدئًا فابدأ بـ12:12 أو 14:10. وإن كنت متمرسًا فجرب 16:8 أو 18:6. خطتا 20:4 وOMAD للمتقدمين.';

  @override
  String get faq_exercise => 'هل يمكنني ممارسة الرياضة أثناء الصيام؟';

  @override
  String get faq_exerciseAnswer =>
      'نعم، لكن تجنب التمارين الشديدة. المشي والكارديو الخفيف واليوغا مناسبة. اجعل تمارين الأوزان قرب نافذة الأكل.';

  @override
  String get faq_weight => 'هل يساعد الصيام على خسارة الوزن؟';

  @override
  String get faq_weightAnswer =>
      'قد يقلل تقييد وقت الأكل إجمالي الطاقة المتناولة لدى بعض الأشخاص. تختلف النتائج وما زالت الآثار طويلة المدى قيد الدراسة.';

  @override
  String get plan_12_desc => 'مستوى مبتدئ';

  @override
  String get plan_12_detail => 'مثالي للمبتدئين. صم 12 ساعة تشمل وقت نومك.';

  @override
  String get plan_16_desc => 'الخطة الأكثر شيوعًا';

  @override
  String get plan_16_detail =>
      'خطة الصيام المتقطع الأشهر. 16 ساعة صيام و8 ساعات أكل، عادة من الغداء إلى العشاء.';

  @override
  String get plan_18_desc => 'مستوى متوسط';

  @override
  String get plan_18_detail =>
      '18 ساعة صيام و6 ساعات أكل. مدة أطول لحرق الدهون.';

  @override
  String get plan_20_desc => 'مستوى متقدم';

  @override
  String get plan_20_detail =>
      '20 ساعة صيام و4 ساعات أكل. مناسبة للوصول إلى الكيتوزية والالتهام الذاتي.';

  @override
  String get plan_omad_desc => 'وجبة واحدة يوميًا';

  @override
  String get plan_omad_detail =>
      'وجبة واحدة يوميًا. 23 ساعة صيام وساعة واحدة للأكل. مستوى خبير.';

  @override
  String get plan_52_desc => 'يومان في الأسبوع';

  @override
  String get plan_52_detail =>
      'كُل بصورة طبيعية 5 أيام، ونحو 500 سعرة فقط في يومين. نهج بديل.';

  @override
  String get plan_ese_desc => 'صيام 24 ساعة';

  @override
  String get plan_ese_detail =>
      'صم 24 ساعة مرة أو مرتين أسبوعيًا. للمستخدمين المتقدمين.';

  @override
  String get plan_warrior_desc => 'حمية المحارب';

  @override
  String get plan_warrior_detail =>
      'تناول طعامًا خفيفًا نهارًا (فواكه وخضار)، واجعل وجبتك الرئيسية ضمن نافذة مسائية مدتها 4 ساعات.';

  @override
  String get award_first_title => 'الخطوة الأولى';

  @override
  String get award_first_desc => 'أكمل صيامك الأول';

  @override
  String get award_rhythm3_title => 'إيقاع 3 أيام';

  @override
  String get award_rhythm3_desc => 'حافظ على إيقاعك ثلاثة أيام';

  @override
  String get award_hours24_title => '24 ساعة';

  @override
  String get award_hours24_desc => 'صم 24 ساعة إجمالًا';

  @override
  String get award_week_title => 'إيقاع أسبوع';

  @override
  String get award_week_desc => 'أنشئ سلسلة سبعة أيام';

  @override
  String get award_fasts10_title => '10 مرات صيام';

  @override
  String get award_fasts10_desc => 'أكمل عشر مرات صيام';

  @override
  String get award_hours100_title => '100 ساعة';

  @override
  String get award_hours100_desc => 'بلغ 100 ساعة إجمالًا';

  @override
  String get award_rhythm30_title => 'إيقاع 30 يومًا';

  @override
  String get award_rhythm30_desc => 'أنشئ سلسلة ثلاثين يومًا';

  @override
  String get award_fasts50_title => '50 مرة صيام';

  @override
  String get award_fasts50_desc => 'أكمل خمسين مرة صيام';

  @override
  String get award_hours500_title => '500 ساعة';

  @override
  String get award_hours500_desc => 'بلغ 500 ساعة إجمالًا';

  @override
  String get award_fasts100_title => '100 مرة صيام';

  @override
  String get award_fasts100_desc => 'أكمل مئة مرة صيام';

  @override
  String get award_rhythm90_title => 'إيقاع 90 يومًا';

  @override
  String get award_rhythm90_desc => 'أنشئ سلسلة تسعين يومًا';

  @override
  String get award_year_title => 'رحلة عام';

  @override
  String get award_year_desc => 'بلغ إيقاع 365 يومًا';

  @override
  String get awards_loadError => 'تعذر تحميل التقدم';

  @override
  String get awards_journeyComplete => 'اكتملت الرحلة';

  @override
  String get awards_nextGoal => 'الهدف التالي';

  @override
  String get awards_allYours => 'كل الإنجازات لك';

  @override
  String get awards_dayStreak => 'أيام متتالية';

  @override
  String get awards_fasts => 'مرات صيام';

  @override
  String get awards_total => 'الإجمالي';

  @override
  String get awards_stageStart => 'البداية';

  @override
  String get awards_stageRhythm => 'الإيقاع';

  @override
  String get awards_stageEndurance => 'التحمل';

  @override
  String get awards_stageMastery => 'الإتقان';

  @override
  String get awards_completed => 'مكتمل';

  @override
  String awards_fastsRemaining(int count) {
    return 'تبقى $count من مرات الصيام';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'تبقى $count أيام';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'تبقى $count ساعات';
  }

  @override
  String get common_retry => 'إعادة المحاولة';

  @override
  String get game_title => 'مركز التقدم';

  @override
  String get game_quests => 'مهام اليوم';

  @override
  String get game_questsDesc => 'خطوات صغيرة، وإيقاع مستدام.';

  @override
  String get game_season => 'موسم من 30 خطوة';

  @override
  String get game_seasonDesc => 'ختم قابل للجمع كل خمس خطوات.';

  @override
  String get game_badges => 'مجموعة الشارات';

  @override
  String game_shields(int count) {
    return '$count من دروع الإيقاع';
  }

  @override
  String get game_shieldsDesc =>
      'تُكتسب كل سبع عمليات إكمال. لا يمحو يوم فائت تقدمك أبدًا.';

  @override
  String get game_league => 'دوري أسبوعي خاص';

  @override
  String game_leagueDesc(int percent) {
    return 'درجة إيقاعك في المئين $percent ضمن نموذج محلي خاص. لا يُصنف الوزن أو الصيام المفرط أبدًا.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'المستوى $level، $xp نقطة خبرة';
  }

  @override
  String get game_explorer => 'مستكشف الإيقاع';

  @override
  String get game_streak => 'السلسلة';

  @override
  String get game_targets => 'الأهداف';

  @override
  String get game_best => 'الأفضل';

  @override
  String get quest_rhythm => 'ابنِ إيقاع اليوم';

  @override
  String get quest_hydrate => 'بلغ نصف هدف الماء';

  @override
  String get quest_steady => 'احمِ سلسلتك';

  @override
  String get badge_first_title => 'الخطوة الأولى';

  @override
  String get badge_first_desc => 'سجّل صيامك الأول';

  @override
  String get badge_rhythm7_title => 'حارس الإيقاع';

  @override
  String get badge_rhythm7_desc => 'بلغ سلسلة 7 أيام';

  @override
  String get badge_rhythm3_title => 'إيقاع ثلاثة أيام';

  @override
  String get badge_rhythm3_desc => 'بلغ سلسلة 3 أيام';

  @override
  String get badge_target1_title => 'الهدف الأول';

  @override
  String get badge_target1_desc => 'أكمل صيامك المستهدف الأول';

  @override
  String get badge_target3_title => 'ثلاث خطوات';

  @override
  String get badge_target3_desc => 'أكمل 3 أهداف';

  @override
  String get badge_water_title => 'متوازن';

  @override
  String get badge_water_desc => 'أكمل هدف الماء اليومي';

  @override
  String get badge_support_title => 'واعي بذاتك';

  @override
  String get badge_support_desc => 'استخدم وضع الدعم';

  @override
  String get badge_hours10_title => '10 ساعات';

  @override
  String get badge_hours10_desc => 'سجّل 10 ساعات إجمالًا';

  @override
  String get badge_target10_title => 'عشرة أقوياء';

  @override
  String get badge_target10_desc => 'أكمل 10 أهداف';

  @override
  String get badge_target20_title => 'عشرون هدفًا';

  @override
  String get badge_target20_desc => 'أكمل 20 هدفًا';

  @override
  String get badge_fast16_title => '16 ساعة';

  @override
  String get badge_fast16_desc => 'بلغ 16 ساعة في صيام واحد';

  @override
  String get badge_hours50_title => '50 ساعة';

  @override
  String get badge_hours50_desc => 'سجّل 50 ساعة إجمالًا';

  @override
  String get badge_hours100_title => 'مئة ساعة';

  @override
  String get badge_hours100_desc => 'سجّل 100 ساعة إجمالًا';

  @override
  String get badge_target30_title => 'ثلاثون هدفًا';

  @override
  String get badge_target30_desc => 'أكمل 30 هدفًا';

  @override
  String get badge_rhythm30_title => 'إيقاع 30 يومًا';

  @override
  String get badge_rhythm30_desc => 'بلغ سلسلة 30 يومًا';

  @override
  String get paywall_restoreSuccess => 'تمت استعادة المشتريات!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'تقدم الصيام $percent بالمئة';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hourس';
  }

  @override
  String get paywall_lifetime => 'مدى الحياة';

  @override
  String get paywall_once => 'دفعة واحدة';

  @override
  String get paywall_processing => 'جارٍ المعالجة…';

  @override
  String get paywall_continue => 'متابعة';

  @override
  String get paywall_productsUnavailable =>
      'المشتريات غير متاحة الآن. حاول لاحقًا.';

  @override
  String get paywall_purchaseFailed => 'تعذر إكمال عملية الشراء.';

  @override
  String get paywall_nothingToRestore => 'لم يُعثر على شراء سابق.';

  @override
  String get paywall_restoreFailed => 'تعذرت استعادة المشتريات.';

  @override
  String get paywall_terms => 'شروط الاستخدام';

  @override
  String get permission_notificationDesc =>
      'تذكيرات الصيام وتحديثات المراحل وإشعارات الإكمال';

  @override
  String get profile_privacyChoices => 'خيارات الخصوصية';

  @override
  String get paywall_autoRenewInfo =>
      'تتجدد الاشتراكات تلقائيًا ما لم تُلغَ قبل نهاية الفترة بـ24 ساعة على الأقل. يمكنك إدارتها أو إلغاؤها في إعدادات App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / شهر';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'وفّر $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'تجربة مجانية لمدة $days أيام';
  }

  @override
  String get paywall_startFreeTrial => 'بدء التجربة المجانية';

  @override
  String get paywall_retry => 'إعادة المحاولة';

  @override
  String get paywall_alreadyOwned =>
      'أنت تملك هذا الاشتراك بالفعل. اضغط «استعادة المشتريات».';

  @override
  String get paywall_storeUnavailable =>
      'يتعذر الوصول إلى المتجر الآن. تحقق من اتصالك وحاول مجددًا.';

  @override
  String get paywall_secureNote =>
      'يمكنك الإلغاء في أي وقت. تُحمّل الدفعة على حساب المتجر.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'تتجدد الاشتراكات تلقائيًا ما لم تُلغَ قبل نهاية الفترة بـ24 ساعة على الأقل. يمكنك إدارتها أو إلغاؤها في Google Play > الاشتراكات.';

  @override
  String get paywall_allPlansDesc =>
      'يفتح 18:6 و20:4 وOMAD و5:2 وEat-Stop-Eat وWarrior';

  @override
  String get paywall_noAdsDesc =>
      'تُوقف إعلانات البانر والإعلانات البينية تمامًا';

  @override
  String get foodScan_title => 'مسح الطعام بالذكاء الاصطناعي';

  @override
  String get foodScan_scanCta => 'مسح الوجبة';

  @override
  String get foodScan_scanCtaDesc =>
      'صوّر طبقك واحصل على السعرات والمغذيات الكبرى';

  @override
  String get foodScan_introTitle => 'صوّر طبقك';

  @override
  String get foodScan_introDesc =>
      'يقرأ الذكاء الاصطناعي الصورة ويقدّر السعرات والبروتين والكربوهيدرات والدهون.';

  @override
  String get foodScan_tipLight => 'الإضاءة الجيدة والمتساوية تعطي تقديرًا أفضل';

  @override
  String get foodScan_tipFrame => 'ضع الطبق كاملًا داخل الإطار';

  @override
  String get foodScan_tipScale =>
      'أظهر أدوات المائدة أو يدًا للمساعدة في تقدير الحصص';

  @override
  String get foodScan_takePhoto => 'التقاط صورة';

  @override
  String get foodScan_chooseFromGallery => 'اختيار من المعرض';

  @override
  String foodScan_scansLeft(int count) {
    return 'تبقى $count عمليات مسح اليوم';
  }

  @override
  String get foodScan_quotaReached => 'استخدمت عمليات مسح اليوم. حاول غدًا.';

  @override
  String get foodScan_privacyNote =>
      'تُرسل الصورة إلى واجهة Gemini من Google للتحليل ولا تُخزن على خوادمنا.';

  @override
  String get foodScan_consentTitle => 'هل تريد إرسال الصور إلى Google Gemini؟';

  @override
  String get foodScan_consentBody =>
      'لتقدير السعرات الحرارية والعناصر الغذائية، تُرسل كل صورة وجبة تلتقطها أو تختارها إلى خدمة Gemini للذكاء الاصطناعي من Google. تُستخدم الصورة لهذا التحليل فقط ولا تُخزَّن على خوادمنا.';

  @override
  String get foodScan_consentAgree => 'موافق ومتابعة';

  @override
  String get foodScan_analyzing => 'جارٍ تحليل وجبتك…';

  @override
  String get foodScan_analyzingHint => 'يستغرق ذلك عادة بضع ثوانٍ';

  @override
  String get foodScan_detectedItems => 'العناصر المكتشفة';

  @override
  String get foodScan_disclaimer =>
      'تقديرات الذكاء الاصطناعي تقريبية. اضغط عنصرًا لتصحيحه.';

  @override
  String get foodScan_lowConfidence =>
      'النموذج غير واثق من هذه الصورة. تحقق من الأرقام قبل الحفظ.';

  @override
  String get foodScan_save => 'إضافة إلى الوجبات';

  @override
  String get foodScan_retake => 'صورة جديدة';

  @override
  String get foodScan_retry => 'إعادة المحاولة';

  @override
  String get foodScan_editItem => 'تعديل العنصر';

  @override
  String get foodScan_portion => 'الحصة';

  @override
  String get foodScan_saveEdit => 'حفظ';

  @override
  String get foodScan_premiumTitle => 'ميزة Premium';

  @override
  String get foodScan_premiumDesc => 'تحليل السعرات من الصور مشمول في Premium.';

  @override
  String get foodScan_upgrade => 'عرض Premium';

  @override
  String get foodScan_errorNetwork =>
      'لا يوجد اتصال. تحقق من الإنترنت وحاول مجددًا.';

  @override
  String get foodScan_errorRateLimited =>
      'عمليات المسح كثيرة الآن. حاول بعد بضع دقائق.';

  @override
  String get foodScan_errorUnavailable => 'تحليل الصور غير متاح الآن.';

  @override
  String get foodScan_errorServer => 'تواجه خدمة التحليل مشكلة. حاول بعد قليل.';

  @override
  String get foodScan_errorNoFood =>
      'لم يُعثر على طعام في الصورة. التقط صورة أوضح للطبق.';

  @override
  String get foodScan_errorUnreadable =>
      'تعذر تحليل هذه الصورة. جرّب صورة أخرى.';

  @override
  String get paywall_aiFoodScan => 'مسح الطعام بالذكاء الاصطناعي';

  @override
  String get paywall_aiFoodScanDesc =>
      'صوّر وجبة وسجّل سعراتها ومغذياتها الكبرى خلال ثوانٍ';
}
