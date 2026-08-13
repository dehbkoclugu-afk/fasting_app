// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Günaydın';

  @override
  String get greeting_afternoon => 'İyi günler';

  @override
  String get greeting_evening => 'İyi akşamlar';

  @override
  String get tab_timer => 'Ana Sayfa';

  @override
  String get tab_explore => 'Keşfet';

  @override
  String get tab_stats => 'Rapor';

  @override
  String get tab_meals => 'Yemek';

  @override
  String get tab_achievements => 'Başarılar';

  @override
  String get tab_profile => 'Hesap';

  @override
  String get timer_fasting => 'Oruç Süresi';

  @override
  String get timer_remaining => 'Kalan';

  @override
  String get timer_elapsed => 'Geçen';

  @override
  String get timer_start => 'Başlat';

  @override
  String get timer_stop => 'Durdur';

  @override
  String get timer_completed => 'Tebrikler!';

  @override
  String get timer_completedMessage => 'Orucunu başarıyla tamamladın!';

  @override
  String get timer_selectPlan => 'Oruç Planı Seç';

  @override
  String get timer_stopConfirm => 'Orucu erken bitirmek istediğine emin misin?';

  @override
  String get timer_stopTitle => 'Orucu Bitir';

  @override
  String get timer_cancel => 'İptal';

  @override
  String get timer_confirmStop => 'Evet, Bitir';

  @override
  String get phase_anabolic => 'Anabolik';

  @override
  String get phase_anabolicDesc => 'Sindirim devam ediyor';

  @override
  String get phase_catabolic => 'Katabolik';

  @override
  String get phase_catabolicDesc => 'Enerji geçişi';

  @override
  String get phase_fatBurning => 'Yağ Yakımı';

  @override
  String get phase_fatBurningDesc => 'Yağ yakımı başladı';

  @override
  String get phase_ketosis => 'Ketozis';

  @override
  String get phase_ketosisDesc => 'Keton üretimi aktif';

  @override
  String get phase_autophagy => 'Otofaji';

  @override
  String get phase_autophagyDesc => 'Hücre yenilenmesi';

  @override
  String get stats_title => 'İstatistikler';

  @override
  String get stats_week => 'Hafta';

  @override
  String get stats_month => 'Ay';

  @override
  String get stats_year => 'Yıl';

  @override
  String get stats_totalFasts => 'Toplam Oruç';

  @override
  String get stats_average => 'Ortalama';

  @override
  String get stats_fastDuration => 'oruç süresi';

  @override
  String get stats_streak => 'Seri';

  @override
  String get stats_daysConsecutive => 'gün ardışık';

  @override
  String get stats_success => 'Başarı';

  @override
  String get stats_completion => 'tamamlama';

  @override
  String get stats_weeklyFasting => 'Haftalık Oruç';

  @override
  String get stats_monthlyView => 'Aylık Görünüm';

  @override
  String get stats_weightChange => 'Kilo Değişimi';

  @override
  String get heatmap_none => 'Yok';

  @override
  String get heatmap_low => 'Az';

  @override
  String get heatmap_good => 'İyi';

  @override
  String get heatmap_full => 'Tam';

  @override
  String get meals_title => 'Yemek Planlayıcı';

  @override
  String get meals_eatingWindow => 'Yemek Penceresi';

  @override
  String get meals_windowOpen => 'Açık';

  @override
  String get meals_windowFasting => 'Oruç';

  @override
  String get meals_calories => 'Kalori';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Karb';

  @override
  String get meals_fat => 'Yağ';

  @override
  String get meals_todayMeals => 'Bugünkü Öğünler';

  @override
  String get meals_noMeals => 'Henüz yemek eklenmedi';

  @override
  String get meals_breakfastSuggestions => 'Oruç Kırma Önerileri';

  @override
  String get meals_addMeal => 'Yemek Ekle';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Kullanıcı';

  @override
  String profile_planActive(String plan) {
    return '$plan Planı aktif';
  }

  @override
  String get profile_upgradePremium => 'Premium\'a Yükselt';

  @override
  String get profile_premiumDesc => 'Tüm oruç planları ve reklamsız kullanım';

  @override
  String get profile_bodyMetrics => 'Vücut Ölçüleri';

  @override
  String get profile_height => 'Boy';

  @override
  String get profile_weight => 'Kilo';

  @override
  String get profile_targetWeight => 'Hedef Kilo';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Ayarlar';

  @override
  String get profile_notifications => 'Bildirimler';

  @override
  String get profile_darkTheme => 'Koyu Tema';

  @override
  String get profile_waterReminder => 'Su Hatırlatıcısı';

  @override
  String get profile_phaseNotifications => 'Faz Bildirimleri';

  @override
  String get profile_language => 'Dil';

  @override
  String get profile_about => 'Hakkında';

  @override
  String get profile_rateApp => 'Uygulamayı Değerlendir';

  @override
  String get profile_share => 'Paylaş';

  @override
  String get profile_privacyPolicy => 'Gizlilik Politikası';

  @override
  String get profile_version => 'Versiyon';

  @override
  String get onboarding_welcome => 'Hoş Geldin';

  @override
  String get onboarding_welcomeDesc =>
      'Intermittent fasting yolculuğunu\nkontrol altına al';

  @override
  String get onboarding_featureTimer => 'Akıllı oruç zamanlayıcı';

  @override
  String get onboarding_featureStats => 'Detaylı istatistikler ve grafikler';

  @override
  String get onboarding_featureMeals => 'Yemek planlayıcı ve tarif önerileri';

  @override
  String get onboarding_getStarted => 'Başla';

  @override
  String get onboarding_selectGoal => 'Hedefin ne?';

  @override
  String get onboarding_selectGoalDesc => 'Birden fazla seçebilirsin';

  @override
  String get onboarding_goalWeight => 'Kilo Vermek';

  @override
  String get onboarding_goalWeightDesc => 'Sağlıklı kilo kaybı';

  @override
  String get onboarding_goalHealth => 'Sağlığı İyileştirmek';

  @override
  String get onboarding_goalHealthDesc => 'Genel sağlık ve bağışıklık';

  @override
  String get onboarding_goalEnergy => 'Enerji Artışı';

  @override
  String get onboarding_goalEnergyDesc => 'Gün boyu enerji';

  @override
  String get onboarding_goalMental => 'Mental Netlik';

  @override
  String get onboarding_goalMentalDesc => 'Odaklanma ve berraklık';

  @override
  String get onboarding_goalLongevity => 'Uzun Ömür';

  @override
  String get onboarding_goalLongevityDesc => 'Hücre yenilenmesi ve anti-aging';

  @override
  String get onboarding_goalDiscipline => 'Disiplin';

  @override
  String get onboarding_goalDisciplineDesc => 'Öz disiplin geliştirme';

  @override
  String get onboarding_selectPlan => 'Planını Seç';

  @override
  String get onboarding_selectPlanDesc => 'Sana en uygun oruç planını seç';

  @override
  String get onboarding_bodyInfo => 'Bilgilerini Gir';

  @override
  String get onboarding_bodyInfoDesc => 'Kişiselleştirilmiş öneriler için';

  @override
  String get onboarding_gender => 'Cinsiyet';

  @override
  String get onboarding_male => 'Erkek';

  @override
  String get onboarding_female => 'Kadın';

  @override
  String get onboarding_age => 'Yaş';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Bu bilgiler sadece cihazında saklanır ve kalori hesaplamaları için kullanılır.';

  @override
  String get onboarding_permissions => 'Son Adım';

  @override
  String get onboarding_permissionsDesc =>
      'En iyi deneyim için izinleri etkinleştir';

  @override
  String get onboarding_next => 'Devam Et';

  @override
  String get onboarding_start => 'Başlayalım!';

  @override
  String get onboarding_skipForNow => 'Sonra ayarla';

  @override
  String get waterAdded => '+250ml su eklendi';

  @override
  String get languageSelect => 'Dil Seçimi';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Premium\'a Yükselt';

  @override
  String get paywall_subtitle => 'Tüm oruç planlarını aç, reklamları kaldır';

  @override
  String get paywall_allPlans => 'Tüm oruç planları';

  @override
  String get paywall_advancedStats => 'Gelişmiş istatistikler';

  @override
  String get paywall_mealPlanner => 'Yemek planlayıcı';

  @override
  String get paywall_healthKit => 'HealthKit entegrasyonu';

  @override
  String get paywall_themes => 'Tema özelleştirme';

  @override
  String get paywall_noAds => 'Reklam yok';

  @override
  String get paywall_weekly => 'Haftalık';

  @override
  String get paywall_monthly => 'Aylık';

  @override
  String get paywall_yearly => 'Yıllık';

  @override
  String get paywall_bestValue => 'En İyi';

  @override
  String get paywall_freeTrial => 'Ücretsiz Dene (3 Gün)';

  @override
  String get paywall_restore => 'Satın alımları geri yükle';

  @override
  String get paywall_premiumActive => 'Premium Aktif!';

  @override
  String get paywall_premiumActiveDesc =>
      'Tüm oruç planları açık, reklamlar kapalı';

  @override
  String get water_title => 'Su Tüketimi';

  @override
  String get water_addWater => 'Su Ekle';

  @override
  String get water_goal => 'Hedef';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'Tamam';

  @override
  String get common_cancel => 'İptal';

  @override
  String get common_save => 'Kaydet';

  @override
  String get common_delete => 'Sil';

  @override
  String get common_hours => 'saat';

  @override
  String get common_minutes => 'dakika';

  @override
  String get common_days => 'gün';

  @override
  String get common_enable => 'Aç';

  @override
  String get streakCard_currentStreak => 'Mevcut Seri';

  @override
  String get streakCard_longestStreak => 'En Uzun Seri';

  @override
  String get streakCard_totalSessions => 'Toplam Oruç';

  @override
  String get meals_mealType => 'Öğün';

  @override
  String get meals_breakfast => 'Kahvaltı';

  @override
  String get meals_lunch => 'Öğle';

  @override
  String get meals_dinner => 'Akşam';

  @override
  String get meals_snack => 'Atıştırma';

  @override
  String get meals_carbohydrate => 'Karbonhidrat';

  @override
  String get meals_add => 'Ekle';

  @override
  String get meals_mealName => 'Yemek adı';

  @override
  String get bodyMetrics_title => 'Vücut Ölçüleri';

  @override
  String get bodyMetrics_weight => 'Kilo';

  @override
  String get bodyMetrics_target => 'Hedef';

  @override
  String get bodyMetrics_save => 'Kaydet';

  @override
  String get bodyMetrics_history => 'Geçmiş';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Henüz veri yok';

  @override
  String get meals_quickAdd => 'Hızlı Ekle';

  @override
  String get meals_manualEntry => 'Manuel Giriş';

  @override
  String meals_added(String name) {
    return '$name eklendi';
  }

  @override
  String get meals_nameCalorieRequired => 'İsim ve kalori zorunlu';

  @override
  String get bodyMetrics_addWeight => 'Kilo Ekle';

  @override
  String get bodyMetrics_hintWeight => 'Örn: 74.5';

  @override
  String get bodyMetrics_invalidWeight => 'Geçerli bir kilo gir';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg kaydedildi';
  }

  @override
  String get completion_duration => 'Süre';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Son Faz';

  @override
  String get timer_remainingTime => 'Kalan Süre';

  @override
  String get timer_ready => 'Başlamaya Hazır';

  @override
  String get streak_status => 'Durum';

  @override
  String get streak_startToday => 'Bugün başla!';

  @override
  String get streak_goodStart => 'İyi başlangıç!';

  @override
  String get streak_goingGreat => 'Harika gidiyorsun!';

  @override
  String get streak_superb => 'Süpersin!';

  @override
  String get streak_legendary => 'Efsane!';

  @override
  String get streak_incredible => 'İnanılmaz!';

  @override
  String get weight_noRecord =>
      'Henüz kilo kaydı yok\nProfil > Vücut Ölçüleri\'nden ekle';

  @override
  String get day_mon => 'Pzt';

  @override
  String get day_tue => 'Sal';

  @override
  String get day_wed => 'Çar';

  @override
  String get day_thu => 'Per';

  @override
  String get day_fri => 'Cum';

  @override
  String get day_sat => 'Cmt';

  @override
  String get day_sun => 'Paz';

  @override
  String get day_short_mon => 'P';

  @override
  String get day_short_tue => 'S';

  @override
  String get day_short_wed => 'Ç';

  @override
  String get day_short_thu => 'P';

  @override
  String get day_short_fri => 'C';

  @override
  String get day_short_sat => 'C';

  @override
  String get day_short_sun => 'P';

  @override
  String get month_jan => 'Ocak';

  @override
  String get month_feb => 'Şubat';

  @override
  String get month_mar => 'Mart';

  @override
  String get month_apr => 'Nisan';

  @override
  String get month_may => 'Mayıs';

  @override
  String get month_jun => 'Haziran';

  @override
  String get month_jul => 'Temmuz';

  @override
  String get month_aug => 'Ağustos';

  @override
  String get month_sep => 'Eylül';

  @override
  String get month_oct => 'Ekim';

  @override
  String get month_nov => 'Kasım';

  @override
  String get month_dec => 'Aralık';

  @override
  String meals_fastingWindow(String hours) {
    return 'Oruç (${hours}s)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Yemek (${hours}s)';
  }

  @override
  String get recipe_oatSmoothie => 'Yulaflı Smoothie';

  @override
  String get recipe_avocadoToast => 'Avokado Toast';

  @override
  String get recipe_yogurtBowl => 'Yoğurt Bowl';

  @override
  String get elapsed_time => 'Geçen Süre';

  @override
  String get fast_ends_on => 'Orucun bitiş saati';

  @override
  String get end_fasting => 'Orucu Bitir';

  @override
  String get start_fasting => 'Oruç Başlat';

  @override
  String get water_tracker => 'Su Takibi';

  @override
  String get weight_tracker => 'Kilo Takibi';

  @override
  String get drink => 'İç';

  @override
  String get log_weight => 'Kilo Kaydet';

  @override
  String get bmi => 'VKİ';

  @override
  String get weight_lost => 'Verilen Kilo';

  @override
  String get current_weight => 'Mevcut Kilo';

  @override
  String get goal_weight => 'Hedef Kilo';

  @override
  String get daily_goal => 'Günlük Hedef';

  @override
  String completed_percent(String percent) {
    return '%$percent Tamamlandı';
  }

  @override
  String get explore => 'Keşfet';

  @override
  String get achievements => 'Başarılar';

  @override
  String get profile_theme => 'Görünüm';

  @override
  String get theme_select => 'Görünüm seç';

  @override
  String get theme_system => 'Sistem varsayılanı';

  @override
  String get theme_light => 'Aydınlık';

  @override
  String get theme_dark => 'Karanlık';

  @override
  String get language_system => 'Sistem dili';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Tamamlama sesi';

  @override
  String get profile_calmGamification => 'Sakin oyunlaştırma';

  @override
  String get profile_calmGamificationDesc => 'Lig ve sezon baskısını azaltır';

  @override
  String get profile_editName => 'Adını düzenle';

  @override
  String get profile_name => 'Ad';

  @override
  String get circle_title => 'Oruç Çemberi';

  @override
  String get circle_you => 'Sen';

  @override
  String get circle_tagline => 'Birlikte, baskı olmadan.';

  @override
  String get circle_privacy =>
      'Kilo ve özel ölçüler paylaşılmaz. Yalnızca ilerleme ve destek görünür.';

  @override
  String circle_sendSupport(int count) {
    return 'Destek gönder · $count';
  }

  @override
  String get circle_inviteCopied => 'Davet kodu kopyalandı';

  @override
  String get circle_createInvite => 'Özel davet oluştur';

  @override
  String get crisis_nameTitle => 'Önce ne olduğunu adlandıralım';

  @override
  String get crisis_nameDesc => 'Bu açlık, alışkanlık veya duygu olabilir.';

  @override
  String get crisis_waterTitle => 'Bir bardak su iç';

  @override
  String get crisis_waterDesc => 'Sonra üç yavaş nefes al.';

  @override
  String get crisis_delayTitle => 'Kararı 10 dakika ertele';

  @override
  String get crisis_delayDesc =>
      'İyi hissetmiyorsan orucu bitirmek başarısızlık değildir.';

  @override
  String get crisis_hunger => 'Açlık';

  @override
  String get crisis_habit => 'Alışkanlık';

  @override
  String get crisis_stress => 'Stres';

  @override
  String get crisis_tenMore => '10 dakika daha';

  @override
  String get stats_storyEmpty =>
      'İlk orucun, kişisel hikâyenin başlangıcı olacak.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Bu dönemde $sessions oruç tuttun. Toplam $hours saat boyunca ritmini korudun ve %$rate tamamlama oranına ulaştın.';
  }

  @override
  String get stats_storyTitle => 'Ritminin hikâyesi';

  @override
  String get home_todayRhythm => 'Bugünkü ritmin';

  @override
  String get home_finalHourSupport => 'Son saat desteği';

  @override
  String get home_needSupport => 'Biraz desteğe ihtiyacım var';

  @override
  String get home_todaySummary => 'Günün özeti';

  @override
  String get home_dayStreak => 'günlük seri';

  @override
  String home_weightGoal(String weight) {
    return 'hedef $weight kg';
  }

  @override
  String get weather_steady => 'Ritmin dengeli';

  @override
  String get weather_gentle => 'Nazik bir gün';

  @override
  String get weather_water => 'Bir bardak su iyi gelebilir.';

  @override
  String get weather_listen => 'Uzun bir yol aldın; bedenini dinle.';

  @override
  String get weather_onPlan => 'Bugünkü tempon planınla uyumlu.';

  @override
  String get weather_challenging =>
      'Bu saat daha önce zorlayıcı olmuştu; destek modu hazır.';

  @override
  String get replay_copied => 'Fasting Replay kopyalandı';

  @override
  String get replay_button => 'Replay';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return '$plan orucumu ${hours}sa ${minutes}dk ile tamamladım · $phase';
  }

  @override
  String get journey_label => 'Metabolik yolculuk';

  @override
  String get journey_now => 'Şimdi';

  @override
  String journey_next(String time, String phase) {
    return '$time sonra $phase';
  }

  @override
  String get phase_estimateShort =>
      'Evre saatleri genel tahmindir; tıbbi ölçüm değildir.';

  @override
  String phase_hours(int start, int end) {
    return '$start–$end. saat';
  }

  @override
  String get phase_estimateLong =>
      'Bu zaman aralığı genel bir tahmindir. Metabolik yanıt kişiden kişiye değişebilir.';

  @override
  String get bmi_underweight => 'Zayıf';

  @override
  String get bmi_normal => 'Normal';

  @override
  String get bmi_overweight => 'Fazla Kilolu';

  @override
  String get bmi_obese => 'Obez';

  @override
  String get notification_halfwayTitle => 'Yarı Yoldasın! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return '$plan orucunun yarısını tamamladın. Devam et!';
  }

  @override
  String get notification_phaseCatabolic => 'Katabolik faza geçtin 📉';

  @override
  String get notification_phaseFatBurning => 'Yağ Yakımı başladı! 🔥';

  @override
  String get notification_phaseKetosis => 'Ketozis fazındasın ⚡';

  @override
  String get notification_phaseAutophagy => 'Otofaji aktif! 🔄';

  @override
  String notification_completedBody(String plan) {
    return '$plan orucunu tamamladın! Yemek penceren açıldı.';
  }

  @override
  String get notification_waterTitle => 'Su İç 💧';

  @override
  String get notification_waterBody => 'Oruç süresince bol su içmeyi unutma!';

  @override
  String get notification_windowTitle => 'Yemek Penceresi Kapanıyor ⏰';

  @override
  String get notification_windowBody =>
      '30 dakika içinde yemek penceren kapanacak.';

  @override
  String notification_streakTitle(int days) {
    return '$days Günlük Seri! 🔥';
  }

  @override
  String get notification_streakBody => 'Harika gidiyorsun! Bugün de devam et.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Oruç Devam Ediyor - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Kalan: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Oruç Başladı - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Hedef: $hours saat';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}sa ${minutes}dk';
  }

  @override
  String get explore_guide => 'Oruç Rehberi';

  @override
  String get explore_guideDesc =>
      'Intermittent fasting hakkında bilmeniz gerekenler';

  @override
  String get explore_circleDesc => 'Özel grubunla sessizce destekleş.';

  @override
  String get explore_faq => 'Sık Sorulan Sorular';

  @override
  String get explore_education =>
      'Bu içerik yalnızca genel eğitim amaçlıdır; tıbbi tanı veya tedavi önerisi değildir.';

  @override
  String get explore_safety => 'Sağlık ve güvenlik';

  @override
  String get explore_safetyDesc =>
      'Bir hastalığın, düzenli ilacın veya endişe veren belirtin varsa; hamileysen ya da emziriyorsan oruç planına başlamadan önce yetkin bir sağlık uzmanına danış. Kendini kötü hissedersen orucu sonlandır.';

  @override
  String get explore_sources => 'Kaynaklar';

  @override
  String get explore_sourcesDesc =>
      'İçerik, aşağıdaki kamu sağlığı kaynakları temel alınarak sadeleştirilmiştir.';

  @override
  String get explore_sourceError => 'Kaynak açılamadı';

  @override
  String get explore_rules => 'Önemli Kurallar';

  @override
  String get explore_rule1 => 'Oruç süresince kalorili gıda tüketmeyin';

  @override
  String get explore_rule2 => 'Bol su ve sıvı tüketin';

  @override
  String get explore_rule3 => 'Yemek penceresinde dengeli beslenin';

  @override
  String get explore_rule4 => 'Kendinizi kötü hissederseniz orucu bırakın';

  @override
  String get explore_rule5 => 'Hamile veya emziren kadınlar oruç tutmamalı';

  @override
  String get explore_rule6 => 'Kronik hastalığınız varsa doktora danışın';

  @override
  String get tip_water => 'Bol Su İç';

  @override
  String get tip_waterDesc =>
      'Susadığınızda su için ve öğünlerle birlikte sıvı tüketin. İhtiyaç; sağlık durumu, hava ve aktiviteye göre değişebilir.';

  @override
  String get tip_food => 'Doğru Beslen';

  @override
  String get tip_foodDesc =>
      'Yemek penceresinde protein ağırlıklı, lifli ve sağlıklı yağlar içeren besinler tercih edin. İşlenmiş gıdalardan kaçının.';

  @override
  String get tip_sleep => 'Yeterli Uyu';

  @override
  String get tip_sleepDesc =>
      'Düzenli ve yeterli uyku genel iyilik hâlini destekler. Oruç planını uykunuzu bozmayacak saatlere yerleştirin.';

  @override
  String get tip_exercise => 'Hafif Egzersiz';

  @override
  String get tip_exerciseDesc =>
      'Oruç sırasında hafif yürüyüş veya yoga yapabilirsiniz. Ağır egzersizlerden kaçının, özellikle ilk haftalarda vücudunuz adapte olana kadar.';

  @override
  String get tip_drinks => 'İzin Verilen İçecekler';

  @override
  String get tip_drinksDesc =>
      'Oruç süresince su, sade çay, sade kahve (şekersiz, sütsüz) tüketebilirsiniz. Bu içecekler orucu bozmaz.';

  @override
  String get faq_drinks => 'Oruç sırasında ne içebilirim?';

  @override
  String get faq_drinksAnswer =>
      'Su, sade çay, sade kahve (şekersiz ve sütsüz) içebilirsiniz. Kalorili içecekler orucu bozar.';

  @override
  String get faq_plan => 'Hangi oruç planını seçmeliyim?';

  @override
  String get faq_planAnswer =>
      'Yeni başlıyorsanız 12:12 veya 14:10 ile başlayın. Deneyimliyseniz 16:8 veya 18:6 deneyin. 20:4 ve OMAD ileri seviye için uygundur.';

  @override
  String get faq_exercise => 'Oruç tutarken spor yapabilir miyim?';

  @override
  String get faq_exerciseAnswer =>
      'Evet, ancak yoğun egzersizlerden kaçının. Hafif kardiyo, yürüyüş ve yoga idealdir. Ağırlık çalışması yapacaksanız yemek penceresine yakın saatleri tercih edin.';

  @override
  String get faq_weight => 'Oruç kilo verdirir mi?';

  @override
  String get faq_weightAnswer =>
      'Bazı kişilerde yemek süresini sınırlamak toplam enerji alımını azaltabilir. Sonuçlar kişiden kişiye değişir ve uzun dönem etkileri için araştırmalar sürmektedir.';

  @override
  String get plan_12_desc => 'Başlangıç seviyesi';

  @override
  String get plan_12_detail =>
      'Oruç tutmaya yeni başlayanlar için ideal. Gece uykusu ile birlikte 12 saat oruç tutarsın.';

  @override
  String get plan_16_desc => 'En popüler plan';

  @override
  String get plan_16_detail =>
      'En yaygın IF planı. 16 saat oruç, 8 saat yemek penceresi. Genelde öğle-akşam yemeği arası.';

  @override
  String get plan_18_desc => 'Orta seviye';

  @override
  String get plan_18_detail =>
      '18 saat oruç, 6 saat yemek penceresi. Daha uzun yağ yakım süresi sağlar.';

  @override
  String get plan_20_desc => 'İleri seviye';

  @override
  String get plan_20_detail =>
      '20 saat oruç, 4 saat yemek penceresi. Ketozis ve otofaji fazlarına ulaşmak için ideal.';

  @override
  String get plan_omad_desc => 'Günde tek öğün';

  @override
  String get plan_omad_detail =>
      'Günde tek öğün. 23 saat oruç, 1 saat yemek penceresi. Uzman seviyesi.';

  @override
  String get plan_52_desc => 'Haftada 2 gün';

  @override
  String get plan_52_detail =>
      'Haftada 5 gün normal ye, 2 gün sadece ~500 kalori al. Alternatif bir yaklaşım.';

  @override
  String get plan_ese_desc => '24 saat oruç';

  @override
  String get plan_ese_detail =>
      'Haftada 1–2 kez tam 24 saat oruç tut. İleri seviye kullanıcılar için.';

  @override
  String get plan_warrior_desc => 'Savaşçı diyeti';

  @override
  String get plan_warrior_detail =>
      'Gün boyunca az ye (meyve, sebze), akşam 4 saatlik pencerede ana öğününü ye.';

  @override
  String get award_first_title => 'İlk Adım';

  @override
  String get award_first_desc => 'İlk orucunu tamamla';

  @override
  String get award_rhythm3_title => '3 Günlük Ritim';

  @override
  String get award_rhythm3_desc => 'Üç gün üst üste ritmini koru';

  @override
  String get award_hours24_title => '24 Saat';

  @override
  String get award_hours24_desc => 'Toplam 24 saat oruç tut';

  @override
  String get award_week_title => 'Bir Haftalık Ritim';

  @override
  String get award_week_desc => 'Yedi günlük seri oluştur';

  @override
  String get award_fasts10_title => '10 Oruç';

  @override
  String get award_fasts10_desc => 'On orucu tamamla';

  @override
  String get award_hours100_title => '100 Saat';

  @override
  String get award_hours100_desc => 'Toplam 100 saate ulaş';

  @override
  String get award_rhythm30_title => '30 Günlük Ritim';

  @override
  String get award_rhythm30_desc => 'Otuz günlük seri oluştur';

  @override
  String get award_fasts50_title => '50 Oruç';

  @override
  String get award_fasts50_desc => 'Elli orucu tamamla';

  @override
  String get award_hours500_title => '500 Saat';

  @override
  String get award_hours500_desc => 'Toplam 500 saate ulaş';

  @override
  String get award_fasts100_title => '100 Oruç';

  @override
  String get award_fasts100_desc => 'Yüz orucu tamamla';

  @override
  String get award_rhythm90_title => '90 Günlük Ritim';

  @override
  String get award_rhythm90_desc => 'Doksan günlük seri oluştur';

  @override
  String get award_year_title => 'Bir Yıllık Yolculuk';

  @override
  String get award_year_desc => '365 günlük ritme ulaş';

  @override
  String get awards_loadError => 'İlerleme yüklenemedi';

  @override
  String get awards_journeyComplete => 'Yolculuk tamamlandı';

  @override
  String get awards_nextGoal => 'Sıradaki hedef';

  @override
  String get awards_allYours => 'Tüm başarımlar senin';

  @override
  String get awards_dayStreak => 'gün seri';

  @override
  String get awards_fasts => 'oruç';

  @override
  String get awards_total => 'toplam';

  @override
  String get awards_stageStart => 'Başlangıç';

  @override
  String get awards_stageRhythm => 'Ritim';

  @override
  String get awards_stageEndurance => 'Dayanıklılık';

  @override
  String get awards_stageMastery => 'Ustalık';

  @override
  String get awards_completed => 'Tamamlandı';

  @override
  String awards_fastsRemaining(int count) {
    return '$count oruç kaldı';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count gün kaldı';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count saat kaldı';
  }

  @override
  String get common_retry => 'Tekrar dene';

  @override
  String get game_title => 'İlerleme Merkezi';

  @override
  String get game_quests => 'Bugünün görevleri';

  @override
  String get game_questsDesc => 'Küçük adımlar, sürdürülebilir ritim.';

  @override
  String get game_season => '30 adımlık sezon';

  @override
  String get game_seasonDesc => 'Her beşinci adım koleksiyon mührü.';

  @override
  String get game_badges => 'Rozet koleksiyonu';

  @override
  String game_shields(int count) {
    return '$count ritim kalkanı';
  }

  @override
  String get game_shieldsDesc =>
      'Her yedi tamamlamada kazanılır. Kaçırılan bir gün ilerlemeni değersizleştirmez.';

  @override
  String get game_league => 'Özel haftalık lig';

  @override
  String game_leagueDesc(int percent) {
    return 'Ritim puanın anonim yerel modelin %$percent diliminde. Kimseyle kilo veya açlık süresi yarıştırılmaz.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Seviye $level, $xp deneyim puanı';
  }

  @override
  String get game_explorer => 'Ritim Kaşifi';

  @override
  String get game_streak => 'Seri';

  @override
  String get game_targets => 'Hedef';

  @override
  String get game_best => 'Rekor';

  @override
  String get quest_rhythm => 'Bugünün ritmini oluştur';

  @override
  String get quest_hydrate => 'Su hedefinin yarısına ulaş';

  @override
  String get quest_steady => 'Serini koru';

  @override
  String get badge_first_title => 'İlk Adım';

  @override
  String get badge_first_desc => 'İlk orucunu kaydet';

  @override
  String get badge_rhythm7_title => 'Ritim Ustası';

  @override
  String get badge_rhythm7_desc => '7 günlük seriye ulaş';

  @override
  String get badge_rhythm3_title => 'Üç Gün Ritim';

  @override
  String get badge_rhythm3_desc => '3 günlük seriye ulaş';

  @override
  String get badge_target1_title => 'İlk Hedef';

  @override
  String get badge_target1_desc => 'İlk hedef orucunu tamamla';

  @override
  String get badge_target3_title => 'Üçlü Adım';

  @override
  String get badge_target3_desc => '3 hedef tamamla';

  @override
  String get badge_water_title => 'Denge';

  @override
  String get badge_water_desc => 'Günlük su hedefini tamamla';

  @override
  String get badge_support_title => 'Kendini Dinle';

  @override
  String get badge_support_desc => 'Destek modunu kullan';

  @override
  String get badge_hours10_title => '10 Saat';

  @override
  String get badge_hours10_desc => 'Toplam 10 saat kaydet';

  @override
  String get badge_target10_title => 'Onlu Seri';

  @override
  String get badge_target10_desc => '10 hedef tamamla';

  @override
  String get badge_target20_title => 'Yirmi Hedef';

  @override
  String get badge_target20_desc => '20 hedef tamamla';

  @override
  String get badge_fast16_title => '16 Saat';

  @override
  String get badge_fast16_desc => 'Tek oruçta 16 saate ulaş';

  @override
  String get badge_hours50_title => '50 Saat';

  @override
  String get badge_hours50_desc => 'Toplam 50 saat kaydet';

  @override
  String get badge_hours100_title => 'Yüz Saat';

  @override
  String get badge_hours100_desc => 'Toplam 100 saat kaydet';

  @override
  String get badge_target30_title => 'Otuz Hedef';

  @override
  String get badge_target30_desc => '30 hedef tamamla';

  @override
  String get badge_rhythm30_title => '30 Gün Ritim';

  @override
  String get badge_rhythm30_desc => '30 günlük seriye ulaş';

  @override
  String get paywall_restoreSuccess => 'Satın almalar geri yüklendi!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Oruç ilerlemesi yüzde $percent';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}s';
  }

  @override
  String get paywall_lifetime => 'Ömür boyu';

  @override
  String get paywall_once => 'tek ödeme';

  @override
  String get paywall_processing => 'İşleniyor…';

  @override
  String get paywall_continue => 'Devam et';

  @override
  String get paywall_productsUnavailable =>
      'Satın alma seçenekleri şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';

  @override
  String get paywall_purchaseFailed => 'Satın alma tamamlanamadı.';

  @override
  String get paywall_nothingToRestore =>
      'Geri yüklenecek önceki bir satın alma bulunamadı.';

  @override
  String get paywall_restoreFailed => 'Satın almalar geri yüklenemedi.';

  @override
  String get paywall_terms => 'Kullanım Şartları';

  @override
  String get permission_notificationDesc =>
      'Oruç hatırlatmaları, faz güncellemeleri ve tamamlanma bildirimleri';

  @override
  String get permission_healthTitle => 'Health Connect / HealthKit';

  @override
  String get permission_healthDesc =>
      'İzninizle adım, aktif kalori ve kilo verilerini eşitleyin';

  @override
  String get profile_privacyChoices => 'Gizlilik tercihleri';

  @override
  String get paywall_autoRenewInfo =>
      'Abonelikler, dönem bitmeden en az 24 saat önce iptal edilmezse otomatik yenilenir. App Store ayarlarından istediğin zaman yönetebilir veya iptal edebilirsin.';

  @override
  String paywall_perMonth(String price) {
    return '$price / ay';
  }

  @override
  String paywall_savePercent(int percent) {
    return '%$percent tasarruf';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days gün ücretsiz deneme';
  }

  @override
  String get paywall_startFreeTrial => 'Ücretsiz denemeyi başlat';

  @override
  String get paywall_retry => 'Tekrar dene';

  @override
  String get paywall_alreadyOwned =>
      'Bu abonelik zaten hesabında. “Satın alımları geri yükle”ye dokun.';

  @override
  String get paywall_storeUnavailable =>
      'Mağazaya şu anda ulaşılamıyor. Bağlantını kontrol edip tekrar dene.';

  @override
  String get paywall_secureNote =>
      'İstediğin zaman iptal et. Ödeme mağaza hesabından tahsil edilir.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Abonelikler, dönem bitmeden en az 24 saat önce iptal edilmezse otomatik yenilenir. Google Play > Abonelikler bölümünden istediğin zaman yönetebilir veya iptal edebilirsin.';

  @override
  String get paywall_healthConnect => 'Health Connect entegrasyonu';

  @override
  String get paywall_allPlansDesc =>
      '18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat ve Warrior kilidi açılır';

  @override
  String get paywall_noAdsDesc => 'Banner ve geçiş reklamları tamamen kapanır';
}
