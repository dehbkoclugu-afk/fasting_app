// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => '좋은 아침이에요';

  @override
  String get greeting_afternoon => '좋은 오후예요';

  @override
  String get greeting_evening => '좋은 저녁이에요';

  @override
  String get tab_timer => '홈';

  @override
  String get tab_explore => '둘러보기';

  @override
  String get tab_stats => '보고서';

  @override
  String get tab_meals => '식사';

  @override
  String get tab_achievements => '업적';

  @override
  String get tab_profile => '계정';

  @override
  String get timer_fasting => '단식 시간';

  @override
  String get timer_remaining => '남은 시간';

  @override
  String get timer_elapsed => '경과 시간';

  @override
  String get timer_start => '시작';

  @override
  String get timer_stop => '중지';

  @override
  String get timer_completed => '축하합니다!';

  @override
  String get timer_completedMessage => '단식을 성공적으로 완료했습니다!';

  @override
  String get timer_selectPlan => '단식 계획 선택';

  @override
  String get timer_stopConfirm => '단식을 일찍 종료하시겠어요?';

  @override
  String get timer_stopTitle => '단식 종료';

  @override
  String get timer_cancel => '취소';

  @override
  String get timer_confirmStop => '예, 종료';

  @override
  String get phase_anabolic => '동화 단계';

  @override
  String get phase_anabolicDesc => '소화 진행 중';

  @override
  String get phase_catabolic => '이화 단계';

  @override
  String get phase_catabolicDesc => '에너지 전환 중';

  @override
  String get phase_fatBurning => '지방 연소';

  @override
  String get phase_fatBurningDesc => '지방 연소가 시작되었습니다';

  @override
  String get phase_ketosis => '케토시스';

  @override
  String get phase_ketosisDesc => '케톤 생성 활성화';

  @override
  String get phase_autophagy => '자가포식';

  @override
  String get phase_autophagyDesc => '세포 재생';

  @override
  String get stats_title => '통계';

  @override
  String get stats_week => '주';

  @override
  String get stats_month => '월';

  @override
  String get stats_year => '년';

  @override
  String get stats_totalFasts => '총 단식 횟수';

  @override
  String get stats_average => '평균';

  @override
  String get stats_fastDuration => '단식 시간';

  @override
  String get stats_streak => '연속 기록';

  @override
  String get stats_daysConsecutive => '연속 일수';

  @override
  String get stats_success => '성공';

  @override
  String get stats_completion => '완료율';

  @override
  String get stats_weeklyFasting => '주간 단식';

  @override
  String get stats_monthlyView => '월간 보기';

  @override
  String get stats_weightChange => '체중 변화';

  @override
  String get heatmap_none => '없음';

  @override
  String get heatmap_low => '낮음';

  @override
  String get heatmap_good => '좋음';

  @override
  String get heatmap_full => '충분';

  @override
  String get meals_title => '식사 계획';

  @override
  String get meals_eatingWindow => '식사 시간';

  @override
  String get meals_windowOpen => '열림';

  @override
  String get meals_windowFasting => '단식 중';

  @override
  String get meals_calories => '칼로리';

  @override
  String get meals_protein => '단백질';

  @override
  String get meals_carbs => '탄수화물';

  @override
  String get meals_fat => '지방';

  @override
  String get meals_todayMeals => '오늘의 식사';

  @override
  String get meals_noMeals => '아직 추가된 식사가 없습니다';

  @override
  String get meals_breakfastSuggestions => '단식 종료 식사 추천';

  @override
  String get meals_addMeal => '식사 추가';

  @override
  String get profile_title => '프로필';

  @override
  String get profile_user => '사용자';

  @override
  String profile_planActive(String plan) {
    return '$plan 계획 활성화됨';
  }

  @override
  String get profile_upgradePremium => 'Premium으로 업그레이드';

  @override
  String get profile_premiumDesc => '모든 단식 계획을 광고 없이';

  @override
  String get profile_bodyMetrics => '신체 지표';

  @override
  String get profile_height => '키';

  @override
  String get profile_weight => '체중';

  @override
  String get profile_targetWeight => '목표 체중';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => '설정';

  @override
  String get profile_notifications => '알림';

  @override
  String get profile_darkTheme => '다크 테마';

  @override
  String get profile_waterReminder => '물 마시기 알림';

  @override
  String get profile_phaseNotifications => '단계 알림';

  @override
  String get profile_language => '언어';

  @override
  String get profile_about => '정보';

  @override
  String get profile_rateApp => '앱 평가';

  @override
  String get profile_share => '공유';

  @override
  String get profile_privacyPolicy => '개인정보 처리방침';

  @override
  String get profile_version => '버전';

  @override
  String get onboarding_welcome => '환영합니다';

  @override
  String get onboarding_welcomeDesc => '간헐적 단식 여정을\n직접 관리하세요';

  @override
  String get onboarding_featureTimer => '스마트 단식 타이머';

  @override
  String get onboarding_featureStats => '상세 통계와 차트';

  @override
  String get onboarding_featureMeals => '식사 계획과 레시피 추천';

  @override
  String get onboarding_getStarted => '시작하기';

  @override
  String get onboarding_selectGoal => '목표가 무엇인가요?';

  @override
  String get onboarding_selectGoalDesc => '여러 개 선택할 수 있습니다';

  @override
  String get onboarding_goalWeight => '체중 감량';

  @override
  String get onboarding_goalWeightDesc => '건강한 체중 감량';

  @override
  String get onboarding_goalHealth => '건강 개선';

  @override
  String get onboarding_goalHealthDesc => '전반적인 건강과 면역력';

  @override
  String get onboarding_goalEnergy => '활력 높이기';

  @override
  String get onboarding_goalEnergyDesc => '하루 종일 활기차게';

  @override
  String get onboarding_goalMental => '맑은 정신';

  @override
  String get onboarding_goalMentalDesc => '집중력과 명료함';

  @override
  String get onboarding_goalLongevity => '장수';

  @override
  String get onboarding_goalLongevityDesc => '세포 재생과 건강한 노화';

  @override
  String get onboarding_goalDiscipline => '절제력';

  @override
  String get onboarding_goalDisciplineDesc => '자기 절제력 기르기';

  @override
  String get onboarding_selectPlan => '계획 선택';

  @override
  String get onboarding_selectPlanDesc => '나에게 가장 적합한 단식 계획을 선택하세요';

  @override
  String get onboarding_bodyInfo => '정보 입력';

  @override
  String get onboarding_bodyInfoDesc => '맞춤 추천을 위해 사용됩니다';

  @override
  String get onboarding_gender => '성별';

  @override
  String get onboarding_male => '남성';

  @override
  String get onboarding_female => '여성';

  @override
  String get onboarding_age => '나이';

  @override
  String get onboarding_bodyInfoDisclaimer => '이 정보는 기기에만 저장되며 칼로리 계산에 사용됩니다.';

  @override
  String get onboarding_permissions => '마지막 단계';

  @override
  String get onboarding_permissionsDesc => '최상의 경험을 위해 권한을 활성화하세요';

  @override
  String get onboarding_next => '계속';

  @override
  String get onboarding_start => '시작해 볼까요!';

  @override
  String get onboarding_skipForNow => '나중에 설정';

  @override
  String get waterAdded => '물 250ml를 추가했습니다';

  @override
  String get languageSelect => '언어 선택';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Premium으로 업그레이드';

  @override
  String get paywall_subtitle => '모든 단식 계획을 잠금 해제하고 광고를 제거하세요';

  @override
  String get paywall_allPlans => '모든 단식 계획';

  @override
  String get paywall_advancedStats => '고급 통계';

  @override
  String get paywall_mealPlanner => '식사 계획';

  @override
  String get paywall_themes => '테마 맞춤 설정';

  @override
  String get paywall_noAds => '광고 없음';

  @override
  String get paywall_weekly => '주간';

  @override
  String get paywall_monthly => '월간';

  @override
  String get paywall_yearly => '연간';

  @override
  String get paywall_bestValue => '최고의 선택';

  @override
  String get paywall_freeTrial => '무료 체험(3일)';

  @override
  String get paywall_restore => '구매 복원';

  @override
  String get paywall_premiumActive => 'Premium 활성화됨!';

  @override
  String get paywall_premiumActiveDesc => '모든 단식 계획이 잠금 해제되고 광고가 꺼졌습니다';

  @override
  String get water_title => '물 섭취량';

  @override
  String get water_addWater => '물 추가';

  @override
  String get water_goal => '목표';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => '확인';

  @override
  String get common_cancel => '취소';

  @override
  String get common_save => '저장';

  @override
  String get common_delete => '삭제';

  @override
  String get common_hours => '시간';

  @override
  String get common_minutes => '분';

  @override
  String get common_days => '일';

  @override
  String get common_enable => '활성화';

  @override
  String get streakCard_currentStreak => '현재 연속 기록';

  @override
  String get streakCard_longestStreak => '최장 연속 기록';

  @override
  String get streakCard_totalSessions => '총 단식 횟수';

  @override
  String get meals_mealType => '식사 유형';

  @override
  String get meals_breakfast => '아침 식사';

  @override
  String get meals_lunch => '점심 식사';

  @override
  String get meals_dinner => '저녁 식사';

  @override
  String get meals_snack => '간식';

  @override
  String get meals_carbohydrate => '탄수화물';

  @override
  String get meals_add => '추가';

  @override
  String get meals_mealName => '식사 이름';

  @override
  String get bodyMetrics_title => '신체 지표';

  @override
  String get bodyMetrics_weight => '체중';

  @override
  String get bodyMetrics_target => '목표';

  @override
  String get bodyMetrics_save => '저장';

  @override
  String get bodyMetrics_history => '기록';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => '아직 데이터가 없습니다';

  @override
  String get meals_quickAdd => '빠른 추가';

  @override
  String get meals_manualEntry => '직접 입력';

  @override
  String meals_added(String name) {
    return '$name 추가됨';
  }

  @override
  String get meals_nameCalorieRequired => '이름과 칼로리를 입력해야 합니다';

  @override
  String get bodyMetrics_addWeight => '체중 추가';

  @override
  String get bodyMetrics_hintWeight => '예: 74.5';

  @override
  String get bodyMetrics_invalidWeight => '올바른 체중을 입력하세요';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '${value}kg 저장됨';
  }

  @override
  String get completion_duration => '기간';

  @override
  String get completion_plan => '계획';

  @override
  String get completion_lastPhase => '마지막 단계';

  @override
  String get completion_earlyTitle => '단식이 종료되었습니다';

  @override
  String get completion_earlyMessage =>
      '오늘의 시간이 저장되었습니다. 목표를 완료하지 않아 연속 기록과 성과 진행도는 변경되지 않았습니다.';

  @override
  String get timer_remainingTime => '남은 시간';

  @override
  String get timer_ready => '시작 준비 완료';

  @override
  String get streak_status => '상태';

  @override
  String get streak_startToday => '오늘 시작하세요!';

  @override
  String get streak_goodStart => '좋은 시작이에요!';

  @override
  String get streak_goingGreat => '아주 잘하고 있어요!';

  @override
  String get streak_superb => '훌륭해요!';

  @override
  String get streak_legendary => '전설적이에요!';

  @override
  String get streak_incredible => '놀라워요!';

  @override
  String get weight_noRecord => '아직 체중 기록이 없습니다\n프로필 > 신체 지표에서 추가하세요';

  @override
  String get day_mon => '월';

  @override
  String get day_tue => '화';

  @override
  String get day_wed => '수';

  @override
  String get day_thu => '목';

  @override
  String get day_fri => '금';

  @override
  String get day_sat => '토';

  @override
  String get day_sun => '일';

  @override
  String get day_short_mon => '월';

  @override
  String get day_short_tue => '화';

  @override
  String get day_short_wed => '수';

  @override
  String get day_short_thu => '목';

  @override
  String get day_short_fri => '금';

  @override
  String get day_short_sat => '토';

  @override
  String get day_short_sun => '일';

  @override
  String get month_jan => '1월';

  @override
  String get month_feb => '2월';

  @override
  String get month_mar => '3월';

  @override
  String get month_apr => '4월';

  @override
  String get month_may => '5월';

  @override
  String get month_jun => '6월';

  @override
  String get month_jul => '7월';

  @override
  String get month_aug => '8월';

  @override
  String get month_sep => '9월';

  @override
  String get month_oct => '10월';

  @override
  String get month_nov => '11월';

  @override
  String get month_dec => '12월';

  @override
  String meals_fastingWindow(String hours) {
    return '단식($hours시간)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return '식사($hours시간)';
  }

  @override
  String get recipe_oatSmoothie => '오트 스무디';

  @override
  String get recipe_avocadoToast => '아보카도 토스트';

  @override
  String get recipe_yogurtBowl => '요거트 볼';

  @override
  String get elapsed_time => '경과 시간';

  @override
  String get fast_ends_on => '단식 종료 시각';

  @override
  String get end_fasting => '단식 종료';

  @override
  String get start_fasting => '단식 시작';

  @override
  String get water_tracker => '물 섭취 추적';

  @override
  String get weight_tracker => '체중 추적';

  @override
  String get drink => '마시기';

  @override
  String get log_weight => '체중 기록';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => '감량 체중';

  @override
  String get current_weight => '현재 체중';

  @override
  String get goal_weight => '목표 체중';

  @override
  String get daily_goal => '일일 목표';

  @override
  String completed_percent(String percent) {
    return '$percent% 완료';
  }

  @override
  String get explore => '둘러보기';

  @override
  String get achievements => '업적';

  @override
  String get profile_theme => '화면 모드';

  @override
  String get theme_select => '화면 모드 선택';

  @override
  String get theme_system => '시스템 기본값';

  @override
  String get theme_light => '라이트';

  @override
  String get theme_dark => '다크';

  @override
  String get language_system => '시스템 언어';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => '완료 소리';

  @override
  String get profile_calmGamification => '차분한 게임 요소';

  @override
  String get profile_calmGamificationDesc => '리그와 시즌의 부담을 줄입니다';

  @override
  String get profile_editName => '이름 수정';

  @override
  String get profile_name => '이름';

  @override
  String get circle_title => '단식 모임';

  @override
  String get circle_you => '나';

  @override
  String get circle_tagline => '부담 없이, 함께해요.';

  @override
  String get circle_privacy => '체중과 개인 지표는 숨겨집니다. 진행 상황과 응원만 표시됩니다.';

  @override
  String circle_sendSupport(int count) {
    return '응원 보내기 · $count';
  }

  @override
  String get circle_inviteCopied => '초대 코드가 복사되었습니다';

  @override
  String get circle_createInvite => '비공개 초대 만들기';

  @override
  String get crisis_nameTitle => '먼저 지금의 상태를 말해 보세요';

  @override
  String get crisis_nameDesc => '배고픔, 습관 또는 감정일 수 있습니다.';

  @override
  String get crisis_waterTitle => '물 한 잔 마시기';

  @override
  String get crisis_waterDesc => '그런 다음 천천히 세 번 호흡하세요.';

  @override
  String get crisis_delayTitle => '결정을 10분 미루기';

  @override
  String get crisis_delayDesc => '몸이 불편하다면 단식을 끝내도 실패가 아닙니다.';

  @override
  String get crisis_hunger => '배고픔';

  @override
  String get crisis_habit => '습관';

  @override
  String get crisis_stress => '스트레스';

  @override
  String get crisis_tenMore => '10분만 더 기다리기';

  @override
  String get stats_storyEmpty => '첫 단식이 나만의 이야기를 시작합니다.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return '이 기간에 $sessions회 단식하고 $hours시간 동안 리듬을 지켰으며 $rate%의 완료율을 달성했습니다.';
  }

  @override
  String get stats_storyTitle => '나의 리듬 이야기';

  @override
  String get home_todayRhythm => '오늘의 리듬';

  @override
  String get home_finalHourSupport => '마지막 한 시간 응원';

  @override
  String get home_needSupport => '조금 응원이 필요해요';

  @override
  String get home_todaySummary => '오늘 한눈에 보기';

  @override
  String get home_dayStreak => '일 연속';

  @override
  String home_weightGoal(String weight) {
    return '목표 ${weight}kg';
  }

  @override
  String get weather_steady => '리듬이 안정적이에요';

  @override
  String get weather_gentle => '편안한 하루';

  @override
  String get weather_water => '물 한 잔이 도움이 될 수 있어요.';

  @override
  String get weather_listen => '여기까지 잘 왔어요. 몸의 신호에 귀 기울이세요.';

  @override
  String get weather_onPlan => '오늘의 속도는 계획과 잘 맞아요.';

  @override
  String get weather_challenging => '이 시간은 전에도 힘들었어요. 지원 모드가 준비되었습니다.';

  @override
  String get replay_copied => '단식 리플레이가 복사되었습니다';

  @override
  String get replay_button => '다시 보기';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return '$plan 단식을 $hours시간 $minutes분 만에 완료했습니다 · $phase';
  }

  @override
  String get journey_label => '대사 여정';

  @override
  String get journey_now => '현재';

  @override
  String journey_next(String time, String phase) {
    return '$phase까지 $time';
  }

  @override
  String get phase_estimateShort => '단계 시간은 일반적인 추정치이며 의학적 측정값이 아닙니다.';

  @override
  String phase_hours(int start, int end) {
    return '$start–$end시간';
  }

  @override
  String get phase_estimateLong => '이 시간은 일반적인 추정치입니다. 대사 반응은 사람마다 다를 수 있습니다.';

  @override
  String get bmi_underweight => '저체중';

  @override
  String get bmi_normal => '정상';

  @override
  String get bmi_overweight => '과체중';

  @override
  String get bmi_obese => '비만';

  @override
  String get notification_halfwayTitle => '절반을 완료했어요! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return '$plan 단식의 절반을 완료했습니다. 계속 힘내세요!';
  }

  @override
  String get notification_phaseCatabolic => '이화 단계에 진입했습니다 📉';

  @override
  String get notification_phaseFatBurning => '지방 연소가 시작되었습니다! 🔥';

  @override
  String get notification_phaseKetosis => '케토시스 상태입니다 ⚡';

  @override
  String get notification_phaseAutophagy => '자가포식이 활성화되었습니다! 🔄';

  @override
  String notification_completedBody(String plan) {
    return '$plan 단식을 완료했습니다! 식사 시간이 열렸습니다.';
  }

  @override
  String get notification_waterTitle => '물을 마시세요 💧';

  @override
  String get notification_waterBody => '단식 중 충분한 수분 섭취를 잊지 마세요!';

  @override
  String get notification_windowTitle => '식사 시간이 곧 종료됩니다 ⏰';

  @override
  String get notification_windowBody => '식사 시간이 30분 후 종료됩니다.';

  @override
  String notification_streakTitle(int days) {
    return '$days일 연속! 🔥';
  }

  @override
  String get notification_streakBody => '아주 잘하고 있어요! 오늘도 계속하세요.';

  @override
  String notification_ongoingTitle(String phase) {
    return '단식 진행 중 - $phase';
  }

  @override
  String notification_remaining(String time) {
    return '남은 시간: $time';
  }

  @override
  String notification_started(String plan) {
    return '단식 시작 - $plan';
  }

  @override
  String notification_target(int hours) {
    return '목표: $hours시간';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String get explore_guide => '단식 가이드';

  @override
  String get explore_guideDesc => '간헐적 단식에 관해 알아야 할 모든 것';

  @override
  String get explore_circleDesc => '비공개 그룹과 조용히 응원을 나누세요.';

  @override
  String get explore_faq => '자주 묻는 질문';

  @override
  String get explore_education => '이 콘텐츠는 일반적인 교육 목적이며 의학적 진단이나 치료 조언이 아닙니다.';

  @override
  String get explore_safety => '건강과 안전';

  @override
  String get explore_safetyDesc =>
      '질환이 있거나 정기적으로 약을 복용하거나 우려되는 증상이 있거나 임신 또는 수유 중이라면 단식 전 자격을 갖춘 의료 전문가와 상담하세요. 몸이 불편하면 중단하세요.';

  @override
  String get explore_sources => '출처';

  @override
  String get explore_sourcesDesc => '아래의 공중 보건 자료를 바탕으로 내용을 간소화했습니다.';

  @override
  String get explore_sourceError => '출처를 열 수 없습니다';

  @override
  String get explore_rules => '중요 규칙';

  @override
  String get explore_rule1 => '단식 중 칼로리가 있는 음식을 섭취하지 마세요';

  @override
  String get explore_rule2 => '물과 수분을 충분히 섭취하세요';

  @override
  String get explore_rule3 => '식사 시간에는 균형 있게 드세요';

  @override
  String get explore_rule4 => '몸이 불편하면 단식을 중단하세요';

  @override
  String get explore_rule5 => '임신 또는 수유 중인 여성은 단식하지 마세요';

  @override
  String get explore_rule6 => '만성 질환이 있다면 의사와 상담하세요';

  @override
  String get tip_water => '수분 유지';

  @override
  String get tip_waterDesc =>
      '목이 마를 때 물을 마시고 식사와 함께 수분을 섭취하세요. 필요량은 건강, 날씨, 활동량에 따라 달라질 수 있습니다.';

  @override
  String get tip_food => '건강하게 먹기';

  @override
  String get tip_foodDesc =>
      '식사 시간에는 섬유질과 건강한 지방이 포함된 고단백 식품을 선택하고 가공식품은 피하세요.';

  @override
  String get tip_sleep => '충분히 자기';

  @override
  String get tip_sleepDesc =>
      '규칙적이고 충분한 수면은 전반적인 건강에 도움이 됩니다. 수면을 방해하지 않도록 단식 시간을 계획하세요.';

  @override
  String get tip_exercise => '가벼운 운동';

  @override
  String get tip_exerciseDesc =>
      '단식 중 가볍게 걷거나 요가를 할 수 있습니다. 몸이 적응하는 첫 몇 주에는 특히 격렬한 운동을 피하세요.';

  @override
  String get tip_drinks => '허용되는 음료';

  @override
  String get tip_drinksDesc =>
      '단식 중에는 물, 무가당 차, 블랙커피(설탕과 우유 제외)를 마실 수 있습니다. 이러한 음료는 단식을 깨지 않습니다.';

  @override
  String get faq_drinks => '단식 중 무엇을 마실 수 있나요?';

  @override
  String get faq_drinksAnswer =>
      '물, 무가당 차, 블랙커피(설탕/우유 제외)를 마실 수 있습니다. 칼로리가 있는 음료는 단식을 깹니다.';

  @override
  String get faq_plan => '어떤 단식 계획을 선택해야 하나요?';

  @override
  String get faq_planAnswer =>
      '초보자는 12:12 또는 14:10으로 시작하세요. 경험이 있다면 16:8 또는 18:6을 시도하세요. 20:4와 OMAD는 숙련자용입니다.';

  @override
  String get faq_exercise => '단식 중 운동해도 되나요?';

  @override
  String get faq_exerciseAnswer =>
      '네. 다만 격렬한 운동은 피하세요. 가벼운 유산소, 걷기, 요가가 좋습니다. 웨이트 트레이닝은 식사 시간과 가깝게 하세요.';

  @override
  String get faq_weight => '단식이 체중 감량에 도움이 되나요?';

  @override
  String get faq_weightAnswer =>
      '일부 사람은 식사 시간을 제한하면 총 에너지 섭취가 줄 수 있습니다. 결과는 사람마다 다르며 장기적 영향은 아직 연구 중입니다.';

  @override
  String get plan_12_desc => '초급';

  @override
  String get plan_12_detail => '초보자에게 적합합니다. 수면 시간을 포함해 12시간 단식합니다.';

  @override
  String get plan_16_desc => '가장 인기 있는 계획';

  @override
  String get plan_16_detail =>
      '가장 일반적인 간헐적 단식 계획입니다. 16시간 단식하고 8시간 식사하며 보통 점심부터 저녁까지입니다.';

  @override
  String get plan_18_desc => '중급';

  @override
  String get plan_18_detail => '18시간 단식하고 6시간 식사합니다. 지방 연소 시간이 더 깁니다.';

  @override
  String get plan_20_desc => '고급';

  @override
  String get plan_20_detail => '20시간 단식하고 4시간 식사합니다. 케토시스와 자가포식에 도달하기에 적합합니다.';

  @override
  String get plan_omad_desc => '하루 한 끼';

  @override
  String get plan_omad_detail => '하루 한 끼. 23시간 단식하고 1시간 식사합니다. 전문가 수준입니다.';

  @override
  String get plan_52_desc => '주 2일';

  @override
  String get plan_52_detail => '5일은 평소대로 먹고 2일은 약 500칼로리만 섭취하는 대안적 방법입니다.';

  @override
  String get plan_ese_desc => '24시간 단식';

  @override
  String get plan_ese_detail => '주 1~2회 24시간 단식합니다. 숙련자용입니다.';

  @override
  String get plan_warrior_desc => '워리어 다이어트';

  @override
  String get plan_warrior_detail => '낮에는 과일과 채소를 가볍게 먹고 저녁 4시간 동안 주 식사를 합니다.';

  @override
  String get award_first_title => '첫걸음';

  @override
  String get award_first_desc => '첫 단식 완료';

  @override
  String get award_rhythm3_title => '3일 리듬';

  @override
  String get award_rhythm3_desc => '3일 동안 리듬 유지';

  @override
  String get award_hours24_title => '24시간';

  @override
  String get award_hours24_desc => '총 24시간 단식';

  @override
  String get award_week_title => '일주일 리듬';

  @override
  String get award_week_desc => '7일 연속 기록 만들기';

  @override
  String get award_fasts10_title => '단식 10회';

  @override
  String get award_fasts10_desc => '단식 10회 완료';

  @override
  String get award_hours100_title => '100시간';

  @override
  String get award_hours100_desc => '총 100시간 달성';

  @override
  String get award_rhythm30_title => '30일 리듬';

  @override
  String get award_rhythm30_desc => '30일 연속 기록 만들기';

  @override
  String get award_fasts50_title => '단식 50회';

  @override
  String get award_fasts50_desc => '단식 50회 완료';

  @override
  String get award_hours500_title => '500시간';

  @override
  String get award_hours500_desc => '총 500시간 달성';

  @override
  String get award_fasts100_title => '단식 100회';

  @override
  String get award_fasts100_desc => '단식 100회 완료';

  @override
  String get award_rhythm90_title => '90일 리듬';

  @override
  String get award_rhythm90_desc => '90일 연속 기록 만들기';

  @override
  String get award_year_title => '1년의 여정';

  @override
  String get award_year_desc => '365일 리듬 달성';

  @override
  String get awards_loadError => '진행 상황을 불러올 수 없습니다';

  @override
  String get awards_journeyComplete => '여정 완료';

  @override
  String get awards_nextGoal => '다음 목표';

  @override
  String get awards_allYours => '모든 업적을 달성했습니다';

  @override
  String get awards_dayStreak => '일 연속';

  @override
  String get awards_fasts => '회 단식';

  @override
  String get awards_total => '총';

  @override
  String get awards_stageStart => '시작';

  @override
  String get awards_stageRhythm => '리듬';

  @override
  String get awards_stageEndurance => '인내';

  @override
  String get awards_stageMastery => '숙련';

  @override
  String get awards_completed => '완료';

  @override
  String awards_fastsRemaining(int count) {
    return '단식 $count회 남음';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count일 남음';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count시간 남음';
  }

  @override
  String get common_retry => '다시 시도';

  @override
  String get game_title => '진행 허브';

  @override
  String get game_quests => '오늘의 퀘스트';

  @override
  String get game_questsDesc => '작은 걸음으로 지속 가능한 리듬을 만드세요.';

  @override
  String get game_season => '30단계 시즌';

  @override
  String get game_seasonDesc => '5단계마다 수집용 도장을 받습니다.';

  @override
  String get game_badges => '배지 모음';

  @override
  String game_shields(int count) {
    return '리듬 방패 $count개';
  }

  @override
  String get game_shieldsDesc => '7회 완료할 때마다 획득합니다. 하루를 놓쳐도 진행 상황은 사라지지 않습니다.';

  @override
  String get game_league => '비공개 주간 리그';

  @override
  String game_leagueDesc(int percent) {
    return '리듬 점수는 비공개 로컬 모델에서 $percent백분위입니다. 체중과 극단적 단식은 절대 순위를 매기지 않습니다.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return '레벨 $level, 경험치 $xp';
  }

  @override
  String get game_explorer => '리듬 탐험가';

  @override
  String get game_streak => '연속 기록';

  @override
  String get game_targets => '목표';

  @override
  String get game_best => '최고';

  @override
  String get quest_rhythm => '오늘의 리듬 만들기';

  @override
  String get quest_hydrate => '물 섭취 목표의 절반 달성';

  @override
  String get quest_steady => '연속 기록 지키기';

  @override
  String get badge_first_title => '첫걸음';

  @override
  String get badge_first_desc => '첫 단식 기록';

  @override
  String get badge_rhythm7_title => '리듬 지킴이';

  @override
  String get badge_rhythm7_desc => '7일 연속 달성';

  @override
  String get badge_rhythm3_title => '3일 리듬';

  @override
  String get badge_rhythm3_desc => '3일 연속 달성';

  @override
  String get badge_target1_title => '첫 목표';

  @override
  String get badge_target1_desc => '첫 목표 단식 완료';

  @override
  String get badge_target3_title => '세 걸음';

  @override
  String get badge_target3_desc => '목표 3개 완료';

  @override
  String get badge_water_title => '균형';

  @override
  String get badge_water_desc => '일일 물 섭취 목표 완료';

  @override
  String get badge_support_title => '자기 인식';

  @override
  String get badge_support_desc => '지원 모드 사용';

  @override
  String get badge_hours10_title => '10시간';

  @override
  String get badge_hours10_desc => '총 10시간 기록';

  @override
  String get badge_target10_title => '힘찬 열 번';

  @override
  String get badge_target10_desc => '목표 10개 완료';

  @override
  String get badge_target20_title => '목표 스무 개';

  @override
  String get badge_target20_desc => '목표 20개 완료';

  @override
  String get badge_fast16_title => '16시간';

  @override
  String get badge_fast16_desc => '한 번의 단식에서 16시간 달성';

  @override
  String get badge_hours50_title => '50시간';

  @override
  String get badge_hours50_desc => '총 50시간 기록';

  @override
  String get badge_hours100_title => '100시간';

  @override
  String get badge_hours100_desc => '총 100시간 기록';

  @override
  String get badge_target30_title => '목표 서른 개';

  @override
  String get badge_target30_desc => '목표 30개 완료';

  @override
  String get badge_rhythm30_title => '30일 리듬';

  @override
  String get badge_rhythm30_desc => '30일 연속 달성';

  @override
  String get paywall_restoreSuccess => '구매가 복원되었습니다!';

  @override
  String fasting_progressSemantics(int percent) {
    return '단식 진행률 $percent퍼센트';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour시간';
  }

  @override
  String get paywall_lifetime => '평생 이용';

  @override
  String get paywall_once => '일회성';

  @override
  String get paywall_processing => '처리 중…';

  @override
  String get paywall_continue => '계속';

  @override
  String get paywall_productsUnavailable => '현재 구매할 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get paywall_purchaseFailed => '구매를 완료할 수 없습니다.';

  @override
  String get paywall_nothingToRestore => '이전 구매를 찾을 수 없습니다.';

  @override
  String get paywall_restoreFailed => '구매를 복원할 수 없습니다.';

  @override
  String get paywall_terms => '이용 약관';

  @override
  String get permission_notificationDesc => '단식 알림, 단계 업데이트 및 완료 알림';

  @override
  String get profile_privacyChoices => '개인정보 선택';

  @override
  String get paywall_autoRenewInfo =>
      '기간 종료 최소 24시간 전에 취소하지 않으면 구독이 자동 갱신됩니다. App Store 설정에서 언제든 관리하거나 취소할 수 있습니다.';

  @override
  String paywall_perMonth(String price) {
    return '월 $price';
  }

  @override
  String paywall_savePercent(int percent) {
    return '$percent% 절약';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days일 무료 체험';
  }

  @override
  String get paywall_startFreeTrial => '무료 체험 시작';

  @override
  String get paywall_retry => '다시 시도';

  @override
  String get paywall_alreadyOwned => '이미 이 구독을 보유하고 있습니다. ‘구매 복원’을 누르세요.';

  @override
  String get paywall_storeUnavailable =>
      '현재 스토어에 연결할 수 없습니다. 연결을 확인하고 다시 시도하세요.';

  @override
  String get paywall_secureNote => '언제든 취소할 수 있습니다. 결제 금액은 스토어 계정으로 청구됩니다.';

  @override
  String get paywall_autoRenewInfoPlay =>
      '기간 종료 최소 24시간 전에 취소하지 않으면 구독이 자동 갱신됩니다. Google Play > 구독에서 언제든 관리하거나 취소할 수 있습니다.';

  @override
  String get paywall_allPlansDesc =>
      '18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat, Warrior 잠금 해제';

  @override
  String get paywall_noAdsDesc => '배너 및 전면 광고가 완전히 꺼집니다';

  @override
  String get foodScan_title => 'AI 음식 스캔';

  @override
  String get foodScan_scanCta => '식사 스캔';

  @override
  String get foodScan_scanCtaDesc => '접시를 촬영하고 칼로리와 주요 영양소를 확인하세요';

  @override
  String get foodScan_introTitle => '접시 촬영';

  @override
  String get foodScan_introDesc => 'AI가 사진을 읽고 칼로리, 단백질, 탄수화물, 지방을 추정합니다.';

  @override
  String get foodScan_tipLight => '밝고 고른 조명에서 더 정확하게 추정됩니다';

  @override
  String get foodScan_tipFrame => '접시 전체가 화면에 들어오게 하세요';

  @override
  String get foodScan_tipScale => '양을 가늠할 수 있도록 식기나 손을 함께 담으세요';

  @override
  String get foodScan_takePhoto => '사진 촬영';

  @override
  String get foodScan_chooseFromGallery => '갤러리에서 선택';

  @override
  String foodScan_scansLeft(int count) {
    return '오늘 스캔 $count회 남음';
  }

  @override
  String get foodScan_quotaReached => '오늘의 스캔 횟수를 모두 사용했습니다. 내일 다시 시도하세요.';

  @override
  String get foodScan_privacyNote =>
      '사진은 분석을 위해 Google Gemini API로 전송되며 당사 서버에는 저장되지 않습니다.';

  @override
  String get foodScan_consentTitle => '사진을 Google Gemini로 보낼까요?';

  @override
  String get foodScan_consentBody =>
      '칼로리와 영양소를 추정하기 위해 촬영하거나 선택한 식사 사진이 Google의 AI 서비스 Gemini로 전송됩니다. 사진은 이 분석에만 사용되며 당사 서버에 저장되지 않습니다.';

  @override
  String get foodScan_consentAgree => '동의하고 계속';

  @override
  String get foodScan_analyzing => '식사 분석 중…';

  @override
  String get foodScan_analyzingHint => '보통 몇 초 정도 걸립니다';

  @override
  String get foodScan_detectedItems => '감지된 음식';

  @override
  String get foodScan_disclaimer => 'AI 추정치는 대략적인 값입니다. 항목을 눌러 수정하세요.';

  @override
  String get foodScan_lowConfidence => '모델이 이 사진을 확신하지 못합니다. 저장 전에 수치를 확인하세요.';

  @override
  String get foodScan_save => '식사에 추가';

  @override
  String get foodScan_retake => '새 사진';

  @override
  String get foodScan_retry => '다시 시도';

  @override
  String get foodScan_editItem => '항목 수정';

  @override
  String get foodScan_portion => '분량';

  @override
  String get foodScan_saveEdit => '저장';

  @override
  String get foodScan_premiumTitle => 'Premium 기능';

  @override
  String get foodScan_premiumDesc => '사진 칼로리 분석은 Premium에 포함됩니다.';

  @override
  String get foodScan_upgrade => 'Premium 보기';

  @override
  String get foodScan_errorNetwork => '연결되지 않았습니다. 인터넷 연결을 확인하고 다시 시도하세요.';

  @override
  String get foodScan_errorRateLimited => '현재 스캔 요청이 너무 많습니다. 몇 분 후 다시 시도하세요.';

  @override
  String get foodScan_errorUnavailable => '현재 사진 분석을 사용할 수 없습니다.';

  @override
  String get foodScan_errorServer => '분석 서비스에 문제가 있습니다. 잠시 후 다시 시도하세요.';

  @override
  String get foodScan_errorNoFood => '사진에서 음식을 찾지 못했습니다. 접시를 더 선명하게 촬영하세요.';

  @override
  String get foodScan_errorUnreadable => '이 사진을 분석할 수 없습니다. 다른 사진을 시도하세요.';

  @override
  String get paywall_aiFoodScan => 'AI 음식 스캔';

  @override
  String get paywall_aiFoodScanDesc => '식사를 촬영하고 몇 초 만에 칼로리와 주요 영양소를 기록하세요';
}
