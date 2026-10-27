// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'สวัสดีตอนเช้า';

  @override
  String get greeting_afternoon => 'สวัสดีตอนบ่าย';

  @override
  String get greeting_evening => 'สวัสดีตอนเย็น';

  @override
  String get tab_timer => 'หน้าหลัก';

  @override
  String get tab_explore => 'สำรวจ';

  @override
  String get tab_stats => 'รายงาน';

  @override
  String get tab_meals => 'มื้ออาหาร';

  @override
  String get tab_achievements => 'ความสำเร็จ';

  @override
  String get tab_profile => 'บัญชี';

  @override
  String get timer_fasting => 'เวลาการอดอาหาร';

  @override
  String get timer_remaining => 'เหลือเวลา';

  @override
  String get timer_elapsed => 'เวลาที่ผ่านไป';

  @override
  String get timer_start => 'เริ่ม';

  @override
  String get timer_stop => 'หยุด';

  @override
  String get timer_completed => 'ยินดีด้วย!';

  @override
  String get timer_completedMessage => 'คุณอดอาหารสำเร็จแล้ว!';

  @override
  String get timer_selectPlan => 'เลือกแผนอดอาหาร';

  @override
  String get timer_stopConfirm =>
      'คุณแน่ใจหรือไม่ว่าต้องการจบการอดอาหารก่อนเวลา?';

  @override
  String get timer_stopTitle => 'จบการอดอาหาร';

  @override
  String get timer_cancel => 'ยกเลิก';

  @override
  String get timer_confirmStop => 'ใช่ จบเลย';

  @override
  String get phase_anabolic => 'ระยะแอนาบอลิก';

  @override
  String get phase_anabolicDesc => 'กำลังย่อยอาหาร';

  @override
  String get phase_catabolic => 'ระยะแคแทบอลิก';

  @override
  String get phase_catabolicDesc => 'กำลังเปลี่ยนแหล่งพลังงาน';

  @override
  String get phase_fatBurning => 'เผาผลาญไขมัน';

  @override
  String get phase_fatBurningDesc => 'เริ่มเผาผลาญไขมันแล้ว';

  @override
  String get phase_ketosis => 'ภาวะคีโตซิส';

  @override
  String get phase_ketosisDesc => 'กำลังสร้างคีโตน';

  @override
  String get phase_autophagy => 'ออโตฟาจี';

  @override
  String get phase_autophagyDesc => 'การฟื้นฟูเซลล์';

  @override
  String get stats_title => 'สถิติ';

  @override
  String get stats_week => 'สัปดาห์';

  @override
  String get stats_month => 'เดือน';

  @override
  String get stats_year => 'ปี';

  @override
  String get stats_totalFasts => 'จำนวนการอดอาหารทั้งหมด';

  @override
  String get stats_average => 'เฉลี่ย';

  @override
  String get stats_fastDuration => 'ระยะเวลาอดอาหาร';

  @override
  String get stats_streak => 'สถิติต่อเนื่อง';

  @override
  String get stats_daysConsecutive => 'วันต่อเนื่อง';

  @override
  String get stats_success => 'สำเร็จ';

  @override
  String get stats_completion => 'การทำสำเร็จ';

  @override
  String get stats_weeklyFasting => 'การอดอาหารรายสัปดาห์';

  @override
  String get stats_monthlyView => 'มุมมองรายเดือน';

  @override
  String get stats_weightChange => 'การเปลี่ยนแปลงน้ำหนัก';

  @override
  String get heatmap_none => 'ไม่มี';

  @override
  String get heatmap_low => 'น้อย';

  @override
  String get heatmap_good => 'ดี';

  @override
  String get heatmap_full => 'เต็ม';

  @override
  String get meals_title => 'วางแผนมื้ออาหาร';

  @override
  String get meals_eatingWindow => 'ช่วงรับประทานอาหาร';

  @override
  String get meals_windowOpen => 'เปิด';

  @override
  String get meals_windowFasting => 'กำลังอดอาหาร';

  @override
  String get meals_calories => 'แคลอรี';

  @override
  String get meals_protein => 'โปรตีน';

  @override
  String get meals_carbs => 'คาร์โบไฮเดรต';

  @override
  String get meals_fat => 'ไขมัน';

  @override
  String get meals_todayMeals => 'มื้ออาหารวันนี้';

  @override
  String get meals_noMeals => 'ยังไม่ได้เพิ่มมื้ออาหาร';

  @override
  String get meals_breakfastSuggestions => 'คำแนะนำสำหรับมื้อเปิดการอดอาหาร';

  @override
  String get meals_addMeal => 'เพิ่มมื้ออาหาร';

  @override
  String get profile_title => 'โปรไฟล์';

  @override
  String get profile_user => 'ผู้ใช้';

  @override
  String profile_planActive(String plan) {
    return 'แผน $plan ทำงานอยู่';
  }

  @override
  String get profile_upgradePremium => 'อัปเกรดเป็น Premium';

  @override
  String get profile_premiumDesc => 'ทุกแผนอดอาหารโดยไม่มีโฆษณา';

  @override
  String get profile_bodyMetrics => 'ข้อมูลร่างกาย';

  @override
  String get profile_height => 'ส่วนสูง';

  @override
  String get profile_weight => 'น้ำหนัก';

  @override
  String get profile_targetWeight => 'น้ำหนักเป้าหมาย';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'การตั้งค่า';

  @override
  String get profile_notifications => 'การแจ้งเตือน';

  @override
  String get profile_darkTheme => 'ธีมมืด';

  @override
  String get profile_waterReminder => 'เตือนดื่มน้ำ';

  @override
  String get profile_phaseNotifications => 'การแจ้งเตือนระยะ';

  @override
  String get profile_language => 'ภาษา';

  @override
  String get profile_about => 'เกี่ยวกับ';

  @override
  String get profile_rateApp => 'ให้คะแนนแอป';

  @override
  String get profile_share => 'แชร์';

  @override
  String get profile_privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get profile_version => 'เวอร์ชัน';

  @override
  String get onboarding_welcome => 'ยินดีต้อนรับ';

  @override
  String get onboarding_welcomeDesc =>
      'ควบคุมเส้นทาง\nการอดอาหารเป็นช่วงของคุณ';

  @override
  String get onboarding_featureTimer => 'ตัวจับเวลาอดอาหารอัจฉริยะ';

  @override
  String get onboarding_featureStats => 'สถิติและกราฟโดยละเอียด';

  @override
  String get onboarding_featureMeals => 'วางแผนมื้ออาหารและแนะนำสูตรอาหาร';

  @override
  String get onboarding_getStarted => 'เริ่มต้นใช้งาน';

  @override
  String get onboarding_selectGoal => 'เป้าหมายของคุณคืออะไร?';

  @override
  String get onboarding_selectGoalDesc => 'เลือกได้หลายข้อ';

  @override
  String get onboarding_goalWeight => 'ลดน้ำหนัก';

  @override
  String get onboarding_goalWeightDesc => 'ลดน้ำหนักอย่างมีสุขภาพดี';

  @override
  String get onboarding_goalHealth => 'พัฒนาสุขภาพ';

  @override
  String get onboarding_goalHealthDesc => 'สุขภาพโดยรวมและภูมิคุ้มกัน';

  @override
  String get onboarding_goalEnergy => 'เพิ่มพลังงาน';

  @override
  String get onboarding_goalEnergyDesc => 'มีพลังงานตลอดวัน';

  @override
  String get onboarding_goalMental => 'ความคิดปลอดโปร่ง';

  @override
  String get onboarding_goalMentalDesc => 'สมาธิและความชัดเจน';

  @override
  String get onboarding_goalLongevity => 'อายุยืน';

  @override
  String get onboarding_goalLongevityDesc => 'ฟื้นฟูเซลล์และสูงวัยอย่างแข็งแรง';

  @override
  String get onboarding_goalDiscipline => 'วินัย';

  @override
  String get onboarding_goalDisciplineDesc => 'สร้างวินัยในตนเอง';

  @override
  String get onboarding_selectPlan => 'เลือกแผนของคุณ';

  @override
  String get onboarding_selectPlanDesc => 'เลือกแผนอดอาหารที่เหมาะกับคุณที่สุด';

  @override
  String get onboarding_bodyInfo => 'กรอกข้อมูลของคุณ';

  @override
  String get onboarding_bodyInfoDesc => 'เพื่อรับคำแนะนำเฉพาะบุคคล';

  @override
  String get onboarding_gender => 'เพศ';

  @override
  String get onboarding_male => 'ชาย';

  @override
  String get onboarding_female => 'หญิง';

  @override
  String get onboarding_age => 'อายุ';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'ข้อมูลนี้เก็บไว้บนอุปกรณ์ของคุณเท่านั้นและใช้คำนวณแคลอรี';

  @override
  String get onboarding_permissions => 'ขั้นตอนสุดท้าย';

  @override
  String get onboarding_permissionsDesc =>
      'เปิดสิทธิ์เพื่อประสบการณ์ที่ดีที่สุด';

  @override
  String get onboarding_next => 'ดำเนินการต่อ';

  @override
  String get onboarding_start => 'เริ่มกันเลย!';

  @override
  String get onboarding_skipForNow => 'ตั้งค่าภายหลัง';

  @override
  String get waterAdded => 'เพิ่มน้ำ 250 มล. แล้ว';

  @override
  String get languageSelect => 'เลือกภาษา';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'อัปเกรดเป็น Premium';

  @override
  String get paywall_subtitle => 'ปลดล็อกทุกแผนอดอาหารและนำโฆษณาออก';

  @override
  String get paywall_allPlans => 'ทุกแผนอดอาหาร';

  @override
  String get paywall_advancedStats => 'สถิติขั้นสูง';

  @override
  String get paywall_mealPlanner => 'วางแผนมื้ออาหาร';

  @override
  String get paywall_themes => 'ปรับแต่งธีม';

  @override
  String get paywall_noAds => 'ไม่มีโฆษณา';

  @override
  String get paywall_weekly => 'รายสัปดาห์';

  @override
  String get paywall_monthly => 'รายเดือน';

  @override
  String get paywall_yearly => 'รายปี';

  @override
  String get paywall_bestValue => 'คุ้มค่าที่สุด';

  @override
  String get paywall_freeTrial => 'ทดลองใช้ฟรี (3 วัน)';

  @override
  String get paywall_restore => 'กู้คืนการซื้อ';

  @override
  String get paywall_premiumActive => 'Premium เปิดใช้งานอยู่!';

  @override
  String get paywall_premiumActiveDesc => 'ปลดล็อกทุกแผนอดอาหารและปิดโฆษณาแล้ว';

  @override
  String get water_title => 'ปริมาณน้ำ';

  @override
  String get water_addWater => 'เพิ่มน้ำ';

  @override
  String get water_goal => 'เป้าหมาย';

  @override
  String get water_ml => 'มล.';

  @override
  String get common_ok => 'ตกลง';

  @override
  String get common_cancel => 'ยกเลิก';

  @override
  String get common_save => 'บันทึก';

  @override
  String get common_delete => 'ลบ';

  @override
  String get common_hours => 'ชั่วโมง';

  @override
  String get common_minutes => 'นาที';

  @override
  String get common_days => 'วัน';

  @override
  String get common_enable => 'เปิดใช้งาน';

  @override
  String get streakCard_currentStreak => 'สถิติต่อเนื่องปัจจุบัน';

  @override
  String get streakCard_longestStreak => 'สถิติต่อเนื่องยาวนานที่สุด';

  @override
  String get streakCard_totalSessions => 'จำนวนการอดอาหารทั้งหมด';

  @override
  String get meals_mealType => 'ประเภทมื้ออาหาร';

  @override
  String get meals_breakfast => 'อาหารเช้า';

  @override
  String get meals_lunch => 'อาหารกลางวัน';

  @override
  String get meals_dinner => 'อาหารเย็น';

  @override
  String get meals_snack => 'ของว่าง';

  @override
  String get meals_carbohydrate => 'คาร์โบไฮเดรต';

  @override
  String get meals_add => 'เพิ่ม';

  @override
  String get meals_mealName => 'ชื่อมื้ออาหาร';

  @override
  String get bodyMetrics_title => 'ข้อมูลร่างกาย';

  @override
  String get bodyMetrics_weight => 'น้ำหนัก';

  @override
  String get bodyMetrics_target => 'เป้าหมาย';

  @override
  String get bodyMetrics_save => 'บันทึก';

  @override
  String get bodyMetrics_history => 'ประวัติ';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'ยังไม่มีข้อมูล';

  @override
  String get meals_quickAdd => 'เพิ่มด่วน';

  @override
  String get meals_manualEntry => 'กรอกด้วยตนเอง';

  @override
  String meals_added(String name) {
    return 'เพิ่ม $name แล้ว';
  }

  @override
  String get meals_nameCalorieRequired => 'ต้องระบุชื่อและแคลอรี';

  @override
  String get bodyMetrics_addWeight => 'เพิ่มน้ำหนัก';

  @override
  String get bodyMetrics_hintWeight => 'เช่น 74.5';

  @override
  String get bodyMetrics_invalidWeight => 'กรอกน้ำหนักที่ถูกต้อง';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'บันทึก $value กก. แล้ว';
  }

  @override
  String get completion_duration => 'ระยะเวลา';

  @override
  String get completion_plan => 'แผน';

  @override
  String get completion_lastPhase => 'ระยะสุดท้าย';

  @override
  String get completion_earlyTitle => 'สิ้นสุดการอดอาหารแล้ว';

  @override
  String get completion_earlyMessage =>
      'บันทึกระยะเวลาของวันนี้แล้ว สถิติต่อเนื่องและความคืบหน้าของความสำเร็จไม่เปลี่ยนแปลง เนื่องจากยังไม่บรรลุเป้าหมาย';

  @override
  String get timer_remainingTime => 'เวลาที่เหลือ';

  @override
  String get timer_ready => 'พร้อมเริ่ม';

  @override
  String get streak_status => 'สถานะ';

  @override
  String get streak_startToday => 'เริ่มวันนี้!';

  @override
  String get streak_goodStart => 'เริ่มต้นได้ดี!';

  @override
  String get streak_goingGreat => 'ทำได้ดีมาก!';

  @override
  String get streak_superb => 'ยอดเยี่ยม!';

  @override
  String get streak_legendary => 'ระดับตำนาน!';

  @override
  String get streak_incredible => 'น่าทึ่ง!';

  @override
  String get weight_noRecord =>
      'ยังไม่มีบันทึกน้ำหนัก\nเพิ่มจาก โปรไฟล์ > ข้อมูลร่างกาย';

  @override
  String get day_mon => 'จ.';

  @override
  String get day_tue => 'อ.';

  @override
  String get day_wed => 'พ.';

  @override
  String get day_thu => 'พฤ.';

  @override
  String get day_fri => 'ศ.';

  @override
  String get day_sat => 'ส.';

  @override
  String get day_sun => 'อา.';

  @override
  String get day_short_mon => 'จ';

  @override
  String get day_short_tue => 'อ';

  @override
  String get day_short_wed => 'พ';

  @override
  String get day_short_thu => 'พฤ';

  @override
  String get day_short_fri => 'ศ';

  @override
  String get day_short_sat => 'ส';

  @override
  String get day_short_sun => 'อา';

  @override
  String get month_jan => 'มกราคม';

  @override
  String get month_feb => 'กุมภาพันธ์';

  @override
  String get month_mar => 'มีนาคม';

  @override
  String get month_apr => 'เมษายน';

  @override
  String get month_may => 'พฤษภาคม';

  @override
  String get month_jun => 'มิถุนายน';

  @override
  String get month_jul => 'กรกฎาคม';

  @override
  String get month_aug => 'สิงหาคม';

  @override
  String get month_sep => 'กันยายน';

  @override
  String get month_oct => 'ตุลาคม';

  @override
  String get month_nov => 'พฤศจิกายน';

  @override
  String get month_dec => 'ธันวาคม';

  @override
  String meals_fastingWindow(String hours) {
    return 'อดอาหาร ($hours ชม.)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'รับประทานอาหาร ($hours ชม.)';
  }

  @override
  String get recipe_oatSmoothie => 'สมูททีข้าวโอ๊ต';

  @override
  String get recipe_avocadoToast => 'ขนมปังปิ้งอะโวคาโด';

  @override
  String get recipe_yogurtBowl => 'โยเกิร์ตโบวล์';

  @override
  String get elapsed_time => 'เวลาที่ผ่านไป';

  @override
  String get fast_ends_on => 'การอดอาหารสิ้นสุดเวลา';

  @override
  String get end_fasting => 'จบการอดอาหาร';

  @override
  String get start_fasting => 'เริ่มอดอาหาร';

  @override
  String get water_tracker => 'ติดตามการดื่มน้ำ';

  @override
  String get weight_tracker => 'ติดตามน้ำหนัก';

  @override
  String get drink => 'ดื่ม';

  @override
  String get log_weight => 'บันทึกน้ำหนัก';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'น้ำหนักที่ลดลง';

  @override
  String get current_weight => 'น้ำหนักปัจจุบัน';

  @override
  String get goal_weight => 'น้ำหนักเป้าหมาย';

  @override
  String get daily_goal => 'เป้าหมายรายวัน';

  @override
  String completed_percent(String percent) {
    return 'สำเร็จ $percent%';
  }

  @override
  String get explore => 'สำรวจ';

  @override
  String get achievements => 'ความสำเร็จ';

  @override
  String get profile_theme => 'รูปลักษณ์';

  @override
  String get theme_select => 'เลือกรูปลักษณ์';

  @override
  String get theme_system => 'ค่าเริ่มต้นของระบบ';

  @override
  String get theme_light => 'สว่าง';

  @override
  String get theme_dark => 'มืด';

  @override
  String get language_system => 'ภาษาของระบบ';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'เสียงเมื่อเสร็จสิ้น';

  @override
  String get profile_calmGamification => 'เกมมิฟิเคชันแบบผ่อนคลาย';

  @override
  String get profile_calmGamificationDesc => 'ลดแรงกดดันจากลีกและฤดูกาล';

  @override
  String get profile_editName => 'แก้ไขชื่อของคุณ';

  @override
  String get profile_name => 'ชื่อ';

  @override
  String get circle_title => 'วงสนับสนุนการอดอาหาร';

  @override
  String get circle_you => 'คุณ';

  @override
  String get circle_tagline => 'ไปด้วยกันโดยไม่กดดัน';

  @override
  String get circle_privacy =>
      'น้ำหนักและข้อมูลส่วนตัวจะถูกซ่อน แสดงเฉพาะความคืบหน้าและการสนับสนุน';

  @override
  String circle_sendSupport(int count) {
    return 'ส่งกำลังใจ · $count';
  }

  @override
  String get circle_inviteCopied => 'คัดลอกรหัสเชิญแล้ว';

  @override
  String get circle_createInvite => 'สร้างคำเชิญส่วนตัว';

  @override
  String get crisis_nameTitle => 'ก่อนอื่น ลองบอกว่าสิ่งที่เกิดขึ้นคืออะไร';

  @override
  String get crisis_nameDesc => 'อาจเป็นความหิว ความเคยชิน หรืออารมณ์';

  @override
  String get crisis_waterTitle => 'ดื่มน้ำหนึ่งแก้ว';

  @override
  String get crisis_waterDesc => 'จากนั้นหายใจช้า ๆ สามครั้ง';

  @override
  String get crisis_delayTitle => 'เลื่อนการตัดสินใจออกไป 10 นาที';

  @override
  String get crisis_delayDesc =>
      'หากรู้สึกไม่สบาย การจบการอดอาหารไม่ใช่ความล้มเหลว';

  @override
  String get crisis_hunger => 'ความหิว';

  @override
  String get crisis_habit => 'ความเคยชิน';

  @override
  String get crisis_stress => 'ความเครียด';

  @override
  String get crisis_tenMore => 'ให้เวลาอีก 10 นาที';

  @override
  String get stats_storyEmpty =>
      'การอดอาหารครั้งแรกจะเริ่มเรื่องราวส่วนตัวของคุณ';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'ช่วงนี้คุณอดอาหาร $sessions ครั้ง รักษาจังหวะได้ $hours ชั่วโมง และมีอัตราความสำเร็จ $rate%';
  }

  @override
  String get stats_storyTitle => 'เรื่องราวของจังหวะคุณ';

  @override
  String get home_todayRhythm => 'จังหวะวันนี้';

  @override
  String get home_finalHourSupport => 'กำลังใจในชั่วโมงสุดท้าย';

  @override
  String get home_needSupport => 'ฉันต้องการกำลังใจเล็กน้อย';

  @override
  String get home_todaySummary => 'ภาพรวมวันนี้';

  @override
  String get home_dayStreak => 'วันต่อเนื่อง';

  @override
  String home_weightGoal(String weight) {
    return 'เป้าหมาย $weight กก.';
  }

  @override
  String get weather_steady => 'จังหวะของคุณคงที่';

  @override
  String get weather_gentle => 'วันที่สบาย ๆ';

  @override
  String get weather_water => 'น้ำหนึ่งแก้วอาจช่วยได้';

  @override
  String get weather_listen => 'คุณมาไกลแล้ว รับฟังร่างกายของคุณ';

  @override
  String get weather_onPlan => 'จังหวะวันนี้ตรงกับแผนของคุณ';

  @override
  String get weather_challenging =>
      'ชั่วโมงนี้เคยท้าทายมาก่อน โหมดสนับสนุนพร้อมแล้ว';

  @override
  String get replay_copied => 'คัดลอกสรุปการอดอาหารแล้ว';

  @override
  String get replay_button => 'ดูย้อนหลัง';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'ฉันทำการอดอาหาร $plan สำเร็จใน $hoursชม. $minutesนาที · $phase';
  }

  @override
  String get journey_label => 'เส้นทางการเผาผลาญ';

  @override
  String get journey_now => 'ตอนนี้';

  @override
  String journey_next(String time, String phase) {
    return 'อีก $time ถึง $phase';
  }

  @override
  String get phase_estimateShort =>
      'เวลาของแต่ละระยะเป็นเพียงค่าประมาณทั่วไป ไม่ใช่การวัดทางการแพทย์';

  @override
  String phase_hours(int start, int end) {
    return 'ชั่วโมง $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'เวลานี้เป็นเพียงค่าประมาณทั่วไป การตอบสนองด้านการเผาผลาญอาจแตกต่างกันในแต่ละคน';

  @override
  String get bmi_underweight => 'น้ำหนักต่ำกว่าเกณฑ์';

  @override
  String get bmi_normal => 'ปกติ';

  @override
  String get bmi_overweight => 'น้ำหนักเกิน';

  @override
  String get bmi_obese => 'โรคอ้วน';

  @override
  String get notification_halfwayTitle => 'ถึงครึ่งทางแล้ว! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'คุณทำการอดอาหาร $plan สำเร็จครึ่งหนึ่งแล้ว สู้ต่อไป!';
  }

  @override
  String get notification_phaseCatabolic => 'เข้าสู่ระยะแคแทบอลิกแล้ว 📉';

  @override
  String get notification_phaseFatBurning => 'เริ่มเผาผลาญไขมันแล้ว! 🔥';

  @override
  String get notification_phaseKetosis => 'คุณอยู่ในภาวะคีโตซิส ⚡';

  @override
  String get notification_phaseAutophagy => 'ออโตฟาจีกำลังทำงาน! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'คุณทำการอดอาหาร $plan สำเร็จแล้ว! ช่วงรับประทานอาหารเปิดแล้ว';
  }

  @override
  String get notification_waterTitle => 'ดื่มน้ำ 💧';

  @override
  String get notification_waterBody =>
      'อย่าลืมดื่มน้ำให้เพียงพอระหว่างอดอาหาร!';

  @override
  String get notification_windowTitle => 'ช่วงรับประทานอาหารใกล้สิ้นสุด ⏰';

  @override
  String get notification_windowBody => 'ช่วงรับประทานอาหารจะสิ้นสุดใน 30 นาที';

  @override
  String notification_streakTitle(int days) {
    return 'ต่อเนื่อง $days วัน! 🔥';
  }

  @override
  String get notification_streakBody => 'คุณทำได้ดีมาก! ทำต่อในวันนี้';

  @override
  String notification_ongoingTitle(String phase) {
    return 'กำลังอดอาหาร - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'เหลือ: $time';
  }

  @override
  String notification_started(String plan) {
    return 'เริ่มอดอาหาร - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'เป้าหมาย: $hours ชั่วโมง';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hoursชม. $minutesนาที';
  }

  @override
  String get explore_guide => 'คู่มือการอดอาหาร';

  @override
  String get explore_guideDesc => 'ทุกสิ่งที่ควรรู้เกี่ยวกับการอดอาหารเป็นช่วง';

  @override
  String get explore_circleDesc =>
      'แบ่งปันกำลังใจอย่างสงบกับกลุ่มส่วนตัวของคุณ';

  @override
  String get explore_faq => 'คำถามที่พบบ่อย';

  @override
  String get explore_education =>
      'เนื้อหานี้มีไว้เพื่อให้ความรู้ทั่วไปเท่านั้น ไม่ใช่การวินิจฉัยหรือคำแนะนำการรักษาทางการแพทย์';

  @override
  String get explore_safety => 'สุขภาพและความปลอดภัย';

  @override
  String get explore_safetyDesc =>
      'หากคุณมีโรคประจำตัว ใช้ยาเป็นประจำ มีอาการน่ากังวล กำลังตั้งครรภ์หรือให้นมบุตร โปรดปรึกษาผู้เชี่ยวชาญด้านสุขภาพก่อนอดอาหาร และหยุดหากรู้สึกไม่สบาย';

  @override
  String get explore_sources => 'แหล่งข้อมูล';

  @override
  String get explore_sourcesDesc =>
      'เนื้อหาถูกเรียบเรียงให้ง่ายขึ้นจากแหล่งข้อมูลสาธารณสุขด้านล่าง';

  @override
  String get explore_sourceError => 'ไม่สามารถเปิดแหล่งข้อมูลได้';

  @override
  String get explore_rules => 'กฎสำคัญ';

  @override
  String get explore_rule1 => 'อย่ารับประทานอาหารที่มีแคลอรีระหว่างอดอาหาร';

  @override
  String get explore_rule2 => 'ดื่มน้ำและของเหลวให้เพียงพอ';

  @override
  String get explore_rule3 => 'รับประทานอาหารให้สมดุลในช่วงรับประทานอาหาร';

  @override
  String get explore_rule4 => 'หยุดอดอาหารหากรู้สึกไม่สบาย';

  @override
  String get explore_rule5 => 'หญิงตั้งครรภ์หรือให้นมบุตรไม่ควรอดอาหาร';

  @override
  String get explore_rule6 => 'ปรึกษาแพทย์หากมีโรคเรื้อรัง';

  @override
  String get tip_water => 'รักษาระดับน้ำในร่างกาย';

  @override
  String get tip_waterDesc =>
      'ดื่มน้ำเมื่อกระหายและรับของเหลวพร้อมมื้ออาหาร ความต้องการอาจต่างกันตามสุขภาพ อากาศ และกิจกรรม';

  @override
  String get tip_food => 'รับประทานให้เหมาะสม';

  @override
  String get tip_foodDesc =>
      'ช่วงรับประทานอาหารให้เลือกอาหารโปรตีนสูงที่มีใยอาหารและไขมันดี หลีกเลี่ยงอาหารแปรรูป';

  @override
  String get tip_sleep => 'นอนหลับให้เพียงพอ';

  @override
  String get tip_sleepDesc =>
      'การนอนอย่างสม่ำเสมอและเพียงพอช่วยสุขภาพโดยรวม จัดเวลาอดอาหารไม่ให้รบกวนการนอน';

  @override
  String get tip_exercise => 'ออกกำลังกายเบา ๆ';

  @override
  String get tip_exerciseDesc =>
      'คุณเดินเบา ๆ หรือเล่นโยคะระหว่างอดอาหารได้ หลีกเลี่ยงการออกกำลังหนัก โดยเฉพาะช่วงสัปดาห์แรกที่ร่างกายกำลังปรับตัว';

  @override
  String get tip_drinks => 'เครื่องดื่มที่อนุญาต';

  @override
  String get tip_drinksDesc =>
      'ระหว่างอดอาหาร คุณดื่มน้ำ ชาไม่ปรุงแต่ง และกาแฟดำได้ (ไม่ใส่น้ำตาลหรือนม) เครื่องดื่มเหล่านี้ไม่ทำให้การอดอาหารสิ้นสุด';

  @override
  String get faq_drinks => 'ดื่มอะไรได้บ้างระหว่างอดอาหาร?';

  @override
  String get faq_drinksAnswer =>
      'ดื่มน้ำ ชาไม่ปรุงแต่ง และกาแฟดำได้ (ไม่ใส่น้ำตาล/นม) เครื่องดื่มที่มีแคลอรีจะทำให้การอดอาหารสิ้นสุด';

  @override
  String get faq_plan => 'ควรเลือกแผนอดอาหารใด?';

  @override
  String get faq_planAnswer =>
      'หากเพิ่งเริ่ม ให้เริ่มจาก 12:12 หรือ 14:10 หากมีประสบการณ์ ลอง 16:8 หรือ 18:6 ส่วน 20:4 และ OMAD เหมาะกับผู้มีประสบการณ์สูง';

  @override
  String get faq_exercise => 'ออกกำลังกายระหว่างอดอาหารได้หรือไม่?';

  @override
  String get faq_exerciseAnswer =>
      'ได้ แต่ควรหลีกเลี่ยงการออกกำลังหนัก คาร์ดิโอเบา ๆ การเดิน และโยคะเหมาะที่สุด หากยกน้ำหนัก ให้จัดไว้ใกล้ช่วงรับประทานอาหาร';

  @override
  String get faq_weight => 'การอดอาหารช่วยลดน้ำหนักหรือไม่?';

  @override
  String get faq_weightAnswer =>
      'สำหรับบางคน การจำกัดเวลารับประทานอาจลดพลังงานรวมที่ได้รับ ผลลัพธ์แตกต่างกันและผลระยะยาวยังอยู่ระหว่างการศึกษา';

  @override
  String get plan_12_desc => 'ระดับเริ่มต้น';

  @override
  String get plan_12_detail =>
      'เหมาะสำหรับผู้เริ่มต้น อดอาหาร 12 ชั่วโมงรวมเวลานอน';

  @override
  String get plan_16_desc => 'แผนยอดนิยมที่สุด';

  @override
  String get plan_16_detail =>
      'แผนอดอาหารเป็นช่วงที่พบบ่อยที่สุด อด 16 ชั่วโมง รับประทาน 8 ชั่วโมง โดยทั่วไปตั้งแต่มื้อกลางวันถึงมื้อเย็น';

  @override
  String get plan_18_desc => 'ระดับปานกลาง';

  @override
  String get plan_18_detail =>
      'อด 18 ชั่วโมง รับประทาน 6 ชั่วโมง มีช่วงเผาผลาญไขมันนานขึ้น';

  @override
  String get plan_20_desc => 'ระดับสูง';

  @override
  String get plan_20_detail =>
      'อด 20 ชั่วโมง รับประทาน 4 ชั่วโมง เหมาะสำหรับเข้าสู่ภาวะคีโตซิสและออโตฟาจี';

  @override
  String get plan_omad_desc => 'หนึ่งมื้อต่อวัน';

  @override
  String get plan_omad_detail =>
      'หนึ่งมื้อต่อวัน อด 23 ชั่วโมง รับประทาน 1 ชั่วโมง ระดับผู้เชี่ยวชาญ';

  @override
  String get plan_52_desc => '2 วันต่อสัปดาห์';

  @override
  String get plan_52_detail =>
      'รับประทานตามปกติ 5 วัน และเพียงประมาณ 500 แคลอรีใน 2 วัน เป็นอีกแนวทางหนึ่ง';

  @override
  String get plan_ese_desc => 'อดอาหาร 24 ชั่วโมง';

  @override
  String get plan_ese_detail =>
      'อดอาหาร 24 ชั่วโมง สัปดาห์ละ 1–2 ครั้ง สำหรับผู้ใช้ระดับสูง';

  @override
  String get plan_warrior_desc => 'อาหารแบบนักรบ';

  @override
  String get plan_warrior_detail =>
      'รับประทานเบา ๆ ระหว่างวัน (ผลไม้ ผัก) และรับประทานมื้อหลักในช่วง 4 ชั่วโมงตอนเย็น';

  @override
  String get award_first_title => 'ก้าวแรก';

  @override
  String get award_first_desc => 'ทำการอดอาหารครั้งแรกให้สำเร็จ';

  @override
  String get award_rhythm3_title => 'จังหวะ 3 วัน';

  @override
  String get award_rhythm3_desc => 'รักษาจังหวะเป็นเวลาสามวัน';

  @override
  String get award_hours24_title => '24 ชั่วโมง';

  @override
  String get award_hours24_desc => 'อดอาหารรวม 24 ชั่วโมง';

  @override
  String get award_week_title => 'จังหวะหนึ่งสัปดาห์';

  @override
  String get award_week_desc => 'สร้างสถิติต่อเนื่องเจ็ดวัน';

  @override
  String get award_fasts10_title => 'อดอาหาร 10 ครั้ง';

  @override
  String get award_fasts10_desc => 'ทำการอดอาหารสิบครั้งให้สำเร็จ';

  @override
  String get award_hours100_title => '100 ชั่วโมง';

  @override
  String get award_hours100_desc => 'ทำให้ถึงทั้งหมด 100 ชั่วโมง';

  @override
  String get award_rhythm30_title => 'จังหวะ 30 วัน';

  @override
  String get award_rhythm30_desc => 'สร้างสถิติต่อเนื่องสามสิบวัน';

  @override
  String get award_fasts50_title => 'อดอาหาร 50 ครั้ง';

  @override
  String get award_fasts50_desc => 'ทำการอดอาหารห้าสิบครั้งให้สำเร็จ';

  @override
  String get award_hours500_title => '500 ชั่วโมง';

  @override
  String get award_hours500_desc => 'ทำให้ถึงทั้งหมด 500 ชั่วโมง';

  @override
  String get award_fasts100_title => 'อดอาหาร 100 ครั้ง';

  @override
  String get award_fasts100_desc => 'ทำการอดอาหารหนึ่งร้อยครั้งให้สำเร็จ';

  @override
  String get award_rhythm90_title => 'จังหวะ 90 วัน';

  @override
  String get award_rhythm90_desc => 'สร้างสถิติต่อเนื่องเก้าสิบวัน';

  @override
  String get award_year_title => 'เส้นทางหนึ่งปี';

  @override
  String get award_year_desc => 'ทำจังหวะให้ถึง 365 วัน';

  @override
  String get awards_loadError => 'โหลดความคืบหน้าไม่ได้';

  @override
  String get awards_journeyComplete => 'เส้นทางเสร็จสมบูรณ์';

  @override
  String get awards_nextGoal => 'เป้าหมายถัดไป';

  @override
  String get awards_allYours => 'ความสำเร็จทั้งหมดเป็นของคุณ';

  @override
  String get awards_dayStreak => 'วันต่อเนื่อง';

  @override
  String get awards_fasts => 'ครั้งของการอดอาหาร';

  @override
  String get awards_total => 'ทั้งหมด';

  @override
  String get awards_stageStart => 'เริ่มต้น';

  @override
  String get awards_stageRhythm => 'จังหวะ';

  @override
  String get awards_stageEndurance => 'ความอดทน';

  @override
  String get awards_stageMastery => 'ความชำนาญ';

  @override
  String get awards_completed => 'สำเร็จแล้ว';

  @override
  String awards_fastsRemaining(int count) {
    return 'เหลือการอดอาหาร $count ครั้ง';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'เหลือ $count วัน';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'เหลือ $count ชั่วโมง';
  }

  @override
  String get common_retry => 'ลองอีกครั้ง';

  @override
  String get game_title => 'ศูนย์ความคืบหน้า';

  @override
  String get game_quests => 'ภารกิจวันนี้';

  @override
  String get game_questsDesc => 'ก้าวเล็ก ๆ สู่จังหวะที่ยั่งยืน';

  @override
  String get game_season => 'ฤดูกาล 30 ขั้น';

  @override
  String get game_seasonDesc => 'รับตราสะสมทุกห้าขั้น';

  @override
  String get game_badges => 'ชุดเหรียญตรา';

  @override
  String game_shields(int count) {
    return 'โล่จังหวะ $count อัน';
  }

  @override
  String get game_shieldsDesc =>
      'ได้รับทุกครั้งที่ทำสำเร็จเจ็ดครั้ง การพลาดหนึ่งวันจะไม่ลบความคืบหน้าของคุณ';

  @override
  String get game_league => 'ลีกส่วนตัวรายสัปดาห์';

  @override
  String game_leagueDesc(int percent) {
    return 'คะแนนจังหวะของคุณอยู่ที่เปอร์เซ็นไทล์ $percent ของแบบจำลองส่วนตัวในเครื่อง น้ำหนักและการอดอาหารแบบสุดโต่งจะไม่ถูกจัดอันดับ';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'ระดับ $level, คะแนนประสบการณ์ $xp';
  }

  @override
  String get game_explorer => 'นักสำรวจจังหวะ';

  @override
  String get game_streak => 'สถิติต่อเนื่อง';

  @override
  String get game_targets => 'เป้าหมาย';

  @override
  String get game_best => 'ดีที่สุด';

  @override
  String get quest_rhythm => 'สร้างจังหวะของวันนี้';

  @override
  String get quest_hydrate => 'ดื่มน้ำให้ถึงครึ่งหนึ่งของเป้าหมาย';

  @override
  String get quest_steady => 'รักษาสถิติต่อเนื่องของคุณ';

  @override
  String get badge_first_title => 'ก้าวแรก';

  @override
  String get badge_first_desc => 'บันทึกการอดอาหารครั้งแรก';

  @override
  String get badge_rhythm7_title => 'ผู้รักษาจังหวะ';

  @override
  String get badge_rhythm7_desc => 'ทำสถิติต่อเนื่อง 7 วัน';

  @override
  String get badge_rhythm3_title => 'จังหวะสามวัน';

  @override
  String get badge_rhythm3_desc => 'ทำสถิติต่อเนื่อง 3 วัน';

  @override
  String get badge_target1_title => 'เป้าหมายแรก';

  @override
  String get badge_target1_desc => 'ทำการอดอาหารตามเป้าหมายครั้งแรกให้สำเร็จ';

  @override
  String get badge_target3_title => 'สามก้าว';

  @override
  String get badge_target3_desc => 'ทำ 3 เป้าหมายให้สำเร็จ';

  @override
  String get badge_water_title => 'สมดุล';

  @override
  String get badge_water_desc => 'ทำเป้าหมายการดื่มน้ำรายวันให้สำเร็จ';

  @override
  String get badge_support_title => 'รู้จักตนเอง';

  @override
  String get badge_support_desc => 'ใช้โหมดสนับสนุน';

  @override
  String get badge_hours10_title => '10 ชั่วโมง';

  @override
  String get badge_hours10_desc => 'บันทึกรวม 10 ชั่วโมง';

  @override
  String get badge_target10_title => 'สิบครั้งอย่างแข็งแกร่ง';

  @override
  String get badge_target10_desc => 'ทำ 10 เป้าหมายให้สำเร็จ';

  @override
  String get badge_target20_title => 'ยี่สิบเป้าหมาย';

  @override
  String get badge_target20_desc => 'ทำ 20 เป้าหมายให้สำเร็จ';

  @override
  String get badge_fast16_title => '16 ชั่วโมง';

  @override
  String get badge_fast16_desc => 'อดอาหารครั้งเดียวให้ถึง 16 ชั่วโมง';

  @override
  String get badge_hours50_title => '50 ชั่วโมง';

  @override
  String get badge_hours50_desc => 'บันทึกรวม 50 ชั่วโมง';

  @override
  String get badge_hours100_title => 'หนึ่งร้อยชั่วโมง';

  @override
  String get badge_hours100_desc => 'บันทึกรวม 100 ชั่วโมง';

  @override
  String get badge_target30_title => 'สามสิบเป้าหมาย';

  @override
  String get badge_target30_desc => 'ทำ 30 เป้าหมายให้สำเร็จ';

  @override
  String get badge_rhythm30_title => 'จังหวะ 30 วัน';

  @override
  String get badge_rhythm30_desc => 'ทำสถิติต่อเนื่อง 30 วัน';

  @override
  String get paywall_restoreSuccess => 'กู้คืนการซื้อแล้ว!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'ความคืบหน้าการอดอาหาร $percent เปอร์เซ็นต์';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hourชม.';
  }

  @override
  String get paywall_lifetime => 'ตลอดชีพ';

  @override
  String get paywall_once => 'ครั้งเดียว';

  @override
  String get paywall_processing => 'กำลังดำเนินการ…';

  @override
  String get paywall_continue => 'ดำเนินการต่อ';

  @override
  String get paywall_productsUnavailable =>
      'ไม่สามารถซื้อได้ในขณะนี้ โปรดลองอีกครั้งภายหลัง';

  @override
  String get paywall_purchaseFailed => 'ไม่สามารถทำรายการซื้อให้สำเร็จ';

  @override
  String get paywall_nothingToRestore => 'ไม่พบการซื้อก่อนหน้า';

  @override
  String get paywall_restoreFailed => 'ไม่สามารถกู้คืนการซื้อได้';

  @override
  String get paywall_terms => 'ข้อกำหนดการใช้งาน';

  @override
  String get permission_notificationDesc =>
      'การเตือนอดอาหาร การอัปเดตระยะ และการแจ้งเตือนเมื่อเสร็จสิ้น';

  @override
  String get profile_privacyChoices => 'ตัวเลือกความเป็นส่วนตัว';

  @override
  String get paywall_autoRenewInfo =>
      'การสมัครจะต่ออายุอัตโนมัติ เว้นแต่ยกเลิกอย่างน้อย 24 ชั่วโมงก่อนสิ้นสุดรอบ จัดการหรือยกเลิกได้ทุกเมื่อในการตั้งค่า App Store';

  @override
  String paywall_perMonth(String price) {
    return '$price / เดือน';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'ประหยัด $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'ทดลองใช้ฟรี $days วัน';
  }

  @override
  String get paywall_startFreeTrial => 'เริ่มทดลองใช้ฟรี';

  @override
  String get paywall_retry => 'ลองอีกครั้ง';

  @override
  String get paywall_alreadyOwned =>
      'คุณเป็นเจ้าของการสมัครนี้แล้ว แตะ “กู้คืนการซื้อ”';

  @override
  String get paywall_storeUnavailable =>
      'เชื่อมต่อร้านค้าไม่ได้ในขณะนี้ ตรวจสอบการเชื่อมต่อแล้วลองอีกครั้ง';

  @override
  String get paywall_secureNote =>
      'ยกเลิกได้ทุกเมื่อ ระบบจะเรียกเก็บเงินจากบัญชีร้านค้าของคุณ';

  @override
  String get paywall_autoRenewInfoPlay =>
      'การสมัครจะต่ออายุอัตโนมัติ เว้นแต่ยกเลิกอย่างน้อย 24 ชั่วโมงก่อนสิ้นสุดรอบ จัดการหรือยกเลิกได้ทุกเมื่อใน Google Play > การสมัครใช้บริการ';

  @override
  String get paywall_allPlansDesc =>
      'ปลดล็อก 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat และ Warrior';

  @override
  String get paywall_noAdsDesc => 'ปิดโฆษณาแบนเนอร์และโฆษณาคั่นทั้งหมด';

  @override
  String get foodScan_title => 'สแกนอาหารด้วย AI';

  @override
  String get foodScan_scanCta => 'สแกนมื้ออาหาร';

  @override
  String get foodScan_scanCtaDesc =>
      'ถ่ายภาพจานอาหารเพื่อดูแคลอรีและสารอาหารหลัก';

  @override
  String get foodScan_introTitle => 'ถ่ายภาพจานอาหาร';

  @override
  String get foodScan_introDesc =>
      'AI อ่านภาพและประมาณแคลอรี โปรตีน คาร์โบไฮเดรต และไขมัน';

  @override
  String get foodScan_tipLight => 'แสงที่ดีและสม่ำเสมอช่วยให้ประมาณได้แม่นขึ้น';

  @override
  String get foodScan_tipFrame => 'ให้จานทั้งหมดอยู่ในกรอบ';

  @override
  String get foodScan_tipScale => 'ใส่ช้อนส้อมหรือมือในภาพเพื่อช่วยกะขนาดอาหาร';

  @override
  String get foodScan_takePhoto => 'ถ่ายภาพ';

  @override
  String get foodScan_chooseFromGallery => 'เลือกจากแกลเลอรี';

  @override
  String foodScan_scansLeft(int count) {
    return 'วันนี้เหลือ $count ครั้ง';
  }

  @override
  String get foodScan_quotaReached =>
      'คุณใช้จำนวนสแกนของวันนี้หมดแล้ว ลองอีกครั้งพรุ่งนี้';

  @override
  String get foodScan_privacyNote =>
      'ภาพจะถูกส่งไปยัง Gemini API ของ Google เพื่อวิเคราะห์และไม่เก็บไว้บนเซิร์ฟเวอร์ของเรา';

  @override
  String get foodScan_consentTitle => 'ส่งรูปภาพไปยัง Google Gemini หรือไม่';

  @override
  String get foodScan_consentBody =>
      'เพื่อประมาณแคลอรีและสารอาหารหลัก รูปอาหารทุกรูปที่คุณถ่ายหรือเลือกจะถูกส่งไปยังบริการ AI Gemini ของ Google รูปภาพจะใช้สำหรับการวิเคราะห์นี้เท่านั้นและไม่ถูกจัดเก็บบนเซิร์ฟเวอร์ของเรา';

  @override
  String get foodScan_consentAgree => 'ยอมรับและดำเนินการต่อ';

  @override
  String get foodScan_analyzing => 'กำลังวิเคราะห์มื้ออาหาร…';

  @override
  String get foodScan_analyzingHint => 'โดยปกติใช้เวลาไม่กี่วินาที';

  @override
  String get foodScan_detectedItems => 'รายการที่ตรวจพบ';

  @override
  String get foodScan_disclaimer =>
      'ค่าประมาณจาก AI เป็นค่าโดยประมาณ แตะรายการเพื่อแก้ไข';

  @override
  String get foodScan_lowConfidence =>
      'โมเดลไม่แน่ใจเกี่ยวกับภาพนี้ ตรวจสอบตัวเลขก่อนบันทึก';

  @override
  String get foodScan_save => 'เพิ่มในมื้ออาหาร';

  @override
  String get foodScan_retake => 'ภาพใหม่';

  @override
  String get foodScan_retry => 'ลองอีกครั้ง';

  @override
  String get foodScan_editItem => 'แก้ไขรายการ';

  @override
  String get foodScan_portion => 'ปริมาณ';

  @override
  String get foodScan_saveEdit => 'บันทึก';

  @override
  String get foodScan_premiumTitle => 'ฟีเจอร์ Premium';

  @override
  String get foodScan_premiumDesc =>
      'การวิเคราะห์แคลอรีจากภาพรวมอยู่ใน Premium';

  @override
  String get foodScan_upgrade => 'ดู Premium';

  @override
  String get foodScan_errorNetwork =>
      'ไม่มีการเชื่อมต่อ ตรวจสอบอินเทอร์เน็ตแล้วลองอีกครั้ง';

  @override
  String get foodScan_errorRateLimited =>
      'ขณะนี้มีการสแกนมากเกินไป ลองอีกครั้งในอีกไม่กี่นาที';

  @override
  String get foodScan_errorUnavailable =>
      'การวิเคราะห์ภาพไม่พร้อมใช้งานในขณะนี้';

  @override
  String get foodScan_errorServer =>
      'บริการวิเคราะห์มีปัญหา โปรดลองอีกครั้งในอีกสักครู่';

  @override
  String get foodScan_errorNoFood => 'ไม่พบอาหารในภาพ ลองถ่ายจานให้ชัดขึ้น';

  @override
  String get foodScan_errorUnreadable =>
      'ไม่สามารถวิเคราะห์ภาพนี้ได้ ลองใช้ภาพอื่น';

  @override
  String get paywall_aiFoodScan => 'สแกนอาหารด้วย AI';

  @override
  String get paywall_aiFoodScanDesc =>
      'ถ่ายภาพมื้ออาหารและบันทึกแคลอรีกับสารอาหารหลักในไม่กี่วินาที';
}
