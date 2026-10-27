// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Chào buổi sáng';

  @override
  String get greeting_afternoon => 'Chào buổi chiều';

  @override
  String get greeting_evening => 'Chào buổi tối';

  @override
  String get tab_timer => 'Trang chủ';

  @override
  String get tab_explore => 'Khám phá';

  @override
  String get tab_stats => 'Báo cáo';

  @override
  String get tab_meals => 'Bữa ăn';

  @override
  String get tab_achievements => 'Phần thưởng';

  @override
  String get tab_profile => 'Tài khoản';

  @override
  String get timer_fasting => 'Thời gian nhịn ăn';

  @override
  String get timer_remaining => 'Còn lại';

  @override
  String get timer_elapsed => 'Đã qua';

  @override
  String get timer_start => 'Bắt đầu';

  @override
  String get timer_stop => 'Dừng';

  @override
  String get timer_completed => 'Chúc mừng!';

  @override
  String get timer_completedMessage => 'Bạn đã hoàn thành kỳ nhịn ăn!';

  @override
  String get timer_selectPlan => 'Chọn kế hoạch nhịn ăn';

  @override
  String get timer_stopConfirm =>
      'Bạn có chắc muốn kết thúc kỳ nhịn ăn sớm không?';

  @override
  String get timer_stopTitle => 'Kết thúc nhịn ăn';

  @override
  String get timer_cancel => 'Hủy';

  @override
  String get timer_confirmStop => 'Có, kết thúc';

  @override
  String get phase_anabolic => 'Đồng hóa';

  @override
  String get phase_anabolicDesc => 'Đang tiêu hóa';

  @override
  String get phase_catabolic => 'Dị hóa';

  @override
  String get phase_catabolicDesc => 'Chuyển đổi năng lượng';

  @override
  String get phase_fatBurning => 'Đốt mỡ';

  @override
  String get phase_fatBurningDesc => 'Đã bắt đầu đốt mỡ';

  @override
  String get phase_ketosis => 'Ketosis';

  @override
  String get phase_ketosisDesc => 'Quá trình tạo ketone đang hoạt động';

  @override
  String get phase_autophagy => 'Tự thực bào';

  @override
  String get phase_autophagyDesc => 'Tái tạo tế bào';

  @override
  String get stats_title => 'Thống kê';

  @override
  String get stats_week => 'Tuần';

  @override
  String get stats_month => 'Tháng';

  @override
  String get stats_year => 'Năm';

  @override
  String get stats_totalFasts => 'Tổng số lần nhịn ăn';

  @override
  String get stats_average => 'Trung bình';

  @override
  String get stats_fastDuration => 'thời lượng nhịn ăn';

  @override
  String get stats_streak => 'Chuỗi';

  @override
  String get stats_daysConsecutive => 'ngày liên tiếp';

  @override
  String get stats_success => 'Thành công';

  @override
  String get stats_completion => 'hoàn thành';

  @override
  String get stats_weeklyFasting => 'Nhịn ăn hằng tuần';

  @override
  String get stats_monthlyView => 'Xem theo tháng';

  @override
  String get stats_weightChange => 'Thay đổi cân nặng';

  @override
  String get heatmap_none => 'Không có';

  @override
  String get heatmap_low => 'Thấp';

  @override
  String get heatmap_good => 'Tốt';

  @override
  String get heatmap_full => 'Đầy đủ';

  @override
  String get meals_title => 'Lập kế hoạch bữa ăn';

  @override
  String get meals_eatingWindow => 'Khung giờ ăn';

  @override
  String get meals_windowOpen => 'Đang mở';

  @override
  String get meals_windowFasting => 'Nhịn ăn';

  @override
  String get meals_calories => 'Calo';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Carbohydrate';

  @override
  String get meals_fat => 'Chất béo';

  @override
  String get meals_todayMeals => 'Bữa ăn hôm nay';

  @override
  String get meals_noMeals => 'Chưa thêm bữa ăn nào';

  @override
  String get meals_breakfastSuggestions => 'Gợi ý kết thúc nhịn ăn';

  @override
  String get meals_addMeal => 'Thêm bữa ăn';

  @override
  String get profile_title => 'Hồ sơ';

  @override
  String get profile_user => 'Người dùng';

  @override
  String profile_planActive(String plan) {
    return 'Kế hoạch $plan đang hoạt động';
  }

  @override
  String get profile_upgradePremium => 'Nâng cấp lên Premium';

  @override
  String get profile_premiumDesc => 'Mọi kế hoạch nhịn ăn, không quảng cáo';

  @override
  String get profile_bodyMetrics => 'Chỉ số cơ thể';

  @override
  String get profile_height => 'Chiều cao';

  @override
  String get profile_weight => 'Cân nặng';

  @override
  String get profile_targetWeight => 'Cân nặng mục tiêu';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Cài đặt';

  @override
  String get profile_notifications => 'Thông báo';

  @override
  String get profile_darkTheme => 'Giao diện tối';

  @override
  String get profile_waterReminder => 'Nhắc uống nước';

  @override
  String get profile_phaseNotifications => 'Thông báo giai đoạn';

  @override
  String get profile_language => 'Ngôn ngữ';

  @override
  String get profile_about => 'Giới thiệu';

  @override
  String get profile_rateApp => 'Đánh giá ứng dụng';

  @override
  String get profile_share => 'Chia sẻ';

  @override
  String get profile_privacyPolicy => 'Chính sách quyền riêng tư';

  @override
  String get profile_version => 'Phiên bản';

  @override
  String get onboarding_welcome => 'Chào mừng';

  @override
  String get onboarding_welcomeDesc =>
      'Làm chủ hành trình\nnhịn ăn gián đoạn của bạn';

  @override
  String get onboarding_featureTimer => 'Bộ hẹn giờ nhịn ăn thông minh';

  @override
  String get onboarding_featureStats => 'Thống kê và biểu đồ chi tiết';

  @override
  String get onboarding_featureMeals =>
      'Lập kế hoạch bữa ăn và gợi ý công thức';

  @override
  String get onboarding_getStarted => 'Bắt đầu';

  @override
  String get onboarding_selectGoal => 'Mục tiêu của bạn là gì?';

  @override
  String get onboarding_selectGoalDesc => 'Bạn có thể chọn nhiều mục';

  @override
  String get onboarding_goalWeight => 'Giảm cân';

  @override
  String get onboarding_goalWeightDesc => 'Giảm cân lành mạnh';

  @override
  String get onboarding_goalHealth => 'Cải thiện sức khỏe';

  @override
  String get onboarding_goalHealthDesc => 'Sức khỏe tổng thể và miễn dịch';

  @override
  String get onboarding_goalEnergy => 'Nhiều năng lượng hơn';

  @override
  String get onboarding_goalEnergyDesc => 'Năng lượng suốt cả ngày';

  @override
  String get onboarding_goalMental => 'Minh mẫn';

  @override
  String get onboarding_goalMentalDesc => 'Tập trung và sáng suốt';

  @override
  String get onboarding_goalLongevity => 'Sống lâu';

  @override
  String get onboarding_goalLongevityDesc =>
      'Tái tạo tế bào và lão hóa khỏe mạnh';

  @override
  String get onboarding_goalDiscipline => 'Kỷ luật';

  @override
  String get onboarding_goalDisciplineDesc => 'Xây dựng tính tự giác';

  @override
  String get onboarding_selectPlan => 'Chọn kế hoạch của bạn';

  @override
  String get onboarding_selectPlanDesc => 'Chọn kế hoạch nhịn ăn phù hợp nhất';

  @override
  String get onboarding_bodyInfo => 'Nhập thông tin của bạn';

  @override
  String get onboarding_bodyInfoDesc => 'Để nhận đề xuất cá nhân hóa';

  @override
  String get onboarding_gender => 'Giới tính';

  @override
  String get onboarding_male => 'Nam';

  @override
  String get onboarding_female => 'Nữ';

  @override
  String get onboarding_age => 'Tuổi';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Thông tin này chỉ được lưu trên thiết bị của bạn và dùng để tính calo.';

  @override
  String get onboarding_permissions => 'Bước cuối';

  @override
  String get onboarding_permissionsDesc =>
      'Bật quyền để có trải nghiệm tốt nhất';

  @override
  String get onboarding_next => 'Tiếp tục';

  @override
  String get onboarding_start => 'Bắt đầu thôi!';

  @override
  String get onboarding_skipForNow => 'Thiết lập sau';

  @override
  String get waterAdded => 'Đã thêm 250 ml nước';

  @override
  String get languageSelect => 'Chọn ngôn ngữ';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Nâng cấp lên Premium';

  @override
  String get paywall_subtitle =>
      'Mở khóa mọi kế hoạch nhịn ăn và loại bỏ quảng cáo';

  @override
  String get paywall_allPlans => 'Mọi kế hoạch nhịn ăn';

  @override
  String get paywall_advancedStats => 'Thống kê nâng cao';

  @override
  String get paywall_mealPlanner => 'Lập kế hoạch bữa ăn';

  @override
  String get paywall_themes => 'Tùy chỉnh giao diện';

  @override
  String get paywall_noAds => 'Không quảng cáo';

  @override
  String get paywall_weekly => 'Hằng tuần';

  @override
  String get paywall_monthly => 'Hằng tháng';

  @override
  String get paywall_yearly => 'Hằng năm';

  @override
  String get paywall_bestValue => 'Tốt nhất';

  @override
  String get paywall_freeTrial => 'Dùng thử miễn phí (3 ngày)';

  @override
  String get paywall_restore => 'Khôi phục giao dịch mua';

  @override
  String get paywall_premiumActive => 'Premium đang hoạt động!';

  @override
  String get paywall_premiumActiveDesc =>
      'Mọi kế hoạch nhịn ăn đã được mở khóa và quảng cáo đã tắt';

  @override
  String get water_title => 'Lượng nước uống';

  @override
  String get water_addWater => 'Thêm nước';

  @override
  String get water_goal => 'Mục tiêu';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Hủy';

  @override
  String get common_save => 'Lưu';

  @override
  String get common_delete => 'Xóa';

  @override
  String get common_hours => 'giờ';

  @override
  String get common_minutes => 'phút';

  @override
  String get common_days => 'ngày';

  @override
  String get common_enable => 'Bật';

  @override
  String get streakCard_currentStreak => 'Chuỗi hiện tại';

  @override
  String get streakCard_longestStreak => 'Chuỗi dài nhất';

  @override
  String get streakCard_totalSessions => 'Tổng số lần nhịn ăn';

  @override
  String get meals_mealType => 'Loại bữa ăn';

  @override
  String get meals_breakfast => 'Bữa sáng';

  @override
  String get meals_lunch => 'Bữa trưa';

  @override
  String get meals_dinner => 'Bữa tối';

  @override
  String get meals_snack => 'Bữa phụ';

  @override
  String get meals_carbohydrate => 'Carbohydrate';

  @override
  String get meals_add => 'Thêm';

  @override
  String get meals_mealName => 'Tên món ăn';

  @override
  String get bodyMetrics_title => 'Chỉ số cơ thể';

  @override
  String get bodyMetrics_weight => 'Cân nặng';

  @override
  String get bodyMetrics_target => 'Mục tiêu';

  @override
  String get bodyMetrics_save => 'Lưu';

  @override
  String get bodyMetrics_history => 'Lịch sử';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Chưa có dữ liệu';

  @override
  String get meals_quickAdd => 'Thêm nhanh';

  @override
  String get meals_manualEntry => 'Nhập thủ công';

  @override
  String meals_added(String name) {
    return 'Đã thêm $name';
  }

  @override
  String get meals_nameCalorieRequired => 'Cần nhập tên và lượng calo';

  @override
  String get bodyMetrics_addWeight => 'Thêm cân nặng';

  @override
  String get bodyMetrics_hintWeight => 'ví dụ 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Nhập cân nặng hợp lệ';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'Đã lưu $value kg';
  }

  @override
  String get completion_duration => 'Thời lượng';

  @override
  String get completion_plan => 'Kế hoạch';

  @override
  String get completion_lastPhase => 'Giai đoạn cuối';

  @override
  String get completion_earlyTitle => 'Đã kết thúc nhịn ăn';

  @override
  String get completion_earlyMessage =>
      'Thời gian hôm nay đã được lưu. Chuỗi ngày và tiến độ thành tích không thay đổi vì mục tiêu chưa hoàn thành.';

  @override
  String get timer_remainingTime => 'Thời gian còn lại';

  @override
  String get timer_ready => 'Sẵn sàng bắt đầu';

  @override
  String get streak_status => 'Trạng thái';

  @override
  String get streak_startToday => 'Bắt đầu hôm nay!';

  @override
  String get streak_goodStart => 'Khởi đầu tốt!';

  @override
  String get streak_goingGreat => 'Đang tiến triển tốt!';

  @override
  String get streak_superb => 'Tuyệt vời!';

  @override
  String get streak_legendary => 'Huyền thoại!';

  @override
  String get streak_incredible => 'Không thể tin được!';

  @override
  String get weight_noRecord =>
      'Chưa có bản ghi cân nặng\nThêm tại Hồ sơ > Chỉ số cơ thể';

  @override
  String get day_mon => 'T2';

  @override
  String get day_tue => 'T3';

  @override
  String get day_wed => 'T4';

  @override
  String get day_thu => 'T5';

  @override
  String get day_fri => 'T6';

  @override
  String get day_sat => 'T7';

  @override
  String get day_sun => 'CN';

  @override
  String get day_short_mon => '2';

  @override
  String get day_short_tue => '3';

  @override
  String get day_short_wed => '4';

  @override
  String get day_short_thu => '5';

  @override
  String get day_short_fri => '6';

  @override
  String get day_short_sat => '7';

  @override
  String get day_short_sun => 'CN';

  @override
  String get month_jan => 'Tháng 1';

  @override
  String get month_feb => 'Tháng 2';

  @override
  String get month_mar => 'Tháng 3';

  @override
  String get month_apr => 'Tháng 4';

  @override
  String get month_may => 'Tháng 5';

  @override
  String get month_jun => 'Tháng 6';

  @override
  String get month_jul => 'Tháng 7';

  @override
  String get month_aug => 'Tháng 8';

  @override
  String get month_sep => 'Tháng 9';

  @override
  String get month_oct => 'Tháng 10';

  @override
  String get month_nov => 'Tháng 11';

  @override
  String get month_dec => 'Tháng 12';

  @override
  String meals_fastingWindow(String hours) {
    return 'Nhịn ăn ($hours giờ)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Ăn ($hours giờ)';
  }

  @override
  String get recipe_oatSmoothie => 'Sinh tố yến mạch';

  @override
  String get recipe_avocadoToast => 'Bánh mì nướng bơ';

  @override
  String get recipe_yogurtBowl => 'Bát sữa chua';

  @override
  String get elapsed_time => 'Thời gian đã qua';

  @override
  String get fast_ends_on => 'Kỳ nhịn ăn kết thúc lúc';

  @override
  String get end_fasting => 'Kết thúc nhịn ăn';

  @override
  String get start_fasting => 'Bắt đầu nhịn ăn';

  @override
  String get water_tracker => 'Theo dõi nước';

  @override
  String get weight_tracker => 'Theo dõi cân nặng';

  @override
  String get drink => 'Uống';

  @override
  String get log_weight => 'Ghi cân nặng';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Cân nặng đã giảm';

  @override
  String get current_weight => 'Cân nặng hiện tại';

  @override
  String get goal_weight => 'Cân nặng mục tiêu';

  @override
  String get daily_goal => 'Mục tiêu hằng ngày';

  @override
  String completed_percent(String percent) {
    return 'Đã hoàn thành $percent%';
  }

  @override
  String get explore => 'Khám phá';

  @override
  String get achievements => 'Thành tích';

  @override
  String get profile_theme => 'Giao diện';

  @override
  String get theme_select => 'Chọn giao diện';

  @override
  String get theme_system => 'Mặc định hệ thống';

  @override
  String get theme_light => 'Sáng';

  @override
  String get theme_dark => 'Tối';

  @override
  String get language_system => 'Ngôn ngữ hệ thống';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Âm thanh hoàn thành';

  @override
  String get profile_calmGamification => 'Trò chơi hóa nhẹ nhàng';

  @override
  String get profile_calmGamificationDesc => 'Giảm áp lực từ giải đấu và mùa';

  @override
  String get profile_editName => 'Sửa tên của bạn';

  @override
  String get profile_name => 'Tên';

  @override
  String get circle_title => 'Vòng tròn nhịn ăn';

  @override
  String get circle_you => 'Bạn';

  @override
  String get circle_tagline => 'Cùng nhau, không áp lực.';

  @override
  String get circle_privacy =>
      'Cân nặng và các chỉ số riêng tư luôn được ẩn. Chỉ tiến độ và sự hỗ trợ được hiển thị.';

  @override
  String circle_sendSupport(int count) {
    return 'Gửi lời động viên · $count';
  }

  @override
  String get circle_inviteCopied => 'Đã sao chép mã mời';

  @override
  String get circle_createInvite => 'Tạo lời mời riêng tư';

  @override
  String get crisis_nameTitle => 'Trước tiên, hãy gọi tên điều đang xảy ra';

  @override
  String get crisis_nameDesc => 'Đó có thể là đói, thói quen hoặc cảm xúc.';

  @override
  String get crisis_waterTitle => 'Uống một cốc nước';

  @override
  String get crisis_waterDesc => 'Sau đó hít thở chậm ba lần.';

  @override
  String get crisis_delayTitle => 'Trì hoãn quyết định trong 10 phút';

  @override
  String get crisis_delayDesc =>
      'Nếu bạn thấy không khỏe, kết thúc nhịn ăn không phải là thất bại.';

  @override
  String get crisis_hunger => 'Đói';

  @override
  String get crisis_habit => 'Thói quen';

  @override
  String get crisis_stress => 'Căng thẳng';

  @override
  String get crisis_tenMore => 'Cho bản thân thêm 10 phút';

  @override
  String get stats_storyEmpty =>
      'Lần nhịn ăn đầu tiên sẽ mở đầu câu chuyện của riêng bạn.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Bạn đã nhịn ăn $sessions lần trong giai đoạn này, duy trì nhịp điệu trong $hours giờ và đạt tỷ lệ hoàn thành $rate%.';
  }

  @override
  String get stats_storyTitle => 'Câu chuyện về nhịp điệu của bạn';

  @override
  String get home_todayRhythm => 'Nhịp điệu hôm nay';

  @override
  String get home_finalHourSupport => 'Hỗ trợ giờ cuối';

  @override
  String get home_needSupport => 'Tôi cần một chút động viên';

  @override
  String get home_todaySummary => 'Tổng quan hôm nay';

  @override
  String get home_dayStreak => 'ngày liên tiếp';

  @override
  String home_weightGoal(String weight) {
    return 'mục tiêu $weight kg';
  }

  @override
  String get weather_steady => 'Nhịp điệu của bạn đang ổn định';

  @override
  String get weather_gentle => 'Một ngày nhẹ nhàng';

  @override
  String get weather_water => 'Một cốc nước có thể giúp ích.';

  @override
  String get weather_listen =>
      'Bạn đã đi được một chặng dài; hãy lắng nghe cơ thể.';

  @override
  String get weather_onPlan => 'Nhịp độ hôm nay phù hợp với kế hoạch của bạn.';

  @override
  String get weather_challenging =>
      'Giờ này trước đây từng khó khăn; chế độ hỗ trợ đã sẵn sàng.';

  @override
  String get replay_copied => 'Đã sao chép bản tóm tắt nhịn ăn';

  @override
  String get replay_button => 'Xem lại';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Tôi đã hoàn thành kỳ nhịn ăn $plan trong ${hours}g ${minutes}p · $phase';
  }

  @override
  String get journey_label => 'Hành trình chuyển hóa';

  @override
  String get journey_now => 'Hiện tại';

  @override
  String journey_next(String time, String phase) {
    return 'Còn $time đến $phase';
  }

  @override
  String get phase_estimateShort =>
      'Thời điểm của giai đoạn chỉ là ước tính chung, không phải phép đo y khoa.';

  @override
  String phase_hours(int start, int end) {
    return 'Giờ $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Thời điểm này chỉ là ước tính chung. Phản ứng chuyển hóa có thể khác nhau ở mỗi người.';

  @override
  String get bmi_underweight => 'Thiếu cân';

  @override
  String get bmi_normal => 'Bình thường';

  @override
  String get bmi_overweight => 'Thừa cân';

  @override
  String get bmi_obese => 'Béo phì';

  @override
  String get notification_halfwayTitle => 'Đã đi được nửa chặng! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Bạn đã hoàn thành một nửa kỳ nhịn ăn $plan. Tiếp tục nhé!';
  }

  @override
  String get notification_phaseCatabolic => 'Đã vào giai đoạn dị hóa 📉';

  @override
  String get notification_phaseFatBurning => 'Bắt đầu đốt mỡ! 🔥';

  @override
  String get notification_phaseKetosis => 'Bạn đang ở trạng thái ketosis ⚡';

  @override
  String get notification_phaseAutophagy =>
      'Quá trình tự thực bào đang hoạt động! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Bạn đã hoàn thành kỳ nhịn ăn $plan! Khung giờ ăn đã mở.';
  }

  @override
  String get notification_waterTitle => 'Uống nước 💧';

  @override
  String get notification_waterBody => 'Đừng quên uống đủ nước khi nhịn ăn!';

  @override
  String get notification_windowTitle => 'Khung giờ ăn sắp kết thúc ⏰';

  @override
  String get notification_windowBody =>
      'Khung giờ ăn của bạn sẽ kết thúc sau 30 phút.';

  @override
  String notification_streakTitle(int days) {
    return 'Chuỗi $days ngày! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Bạn đang làm rất tốt! Hãy tiếp tục hôm nay.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Đang nhịn ăn - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Còn lại: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Đã bắt đầu nhịn ăn - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Mục tiêu: $hours giờ';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}g ${minutes}p';
  }

  @override
  String get explore_guide => 'Hướng dẫn nhịn ăn';

  @override
  String get explore_guideDesc => 'Mọi điều bạn cần biết về nhịn ăn gián đoạn';

  @override
  String get explore_circleDesc =>
      'Chia sẻ sự động viên nhẹ nhàng với nhóm riêng tư của bạn.';

  @override
  String get explore_faq => 'Câu hỏi thường gặp';

  @override
  String get explore_education =>
      'Nội dung này chỉ nhằm giáo dục phổ thông, không phải chẩn đoán hay tư vấn điều trị y khoa.';

  @override
  String get explore_safety => 'Sức khỏe và an toàn';

  @override
  String get explore_safetyDesc =>
      'Nếu bạn có bệnh lý, dùng thuốc thường xuyên, có triệu chứng đáng lo, đang mang thai hoặc cho con bú, hãy hỏi ý kiến chuyên gia y tế đủ chuyên môn trước khi nhịn ăn. Hãy dừng lại nếu thấy không khỏe.';

  @override
  String get explore_sources => 'Nguồn';

  @override
  String get explore_sourcesDesc =>
      'Nội dung được đơn giản hóa từ các tài liệu y tế công cộng bên dưới.';

  @override
  String get explore_sourceError => 'Không thể mở nguồn';

  @override
  String get explore_rules => 'Quy tắc quan trọng';

  @override
  String get explore_rule1 =>
      'Không dùng thực phẩm có calo trong thời gian nhịn ăn';

  @override
  String get explore_rule2 => 'Uống nhiều nước và chất lỏng';

  @override
  String get explore_rule3 => 'Ăn cân bằng trong khung giờ ăn';

  @override
  String get explore_rule4 => 'Dừng nhịn ăn nếu bạn thấy không khỏe';

  @override
  String get explore_rule5 =>
      'Phụ nữ mang thai hoặc cho con bú không nên nhịn ăn';

  @override
  String get explore_rule6 => 'Tham khảo bác sĩ nếu bạn có bệnh mạn tính';

  @override
  String get tip_water => 'Giữ đủ nước';

  @override
  String get tip_waterDesc =>
      'Uống nước khi khát và bổ sung chất lỏng trong bữa ăn. Nhu cầu có thể thay đổi theo sức khỏe, thời tiết và mức vận động.';

  @override
  String get tip_food => 'Ăn đúng cách';

  @override
  String get tip_foodDesc =>
      'Trong khung giờ ăn, hãy chọn thực phẩm giàu protein, chất xơ và chất béo lành mạnh. Tránh thực phẩm chế biến sẵn.';

  @override
  String get tip_sleep => 'Ngủ ngon';

  @override
  String get tip_sleepDesc =>
      'Giấc ngủ đều đặn và đầy đủ hỗ trợ sức khỏe tổng thể. Hãy sắp xếp nhịn ăn để không làm gián đoạn giấc ngủ.';

  @override
  String get tip_exercise => 'Vận động nhẹ';

  @override
  String get tip_exerciseDesc =>
      'Bạn có thể đi bộ nhẹ hoặc tập yoga khi nhịn ăn. Tránh vận động nặng, đặc biệt trong những tuần đầu khi cơ thể chưa thích nghi.';

  @override
  String get tip_drinks => 'Đồ uống được phép';

  @override
  String get tip_drinksDesc =>
      'Trong thời gian nhịn ăn, bạn có thể uống nước, trà nguyên chất và cà phê đen (không đường, không sữa). Những đồ uống này không phá vỡ kỳ nhịn ăn.';

  @override
  String get faq_drinks => 'Tôi có thể uống gì khi nhịn ăn?';

  @override
  String get faq_drinksAnswer =>
      'Bạn có thể uống nước, trà nguyên chất và cà phê đen (không đường/sữa). Đồ uống có calo sẽ phá vỡ kỳ nhịn ăn.';

  @override
  String get faq_plan => 'Tôi nên chọn kế hoạch nhịn ăn nào?';

  @override
  String get faq_planAnswer =>
      'Nếu mới bắt đầu, hãy thử 12:12 hoặc 14:10. Nếu đã có kinh nghiệm, hãy thử 16:8 hoặc 18:6. 20:4 và OMAD dành cho người nhịn ăn nâng cao.';

  @override
  String get faq_exercise => 'Tôi có thể tập thể dục khi nhịn ăn không?';

  @override
  String get faq_exerciseAnswer =>
      'Có, nhưng hãy tránh tập cường độ cao. Cardio nhẹ, đi bộ và yoga là lựa chọn lý tưởng. Nếu tập tạ, hãy sắp xếp gần khung giờ ăn.';

  @override
  String get faq_weight => 'Nhịn ăn có giúp giảm cân không?';

  @override
  String get faq_weightAnswer =>
      'Với một số người, giới hạn thời gian ăn có thể làm giảm tổng năng lượng nạp vào. Kết quả khác nhau và tác động dài hạn vẫn đang được nghiên cứu.';

  @override
  String get plan_12_desc => 'Mức người mới';

  @override
  String get plan_12_detail =>
      'Lý tưởng cho người mới. Nhịn ăn 12 giờ, bao gồm thời gian ngủ.';

  @override
  String get plan_16_desc => 'Kế hoạch phổ biến nhất';

  @override
  String get plan_16_detail =>
      'Kế hoạch nhịn ăn gián đoạn phổ biến nhất. Nhịn 16 giờ, ăn trong 8 giờ. Thường từ bữa trưa đến bữa tối.';

  @override
  String get plan_18_desc => 'Mức trung cấp';

  @override
  String get plan_18_detail =>
      'Nhịn 18 giờ, ăn trong 6 giờ. Thời gian đốt mỡ lâu hơn.';

  @override
  String get plan_20_desc => 'Mức nâng cao';

  @override
  String get plan_20_detail =>
      'Nhịn 20 giờ, ăn trong 4 giờ. Lý tưởng để đạt ketosis và tự thực bào.';

  @override
  String get plan_omad_desc => 'Một bữa mỗi ngày';

  @override
  String get plan_omad_detail =>
      'Một bữa mỗi ngày. Nhịn 23 giờ, ăn trong 1 giờ. Mức chuyên sâu.';

  @override
  String get plan_52_desc => '2 ngày mỗi tuần';

  @override
  String get plan_52_detail =>
      'Ăn bình thường 5 ngày, chỉ khoảng 500 calo trong 2 ngày. Một phương pháp thay thế.';

  @override
  String get plan_ese_desc => 'Nhịn ăn 24 giờ';

  @override
  String get plan_ese_detail =>
      'Nhịn ăn 24 giờ, 1–2 lần mỗi tuần. Dành cho người dùng nâng cao.';

  @override
  String get plan_warrior_desc => 'Chế độ ăn chiến binh';

  @override
  String get plan_warrior_detail =>
      'Ăn nhẹ ban ngày (trái cây, rau củ), dùng bữa chính trong khung 4 giờ vào buổi tối.';

  @override
  String get award_first_title => 'Bước đầu tiên';

  @override
  String get award_first_desc => 'Hoàn thành lần nhịn ăn đầu tiên';

  @override
  String get award_rhythm3_title => 'Nhịp điệu 3 ngày';

  @override
  String get award_rhythm3_desc => 'Duy trì nhịp điệu trong ba ngày';

  @override
  String get award_hours24_title => '24 giờ';

  @override
  String get award_hours24_desc => 'Nhịn ăn tổng cộng 24 giờ';

  @override
  String get award_week_title => 'Nhịp điệu một tuần';

  @override
  String get award_week_desc => 'Tạo chuỗi bảy ngày';

  @override
  String get award_fasts10_title => '10 lần nhịn ăn';

  @override
  String get award_fasts10_desc => 'Hoàn thành mười lần nhịn ăn';

  @override
  String get award_hours100_title => '100 giờ';

  @override
  String get award_hours100_desc => 'Đạt tổng cộng 100 giờ';

  @override
  String get award_rhythm30_title => 'Nhịp điệu 30 ngày';

  @override
  String get award_rhythm30_desc => 'Tạo chuỗi ba mươi ngày';

  @override
  String get award_fasts50_title => '50 lần nhịn ăn';

  @override
  String get award_fasts50_desc => 'Hoàn thành năm mươi lần nhịn ăn';

  @override
  String get award_hours500_title => '500 giờ';

  @override
  String get award_hours500_desc => 'Đạt tổng cộng 500 giờ';

  @override
  String get award_fasts100_title => '100 lần nhịn ăn';

  @override
  String get award_fasts100_desc => 'Hoàn thành một trăm lần nhịn ăn';

  @override
  String get award_rhythm90_title => 'Nhịp điệu 90 ngày';

  @override
  String get award_rhythm90_desc => 'Tạo chuỗi chín mươi ngày';

  @override
  String get award_year_title => 'Hành trình một năm';

  @override
  String get award_year_desc => 'Đạt nhịp điệu 365 ngày';

  @override
  String get awards_loadError => 'Không thể tải tiến độ';

  @override
  String get awards_journeyComplete => 'Hoàn thành hành trình';

  @override
  String get awards_nextGoal => 'Mục tiêu tiếp theo';

  @override
  String get awards_allYours => 'Mọi thành tích đều thuộc về bạn';

  @override
  String get awards_dayStreak => 'ngày liên tiếp';

  @override
  String get awards_fasts => 'lần nhịn ăn';

  @override
  String get awards_total => 'tổng cộng';

  @override
  String get awards_stageStart => 'Khởi đầu';

  @override
  String get awards_stageRhythm => 'Nhịp điệu';

  @override
  String get awards_stageEndurance => 'Sức bền';

  @override
  String get awards_stageMastery => 'Tinh thông';

  @override
  String get awards_completed => 'Đã hoàn thành';

  @override
  String awards_fastsRemaining(int count) {
    return 'Còn $count lần nhịn ăn';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Còn $count ngày';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Còn $count giờ';
  }

  @override
  String get common_retry => 'Thử lại';

  @override
  String get game_title => 'Trung tâm tiến độ';

  @override
  String get game_quests => 'Nhiệm vụ hôm nay';

  @override
  String get game_questsDesc => 'Những bước nhỏ, nhịp điệu bền vững.';

  @override
  String get game_season => 'Mùa 30 bước';

  @override
  String get game_seasonDesc => 'Nhận một con dấu sưu tầm sau mỗi năm bước.';

  @override
  String get game_badges => 'Bộ sưu tập huy hiệu';

  @override
  String game_shields(int count) {
    return '$count khiên nhịp điệu';
  }

  @override
  String get game_shieldsDesc =>
      'Nhận được sau mỗi bảy lần hoàn thành. Một ngày bỏ lỡ không bao giờ xóa tiến độ của bạn.';

  @override
  String get game_league => 'Giải đấu tuần riêng tư';

  @override
  String game_leagueDesc(int percent) {
    return 'Điểm nhịp điệu của bạn nằm ở phân vị $percent trong mô hình cục bộ riêng tư. Cân nặng và nhịn ăn cực đoan không bao giờ được xếp hạng.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Cấp $level, $xp điểm kinh nghiệm';
  }

  @override
  String get game_explorer => 'Nhà khám phá nhịp điệu';

  @override
  String get game_streak => 'Chuỗi';

  @override
  String get game_targets => 'Mục tiêu';

  @override
  String get game_best => 'Tốt nhất';

  @override
  String get quest_rhythm => 'Xây dựng nhịp điệu hôm nay';

  @override
  String get quest_hydrate => 'Đạt một nửa mục tiêu nước';

  @override
  String get quest_steady => 'Bảo vệ chuỗi của bạn';

  @override
  String get badge_first_title => 'Bước đầu tiên';

  @override
  String get badge_first_desc => 'Ghi lại lần nhịn ăn đầu tiên';

  @override
  String get badge_rhythm7_title => 'Người giữ nhịp';

  @override
  String get badge_rhythm7_desc => 'Đạt chuỗi 7 ngày';

  @override
  String get badge_rhythm3_title => 'Nhịp điệu ba ngày';

  @override
  String get badge_rhythm3_desc => 'Đạt chuỗi 3 ngày';

  @override
  String get badge_target1_title => 'Mục tiêu đầu tiên';

  @override
  String get badge_target1_desc => 'Hoàn thành kỳ nhịn ăn mục tiêu đầu tiên';

  @override
  String get badge_target3_title => 'Ba bước';

  @override
  String get badge_target3_desc => 'Hoàn thành 3 mục tiêu';

  @override
  String get badge_water_title => 'Cân bằng';

  @override
  String get badge_water_desc => 'Hoàn thành mục tiêu nước hằng ngày';

  @override
  String get badge_support_title => 'Tự nhận thức';

  @override
  String get badge_support_desc => 'Sử dụng chế độ hỗ trợ';

  @override
  String get badge_hours10_title => '10 giờ';

  @override
  String get badge_hours10_desc => 'Ghi lại tổng cộng 10 giờ';

  @override
  String get badge_target10_title => 'Mười mục tiêu vững vàng';

  @override
  String get badge_target10_desc => 'Hoàn thành 10 mục tiêu';

  @override
  String get badge_target20_title => 'Hai mươi mục tiêu';

  @override
  String get badge_target20_desc => 'Hoàn thành 20 mục tiêu';

  @override
  String get badge_fast16_title => '16 giờ';

  @override
  String get badge_fast16_desc => 'Đạt 16 giờ trong một lần nhịn ăn';

  @override
  String get badge_hours50_title => '50 giờ';

  @override
  String get badge_hours50_desc => 'Ghi lại tổng cộng 50 giờ';

  @override
  String get badge_hours100_title => 'Một trăm giờ';

  @override
  String get badge_hours100_desc => 'Ghi lại tổng cộng 100 giờ';

  @override
  String get badge_target30_title => 'Ba mươi mục tiêu';

  @override
  String get badge_target30_desc => 'Hoàn thành 30 mục tiêu';

  @override
  String get badge_rhythm30_title => 'Nhịp điệu 30 ngày';

  @override
  String get badge_rhythm30_desc => 'Đạt chuỗi 30 ngày';

  @override
  String get paywall_restoreSuccess => 'Đã khôi phục giao dịch mua!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Tiến độ nhịn ăn $percent phần trăm';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}g';
  }

  @override
  String get paywall_lifetime => 'Trọn đời';

  @override
  String get paywall_once => 'một lần';

  @override
  String get paywall_processing => 'Đang xử lý…';

  @override
  String get paywall_continue => 'Tiếp tục';

  @override
  String get paywall_productsUnavailable =>
      'Hiện không thể mua hàng. Vui lòng thử lại sau.';

  @override
  String get paywall_purchaseFailed => 'Không thể hoàn tất giao dịch mua.';

  @override
  String get paywall_nothingToRestore =>
      'Không tìm thấy giao dịch mua trước đó.';

  @override
  String get paywall_restoreFailed => 'Không thể khôi phục giao dịch mua.';

  @override
  String get paywall_terms => 'Điều khoản sử dụng';

  @override
  String get permission_notificationDesc =>
      'Nhắc nhở nhịn ăn, cập nhật giai đoạn và thông báo hoàn thành';

  @override
  String get profile_privacyChoices => 'Lựa chọn quyền riêng tư';

  @override
  String get paywall_autoRenewInfo =>
      'Gói đăng ký tự động gia hạn trừ khi bị hủy ít nhất 24 giờ trước khi kết thúc kỳ hạn. Quản lý hoặc hủy bất cứ lúc nào trong cài đặt App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / tháng';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Tiết kiệm $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Dùng thử miễn phí $days ngày';
  }

  @override
  String get paywall_startFreeTrial => 'Bắt đầu dùng thử miễn phí';

  @override
  String get paywall_retry => 'Thử lại';

  @override
  String get paywall_alreadyOwned =>
      'Bạn đã sở hữu gói đăng ký này. Nhấn “Khôi phục giao dịch mua”.';

  @override
  String get paywall_storeUnavailable =>
      'Hiện không thể kết nối với cửa hàng. Hãy kiểm tra kết nối và thử lại.';

  @override
  String get paywall_secureNote =>
      'Hủy bất cứ lúc nào. Khoản thanh toán được tính vào tài khoản cửa hàng của bạn.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Gói đăng ký tự động gia hạn trừ khi bị hủy ít nhất 24 giờ trước khi kết thúc kỳ hạn. Quản lý hoặc hủy bất cứ lúc nào trong Google Play > Gói thuê bao.';

  @override
  String get paywall_allPlansDesc =>
      'Mở khóa 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat và Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Quảng cáo biểu ngữ và quảng cáo xen kẽ được tắt hoàn toàn';

  @override
  String get foodScan_title => 'Quét món ăn bằng AI';

  @override
  String get foodScan_scanCta => 'Quét bữa ăn';

  @override
  String get foodScan_scanCtaDesc =>
      'Chụp đĩa thức ăn để nhận lượng calo và các chất dinh dưỡng đa lượng';

  @override
  String get foodScan_introTitle => 'Chụp đĩa thức ăn của bạn';

  @override
  String get foodScan_introDesc =>
      'AI đọc ảnh và ước tính calo, protein, carbohydrate và chất béo.';

  @override
  String get foodScan_tipLight =>
      'Ánh sáng đều, đủ sáng giúp ước tính chính xác hơn';

  @override
  String get foodScan_tipFrame => 'Đặt toàn bộ đĩa thức ăn trong khung hình';

  @override
  String get foodScan_tipScale =>
      'Đặt thêm dao nĩa hoặc bàn tay để ước lượng khẩu phần';

  @override
  String get foodScan_takePhoto => 'Chụp ảnh';

  @override
  String get foodScan_chooseFromGallery => 'Chọn từ thư viện';

  @override
  String foodScan_scansLeft(int count) {
    return 'Hôm nay còn $count lượt quét';
  }

  @override
  String get foodScan_quotaReached =>
      'Bạn đã dùng hết lượt quét hôm nay. Hãy thử lại vào ngày mai.';

  @override
  String get foodScan_privacyNote =>
      'Ảnh được gửi tới API Gemini của Google để phân tích và không được lưu trên máy chủ của chúng tôi.';

  @override
  String get foodScan_consentTitle => 'Gửi ảnh đến Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Để ước tính calo và các chất dinh dưỡng đa lượng, mỗi ảnh bữa ăn bạn chụp hoặc chọn sẽ được gửi đến dịch vụ AI Gemini của Google. Ảnh chỉ được dùng cho lần phân tích này và không được lưu trên máy chủ của chúng tôi.';

  @override
  String get foodScan_consentAgree => 'Đồng ý và tiếp tục';

  @override
  String get foodScan_analyzing => 'Đang phân tích bữa ăn…';

  @override
  String get foodScan_analyzingHint => 'Quá trình này thường mất vài giây';

  @override
  String get foodScan_detectedItems => 'Món ăn đã nhận diện';

  @override
  String get foodScan_disclaimer =>
      'Ước tính của AI chỉ mang tính tương đối. Nhấn vào một món để chỉnh sửa.';

  @override
  String get foodScan_lowConfidence =>
      'Mô hình chưa chắc chắn về ảnh này. Hãy kiểm tra số liệu trước khi lưu.';

  @override
  String get foodScan_save => 'Thêm vào bữa ăn';

  @override
  String get foodScan_retake => 'Ảnh mới';

  @override
  String get foodScan_retry => 'Thử lại';

  @override
  String get foodScan_editItem => 'Sửa món';

  @override
  String get foodScan_portion => 'Khẩu phần';

  @override
  String get foodScan_saveEdit => 'Lưu';

  @override
  String get foodScan_premiumTitle => 'Tính năng Premium';

  @override
  String get foodScan_premiumDesc =>
      'Phân tích calo từ ảnh được bao gồm trong Premium.';

  @override
  String get foodScan_upgrade => 'Xem Premium';

  @override
  String get foodScan_errorNetwork =>
      'Không có kết nối. Hãy kiểm tra Internet và thử lại.';

  @override
  String get foodScan_errorRateLimited =>
      'Hiện có quá nhiều lượt quét. Hãy thử lại sau vài phút.';

  @override
  String get foodScan_errorUnavailable => 'Hiện không thể phân tích ảnh.';

  @override
  String get foodScan_errorServer =>
      'Dịch vụ phân tích đang gặp sự cố. Hãy thử lại sau ít phút.';

  @override
  String get foodScan_errorNoFood =>
      'Không tìm thấy thức ăn trong ảnh. Hãy thử chụp đĩa rõ hơn.';

  @override
  String get foodScan_errorUnreadable =>
      'Không thể phân tích ảnh này. Hãy thử ảnh khác.';

  @override
  String get paywall_aiFoodScan => 'Quét món ăn bằng AI';

  @override
  String get paywall_aiFoodScanDesc =>
      'Chụp bữa ăn và ghi lại calo cùng chất dinh dưỡng đa lượng trong vài giây';
}
