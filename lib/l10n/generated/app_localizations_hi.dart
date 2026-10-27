// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'सुप्रभात';

  @override
  String get greeting_afternoon => 'नमस्कार';

  @override
  String get greeting_evening => 'शुभ संध्या';

  @override
  String get tab_timer => 'होम';

  @override
  String get tab_explore => 'खोजें';

  @override
  String get tab_stats => 'रिपोर्ट';

  @override
  String get tab_meals => 'भोजन';

  @override
  String get tab_achievements => 'उपलब्धियाँ';

  @override
  String get tab_profile => 'खाता';

  @override
  String get timer_fasting => 'उपवास का समय';

  @override
  String get timer_remaining => 'शेष';

  @override
  String get timer_elapsed => 'बीता समय';

  @override
  String get timer_start => 'शुरू करें';

  @override
  String get timer_stop => 'रोकें';

  @override
  String get timer_completed => 'बधाई हो!';

  @override
  String get timer_completedMessage => 'आपने अपना उपवास सफलतापूर्वक पूरा किया!';

  @override
  String get timer_selectPlan => 'उपवास योजना चुनें';

  @override
  String get timer_stopConfirm =>
      'क्या आप उपवास समय से पहले समाप्त करना चाहते हैं?';

  @override
  String get timer_stopTitle => 'उपवास समाप्त करें';

  @override
  String get timer_cancel => 'रद्द करें';

  @override
  String get timer_confirmStop => 'हाँ, समाप्त करें';

  @override
  String get phase_anabolic => 'उपचय चरण';

  @override
  String get phase_anabolicDesc => 'पाचन जारी है';

  @override
  String get phase_catabolic => 'अपचय चरण';

  @override
  String get phase_catabolicDesc => 'ऊर्जा परिवर्तन';

  @override
  String get phase_fatBurning => 'वसा दहन';

  @override
  String get phase_fatBurningDesc => 'वसा जलना शुरू हुआ';

  @override
  String get phase_ketosis => 'कीटोसिस';

  @override
  String get phase_ketosisDesc => 'कीटोन उत्पादन सक्रिय';

  @override
  String get phase_autophagy => 'ऑटोफैजी';

  @override
  String get phase_autophagyDesc => 'कोशिका नवीनीकरण';

  @override
  String get stats_title => 'आँकड़े';

  @override
  String get stats_week => 'सप्ताह';

  @override
  String get stats_month => 'महीना';

  @override
  String get stats_year => 'वर्ष';

  @override
  String get stats_totalFasts => 'कुल उपवास';

  @override
  String get stats_average => 'औसत';

  @override
  String get stats_fastDuration => 'उपवास अवधि';

  @override
  String get stats_streak => 'लगातार क्रम';

  @override
  String get stats_daysConsecutive => 'लगातार दिन';

  @override
  String get stats_success => 'सफलता';

  @override
  String get stats_completion => 'पूर्णता';

  @override
  String get stats_weeklyFasting => 'साप्ताहिक उपवास';

  @override
  String get stats_monthlyView => 'मासिक दृश्य';

  @override
  String get stats_weightChange => 'वजन में बदलाव';

  @override
  String get heatmap_none => 'कोई नहीं';

  @override
  String get heatmap_low => 'कम';

  @override
  String get heatmap_good => 'अच्छा';

  @override
  String get heatmap_full => 'पूरा';

  @override
  String get meals_title => 'भोजन योजनाकार';

  @override
  String get meals_eatingWindow => 'भोजन अवधि';

  @override
  String get meals_windowOpen => 'खुली है';

  @override
  String get meals_windowFasting => 'उपवास जारी';

  @override
  String get meals_calories => 'कैलोरी';

  @override
  String get meals_protein => 'प्रोटीन';

  @override
  String get meals_carbs => 'कार्बोहाइड्रेट';

  @override
  String get meals_fat => 'वसा';

  @override
  String get meals_todayMeals => 'आज के भोजन';

  @override
  String get meals_noMeals => 'अभी कोई भोजन नहीं जोड़ा गया';

  @override
  String get meals_breakfastSuggestions => 'उपवास खोलने के सुझाव';

  @override
  String get meals_addMeal => 'भोजन जोड़ें';

  @override
  String get profile_title => 'प्रोफ़ाइल';

  @override
  String get profile_user => 'उपयोगकर्ता';

  @override
  String profile_planActive(String plan) {
    return '$plan योजना सक्रिय';
  }

  @override
  String get profile_upgradePremium => 'Premium में अपग्रेड करें';

  @override
  String get profile_premiumDesc => 'सभी उपवास योजनाएँ, बिना विज्ञापन';

  @override
  String get profile_bodyMetrics => 'शारीरिक माप';

  @override
  String get profile_height => 'कद';

  @override
  String get profile_weight => 'वजन';

  @override
  String get profile_targetWeight => 'लक्षित वजन';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'सेटिंग्स';

  @override
  String get profile_notifications => 'सूचनाएँ';

  @override
  String get profile_darkTheme => 'डार्क थीम';

  @override
  String get profile_waterReminder => 'पानी पीने का रिमाइंडर';

  @override
  String get profile_phaseNotifications => 'चरण सूचनाएँ';

  @override
  String get profile_language => 'भाषा';

  @override
  String get profile_about => 'परिचय';

  @override
  String get profile_rateApp => 'ऐप को रेट करें';

  @override
  String get profile_share => 'साझा करें';

  @override
  String get profile_privacyPolicy => 'गोपनीयता नीति';

  @override
  String get profile_version => 'संस्करण';

  @override
  String get onboarding_welcome => 'स्वागत है';

  @override
  String get onboarding_welcomeDesc =>
      'अपनी अंतराल उपवास यात्रा का\nनियंत्रण अपने हाथ में लें';

  @override
  String get onboarding_featureTimer => 'स्मार्ट उपवास टाइमर';

  @override
  String get onboarding_featureStats => 'विस्तृत आँकड़े और चार्ट';

  @override
  String get onboarding_featureMeals => 'भोजन योजना और रेसिपी सुझाव';

  @override
  String get onboarding_getStarted => 'शुरू करें';

  @override
  String get onboarding_selectGoal => 'आपका लक्ष्य क्या है?';

  @override
  String get onboarding_selectGoalDesc => 'आप एक से अधिक चुन सकते हैं';

  @override
  String get onboarding_goalWeight => 'वजन घटाएँ';

  @override
  String get onboarding_goalWeightDesc => 'स्वस्थ तरीके से वजन घटाना';

  @override
  String get onboarding_goalHealth => 'स्वास्थ्य सुधारें';

  @override
  String get onboarding_goalHealthDesc => 'समग्र स्वास्थ्य और प्रतिरक्षा';

  @override
  String get onboarding_goalEnergy => 'अधिक ऊर्जा';

  @override
  String get onboarding_goalEnergyDesc => 'दिन भर ऊर्जा';

  @override
  String get onboarding_goalMental => 'मानसिक स्पष्टता';

  @override
  String get onboarding_goalMentalDesc => 'एकाग्रता और स्पष्टता';

  @override
  String get onboarding_goalLongevity => 'दीर्घायु';

  @override
  String get onboarding_goalLongevityDesc =>
      'कोशिका नवीनीकरण और स्वस्थ उम्र बढ़ना';

  @override
  String get onboarding_goalDiscipline => 'अनुशासन';

  @override
  String get onboarding_goalDisciplineDesc => 'आत्म-अनुशासन विकसित करें';

  @override
  String get onboarding_selectPlan => 'अपनी योजना चुनें';

  @override
  String get onboarding_selectPlanDesc =>
      'अपने लिए सबसे अच्छी उपवास योजना चुनें';

  @override
  String get onboarding_bodyInfo => 'अपनी जानकारी दर्ज करें';

  @override
  String get onboarding_bodyInfoDesc => 'व्यक्तिगत सुझावों के लिए';

  @override
  String get onboarding_gender => 'लिंग';

  @override
  String get onboarding_male => 'पुरुष';

  @override
  String get onboarding_female => 'महिला';

  @override
  String get onboarding_age => 'आयु';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'यह जानकारी केवल आपके डिवाइस पर सहेजी जाती है और कैलोरी गणना के लिए उपयोग होती है।';

  @override
  String get onboarding_permissions => 'अंतिम चरण';

  @override
  String get onboarding_permissionsDesc =>
      'बेहतरीन अनुभव के लिए अनुमतियाँ चालू करें';

  @override
  String get onboarding_next => 'जारी रखें';

  @override
  String get onboarding_start => 'चलिए शुरू करें!';

  @override
  String get onboarding_skipForNow => 'बाद में सेट करें';

  @override
  String get waterAdded => '250 मि.ली. पानी जोड़ा गया';

  @override
  String get languageSelect => 'भाषा चुनें';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Premium में अपग्रेड करें';

  @override
  String get paywall_subtitle =>
      'सभी उपवास योजनाएँ अनलॉक करें और विज्ञापन हटाएँ';

  @override
  String get paywall_allPlans => 'सभी उपवास योजनाएँ';

  @override
  String get paywall_advancedStats => 'उन्नत आँकड़े';

  @override
  String get paywall_mealPlanner => 'भोजन योजनाकार';

  @override
  String get paywall_themes => 'थीम अनुकूलन';

  @override
  String get paywall_noAds => 'कोई विज्ञापन नहीं';

  @override
  String get paywall_weekly => 'साप्ताहिक';

  @override
  String get paywall_monthly => 'मासिक';

  @override
  String get paywall_yearly => 'वार्षिक';

  @override
  String get paywall_bestValue => 'सबसे अच्छा मूल्य';

  @override
  String get paywall_freeTrial => 'निःशुल्क परीक्षण (3 दिन)';

  @override
  String get paywall_restore => 'खरीदारी पुनर्स्थापित करें';

  @override
  String get paywall_premiumActive => 'Premium सक्रिय है!';

  @override
  String get paywall_premiumActiveDesc =>
      'सभी उपवास योजनाएँ अनलॉक हैं और विज्ञापन बंद हैं';

  @override
  String get water_title => 'पानी का सेवन';

  @override
  String get water_addWater => 'पानी जोड़ें';

  @override
  String get water_goal => 'लक्ष्य';

  @override
  String get water_ml => 'मि.ली.';

  @override
  String get common_ok => 'ठीक है';

  @override
  String get common_cancel => 'रद्द करें';

  @override
  String get common_save => 'सहेजें';

  @override
  String get common_delete => 'हटाएँ';

  @override
  String get common_hours => 'घंटे';

  @override
  String get common_minutes => 'मिनट';

  @override
  String get common_days => 'दिन';

  @override
  String get common_enable => 'चालू करें';

  @override
  String get streakCard_currentStreak => 'वर्तमान क्रम';

  @override
  String get streakCard_longestStreak => 'सबसे लंबा क्रम';

  @override
  String get streakCard_totalSessions => 'कुल उपवास';

  @override
  String get meals_mealType => 'भोजन का प्रकार';

  @override
  String get meals_breakfast => 'नाश्ता';

  @override
  String get meals_lunch => 'दोपहर का भोजन';

  @override
  String get meals_dinner => 'रात का भोजन';

  @override
  String get meals_snack => 'हल्का नाश्ता';

  @override
  String get meals_carbohydrate => 'कार्बोहाइड्रेट';

  @override
  String get meals_add => 'जोड़ें';

  @override
  String get meals_mealName => 'भोजन का नाम';

  @override
  String get bodyMetrics_title => 'शारीरिक माप';

  @override
  String get bodyMetrics_weight => 'वजन';

  @override
  String get bodyMetrics_target => 'लक्ष्य';

  @override
  String get bodyMetrics_save => 'सहेजें';

  @override
  String get bodyMetrics_history => 'इतिहास';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'अभी कोई डेटा नहीं';

  @override
  String get meals_quickAdd => 'तुरंत जोड़ें';

  @override
  String get meals_manualEntry => 'मैन्युअल प्रविष्टि';

  @override
  String meals_added(String name) {
    return '$name जोड़ा गया';
  }

  @override
  String get meals_nameCalorieRequired => 'नाम और कैलोरी आवश्यक हैं';

  @override
  String get bodyMetrics_addWeight => 'वजन जोड़ें';

  @override
  String get bodyMetrics_hintWeight => 'जैसे 74.5';

  @override
  String get bodyMetrics_invalidWeight => 'सही वजन दर्ज करें';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value किग्रा सहेजा गया';
  }

  @override
  String get completion_duration => 'अवधि';

  @override
  String get completion_plan => 'योजना';

  @override
  String get completion_lastPhase => 'अंतिम चरण';

  @override
  String get completion_earlyTitle => 'उपवास समाप्त हुआ';

  @override
  String get completion_earlyMessage =>
      'आज की अवधि सहेज ली गई। लक्ष्य पूरा न होने के कारण स्ट्रीक और उपलब्धि की प्रगति नहीं बदली।';

  @override
  String get timer_remainingTime => 'शेष समय';

  @override
  String get timer_ready => 'शुरू करने के लिए तैयार';

  @override
  String get streak_status => 'स्थिति';

  @override
  String get streak_startToday => 'आज शुरू करें!';

  @override
  String get streak_goodStart => 'अच्छी शुरुआत!';

  @override
  String get streak_goingGreat => 'बहुत अच्छा चल रहा है!';

  @override
  String get streak_superb => 'शानदार!';

  @override
  String get streak_legendary => 'अद्भुत!';

  @override
  String get streak_incredible => 'अविश्वसनीय!';

  @override
  String get weight_noRecord =>
      'अभी कोई वजन रिकॉर्ड नहीं\nप्रोफ़ाइल > शारीरिक माप से जोड़ें';

  @override
  String get day_mon => 'सोम';

  @override
  String get day_tue => 'मंगल';

  @override
  String get day_wed => 'बुध';

  @override
  String get day_thu => 'गुरु';

  @override
  String get day_fri => 'शुक्र';

  @override
  String get day_sat => 'शनि';

  @override
  String get day_sun => 'रवि';

  @override
  String get day_short_mon => 'सो';

  @override
  String get day_short_tue => 'मं';

  @override
  String get day_short_wed => 'बु';

  @override
  String get day_short_thu => 'गु';

  @override
  String get day_short_fri => 'शु';

  @override
  String get day_short_sat => 'श';

  @override
  String get day_short_sun => 'र';

  @override
  String get month_jan => 'जनवरी';

  @override
  String get month_feb => 'फ़रवरी';

  @override
  String get month_mar => 'मार्च';

  @override
  String get month_apr => 'अप्रैल';

  @override
  String get month_may => 'मई';

  @override
  String get month_jun => 'जून';

  @override
  String get month_jul => 'जुलाई';

  @override
  String get month_aug => 'अगस्त';

  @override
  String get month_sep => 'सितंबर';

  @override
  String get month_oct => 'अक्टूबर';

  @override
  String get month_nov => 'नवंबर';

  @override
  String get month_dec => 'दिसंबर';

  @override
  String meals_fastingWindow(String hours) {
    return 'उपवास ($hours घंटे)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'भोजन ($hours घंटे)';
  }

  @override
  String get recipe_oatSmoothie => 'ओट स्मूदी';

  @override
  String get recipe_avocadoToast => 'एवोकाडो टोस्ट';

  @override
  String get recipe_yogurtBowl => 'योगर्ट बाउल';

  @override
  String get elapsed_time => 'बीता समय';

  @override
  String get fast_ends_on => 'आपका उपवास समाप्त होगा';

  @override
  String get end_fasting => 'उपवास समाप्त करें';

  @override
  String get start_fasting => 'उपवास शुरू करें';

  @override
  String get water_tracker => 'पानी ट्रैकर';

  @override
  String get weight_tracker => 'वजन ट्रैकर';

  @override
  String get drink => 'पिएँ';

  @override
  String get log_weight => 'वजन दर्ज करें';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'घटा हुआ वजन';

  @override
  String get current_weight => 'वर्तमान वजन';

  @override
  String get goal_weight => 'लक्षित वजन';

  @override
  String get daily_goal => 'दैनिक लक्ष्य';

  @override
  String completed_percent(String percent) {
    return '$percent% पूरा';
  }

  @override
  String get explore => 'खोजें';

  @override
  String get achievements => 'उपलब्धियाँ';

  @override
  String get profile_theme => 'रूप-रंग';

  @override
  String get theme_select => 'रूप-रंग चुनें';

  @override
  String get theme_system => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get theme_light => 'हल्का';

  @override
  String get theme_dark => 'गहरा';

  @override
  String get language_system => 'सिस्टम भाषा';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'पूर्णता ध्वनि';

  @override
  String get profile_calmGamification => 'शांत गेमिफ़िकेशन';

  @override
  String get profile_calmGamificationDesc => 'लीग और सीज़न का दबाव कम करता है';

  @override
  String get profile_editName => 'अपना नाम बदलें';

  @override
  String get profile_name => 'नाम';

  @override
  String get circle_title => 'उपवास मंडली';

  @override
  String get circle_you => 'आप';

  @override
  String get circle_tagline => 'बिना दबाव, साथ-साथ।';

  @override
  String get circle_privacy =>
      'वजन और निजी माप छिपे रहते हैं। केवल प्रगति और सहयोग दिखाई देते हैं।';

  @override
  String circle_sendSupport(int count) {
    return 'सहयोग भेजें · $count';
  }

  @override
  String get circle_inviteCopied => 'आमंत्रण कोड कॉपी हुआ';

  @override
  String get circle_createInvite => 'निजी आमंत्रण बनाएँ';

  @override
  String get crisis_nameTitle => 'पहले बताएँ कि क्या हो रहा है';

  @override
  String get crisis_nameDesc => 'यह भूख, आदत या भावना हो सकती है।';

  @override
  String get crisis_waterTitle => 'एक गिलास पानी पिएँ';

  @override
  String get crisis_waterDesc => 'फिर तीन धीमी साँसें लें।';

  @override
  String get crisis_delayTitle => 'निर्णय को 10 मिनट टालें';

  @override
  String get crisis_delayDesc =>
      'यदि आप अस्वस्थ महसूस करें तो उपवास समाप्त करना असफलता नहीं है।';

  @override
  String get crisis_hunger => 'भूख';

  @override
  String get crisis_habit => 'आदत';

  @override
  String get crisis_stress => 'तनाव';

  @override
  String get crisis_tenMore => 'इसे 10 मिनट दें';

  @override
  String get stats_storyEmpty => 'आपका पहला उपवास आपकी निजी कहानी शुरू करेगा।';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'इस अवधि में आपने $sessions बार उपवास किया, $hours घंटे अपनी लय बनाए रखी और $rate% पूर्णता दर हासिल की।';
  }

  @override
  String get stats_storyTitle => 'आपकी लय की कहानी';

  @override
  String get home_todayRhythm => 'आज की लय';

  @override
  String get home_finalHourSupport => 'अंतिम घंटे का सहयोग';

  @override
  String get home_needSupport => 'मुझे थोड़ा सहयोग चाहिए';

  @override
  String get home_todaySummary => 'आज एक नज़र में';

  @override
  String get home_dayStreak => 'दिन का क्रम';

  @override
  String home_weightGoal(String weight) {
    return 'लक्ष्य $weight किग्रा';
  }

  @override
  String get weather_steady => 'आपकी लय स्थिर है';

  @override
  String get weather_gentle => 'एक सहज दिन';

  @override
  String get weather_water => 'एक गिलास पानी मदद कर सकता है।';

  @override
  String get weather_listen => 'आप बहुत आगे आ चुके हैं; अपने शरीर की सुनें।';

  @override
  String get weather_onPlan => 'आज की गति आपकी योजना के अनुरूप है।';

  @override
  String get weather_challenging => 'यह घंटा पहले कठिन था; सहयोग मोड तैयार है।';

  @override
  String get replay_copied => 'उपवास रीप्ले कॉपी हुआ';

  @override
  String get replay_button => 'रीप्ले';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'मैंने $plan उपवास $hoursघं $minutesमि में पूरा किया · $phase';
  }

  @override
  String get journey_label => 'चयापचय यात्रा';

  @override
  String get journey_now => 'अभी';

  @override
  String journey_next(String time, String phase) {
    return '$phase तक $time';
  }

  @override
  String get phase_estimateShort =>
      'चरण का समय सामान्य अनुमान है, चिकित्सकीय माप नहीं।';

  @override
  String phase_hours(int start, int end) {
    return 'घंटे $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'यह समय सामान्य अनुमान है। चयापचय प्रतिक्रियाएँ हर व्यक्ति में अलग हो सकती हैं।';

  @override
  String get bmi_underweight => 'कम वजन';

  @override
  String get bmi_normal => 'सामान्य';

  @override
  String get bmi_overweight => 'अधिक वजन';

  @override
  String get bmi_obese => 'मोटापा';

  @override
  String get notification_halfwayTitle => 'आधा रास्ता पूरा! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'आपने $plan उपवास का आधा हिस्सा पूरा किया। जारी रखें!';
  }

  @override
  String get notification_phaseCatabolic => 'अपचय चरण शुरू हुआ 📉';

  @override
  String get notification_phaseFatBurning => 'वसा दहन शुरू हुआ! 🔥';

  @override
  String get notification_phaseKetosis => 'आप कीटोसिस में हैं ⚡';

  @override
  String get notification_phaseAutophagy => 'ऑटोफैजी सक्रिय! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'आपने $plan उपवास पूरा किया! आपकी भोजन अवधि खुली है।';
  }

  @override
  String get notification_waterTitle => 'पानी पिएँ 💧';

  @override
  String get notification_waterBody =>
      'उपवास के दौरान पर्याप्त पानी पीना न भूलें!';

  @override
  String get notification_windowTitle => 'भोजन अवधि बंद होने वाली है ⏰';

  @override
  String get notification_windowBody => 'आपकी भोजन अवधि 30 मिनट में बंद होगी।';

  @override
  String notification_streakTitle(int days) {
    return '$days दिन का क्रम! 🔥';
  }

  @override
  String get notification_streakBody =>
      'आप बहुत अच्छा कर रहे हैं! आज भी जारी रखें।';

  @override
  String notification_ongoingTitle(String phase) {
    return 'उपवास जारी - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'शेष: $time';
  }

  @override
  String notification_started(String plan) {
    return 'उपवास शुरू - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'लक्ष्य: $hours घंटे';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hoursघं $minutesमि';
  }

  @override
  String get explore_guide => 'उपवास मार्गदर्शिका';

  @override
  String get explore_guideDesc => 'अंतराल उपवास के बारे में जानने योग्य सब कुछ';

  @override
  String get explore_circleDesc => 'अपने निजी समूह के साथ सहज सहयोग साझा करें।';

  @override
  String get explore_faq => 'अक्सर पूछे जाने वाले प्रश्न';

  @override
  String get explore_education =>
      'यह सामग्री केवल सामान्य शिक्षा के लिए है, चिकित्सकीय निदान या उपचार सलाह नहीं।';

  @override
  String get explore_safety => 'स्वास्थ्य और सुरक्षा';

  @override
  String get explore_safetyDesc =>
      'यदि आपको कोई बीमारी है, आप नियमित दवा लेते हैं, चिंताजनक लक्षण हैं, आप गर्भवती हैं या स्तनपान करा रही हैं, तो उपवास से पहले योग्य स्वास्थ्य विशेषज्ञ से सलाह लें। अस्वस्थ लगने पर रुक जाएँ।';

  @override
  String get explore_sources => 'स्रोत';

  @override
  String get explore_sourcesDesc =>
      'सामग्री को नीचे दिए सार्वजनिक स्वास्थ्य संदर्भों से सरल बनाया गया है।';

  @override
  String get explore_sourceError => 'स्रोत नहीं खोला जा सका';

  @override
  String get explore_rules => 'महत्वपूर्ण नियम';

  @override
  String get explore_rule1 => 'उपवास में कैलोरी वाला भोजन न लें';

  @override
  String get explore_rule2 => 'पर्याप्त पानी और तरल पिएँ';

  @override
  String get explore_rule3 => 'भोजन अवधि में संतुलित आहार लें';

  @override
  String get explore_rule4 => 'अस्वस्थ लगने पर उपवास रोकें';

  @override
  String get explore_rule5 =>
      'गर्भवती या स्तनपान कराने वाली महिलाओं को उपवास नहीं करना चाहिए';

  @override
  String get explore_rule6 => 'पुरानी बीमारी हो तो डॉक्टर से सलाह लें';

  @override
  String get tip_water => 'शरीर में पानी बनाए रखें';

  @override
  String get tip_waterDesc =>
      'प्यास लगने पर पानी पिएँ और भोजन के साथ तरल लें। आवश्यकता स्वास्थ्य, मौसम और गतिविधि के अनुसार बदल सकती है।';

  @override
  String get tip_food => 'सही खाएँ';

  @override
  String get tip_foodDesc =>
      'भोजन अवधि में फाइबर और स्वस्थ वसा वाले प्रोटीन-समृद्ध खाद्य चुनें। प्रसंस्कृत भोजन से बचें।';

  @override
  String get tip_sleep => 'अच्छी नींद लें';

  @override
  String get tip_sleepDesc =>
      'नियमित और पर्याप्त नींद समग्र स्वास्थ्य में सहायक है। उपवास ऐसे रखें कि नींद बाधित न हो।';

  @override
  String get tip_exercise => 'हल्का व्यायाम';

  @override
  String get tip_exerciseDesc =>
      'उपवास में हल्की सैर या योग कर सकते हैं। भारी व्यायाम से बचें, खासकर शुरुआती हफ्तों में जब शरीर अनुकूल हो रहा हो।';

  @override
  String get tip_drinks => 'अनुमत पेय';

  @override
  String get tip_drinksDesc =>
      'उपवास में पानी, सादी चाय और ब्लैक कॉफ़ी (बिना चीनी और दूध) ले सकते हैं। ये पेय उपवास नहीं तोड़ेंगे।';

  @override
  String get faq_drinks => 'उपवास में क्या पी सकता हूँ?';

  @override
  String get faq_drinksAnswer =>
      'आप पानी, सादी चाय और ब्लैक कॉफ़ी (बिना चीनी/दूध) पी सकते हैं। कैलोरी वाले पेय उपवास तोड़ते हैं।';

  @override
  String get faq_plan => 'मुझे कौन-सी उपवास योजना चुननी चाहिए?';

  @override
  String get faq_planAnswer =>
      'यदि आप नए हैं तो 12:12 या 14:10 से शुरू करें। अनुभवी हैं तो 16:8 या 18:6 आज़माएँ। 20:4 और OMAD उन्नत उपवास करने वालों के लिए हैं।';

  @override
  String get faq_exercise => 'क्या उपवास में व्यायाम कर सकता हूँ?';

  @override
  String get faq_exerciseAnswer =>
      'हाँ, लेकिन तीव्र कसरत से बचें। हल्का कार्डियो, पैदल चलना और योग आदर्श हैं। वजन प्रशिक्षण भोजन अवधि के पास रखें।';

  @override
  String get faq_weight => 'क्या उपवास वजन घटाने में मदद करता है?';

  @override
  String get faq_weightAnswer =>
      'कुछ लोगों में भोजन का समय सीमित करने से कुल ऊर्जा सेवन घट सकता है। परिणाम अलग-अलग होते हैं और दीर्घकालीन प्रभावों का अभी अध्ययन जारी है।';

  @override
  String get plan_12_desc => 'शुरुआती स्तर';

  @override
  String get plan_12_detail =>
      'शुरुआती लोगों के लिए आदर्श। नींद सहित 12 घंटे उपवास करें।';

  @override
  String get plan_16_desc => 'सबसे लोकप्रिय योजना';

  @override
  String get plan_16_detail =>
      'सबसे आम अंतराल उपवास योजना। 16 घंटे उपवास, 8 घंटे भोजन। सामान्यतः दोपहर से रात के भोजन तक।';

  @override
  String get plan_18_desc => 'मध्यम स्तर';

  @override
  String get plan_18_detail =>
      '18 घंटे उपवास, 6 घंटे भोजन। वसा दहन की अवधि अधिक।';

  @override
  String get plan_20_desc => 'उन्नत स्तर';

  @override
  String get plan_20_detail =>
      '20 घंटे उपवास, 4 घंटे भोजन। कीटोसिस और ऑटोफैजी तक पहुँचने के लिए उपयुक्त।';

  @override
  String get plan_omad_desc => 'दिन में एक भोजन';

  @override
  String get plan_omad_detail =>
      'दिन में एक भोजन। 23 घंटे उपवास, 1 घंटे भोजन। विशेषज्ञ स्तर।';

  @override
  String get plan_52_desc => 'सप्ताह में 2 दिन';

  @override
  String get plan_52_detail =>
      '5 दिन सामान्य खाएँ, 2 दिन केवल लगभग 500 कैलोरी। एक वैकल्पिक तरीका।';

  @override
  String get plan_ese_desc => '24 घंटे का उपवास';

  @override
  String get plan_ese_detail =>
      'सप्ताह में 1–2 बार 24 घंटे उपवास करें। उन्नत उपयोगकर्ताओं के लिए।';

  @override
  String get plan_warrior_desc => 'वॉरियर डाइट';

  @override
  String get plan_warrior_detail =>
      'दिन में हल्का खाएँ (फल, सब्ज़ियाँ), शाम की 4 घंटे की अवधि में मुख्य भोजन लें।';

  @override
  String get award_first_title => 'पहला कदम';

  @override
  String get award_first_desc => 'अपना पहला उपवास पूरा करें';

  @override
  String get award_rhythm3_title => '3-दिवसीय लय';

  @override
  String get award_rhythm3_desc => 'तीन दिन अपनी लय बनाए रखें';

  @override
  String get award_hours24_title => '24 घंटे';

  @override
  String get award_hours24_desc => 'कुल 24 घंटे उपवास करें';

  @override
  String get award_week_title => 'एक-सप्ताह की लय';

  @override
  String get award_week_desc => 'सात दिन का क्रम बनाएँ';

  @override
  String get award_fasts10_title => '10 उपवास';

  @override
  String get award_fasts10_desc => 'दस उपवास पूरे करें';

  @override
  String get award_hours100_title => '100 घंटे';

  @override
  String get award_hours100_desc => 'कुल 100 घंटे तक पहुँचें';

  @override
  String get award_rhythm30_title => '30-दिवसीय लय';

  @override
  String get award_rhythm30_desc => 'तीस दिन का क्रम बनाएँ';

  @override
  String get award_fasts50_title => '50 उपवास';

  @override
  String get award_fasts50_desc => 'पचास उपवास पूरे करें';

  @override
  String get award_hours500_title => '500 घंटे';

  @override
  String get award_hours500_desc => 'कुल 500 घंटे तक पहुँचें';

  @override
  String get award_fasts100_title => '100 उपवास';

  @override
  String get award_fasts100_desc => 'एक सौ उपवास पूरे करें';

  @override
  String get award_rhythm90_title => '90-दिवसीय लय';

  @override
  String get award_rhythm90_desc => 'नब्बे दिन का क्रम बनाएँ';

  @override
  String get award_year_title => 'एक-वर्षीय यात्रा';

  @override
  String get award_year_desc => '365 दिन की लय तक पहुँचें';

  @override
  String get awards_loadError => 'प्रगति लोड नहीं हो सकी';

  @override
  String get awards_journeyComplete => 'यात्रा पूरी';

  @override
  String get awards_nextGoal => 'अगला लक्ष्य';

  @override
  String get awards_allYours => 'हर उपलब्धि आपकी है';

  @override
  String get awards_dayStreak => 'दिन का क्रम';

  @override
  String get awards_fasts => 'उपवास';

  @override
  String get awards_total => 'कुल';

  @override
  String get awards_stageStart => 'शुरुआत';

  @override
  String get awards_stageRhythm => 'लय';

  @override
  String get awards_stageEndurance => 'सहनशक्ति';

  @override
  String get awards_stageMastery => 'निपुणता';

  @override
  String get awards_completed => 'पूरा हुआ';

  @override
  String awards_fastsRemaining(int count) {
    return '$count उपवास शेष';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count दिन शेष';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count घंटे शेष';
  }

  @override
  String get common_retry => 'फिर कोशिश करें';

  @override
  String get game_title => 'प्रगति केंद्र';

  @override
  String get game_quests => 'आज के लक्ष्य';

  @override
  String get game_questsDesc => 'छोटे कदम, टिकाऊ लय।';

  @override
  String get game_season => '30-कदम का सीज़न';

  @override
  String get game_seasonDesc => 'हर पाँचवें कदम पर संग्रह योग्य मुहर।';

  @override
  String get game_badges => 'बैज संग्रह';

  @override
  String game_shields(int count) {
    return '$count लय कवच';
  }

  @override
  String get game_shieldsDesc =>
      'हर सात पूर्णताओं पर मिलता है। एक दिन छूटने से आपकी प्रगति कभी नहीं मिटती।';

  @override
  String get game_league => 'निजी साप्ताहिक लीग';

  @override
  String game_leagueDesc(int percent) {
    return 'आपका लय स्कोर निजी स्थानीय मॉडल के $percentवें प्रतिशतक में है। वजन और अत्यधिक उपवास की कभी रैंकिंग नहीं होती।';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'स्तर $level, $xp अनुभव अंक';
  }

  @override
  String get game_explorer => 'लय खोजकर्ता';

  @override
  String get game_streak => 'क्रम';

  @override
  String get game_targets => 'लक्ष्य';

  @override
  String get game_best => 'सर्वश्रेष्ठ';

  @override
  String get quest_rhythm => 'आज की लय बनाएँ';

  @override
  String get quest_hydrate => 'पानी के लक्ष्य का आधा पूरा करें';

  @override
  String get quest_steady => 'अपना क्रम सुरक्षित रखें';

  @override
  String get badge_first_title => 'पहला कदम';

  @override
  String get badge_first_desc => 'अपना पहला उपवास दर्ज करें';

  @override
  String get badge_rhythm7_title => 'लय रक्षक';

  @override
  String get badge_rhythm7_desc => '7 दिन का क्रम पूरा करें';

  @override
  String get badge_rhythm3_title => 'तीन-दिवसीय लय';

  @override
  String get badge_rhythm3_desc => '3 दिन का क्रम पूरा करें';

  @override
  String get badge_target1_title => 'पहला लक्ष्य';

  @override
  String get badge_target1_desc => 'अपना पहला लक्षित उपवास पूरा करें';

  @override
  String get badge_target3_title => 'तीन कदम';

  @override
  String get badge_target3_desc => '3 लक्ष्य पूरे करें';

  @override
  String get badge_water_title => 'संतुलित';

  @override
  String get badge_water_desc => 'दैनिक पानी लक्ष्य पूरा करें';

  @override
  String get badge_support_title => 'आत्म-जागरूक';

  @override
  String get badge_support_desc => 'सहयोग मोड उपयोग करें';

  @override
  String get badge_hours10_title => '10 घंटे';

  @override
  String get badge_hours10_desc => 'कुल 10 घंटे दर्ज करें';

  @override
  String get badge_target10_title => 'मज़बूत दस';

  @override
  String get badge_target10_desc => '10 लक्ष्य पूरे करें';

  @override
  String get badge_target20_title => 'बीस लक्ष्य';

  @override
  String get badge_target20_desc => '20 लक्ष्य पूरे करें';

  @override
  String get badge_fast16_title => '16 घंटे';

  @override
  String get badge_fast16_desc => 'एक उपवास में 16 घंटे तक पहुँचें';

  @override
  String get badge_hours50_title => '50 घंटे';

  @override
  String get badge_hours50_desc => 'कुल 50 घंटे दर्ज करें';

  @override
  String get badge_hours100_title => 'एक सौ घंटे';

  @override
  String get badge_hours100_desc => 'कुल 100 घंटे दर्ज करें';

  @override
  String get badge_target30_title => 'तीस लक्ष्य';

  @override
  String get badge_target30_desc => '30 लक्ष्य पूरे करें';

  @override
  String get badge_rhythm30_title => '30-दिवसीय लय';

  @override
  String get badge_rhythm30_desc => '30 दिन का क्रम पूरा करें';

  @override
  String get paywall_restoreSuccess => 'खरीदारी पुनर्स्थापित हुई!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'उपवास प्रगति $percent प्रतिशत';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hourघं';
  }

  @override
  String get paywall_lifetime => 'आजीवन';

  @override
  String get paywall_once => 'एक बार';

  @override
  String get paywall_processing => 'प्रक्रिया जारी…';

  @override
  String get paywall_continue => 'जारी रखें';

  @override
  String get paywall_productsUnavailable =>
      'अभी खरीदारी उपलब्ध नहीं है। कृपया बाद में फिर प्रयास करें।';

  @override
  String get paywall_purchaseFailed => 'खरीदारी पूरी नहीं हो सकी।';

  @override
  String get paywall_nothingToRestore => 'कोई पिछली खरीदारी नहीं मिली।';

  @override
  String get paywall_restoreFailed => 'खरीदारी पुनर्स्थापित नहीं हो सकी।';

  @override
  String get paywall_terms => 'उपयोग की शर्तें';

  @override
  String get permission_notificationDesc =>
      'उपवास रिमाइंडर, चरण अपडेट और पूर्णता सूचनाएँ';

  @override
  String get profile_privacyChoices => 'गोपनीयता विकल्प';

  @override
  String get paywall_autoRenewInfo =>
      'अवधि समाप्त होने से कम से कम 24 घंटे पहले रद्द न करने पर सदस्यता स्वतः नवीनीकृत होती है। App Store सेटिंग्स में कभी भी प्रबंधित या रद्द करें।';

  @override
  String paywall_perMonth(String price) {
    return '$price / महीना';
  }

  @override
  String paywall_savePercent(int percent) {
    return '$percent% बचाएँ';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days-दिन का निःशुल्क परीक्षण';
  }

  @override
  String get paywall_startFreeTrial => 'निःशुल्क परीक्षण शुरू करें';

  @override
  String get paywall_retry => 'फिर कोशिश करें';

  @override
  String get paywall_alreadyOwned =>
      'यह सदस्यता आपके पास पहले से है। “खरीदारी पुनर्स्थापित करें” पर टैप करें।';

  @override
  String get paywall_storeUnavailable =>
      'अभी स्टोर तक नहीं पहुँच पा रहे। कनेक्शन जाँचें और फिर प्रयास करें।';

  @override
  String get paywall_secureNote =>
      'कभी भी रद्द करें। भुगतान आपके स्टोर खाते से लिया जाता है।';

  @override
  String get paywall_autoRenewInfoPlay =>
      'अवधि समाप्त होने से कम से कम 24 घंटे पहले रद्द न करने पर सदस्यता स्वतः नवीनीकृत होती है। Google Play > सदस्यताएँ में कभी भी प्रबंधित या रद्द करें।';

  @override
  String get paywall_allPlansDesc =>
      '18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat और Warrior अनलॉक करता है';

  @override
  String get paywall_noAdsDesc =>
      'बैनर और इंटरस्टिशियल विज्ञापन पूरी तरह बंद होते हैं';

  @override
  String get foodScan_title => 'AI भोजन स्कैन';

  @override
  String get foodScan_scanCta => 'भोजन स्कैन करें';

  @override
  String get foodScan_scanCtaDesc =>
      'अपनी प्लेट की तस्वीर लें, कैलोरी और मैक्रो पाएँ';

  @override
  String get foodScan_introTitle => 'अपनी प्लेट की तस्वीर लें';

  @override
  String get foodScan_introDesc =>
      'AI तस्वीर पढ़कर कैलोरी, प्रोटीन, कार्बोहाइड्रेट और वसा का अनुमान लगाता है।';

  @override
  String get foodScan_tipLight => 'अच्छी, समान रोशनी से बेहतर अनुमान मिलता है';

  @override
  String get foodScan_tipFrame => 'पूरी प्लेट को फ़्रेम में रखें';

  @override
  String get foodScan_tipScale =>
      'मात्रा मापने के लिए चम्मच-काँटा या हाथ शामिल करें';

  @override
  String get foodScan_takePhoto => 'तस्वीर लें';

  @override
  String get foodScan_chooseFromGallery => 'गैलरी से चुनें';

  @override
  String foodScan_scansLeft(int count) {
    return 'आज $count स्कैन शेष';
  }

  @override
  String get foodScan_quotaReached =>
      'आज के स्कैन पूरे हो गए। कल फिर प्रयास करें।';

  @override
  String get foodScan_privacyNote =>
      'तस्वीर विश्लेषण के लिए Google के Gemini API को भेजी जाती है और हमारे सर्वर पर संग्रहीत नहीं होती।';

  @override
  String get foodScan_consentTitle => 'क्या फ़ोटो Google Gemini को भेजें?';

  @override
  String get foodScan_consentBody =>
      'कैलोरी और मैक्रो का अनुमान लगाने के लिए, आपकी ली गई या चुनी गई हर भोजन फ़ोटो Google की Gemini AI सेवा को भेजी जाती है। फ़ोटो का उपयोग केवल इस विश्लेषण के लिए होता है और इसे हमारे सर्वर पर संग्रहीत नहीं किया जाता।';

  @override
  String get foodScan_consentAgree => 'सहमत हूँ, जारी रखें';

  @override
  String get foodScan_analyzing => 'आपके भोजन का विश्लेषण हो रहा है…';

  @override
  String get foodScan_analyzingHint => 'आमतौर पर इसमें कुछ सेकंड लगते हैं';

  @override
  String get foodScan_detectedItems => 'पहचाने गए खाद्य';

  @override
  String get foodScan_disclaimer =>
      'AI अनुमान लगभग हैं। सुधारने के लिए किसी आइटम पर टैप करें।';

  @override
  String get foodScan_lowConfidence =>
      'मॉडल इस तस्वीर को लेकर अनिश्चित है। सहेजने से पहले संख्याएँ जाँचें।';

  @override
  String get foodScan_save => 'भोजन में जोड़ें';

  @override
  String get foodScan_retake => 'नई तस्वीर';

  @override
  String get foodScan_retry => 'फिर कोशिश करें';

  @override
  String get foodScan_editItem => 'आइटम बदलें';

  @override
  String get foodScan_portion => 'मात्रा';

  @override
  String get foodScan_saveEdit => 'सहेजें';

  @override
  String get foodScan_premiumTitle => 'Premium सुविधा';

  @override
  String get foodScan_premiumDesc =>
      'तस्वीर से कैलोरी विश्लेषण Premium में शामिल है।';

  @override
  String get foodScan_upgrade => 'Premium देखें';

  @override
  String get foodScan_errorNetwork =>
      'कनेक्शन नहीं है। इंटरनेट जाँचें और फिर प्रयास करें।';

  @override
  String get foodScan_errorRateLimited =>
      'अभी बहुत अधिक स्कैन हो रहे हैं। कुछ मिनट बाद फिर प्रयास करें।';

  @override
  String get foodScan_errorUnavailable => 'तस्वीर विश्लेषण अभी उपलब्ध नहीं है।';

  @override
  String get foodScan_errorServer =>
      'विश्लेषण सेवा में समस्या है। थोड़ी देर बाद फिर प्रयास करें।';

  @override
  String get foodScan_errorNoFood =>
      'इस तस्वीर में भोजन नहीं मिला। प्लेट की अधिक स्पष्ट तस्वीर लें।';

  @override
  String get foodScan_errorUnreadable =>
      'इस तस्वीर का विश्लेषण नहीं हो सका। दूसरी तस्वीर आज़माएँ।';

  @override
  String get paywall_aiFoodScan => 'AI भोजन स्कैन';

  @override
  String get paywall_aiFoodScanDesc =>
      'भोजन की तस्वीर लें और सेकंडों में कैलोरी व मैक्रो दर्ज करें';
}
