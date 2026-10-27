// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Selamat pagi';

  @override
  String get greeting_afternoon => 'Selamat siang';

  @override
  String get greeting_evening => 'Selamat malam';

  @override
  String get tab_timer => 'Beranda';

  @override
  String get tab_explore => 'Jelajahi';

  @override
  String get tab_stats => 'Laporan';

  @override
  String get tab_meals => 'Makanan';

  @override
  String get tab_achievements => 'Penghargaan';

  @override
  String get tab_profile => 'Akun';

  @override
  String get timer_fasting => 'Waktu Puasa';

  @override
  String get timer_remaining => 'Tersisa';

  @override
  String get timer_elapsed => 'Berlalu';

  @override
  String get timer_start => 'Mulai';

  @override
  String get timer_stop => 'Berhenti';

  @override
  String get timer_completed => 'Selamat!';

  @override
  String get timer_completedMessage => 'Anda berhasil menyelesaikan puasa!';

  @override
  String get timer_selectPlan => 'Pilih Program Puasa';

  @override
  String get timer_stopConfirm => 'Yakin ingin mengakhiri puasa lebih awal?';

  @override
  String get timer_stopTitle => 'Akhiri Puasa';

  @override
  String get timer_cancel => 'Batal';

  @override
  String get timer_confirmStop => 'Ya, Akhiri';

  @override
  String get phase_anabolic => 'Anabolik';

  @override
  String get phase_anabolicDesc => 'Pencernaan berlangsung';

  @override
  String get phase_catabolic => 'Katabolik';

  @override
  String get phase_catabolicDesc => 'Peralihan energi';

  @override
  String get phase_fatBurning => 'Pembakaran Lemak';

  @override
  String get phase_fatBurningDesc => 'Pembakaran lemak dimulai';

  @override
  String get phase_ketosis => 'Ketosis';

  @override
  String get phase_ketosisDesc => 'Produksi keton aktif';

  @override
  String get phase_autophagy => 'Autofagi';

  @override
  String get phase_autophagyDesc => 'Pembaruan sel';

  @override
  String get stats_title => 'Statistik';

  @override
  String get stats_week => 'Minggu';

  @override
  String get stats_month => 'Bulan';

  @override
  String get stats_year => 'Tahun';

  @override
  String get stats_totalFasts => 'Total Puasa';

  @override
  String get stats_average => 'Rata-rata';

  @override
  String get stats_fastDuration => 'durasi puasa';

  @override
  String get stats_streak => 'Rentetan';

  @override
  String get stats_daysConsecutive => 'hari berturut-turut';

  @override
  String get stats_success => 'Keberhasilan';

  @override
  String get stats_completion => 'penyelesaian';

  @override
  String get stats_weeklyFasting => 'Puasa Mingguan';

  @override
  String get stats_monthlyView => 'Tampilan Bulanan';

  @override
  String get stats_weightChange => 'Perubahan Berat Badan';

  @override
  String get heatmap_none => 'Tidak Ada';

  @override
  String get heatmap_low => 'Rendah';

  @override
  String get heatmap_good => 'Baik';

  @override
  String get heatmap_full => 'Penuh';

  @override
  String get meals_title => 'Perencana Makanan';

  @override
  String get meals_eatingWindow => 'Jendela Makan';

  @override
  String get meals_windowOpen => 'Terbuka';

  @override
  String get meals_windowFasting => 'Puasa';

  @override
  String get meals_calories => 'Kalori';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Karbohidrat';

  @override
  String get meals_fat => 'Lemak';

  @override
  String get meals_todayMeals => 'Makanan Hari Ini';

  @override
  String get meals_noMeals => 'Belum ada makanan yang ditambahkan';

  @override
  String get meals_breakfastSuggestions => 'Saran Berbuka Puasa';

  @override
  String get meals_addMeal => 'Tambah Makanan';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Pengguna';

  @override
  String profile_planActive(String plan) {
    return 'Program $plan aktif';
  }

  @override
  String get profile_upgradePremium => 'Tingkatkan ke Premium';

  @override
  String get profile_premiumDesc => 'Semua program puasa, tanpa iklan';

  @override
  String get profile_bodyMetrics => 'Ukuran Tubuh';

  @override
  String get profile_height => 'Tinggi Badan';

  @override
  String get profile_weight => 'Berat Badan';

  @override
  String get profile_targetWeight => 'Target Berat Badan';

  @override
  String get profile_bmi => 'IMT';

  @override
  String get profile_settings => 'Pengaturan';

  @override
  String get profile_notifications => 'Notifikasi';

  @override
  String get profile_darkTheme => 'Tema Gelap';

  @override
  String get profile_waterReminder => 'Pengingat Minum';

  @override
  String get profile_phaseNotifications => 'Notifikasi Fase';

  @override
  String get profile_language => 'Bahasa';

  @override
  String get profile_about => 'Tentang';

  @override
  String get profile_rateApp => 'Nilai Aplikasi';

  @override
  String get profile_share => 'Bagikan';

  @override
  String get profile_privacyPolicy => 'Kebijakan Privasi';

  @override
  String get profile_version => 'Versi';

  @override
  String get onboarding_welcome => 'Selamat Datang';

  @override
  String get onboarding_welcomeDesc =>
      'Kendalikan perjalanan puasa\nintermiten Anda';

  @override
  String get onboarding_featureTimer => 'Pengatur waktu puasa pintar';

  @override
  String get onboarding_featureStats => 'Statistik dan grafik terperinci';

  @override
  String get onboarding_featureMeals => 'Perencana makanan dan saran resep';

  @override
  String get onboarding_getStarted => 'Mulai';

  @override
  String get onboarding_selectGoal => 'Apa tujuan Anda?';

  @override
  String get onboarding_selectGoalDesc => 'Anda dapat memilih beberapa';

  @override
  String get onboarding_goalWeight => 'Turunkan Berat Badan';

  @override
  String get onboarding_goalWeightDesc => 'Penurunan berat badan yang sehat';

  @override
  String get onboarding_goalHealth => 'Tingkatkan Kesehatan';

  @override
  String get onboarding_goalHealthDesc => 'Kesehatan umum dan kekebalan tubuh';

  @override
  String get onboarding_goalEnergy => 'Lebih Berenergi';

  @override
  String get onboarding_goalEnergyDesc => 'Energi sepanjang hari';

  @override
  String get onboarding_goalMental => 'Kejernihan Mental';

  @override
  String get onboarding_goalMentalDesc => 'Fokus dan kejernihan';

  @override
  String get onboarding_goalLongevity => 'Umur Panjang';

  @override
  String get onboarding_goalLongevityDesc => 'Pembaruan sel dan penuaan sehat';

  @override
  String get onboarding_goalDiscipline => 'Disiplin';

  @override
  String get onboarding_goalDisciplineDesc => 'Bangun disiplin diri';

  @override
  String get onboarding_selectPlan => 'Pilih Program Anda';

  @override
  String get onboarding_selectPlanDesc =>
      'Pilih program puasa terbaik untuk Anda';

  @override
  String get onboarding_bodyInfo => 'Masukkan Data Anda';

  @override
  String get onboarding_bodyInfoDesc => 'Untuk rekomendasi pribadi';

  @override
  String get onboarding_gender => 'Jenis Kelamin';

  @override
  String get onboarding_male => 'Pria';

  @override
  String get onboarding_female => 'Wanita';

  @override
  String get onboarding_age => 'Usia';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Informasi ini hanya disimpan di perangkat Anda dan digunakan untuk perhitungan kalori.';

  @override
  String get onboarding_permissions => 'Langkah Terakhir';

  @override
  String get onboarding_permissionsDesc =>
      'Aktifkan izin untuk pengalaman terbaik';

  @override
  String get onboarding_next => 'Lanjutkan';

  @override
  String get onboarding_start => 'Ayo Mulai!';

  @override
  String get onboarding_skipForNow => 'Atur nanti';

  @override
  String get waterAdded => '250 ml air ditambahkan';

  @override
  String get languageSelect => 'Pilih Bahasa';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Tingkatkan ke Premium';

  @override
  String get paywall_subtitle => 'Buka semua program puasa dan hapus iklan';

  @override
  String get paywall_allPlans => 'Semua program puasa';

  @override
  String get paywall_advancedStats => 'Statistik lanjutan';

  @override
  String get paywall_mealPlanner => 'Perencana makanan';

  @override
  String get paywall_themes => 'Penyesuaian tema';

  @override
  String get paywall_noAds => 'Tanpa iklan';

  @override
  String get paywall_weekly => 'Mingguan';

  @override
  String get paywall_monthly => 'Bulanan';

  @override
  String get paywall_yearly => 'Tahunan';

  @override
  String get paywall_bestValue => 'Terbaik';

  @override
  String get paywall_freeTrial => 'Uji Coba Gratis (3 Hari)';

  @override
  String get paywall_restore => 'Pulihkan pembelian';

  @override
  String get paywall_premiumActive => 'Premium Aktif!';

  @override
  String get paywall_premiumActiveDesc =>
      'Semua program puasa terbuka dan iklan dinonaktifkan';

  @override
  String get water_title => 'Asupan Air';

  @override
  String get water_addWater => 'Tambah Air';

  @override
  String get water_goal => 'Target';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Batal';

  @override
  String get common_save => 'Simpan';

  @override
  String get common_delete => 'Hapus';

  @override
  String get common_hours => 'jam';

  @override
  String get common_minutes => 'menit';

  @override
  String get common_days => 'hari';

  @override
  String get common_enable => 'Aktifkan';

  @override
  String get streakCard_currentStreak => 'Rentetan Saat Ini';

  @override
  String get streakCard_longestStreak => 'Rentetan Terpanjang';

  @override
  String get streakCard_totalSessions => 'Total Puasa';

  @override
  String get meals_mealType => 'Jenis Makanan';

  @override
  String get meals_breakfast => 'Sarapan';

  @override
  String get meals_lunch => 'Makan Siang';

  @override
  String get meals_dinner => 'Makan Malam';

  @override
  String get meals_snack => 'Camilan';

  @override
  String get meals_carbohydrate => 'Karbohidrat';

  @override
  String get meals_add => 'Tambah';

  @override
  String get meals_mealName => 'Nama makanan';

  @override
  String get bodyMetrics_title => 'Ukuran Tubuh';

  @override
  String get bodyMetrics_weight => 'Berat Badan';

  @override
  String get bodyMetrics_target => 'Target';

  @override
  String get bodyMetrics_save => 'Simpan';

  @override
  String get bodyMetrics_history => 'Riwayat';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'IMT: $value';
  }

  @override
  String get bodyMetrics_noData => 'Belum ada data';

  @override
  String get meals_quickAdd => 'Tambah Cepat';

  @override
  String get meals_manualEntry => 'Entri Manual';

  @override
  String meals_added(String name) {
    return '$name ditambahkan';
  }

  @override
  String get meals_nameCalorieRequired => 'Nama dan kalori wajib diisi';

  @override
  String get bodyMetrics_addWeight => 'Tambah Berat Badan';

  @override
  String get bodyMetrics_hintWeight => 'mis. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Masukkan berat badan yang valid';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg disimpan';
  }

  @override
  String get completion_duration => 'Durasi';

  @override
  String get completion_plan => 'Program';

  @override
  String get completion_lastPhase => 'Fase Terakhir';

  @override
  String get completion_earlyTitle => 'Puasa berakhir';

  @override
  String get completion_earlyMessage =>
      'Durasi hari ini telah disimpan. Rangkaian dan progres pencapaian tidak berubah karena target belum tercapai.';

  @override
  String get timer_remainingTime => 'Waktu Tersisa';

  @override
  String get timer_ready => 'Siap Dimulai';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Mulai hari ini!';

  @override
  String get streak_goodStart => 'Awal yang baik!';

  @override
  String get streak_goingGreat => 'Hebat!';

  @override
  String get streak_superb => 'Luar biasa!';

  @override
  String get streak_legendary => 'Legendaris!';

  @override
  String get streak_incredible => 'Menakjubkan!';

  @override
  String get weight_noRecord =>
      'Belum ada catatan berat badan\nTambahkan dari Profil > Ukuran Tubuh';

  @override
  String get day_mon => 'Sen';

  @override
  String get day_tue => 'Sel';

  @override
  String get day_wed => 'Rab';

  @override
  String get day_thu => 'Kam';

  @override
  String get day_fri => 'Jum';

  @override
  String get day_sat => 'Sab';

  @override
  String get day_sun => 'Min';

  @override
  String get day_short_mon => 'S';

  @override
  String get day_short_tue => 'S';

  @override
  String get day_short_wed => 'R';

  @override
  String get day_short_thu => 'K';

  @override
  String get day_short_fri => 'J';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'M';

  @override
  String get month_jan => 'Januari';

  @override
  String get month_feb => 'Februari';

  @override
  String get month_mar => 'Maret';

  @override
  String get month_apr => 'April';

  @override
  String get month_may => 'Mei';

  @override
  String get month_jun => 'Juni';

  @override
  String get month_jul => 'Juli';

  @override
  String get month_aug => 'Agustus';

  @override
  String get month_sep => 'September';

  @override
  String get month_oct => 'Oktober';

  @override
  String get month_nov => 'November';

  @override
  String get month_dec => 'Desember';

  @override
  String meals_fastingWindow(String hours) {
    return 'Puasa (${hours}j)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Makan (${hours}j)';
  }

  @override
  String get recipe_oatSmoothie => 'Smoothie Oat';

  @override
  String get recipe_avocadoToast => 'Roti Panggang Alpukat';

  @override
  String get recipe_yogurtBowl => 'Mangkuk Yoghurt';

  @override
  String get elapsed_time => 'Waktu Berlalu';

  @override
  String get fast_ends_on => 'Puasa Anda berakhir pukul';

  @override
  String get end_fasting => 'Akhiri Puasa';

  @override
  String get start_fasting => 'Mulai Puasa';

  @override
  String get water_tracker => 'Pelacak Air';

  @override
  String get weight_tracker => 'Pelacak Berat Badan';

  @override
  String get drink => 'Minum';

  @override
  String get log_weight => 'Catat Berat Badan';

  @override
  String get bmi => 'IMT';

  @override
  String get weight_lost => 'Berat Turun';

  @override
  String get current_weight => 'Berat Saat Ini';

  @override
  String get goal_weight => 'Target Berat Badan';

  @override
  String get daily_goal => 'Target Harian';

  @override
  String completed_percent(String percent) {
    return '$percent% Selesai';
  }

  @override
  String get explore => 'Jelajahi';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get profile_theme => 'Tampilan';

  @override
  String get theme_select => 'Pilih tampilan';

  @override
  String get theme_system => 'Bawaan sistem';

  @override
  String get theme_light => 'Terang';

  @override
  String get theme_dark => 'Gelap';

  @override
  String get language_system => 'Bahasa sistem';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Suara penyelesaian';

  @override
  String get profile_calmGamification => 'Gamifikasi tenang';

  @override
  String get profile_calmGamificationDesc =>
      'Mengurangi tekanan liga dan musim';

  @override
  String get profile_editName => 'Edit nama Anda';

  @override
  String get profile_name => 'Nama';

  @override
  String get circle_title => 'Lingkaran Puasa';

  @override
  String get circle_you => 'Anda';

  @override
  String get circle_tagline => 'Bersama, tanpa tekanan.';

  @override
  String get circle_privacy =>
      'Berat badan dan ukuran pribadi tetap tersembunyi. Hanya kemajuan dan dukungan yang terlihat.';

  @override
  String circle_sendSupport(int count) {
    return 'Kirim dukungan · $count';
  }

  @override
  String get circle_inviteCopied => 'Kode undangan disalin';

  @override
  String get circle_createInvite => 'Buat undangan pribadi';

  @override
  String get crisis_nameTitle => 'Pertama, sebutkan apa yang terjadi';

  @override
  String get crisis_nameDesc => 'Mungkin rasa lapar, kebiasaan, atau emosi.';

  @override
  String get crisis_waterTitle => 'Minum segelas air';

  @override
  String get crisis_waterDesc => 'Lalu tarik napas perlahan tiga kali.';

  @override
  String get crisis_delayTitle => 'Tunda keputusan selama 10 menit';

  @override
  String get crisis_delayDesc =>
      'Jika Anda merasa tidak sehat, mengakhiri puasa bukanlah kegagalan.';

  @override
  String get crisis_hunger => 'Lapar';

  @override
  String get crisis_habit => 'Kebiasaan';

  @override
  String get crisis_stress => 'Stres';

  @override
  String get crisis_tenMore => 'Beri waktu 10 menit';

  @override
  String get stats_storyEmpty =>
      'Puasa pertama akan memulai kisah pribadi Anda.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Anda berpuasa $sessions kali dalam periode ini, menjaga ritme selama $hours jam, dan mencapai tingkat penyelesaian $rate%.';
  }

  @override
  String get stats_storyTitle => 'Kisah ritme Anda';

  @override
  String get home_todayRhythm => 'Ritme hari ini';

  @override
  String get home_finalHourSupport => 'Dukungan jam terakhir';

  @override
  String get home_needSupport => 'Saya butuh sedikit dukungan';

  @override
  String get home_todaySummary => 'Ringkasan hari ini';

  @override
  String get home_dayStreak => 'hari berturut-turut';

  @override
  String home_weightGoal(String weight) {
    return 'target $weight kg';
  }

  @override
  String get weather_steady => 'Ritme Anda stabil';

  @override
  String get weather_gentle => 'Hari yang ringan';

  @override
  String get weather_water => 'Segelas air mungkin membantu.';

  @override
  String get weather_listen =>
      'Anda sudah melangkah jauh; dengarkan tubuh Anda.';

  @override
  String get weather_onPlan => 'Laju hari ini sesuai program Anda.';

  @override
  String get weather_challenging =>
      'Jam ini pernah terasa sulit; mode dukungan siap digunakan.';

  @override
  String get replay_copied => 'Kilasan Puasa disalin';

  @override
  String get replay_button => 'Kilasan';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Saya menyelesaikan puasa $plan dalam ${hours}j ${minutes}m · $phase';
  }

  @override
  String get journey_label => 'Perjalanan metabolisme';

  @override
  String get journey_now => 'Sekarang';

  @override
  String journey_next(String time, String phase) {
    return '$time menuju $phase';
  }

  @override
  String get phase_estimateShort =>
      'Waktu fase merupakan perkiraan umum, bukan pengukuran medis.';

  @override
  String phase_hours(int start, int end) {
    return 'Jam $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Waktu ini merupakan perkiraan umum. Respons metabolisme dapat berbeda pada setiap orang.';

  @override
  String get bmi_underweight => 'Berat badan kurang';

  @override
  String get bmi_normal => 'Normal';

  @override
  String get bmi_overweight => 'Berat badan berlebih';

  @override
  String get bmi_obese => 'Obesitas';

  @override
  String get notification_halfwayTitle => 'Sudah Setengah Jalan! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Anda menyelesaikan separuh puasa $plan. Teruskan!';
  }

  @override
  String get notification_phaseCatabolic => 'Memasuki fase Katabolik 📉';

  @override
  String get notification_phaseFatBurning => 'Pembakaran Lemak dimulai! 🔥';

  @override
  String get notification_phaseKetosis => 'Anda dalam Ketosis ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagi aktif! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Anda menyelesaikan puasa $plan! Jendela makan Anda terbuka.';
  }

  @override
  String get notification_waterTitle => 'Minum Air 💧';

  @override
  String get notification_waterBody =>
      'Jangan lupa minum cukup air selama berpuasa!';

  @override
  String get notification_windowTitle => 'Jendela Makan Akan Ditutup ⏰';

  @override
  String get notification_windowBody =>
      'Jendela makan Anda akan ditutup dalam 30 menit.';

  @override
  String notification_streakTitle(int days) {
    return 'Rentetan $days Hari! 🔥';
  }

  @override
  String get notification_streakBody => 'Anda hebat! Pertahankan hari ini.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Puasa Berlangsung – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Tersisa: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Puasa Dimulai – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Target: $hours jam';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}j ${minutes}m';
  }

  @override
  String get explore_guide => 'Panduan Puasa';

  @override
  String get explore_guideDesc =>
      'Semua yang perlu Anda ketahui tentang puasa intermiten';

  @override
  String get explore_circleDesc =>
      'Bagikan dukungan tenang dengan grup pribadi Anda.';

  @override
  String get explore_faq => 'Pertanyaan Umum';

  @override
  String get explore_education =>
      'Konten ini hanya untuk edukasi umum dan bukan diagnosis medis atau saran pengobatan.';

  @override
  String get explore_safety => 'Kesehatan dan keselamatan';

  @override
  String get explore_safetyDesc =>
      'Jika Anda memiliki kondisi medis, rutin minum obat, mengalami gejala yang mengkhawatirkan, sedang hamil, atau menyusui, konsultasikan dengan tenaga kesehatan sebelum berpuasa. Berhentilah jika merasa tidak sehat.';

  @override
  String get explore_sources => 'Sumber';

  @override
  String get explore_sourcesDesc =>
      'Konten disederhanakan dari referensi kesehatan masyarakat di bawah ini.';

  @override
  String get explore_sourceError => 'Sumber tidak dapat dibuka';

  @override
  String get explore_rules => 'Aturan Penting';

  @override
  String get explore_rule1 =>
      'Jangan konsumsi makanan berkalori selama berpuasa';

  @override
  String get explore_rule2 => 'Minum banyak air dan cairan';

  @override
  String get explore_rule3 => 'Makan makanan seimbang selama jendela makan';

  @override
  String get explore_rule4 => 'Hentikan puasa jika merasa tidak sehat';

  @override
  String get explore_rule5 =>
      'Ibu hamil atau menyusui sebaiknya tidak berpuasa';

  @override
  String get explore_rule6 =>
      'Konsultasikan dengan dokter jika memiliki penyakit kronis';

  @override
  String get tip_water => 'Tetap Terhidrasi';

  @override
  String get tip_waterDesc =>
      'Minumlah saat haus dan sertakan cairan bersama makanan. Kebutuhan dapat berbeda menurut kesehatan, cuaca, dan aktivitas.';

  @override
  String get tip_food => 'Makan dengan Baik';

  @override
  String get tip_foodDesc =>
      'Selama jendela makan, pilih makanan kaya protein dan serat serta lemak sehat. Hindari makanan olahan.';

  @override
  String get tip_sleep => 'Tidur Cukup';

  @override
  String get tip_sleepDesc =>
      'Tidur teratur dan cukup mendukung kesehatan umum. Atur puasa agar tidak mengganggu tidur.';

  @override
  String get tip_exercise => 'Olahraga Ringan';

  @override
  String get tip_exerciseDesc =>
      'Anda dapat berjalan santai atau yoga saat berpuasa. Hindari olahraga berat, terutama selama minggu-minggu pertama hingga tubuh beradaptasi.';

  @override
  String get tip_drinks => 'Minuman yang Diizinkan';

  @override
  String get tip_drinksDesc =>
      'Saat berpuasa, Anda dapat minum air, teh tawar, dan kopi hitam tanpa gula atau susu. Minuman ini tidak membatalkan puasa.';

  @override
  String get faq_drinks => 'Apa yang boleh saya minum saat berpuasa?';

  @override
  String get faq_drinksAnswer =>
      'Anda dapat minum air, teh tawar, dan kopi hitam tanpa gula atau susu. Minuman berkalori membatalkan puasa.';

  @override
  String get faq_plan => 'Program puasa mana yang harus saya pilih?';

  @override
  String get faq_planAnswer =>
      'Jika baru mulai, pilih 12:12 atau 14:10. Jika berpengalaman, coba 16:8 atau 18:6. 20:4 dan OMAD untuk pelaku puasa tingkat lanjut.';

  @override
  String get faq_exercise => 'Bolehkah saya berolahraga saat berpuasa?';

  @override
  String get faq_exerciseAnswer =>
      'Ya, tetapi hindari latihan intensif. Kardio ringan, berjalan, dan yoga ideal. Jadwalkan latihan beban dekat jendela makan.';

  @override
  String get faq_weight => 'Apakah puasa membantu menurunkan berat badan?';

  @override
  String get faq_weightAnswer =>
      'Bagi sebagian orang, membatasi waktu makan dapat mengurangi total asupan energi. Hasilnya beragam dan dampak jangka panjang masih diteliti.';

  @override
  String get plan_12_desc => 'Tingkat pemula';

  @override
  String get plan_12_detail =>
      'Ideal untuk pemula. Berpuasalah 12 jam termasuk waktu tidur.';

  @override
  String get plan_16_desc => 'Program terpopuler';

  @override
  String get plan_16_detail =>
      'Program puasa intermiten yang paling umum: puasa 16 jam dan jendela makan 8 jam, biasanya dari makan siang hingga makan malam.';

  @override
  String get plan_18_desc => 'Tingkat menengah';

  @override
  String get plan_18_detail =>
      'Puasa 18 jam dan jendela makan 6 jam. Durasi pembakaran lemak lebih lama.';

  @override
  String get plan_20_desc => 'Tingkat lanjut';

  @override
  String get plan_20_detail =>
      'Puasa 20 jam dan jendela makan 4 jam. Ideal untuk mencapai ketosis dan autofagi.';

  @override
  String get plan_omad_desc => 'Satu kali makan sehari';

  @override
  String get plan_omad_detail =>
      'Satu kali makan sehari: puasa 23 jam dan jendela makan 1 jam. Tingkat ahli.';

  @override
  String get plan_52_desc => '2 hari per minggu';

  @override
  String get plan_52_detail =>
      'Makan normal selama 5 hari dan batasi sekitar 500 kalori selama 2 hari. Pendekatan alternatif.';

  @override
  String get plan_ese_desc => 'Puasa 24 jam';

  @override
  String get plan_ese_detail =>
      'Berpuasalah 24 jam 1–2 kali per minggu. Untuk tingkat lanjut.';

  @override
  String get plan_warrior_desc => 'Diet Prajurit';

  @override
  String get plan_warrior_detail =>
      'Makan ringan pada siang hari, lalu makan utama dalam jendela empat jam pada malam hari.';

  @override
  String get award_first_title => 'Langkah Pertama';

  @override
  String get award_first_desc => 'Selesaikan puasa pertama Anda';

  @override
  String get award_rhythm3_title => 'Ritme 3 Hari';

  @override
  String get award_rhythm3_desc => 'Pertahankan ritme selama tiga hari';

  @override
  String get award_hours24_title => '24 Jam';

  @override
  String get award_hours24_desc => 'Berpuasa total 24 jam';

  @override
  String get award_week_title => 'Ritme Satu Minggu';

  @override
  String get award_week_desc => 'Bangun rentetan tujuh hari';

  @override
  String get award_fasts10_title => '10 Puasa';

  @override
  String get award_fasts10_desc => 'Selesaikan sepuluh puasa';

  @override
  String get award_hours100_title => '100 Jam';

  @override
  String get award_hours100_desc => 'Capai total 100 jam';

  @override
  String get award_rhythm30_title => 'Ritme 30 Hari';

  @override
  String get award_rhythm30_desc => 'Bangun rentetan tiga puluh hari';

  @override
  String get award_fasts50_title => '50 Puasa';

  @override
  String get award_fasts50_desc => 'Selesaikan lima puluh puasa';

  @override
  String get award_hours500_title => '500 Jam';

  @override
  String get award_hours500_desc => 'Capai total 500 jam';

  @override
  String get award_fasts100_title => '100 Puasa';

  @override
  String get award_fasts100_desc => 'Selesaikan seratus puasa';

  @override
  String get award_rhythm90_title => 'Ritme 90 Hari';

  @override
  String get award_rhythm90_desc => 'Bangun rentetan sembilan puluh hari';

  @override
  String get award_year_title => 'Perjalanan Satu Tahun';

  @override
  String get award_year_desc => 'Capai ritme 365 hari';

  @override
  String get awards_loadError => 'Kemajuan tidak dapat dimuat';

  @override
  String get awards_journeyComplete => 'Perjalanan selesai';

  @override
  String get awards_nextGoal => 'Target berikutnya';

  @override
  String get awards_allYours => 'Semua pencapaian milik Anda';

  @override
  String get awards_dayStreak => 'hari berturut-turut';

  @override
  String get awards_fasts => 'puasa';

  @override
  String get awards_total => 'total';

  @override
  String get awards_stageStart => 'Mulai';

  @override
  String get awards_stageRhythm => 'Ritme';

  @override
  String get awards_stageEndurance => 'Ketahanan';

  @override
  String get awards_stageMastery => 'Penguasaan';

  @override
  String get awards_completed => 'Selesai';

  @override
  String awards_fastsRemaining(int count) {
    return '$count puasa lagi';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count hari lagi';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count jam lagi';
  }

  @override
  String get common_retry => 'Coba lagi';

  @override
  String get game_title => 'Pusat Kemajuan';

  @override
  String get game_quests => 'Misi hari ini';

  @override
  String get game_questsDesc => 'Langkah kecil, ritme berkelanjutan.';

  @override
  String get game_season => 'Musim 30 langkah';

  @override
  String get game_seasonDesc => 'Segel koleksi setiap langkah kelima.';

  @override
  String get game_badges => 'Koleksi lencana';

  @override
  String game_shields(int count) {
    return '$count perisai ritme';
  }

  @override
  String get game_shieldsDesc =>
      'Diperoleh setiap tujuh penyelesaian. Hari yang terlewat tidak pernah menghapus kemajuan Anda.';

  @override
  String get game_league => 'Liga mingguan pribadi';

  @override
  String game_leagueDesc(int percent) {
    return 'Skor ritme Anda berada di persentil ke-$percent dalam model lokal pribadi. Berat badan dan puasa ekstrem tidak pernah diperingkat.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Level $level, $xp poin pengalaman';
  }

  @override
  String get game_explorer => 'Penjelajah Ritme';

  @override
  String get game_streak => 'Rentetan';

  @override
  String get game_targets => 'Target';

  @override
  String get game_best => 'Terbaik';

  @override
  String get quest_rhythm => 'Bangun ritme hari ini';

  @override
  String get quest_hydrate => 'Capai separuh target air';

  @override
  String get quest_steady => 'Lindungi rentetan Anda';

  @override
  String get badge_first_title => 'Langkah Pertama';

  @override
  String get badge_first_desc => 'Catat puasa pertama Anda';

  @override
  String get badge_rhythm7_title => 'Penjaga Ritme';

  @override
  String get badge_rhythm7_desc => 'Capai rentetan 7 hari';

  @override
  String get badge_rhythm3_title => 'Ritme Tiga Hari';

  @override
  String get badge_rhythm3_desc => 'Capai rentetan 3 hari';

  @override
  String get badge_target1_title => 'Target Pertama';

  @override
  String get badge_target1_desc => 'Selesaikan target puasa pertama';

  @override
  String get badge_target3_title => 'Tiga Langkah';

  @override
  String get badge_target3_desc => 'Selesaikan 3 target';

  @override
  String get badge_water_title => 'Seimbang';

  @override
  String get badge_water_desc => 'Penuhi target air harian';

  @override
  String get badge_support_title => 'Sadar Diri';

  @override
  String get badge_support_desc => 'Gunakan mode dukungan';

  @override
  String get badge_hours10_title => '10 Jam';

  @override
  String get badge_hours10_desc => 'Catat total 10 jam';

  @override
  String get badge_target10_title => 'Sepuluh Kuat';

  @override
  String get badge_target10_desc => 'Selesaikan 10 target';

  @override
  String get badge_target20_title => 'Dua Puluh Target';

  @override
  String get badge_target20_desc => 'Selesaikan 20 target';

  @override
  String get badge_fast16_title => '16 Jam';

  @override
  String get badge_fast16_desc => 'Capai 16 jam dalam satu puasa';

  @override
  String get badge_hours50_title => '50 Jam';

  @override
  String get badge_hours50_desc => 'Catat total 50 jam';

  @override
  String get badge_hours100_title => 'Seratus Jam';

  @override
  String get badge_hours100_desc => 'Catat total 100 jam';

  @override
  String get badge_target30_title => 'Tiga Puluh Target';

  @override
  String get badge_target30_desc => 'Selesaikan 30 target';

  @override
  String get badge_rhythm30_title => 'Ritme 30 Hari';

  @override
  String get badge_rhythm30_desc => 'Capai rentetan 30 hari';

  @override
  String get paywall_restoreSuccess => 'Pembelian dipulihkan!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Kemajuan puasa $percent persen';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}j';
  }

  @override
  String get paywall_lifetime => 'Seumur hidup';

  @override
  String get paywall_once => 'sekali bayar';

  @override
  String get paywall_processing => 'Memproses…';

  @override
  String get paywall_continue => 'Lanjutkan';

  @override
  String get paywall_productsUnavailable =>
      'Pembelian sedang tidak tersedia. Coba lagi nanti.';

  @override
  String get paywall_purchaseFailed => 'Pembelian tidak dapat diselesaikan.';

  @override
  String get paywall_nothingToRestore =>
      'Tidak ada pembelian sebelumnya yang ditemukan.';

  @override
  String get paywall_restoreFailed => 'Pembelian tidak dapat dipulihkan.';

  @override
  String get paywall_terms => 'Ketentuan Penggunaan';

  @override
  String get permission_notificationDesc =>
      'Pengingat puasa, pembaruan fase, dan notifikasi penyelesaian';

  @override
  String get profile_privacyChoices => 'Pilihan privasi';

  @override
  String get paywall_autoRenewInfo =>
      'Langganan diperpanjang otomatis kecuali dibatalkan setidaknya 24 jam sebelum periode berakhir. Kelola atau batalkan kapan saja di pengaturan App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / bulan';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Hemat $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Uji coba gratis $days hari';
  }

  @override
  String get paywall_startFreeTrial => 'Mulai uji coba gratis';

  @override
  String get paywall_retry => 'Coba lagi';

  @override
  String get paywall_alreadyOwned =>
      'Anda sudah memiliki langganan ini. Ketuk Pulihkan pembelian.';

  @override
  String get paywall_storeUnavailable =>
      'Toko tidak dapat diakses saat ini. Periksa koneksi dan coba lagi.';

  @override
  String get paywall_secureNote =>
      'Batalkan kapan saja. Pembayaran dibebankan ke akun toko Anda.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Langganan diperpanjang otomatis kecuali dibatalkan setidaknya 24 jam sebelum periode berakhir. Kelola atau batalkan di Google Play > Langganan.';

  @override
  String get paywall_allPlansDesc =>
      'Membuka 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat, dan Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Iklan spanduk dan layar penuh dinonaktifkan sepenuhnya';

  @override
  String get foodScan_title => 'Pemindaian Makanan AI';

  @override
  String get foodScan_scanCta => 'Pindai makanan';

  @override
  String get foodScan_scanCtaDesc =>
      'Foto piring Anda untuk mendapatkan kalori dan makro';

  @override
  String get foodScan_introTitle => 'Foto piring Anda';

  @override
  String get foodScan_introDesc =>
      'AI membaca foto dan memperkirakan kalori, protein, karbohidrat, serta lemak.';

  @override
  String get foodScan_tipLight =>
      'Cahaya yang baik dan merata memberikan perkiraan lebih baik';

  @override
  String get foodScan_tipFrame => 'Pastikan seluruh piring masuk dalam bingkai';

  @override
  String get foodScan_tipScale =>
      'Sertakan alat makan atau tangan agar porsi dapat diperkirakan';

  @override
  String get foodScan_takePhoto => 'Ambil foto';

  @override
  String get foodScan_chooseFromGallery => 'Pilih dari galeri';

  @override
  String foodScan_scansLeft(int count) {
    return '$count pemindaian tersisa hari ini';
  }

  @override
  String get foodScan_quotaReached =>
      'Pemindaian hari ini sudah digunakan. Coba lagi besok.';

  @override
  String get foodScan_privacyNote =>
      'Foto dikirim ke Gemini API Google untuk dianalisis dan tidak disimpan di server kami.';

  @override
  String get foodScan_consentTitle => 'Kirim foto ke Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Untuk memperkirakan kalori dan makro, setiap foto makanan yang Anda ambil atau pilih dikirim ke layanan AI Gemini dari Google. Foto hanya digunakan untuk analisis ini dan tidak disimpan di server kami.';

  @override
  String get foodScan_consentAgree => 'Setuju dan lanjutkan';

  @override
  String get foodScan_analyzing => 'Menganalisis makanan Anda…';

  @override
  String get foodScan_analyzingHint => 'Biasanya memerlukan beberapa detik';

  @override
  String get foodScan_detectedItems => 'Item terdeteksi';

  @override
  String get foodScan_disclaimer =>
      'Perkiraan AI bersifat mendekati. Ketuk item untuk memperbaikinya.';

  @override
  String get foodScan_lowConfidence =>
      'Model kurang yakin dengan foto ini. Periksa angka sebelum menyimpan.';

  @override
  String get foodScan_save => 'Tambahkan ke makanan';

  @override
  String get foodScan_retake => 'Foto baru';

  @override
  String get foodScan_retry => 'Coba lagi';

  @override
  String get foodScan_editItem => 'Edit item';

  @override
  String get foodScan_portion => 'Porsi';

  @override
  String get foodScan_saveEdit => 'Simpan';

  @override
  String get foodScan_premiumTitle => 'Fitur Premium';

  @override
  String get foodScan_premiumDesc =>
      'Analisis kalori dari foto termasuk dalam Premium.';

  @override
  String get foodScan_upgrade => 'Lihat Premium';

  @override
  String get foodScan_errorNetwork =>
      'Tidak ada koneksi. Periksa internet dan coba lagi.';

  @override
  String get foodScan_errorRateLimited =>
      'Terlalu banyak pemindaian saat ini. Coba lagi dalam beberapa menit.';

  @override
  String get foodScan_errorUnavailable =>
      'Analisis foto sedang tidak tersedia.';

  @override
  String get foodScan_errorServer =>
      'Layanan analisis mengalami gangguan. Coba lagi sebentar lagi.';

  @override
  String get foodScan_errorNoFood =>
      'Tidak ada makanan yang ditemukan dalam foto ini. Coba foto piring yang lebih jelas.';

  @override
  String get foodScan_errorUnreadable =>
      'Foto ini tidak dapat dianalisis. Coba foto lain.';

  @override
  String get paywall_aiFoodScan => 'Pemindaian Makanan AI';

  @override
  String get paywall_aiFoodScanDesc =>
      'Foto makanan dan catat kalori serta makronya dalam hitungan detik';
}
