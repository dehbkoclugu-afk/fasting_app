// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Jó reggelt';

  @override
  String get greeting_afternoon => 'Jó napot';

  @override
  String get greeting_evening => 'Jó estét';

  @override
  String get tab_timer => 'Kezdőlap';

  @override
  String get tab_explore => 'Felfedezés';

  @override
  String get tab_stats => 'Jelentés';

  @override
  String get tab_meals => 'Étkezések';

  @override
  String get tab_achievements => 'Díjak';

  @override
  String get tab_profile => 'Fiók';

  @override
  String get timer_fasting => 'Böjt ideje';

  @override
  String get timer_remaining => 'Hátralévő';

  @override
  String get timer_elapsed => 'Eltelt';

  @override
  String get timer_start => 'Indítás';

  @override
  String get timer_stop => 'Leállítás';

  @override
  String get timer_completed => 'Gratulálunk!';

  @override
  String get timer_completedMessage => 'Sikeresen teljesítetted a böjtöt!';

  @override
  String get timer_selectPlan => 'Böjtprogram kiválasztása';

  @override
  String get timer_stopConfirm => 'Biztosan idő előtt befejezed a böjtöt?';

  @override
  String get timer_stopTitle => 'Böjt befejezése';

  @override
  String get timer_cancel => 'Mégse';

  @override
  String get timer_confirmStop => 'Igen, befejezem';

  @override
  String get phase_anabolic => 'Anabolikus';

  @override
  String get phase_anabolicDesc => 'Emésztés folyamatban';

  @override
  String get phase_catabolic => 'Katabolikus';

  @override
  String get phase_catabolicDesc => 'Energiaátállás';

  @override
  String get phase_fatBurning => 'Zsírégetés';

  @override
  String get phase_fatBurningDesc => 'A zsírégetés elkezdődött';

  @override
  String get phase_ketosis => 'Ketózis';

  @override
  String get phase_ketosisDesc => 'Aktív ketontermelés';

  @override
  String get phase_autophagy => 'Autofágia';

  @override
  String get phase_autophagyDesc => 'Sejtmegújulás';

  @override
  String get stats_title => 'Statisztikák';

  @override
  String get stats_week => 'Hét';

  @override
  String get stats_month => 'Hónap';

  @override
  String get stats_year => 'Év';

  @override
  String get stats_totalFasts => 'Összes böjt';

  @override
  String get stats_average => 'Átlag';

  @override
  String get stats_fastDuration => 'böjt időtartama';

  @override
  String get stats_streak => 'Sorozat';

  @override
  String get stats_daysConsecutive => 'egymást követő nap';

  @override
  String get stats_success => 'Siker';

  @override
  String get stats_completion => 'teljesítés';

  @override
  String get stats_weeklyFasting => 'Heti böjt';

  @override
  String get stats_monthlyView => 'Havi nézet';

  @override
  String get stats_weightChange => 'Súlyváltozás';

  @override
  String get heatmap_none => 'Nincs';

  @override
  String get heatmap_low => 'Alacsony';

  @override
  String get heatmap_good => 'Jó';

  @override
  String get heatmap_full => 'Teljes';

  @override
  String get meals_title => 'Étkezéstervező';

  @override
  String get meals_eatingWindow => 'Étkezési időablak';

  @override
  String get meals_windowOpen => 'Nyitva';

  @override
  String get meals_windowFasting => 'Böjt';

  @override
  String get meals_calories => 'Kalória';

  @override
  String get meals_protein => 'Fehérje';

  @override
  String get meals_carbs => 'Szénhidrát';

  @override
  String get meals_fat => 'Zsír';

  @override
  String get meals_todayMeals => 'Mai étkezések';

  @override
  String get meals_noMeals => 'Még nincs hozzáadott étkezés';

  @override
  String get meals_breakfastSuggestions => 'Javaslatok a böjt megtöréséhez';

  @override
  String get meals_addMeal => 'Étkezés hozzáadása';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Felhasználó';

  @override
  String profile_planActive(String plan) {
    return 'A(z) $plan program aktív';
  }

  @override
  String get profile_upgradePremium => 'Váltás Premiumra';

  @override
  String get profile_premiumDesc => 'Minden böjtprogram, reklámok nélkül';

  @override
  String get profile_bodyMetrics => 'Testadatok';

  @override
  String get profile_height => 'Magasság';

  @override
  String get profile_weight => 'Testsúly';

  @override
  String get profile_targetWeight => 'Célsúly';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Beállítások';

  @override
  String get profile_notifications => 'Értesítések';

  @override
  String get profile_darkTheme => 'Sötét téma';

  @override
  String get profile_waterReminder => 'Vízivási emlékeztető';

  @override
  String get profile_phaseNotifications => 'Fázisértesítések';

  @override
  String get profile_language => 'Nyelv';

  @override
  String get profile_about => 'Névjegy';

  @override
  String get profile_rateApp => 'Alkalmazás értékelése';

  @override
  String get profile_share => 'Megosztás';

  @override
  String get profile_privacyPolicy => 'Adatvédelmi szabályzat';

  @override
  String get profile_version => 'Verzió';

  @override
  String get onboarding_welcome => 'Üdvözlünk';

  @override
  String get onboarding_welcomeDesc =>
      'Vedd kézbe az időszakos böjttel\nkapcsolatos utadat';

  @override
  String get onboarding_featureTimer => 'Intelligens böjtidőzítő';

  @override
  String get onboarding_featureStats => 'Részletes statisztikák és diagramok';

  @override
  String get onboarding_featureMeals => 'Étkezéstervező és receptjavaslatok';

  @override
  String get onboarding_getStarted => 'Kezdés';

  @override
  String get onboarding_selectGoal => 'Mi a célod?';

  @override
  String get onboarding_selectGoalDesc => 'Többet is választhatsz';

  @override
  String get onboarding_goalWeight => 'Fogyás';

  @override
  String get onboarding_goalWeightDesc => 'Egészséges fogyás';

  @override
  String get onboarding_goalHealth => 'Egészség javítása';

  @override
  String get onboarding_goalHealthDesc => 'Általános egészség és immunitás';

  @override
  String get onboarding_goalEnergy => 'Több energia';

  @override
  String get onboarding_goalEnergyDesc => 'Energia egész nap';

  @override
  String get onboarding_goalMental => 'Szellemi tisztaság';

  @override
  String get onboarding_goalMentalDesc => 'Összpontosítás és tisztánlátás';

  @override
  String get onboarding_goalLongevity => 'Hosszú élet';

  @override
  String get onboarding_goalLongevityDesc =>
      'Sejtmegújulás és egészséges öregedés';

  @override
  String get onboarding_goalDiscipline => 'Fegyelem';

  @override
  String get onboarding_goalDisciplineDesc => 'Önfegyelem kialakítása';

  @override
  String get onboarding_selectPlan => 'Válassz programot';

  @override
  String get onboarding_selectPlanDesc =>
      'Válaszd ki a számodra legjobb böjtprogramot';

  @override
  String get onboarding_bodyInfo => 'Add meg az adataidat';

  @override
  String get onboarding_bodyInfoDesc => 'Személyre szabott ajánlásokhoz';

  @override
  String get onboarding_gender => 'Nem';

  @override
  String get onboarding_male => 'Férfi';

  @override
  String get onboarding_female => 'Nő';

  @override
  String get onboarding_age => 'Életkor';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Ezeket az adatokat csak az eszközödön tároljuk, és kalóriaszámításhoz használjuk.';

  @override
  String get onboarding_permissions => 'Utolsó lépés';

  @override
  String get onboarding_permissionsDesc =>
      'A legjobb élményhez engedélyezd a hozzáféréseket';

  @override
  String get onboarding_next => 'Folytatás';

  @override
  String get onboarding_start => 'Vágjunk bele!';

  @override
  String get onboarding_skipForNow => 'Beállítás később';

  @override
  String get waterAdded => '250 ml víz hozzáadva';

  @override
  String get languageSelect => 'Nyelv kiválasztása';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Váltás Premiumra';

  @override
  String get paywall_subtitle =>
      'Oldd fel az összes böjtprogramot, és távolítsd el a reklámokat';

  @override
  String get paywall_allPlans => 'Minden böjtprogram';

  @override
  String get paywall_advancedStats => 'Haladó statisztikák';

  @override
  String get paywall_mealPlanner => 'Étkezéstervező';

  @override
  String get paywall_themes => 'Téma testreszabása';

  @override
  String get paywall_noAds => 'Reklámmentes';

  @override
  String get paywall_weekly => 'Heti';

  @override
  String get paywall_monthly => 'Havi';

  @override
  String get paywall_yearly => 'Éves';

  @override
  String get paywall_bestValue => 'Legjobb ajánlat';

  @override
  String get paywall_freeTrial => 'Ingyenes próbaidőszak (3 nap)';

  @override
  String get paywall_restore => 'Vásárlások visszaállítása';

  @override
  String get paywall_premiumActive => 'A Premium aktív!';

  @override
  String get paywall_premiumActiveDesc =>
      'Minden böjtprogram fel van oldva, a reklámok pedig ki vannak kapcsolva';

  @override
  String get water_title => 'Vízbevitel';

  @override
  String get water_addWater => 'Víz hozzáadása';

  @override
  String get water_goal => 'Cél';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Mégse';

  @override
  String get common_save => 'Mentés';

  @override
  String get common_delete => 'Törlés';

  @override
  String get common_hours => 'óra';

  @override
  String get common_minutes => 'perc';

  @override
  String get common_days => 'nap';

  @override
  String get common_enable => 'Engedélyezés';

  @override
  String get streakCard_currentStreak => 'Jelenlegi sorozat';

  @override
  String get streakCard_longestStreak => 'Leghosszabb sorozat';

  @override
  String get streakCard_totalSessions => 'Összes böjt';

  @override
  String get meals_mealType => 'Étkezés típusa';

  @override
  String get meals_breakfast => 'Reggeli';

  @override
  String get meals_lunch => 'Ebéd';

  @override
  String get meals_dinner => 'Vacsora';

  @override
  String get meals_snack => 'Kisétkezés';

  @override
  String get meals_carbohydrate => 'Szénhidrát';

  @override
  String get meals_add => 'Hozzáadás';

  @override
  String get meals_mealName => 'Étkezés neve';

  @override
  String get bodyMetrics_title => 'Testadatok';

  @override
  String get bodyMetrics_weight => 'Testsúly';

  @override
  String get bodyMetrics_target => 'Cél';

  @override
  String get bodyMetrics_save => 'Mentés';

  @override
  String get bodyMetrics_history => 'Előzmények';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Még nincs adat';

  @override
  String get meals_quickAdd => 'Gyors hozzáadás';

  @override
  String get meals_manualEntry => 'Kézi bevitel';

  @override
  String meals_added(String name) {
    return '$name hozzáadva';
  }

  @override
  String get meals_nameCalorieRequired =>
      'A név és a kalória megadása kötelező';

  @override
  String get bodyMetrics_addWeight => 'Testsúly hozzáadása';

  @override
  String get bodyMetrics_hintWeight => 'pl. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Adj meg érvényes testsúlyt';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg mentve';
  }

  @override
  String get completion_duration => 'Időtartam';

  @override
  String get completion_plan => 'Program';

  @override
  String get completion_lastPhase => 'Utolsó fázis';

  @override
  String get completion_earlyTitle => 'A böjt véget ért';

  @override
  String get completion_earlyMessage =>
      'A mai időt elmentettük. A sorozat és az eredmények előrehaladása nem változott, mert a cél nem teljesült.';

  @override
  String get timer_remainingTime => 'Hátralévő idő';

  @override
  String get timer_ready => 'Indításra kész';

  @override
  String get streak_status => 'Állapot';

  @override
  String get streak_startToday => 'Kezdd el ma!';

  @override
  String get streak_goodStart => 'Jó kezdet!';

  @override
  String get streak_goingGreat => 'Remekül haladsz!';

  @override
  String get streak_superb => 'Nagyszerű!';

  @override
  String get streak_legendary => 'Legendás!';

  @override
  String get streak_incredible => 'Hihetetlen!';

  @override
  String get weight_noRecord =>
      'Még nincs súlyadat\nAdd hozzá a Profil > Testadatok menüben';

  @override
  String get day_mon => 'H';

  @override
  String get day_tue => 'K';

  @override
  String get day_wed => 'Sze';

  @override
  String get day_thu => 'Cs';

  @override
  String get day_fri => 'P';

  @override
  String get day_sat => 'Szo';

  @override
  String get day_sun => 'V';

  @override
  String get day_short_mon => 'H';

  @override
  String get day_short_tue => 'K';

  @override
  String get day_short_wed => 'S';

  @override
  String get day_short_thu => 'C';

  @override
  String get day_short_fri => 'P';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'V';

  @override
  String get month_jan => 'Január';

  @override
  String get month_feb => 'Február';

  @override
  String get month_mar => 'Március';

  @override
  String get month_apr => 'Április';

  @override
  String get month_may => 'Május';

  @override
  String get month_jun => 'Június';

  @override
  String get month_jul => 'Július';

  @override
  String get month_aug => 'Augusztus';

  @override
  String get month_sep => 'Szeptember';

  @override
  String get month_oct => 'Október';

  @override
  String get month_nov => 'November';

  @override
  String get month_dec => 'December';

  @override
  String meals_fastingWindow(String hours) {
    return 'Böjt ($hours ó)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Étkezés ($hours ó)';
  }

  @override
  String get recipe_oatSmoothie => 'Zabturmix';

  @override
  String get recipe_avocadoToast => 'Avokádós pirítós';

  @override
  String get recipe_yogurtBowl => 'Joghurtos tál';

  @override
  String get elapsed_time => 'Eltelt idő';

  @override
  String get fast_ends_on => 'A böjtöd ekkor ér véget:';

  @override
  String get end_fasting => 'Böjt befejezése';

  @override
  String get start_fasting => 'Böjt indítása';

  @override
  String get water_tracker => 'Vízfogyasztás-követő';

  @override
  String get weight_tracker => 'Súlykövető';

  @override
  String get drink => 'Ivás';

  @override
  String get log_weight => 'Testsúly rögzítése';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Leadott súly';

  @override
  String get current_weight => 'Jelenlegi testsúly';

  @override
  String get goal_weight => 'Célsúly';

  @override
  String get daily_goal => 'Napi cél';

  @override
  String completed_percent(String percent) {
    return '$percent% teljesítve';
  }

  @override
  String get explore => 'Felfedezés';

  @override
  String get achievements => 'Eredmények';

  @override
  String get profile_theme => 'Megjelenés';

  @override
  String get theme_select => 'Megjelenés kiválasztása';

  @override
  String get theme_system => 'Rendszer alapértelmezése';

  @override
  String get theme_light => 'Világos';

  @override
  String get theme_dark => 'Sötét';

  @override
  String get language_system => 'Rendszer nyelve';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Befejezési hang';

  @override
  String get profile_calmGamification => 'Nyugodt játékosítás';

  @override
  String get profile_calmGamificationDesc =>
      'Csökkenti a liga és az idény okozta nyomást';

  @override
  String get profile_editName => 'Név szerkesztése';

  @override
  String get profile_name => 'Név';

  @override
  String get circle_title => 'Böjtkör';

  @override
  String get circle_you => 'Te';

  @override
  String get circle_tagline => 'Együtt, nyomás nélkül.';

  @override
  String get circle_privacy =>
      'A testsúly és a személyes adatok rejtve maradnak. Csak a haladás és a támogatás látható.';

  @override
  String circle_sendSupport(int count) {
    return 'Támogatás küldése · $count';
  }

  @override
  String get circle_inviteCopied => 'Meghívókód másolva';

  @override
  String get circle_createInvite => 'Privát meghívó létrehozása';

  @override
  String get crisis_nameTitle => 'Először nevezd meg, mi történik';

  @override
  String get crisis_nameDesc => 'Lehet éhség, szokás vagy érzelem.';

  @override
  String get crisis_waterTitle => 'Igyál egy pohár vizet';

  @override
  String get crisis_waterDesc => 'Ezután vegyél három lassú lélegzetet.';

  @override
  String get crisis_delayTitle => 'Halaszd el a döntést 10 perccel';

  @override
  String get crisis_delayDesc =>
      'Ha rosszul érzed magad, a böjt befejezése nem kudarc.';

  @override
  String get crisis_hunger => 'Éhség';

  @override
  String get crisis_habit => 'Szokás';

  @override
  String get crisis_stress => 'Stressz';

  @override
  String get crisis_tenMore => 'Adj neki 10 percet';

  @override
  String get stats_storyEmpty =>
      'Az első böjtöddel elkezdődik a saját történeted.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Ebben az időszakban $sessions alkalommal böjtöltél, $hours órán át tartottad a ritmust, és $rate%-os teljesítési arányt értél el.';
  }

  @override
  String get stats_storyTitle => 'A ritmusod története';

  @override
  String get home_todayRhythm => 'Mai ritmus';

  @override
  String get home_finalHourSupport => 'Támogatás az utolsó órában';

  @override
  String get home_needSupport => 'Szükségem van egy kis támogatásra';

  @override
  String get home_todaySummary => 'A mai nap áttekintése';

  @override
  String get home_dayStreak => 'napos sorozat';

  @override
  String home_weightGoal(String weight) {
    return 'cél: $weight kg';
  }

  @override
  String get weather_steady => 'A ritmusod egyenletes';

  @override
  String get weather_gentle => 'Egy könnyed nap';

  @override
  String get weather_water => 'Egy pohár víz segíthet.';

  @override
  String get weather_listen => 'Messzire jutottál; hallgass a testedre.';

  @override
  String get weather_onPlan => 'A mai tempó megfelel a programodnak.';

  @override
  String get weather_challenging =>
      'Ez az óra korábban nehéz volt; a támogatási mód készen áll.';

  @override
  String get replay_copied => 'Böjtösszefoglaló másolva';

  @override
  String get replay_button => 'Összefoglaló';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'A(z) $plan böjtömet $hours óra $minutes perc alatt teljesítettem · $phase';
  }

  @override
  String get journey_label => 'Anyagcsere-út';

  @override
  String get journey_now => 'Most';

  @override
  String journey_next(String time, String phase) {
    return '$time a(z) $phase fázisig';
  }

  @override
  String get phase_estimateShort =>
      'A fázisok időzítése általános becslés, nem orvosi mérés.';

  @override
  String phase_hours(int start, int end) {
    return '$start–$end. óra';
  }

  @override
  String get phase_estimateLong =>
      'Ez az időzítés általános becslés. Az anyagcsere-reakciók egyénenként eltérhetnek.';

  @override
  String get bmi_underweight => 'Soványság';

  @override
  String get bmi_normal => 'Normál testsúly';

  @override
  String get bmi_overweight => 'Túlsúly';

  @override
  String get bmi_obese => 'Elhízás';

  @override
  String get notification_halfwayTitle => 'Félúton jársz! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Teljesítetted a(z) $plan böjt felét. Csak így tovább!';
  }

  @override
  String get notification_phaseCatabolic => 'Beléptél a katabolikus fázisba 📉';

  @override
  String get notification_phaseFatBurning => 'Elkezdődött a zsírégetés! 🔥';

  @override
  String get notification_phaseKetosis => 'Ketózisban vagy ⚡';

  @override
  String get notification_phaseAutophagy => 'Az autofágia aktív! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Teljesítetted a(z) $plan böjtöt! Az étkezési időablak megnyílt.';
  }

  @override
  String get notification_waterTitle => 'Igyál vizet 💧';

  @override
  String get notification_waterBody =>
      'Ne felejts el elegendő vizet inni böjt közben!';

  @override
  String get notification_windowTitle => 'Az étkezési időablak zárul ⏰';

  @override
  String get notification_windowBody =>
      'Az étkezési időablak 30 perc múlva bezárul.';

  @override
  String notification_streakTitle(int days) {
    return '$days napos sorozat! 🔥';
  }

  @override
  String get notification_streakBody => 'Remekül haladsz! Folytasd ma is.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Böjt folyamatban – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Hátralévő: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Böjt elindítva – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Cél: $hours óra';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours ó $minutes p';
  }

  @override
  String get explore_guide => 'Böjtútmutató';

  @override
  String get explore_guideDesc =>
      'Minden, amit az időszakos böjtről tudnod kell';

  @override
  String get explore_circleDesc =>
      'Ossz meg csendes támogatást a privát csoportoddal.';

  @override
  String get explore_faq => 'Gyakori kérdések';

  @override
  String get explore_education =>
      'Ez a tartalom kizárólag általános tájékoztatásra szolgál, és nem minősül orvosi diagnózisnak vagy kezelési tanácsnak.';

  @override
  String get explore_safety => 'Egészség és biztonság';

  @override
  String get explore_safetyDesc =>
      'Ha egészségügyi problémád van, rendszeresen gyógyszert szedsz, aggasztó tüneteid vannak, terhes vagy szoptatsz, böjt előtt kérd ki képzett egészségügyi szakember tanácsát. Hagyd abba, ha rosszul érzed magad.';

  @override
  String get explore_sources => 'Források';

  @override
  String get explore_sourcesDesc =>
      'A tartalom az alábbi közegészségügyi források egyszerűsített változata.';

  @override
  String get explore_sourceError => 'A forrás nem nyitható meg';

  @override
  String get explore_rules => 'Fontos szabályok';

  @override
  String get explore_rule1 => 'Böjt alatt ne fogyassz kalóriatartalmú ételt';

  @override
  String get explore_rule2 => 'Igyál sok vizet és folyadékot';

  @override
  String get explore_rule3 =>
      'Az étkezési időablakban táplálkozz kiegyensúlyozottan';

  @override
  String get explore_rule4 => 'Hagyd abba a böjtöt, ha rosszul érzed magad';

  @override
  String get explore_rule5 => 'Terhes vagy szoptató nők ne böjtöljenek';

  @override
  String get explore_rule6 => 'Krónikus betegség esetén konzultálj orvossal';

  @override
  String get tip_water => 'Maradj hidratált';

  @override
  String get tip_waterDesc =>
      'Igyál vizet, amikor szomjas vagy, és étkezésekhez is fogyassz folyadékot. Az igény az egészségi állapottól, időjárástól és aktivitástól függhet.';

  @override
  String get tip_food => 'Táplálkozz helyesen';

  @override
  String get tip_foodDesc =>
      'Az étkezési időablakban válassz fehérjében és rostban gazdag ételeket, valamint egészséges zsírokat. Kerüld a feldolgozott élelmiszereket.';

  @override
  String get tip_sleep => 'Aludj jól';

  @override
  String get tip_sleepDesc =>
      'A rendszeres, elegendő alvás támogatja az általános jóllétet. Úgy időzítsd a böjtöt, hogy ne zavarja az alvásodat.';

  @override
  String get tip_exercise => 'Könnyű testmozgás';

  @override
  String get tip_exerciseDesc =>
      'Böjt alatt könnyű sétát vagy jógát végezhetsz. Kerüld a megerőltető edzést, különösen az első hetekben, amíg a tested alkalmazkodik.';

  @override
  String get tip_drinks => 'Engedélyezett italok';

  @override
  String get tip_drinksDesc =>
      'Böjt alatt vizet, ízesítetlen teát és feketekávét ihatsz cukor és tej nélkül. Ezek nem törik meg a böjtöt.';

  @override
  String get faq_drinks => 'Mit ihatok böjt alatt?';

  @override
  String get faq_drinksAnswer =>
      'Vizet, ízesítetlen teát és feketekávét ihatsz cukor és tej nélkül. A kalóriatartalmú italok megtörik a böjtöt.';

  @override
  String get faq_plan => 'Melyik böjtprogramot válasszam?';

  @override
  String get faq_planAnswer =>
      'Ha kezdő vagy, kezdd a 12:12 vagy 14:10 programmal. Ha tapasztaltabb vagy, próbáld a 16:8 vagy 18:6 programot. A 20:4 és az OMAD haladóknak való.';

  @override
  String get faq_exercise => 'Edzhetek böjt alatt?';

  @override
  String get faq_exerciseAnswer =>
      'Igen, de kerüld az intenzív edzést. A könnyű kardió, séta és jóga ideális. Az erősítő edzést időzítsd az étkezési időablak közelébe.';

  @override
  String get faq_weight => 'Segít a böjt a fogyásban?';

  @override
  String get faq_weightAnswer =>
      'Egyeseknél az étkezési idő korlátozása csökkentheti a teljes energiabevitelt. Az eredmények eltérnek, a hosszú távú hatásokat még vizsgálják.';

  @override
  String get plan_12_desc => 'Kezdő szint';

  @override
  String get plan_12_detail =>
      'Ideális kezdőknek. Böjtölj 12 órát, az alvásidőt is beleszámítva.';

  @override
  String get plan_16_desc => 'Legnépszerűbb program';

  @override
  String get plan_16_detail =>
      'A leggyakoribb időszakos böjtprogram: 16 óra böjt és 8 órás étkezési időablak, általában ebédtől vacsoráig.';

  @override
  String get plan_18_desc => 'Középhaladó szint';

  @override
  String get plan_18_detail =>
      '18 óra böjt és 6 órás étkezési időablak. Hosszabb zsírégetési idő.';

  @override
  String get plan_20_desc => 'Haladó szint';

  @override
  String get plan_20_detail =>
      '20 óra böjt és 4 órás étkezési időablak. Ideális a ketózis és az autofágia eléréséhez.';

  @override
  String get plan_omad_desc => 'Napi egy étkezés';

  @override
  String get plan_omad_detail =>
      'Napi egy étkezés: 23 óra böjt és 1 órás étkezési időablak. Szakértői szint.';

  @override
  String get plan_52_desc => 'Heti 2 nap';

  @override
  String get plan_52_detail =>
      'Öt napig étkezz normálisan, két napon pedig korlátozd a bevitelt körülbelül 500 kalóriára. Alternatív megközelítés.';

  @override
  String get plan_ese_desc => '24 órás böjt';

  @override
  String get plan_ese_detail =>
      'Böjtölj 24 órán át hetente 1–2 alkalommal. Haladóknak.';

  @override
  String get plan_warrior_desc => 'Harcos étrend';

  @override
  String get plan_warrior_detail =>
      'Napközben étkezz könnyedén, a főétkezést pedig egy négyórás esti időablakban fogyaszd el.';

  @override
  String get award_first_title => 'Első lépés';

  @override
  String get award_first_desc => 'Teljesítsd az első böjtödet';

  @override
  String get award_rhythm3_title => 'Háromnapos ritmus';

  @override
  String get award_rhythm3_desc => 'Tartsd a ritmust három napon át';

  @override
  String get award_hours24_title => '24 óra';

  @override
  String get award_hours24_desc => 'Böjtölj összesen 24 órát';

  @override
  String get award_week_title => 'Egyhetes ritmus';

  @override
  String get award_week_desc => 'Építs fel egy hétnapos sorozatot';

  @override
  String get award_fasts10_title => '10 böjt';

  @override
  String get award_fasts10_desc => 'Teljesíts tíz böjtöt';

  @override
  String get award_hours100_title => '100 óra';

  @override
  String get award_hours100_desc => 'Érd el az összesen 100 órát';

  @override
  String get award_rhythm30_title => '30 napos ritmus';

  @override
  String get award_rhythm30_desc => 'Építs fel egy harmincnapos sorozatot';

  @override
  String get award_fasts50_title => '50 böjt';

  @override
  String get award_fasts50_desc => 'Teljesíts ötven böjtöt';

  @override
  String get award_hours500_title => '500 óra';

  @override
  String get award_hours500_desc => 'Érd el az összesen 500 órát';

  @override
  String get award_fasts100_title => '100 böjt';

  @override
  String get award_fasts100_desc => 'Teljesíts száz böjtöt';

  @override
  String get award_rhythm90_title => '90 napos ritmus';

  @override
  String get award_rhythm90_desc => 'Építs fel egy kilencvennapos sorozatot';

  @override
  String get award_year_title => 'Egyéves utazás';

  @override
  String get award_year_desc => 'Érj el 365 napos ritmust';

  @override
  String get awards_loadError => 'A haladás nem tölthető be';

  @override
  String get awards_journeyComplete => 'Az utazás teljesítve';

  @override
  String get awards_nextGoal => 'Következő cél';

  @override
  String get awards_allYours => 'Minden eredmény a tiéd';

  @override
  String get awards_dayStreak => 'napos sorozat';

  @override
  String get awards_fasts => 'böjt';

  @override
  String get awards_total => 'összesen';

  @override
  String get awards_stageStart => 'Kezdet';

  @override
  String get awards_stageRhythm => 'Ritmus';

  @override
  String get awards_stageEndurance => 'Kitartás';

  @override
  String get awards_stageMastery => 'Mesterszint';

  @override
  String get awards_completed => 'Teljesítve';

  @override
  String awards_fastsRemaining(int count) {
    return 'Még $count böjt';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Még $count nap';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Még $count óra';
  }

  @override
  String get common_retry => 'Újra';

  @override
  String get game_title => 'Haladási központ';

  @override
  String get game_quests => 'Mai küldetések';

  @override
  String get game_questsDesc => 'Kis lépések, fenntartható ritmus.';

  @override
  String get game_season => '30 lépéses idény';

  @override
  String get game_seasonDesc => 'Minden ötödik lépésért gyűjthető pecsét jár.';

  @override
  String get game_badges => 'Jelvénygyűjtemény';

  @override
  String game_shields(int count) {
    return '$count ritmuspajzs';
  }

  @override
  String get game_shieldsDesc =>
      'Minden hét teljesítés után kapsz egyet. Egy kihagyott nap soha nem törli a haladásodat.';

  @override
  String get game_league => 'Privát heti liga';

  @override
  String game_leagueDesc(int percent) {
    return 'A ritmuspontszámod egy privát helyi modell $percent. percentilisébe esik. A testsúlyt és a szélsőséges böjtöt soha nem rangsoroljuk.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return '$level. szint, $xp tapasztalati pont';
  }

  @override
  String get game_explorer => 'Ritmusfelfedező';

  @override
  String get game_streak => 'Sorozat';

  @override
  String get game_targets => 'Célok';

  @override
  String get game_best => 'Legjobb';

  @override
  String get quest_rhythm => 'Építsd fel a mai ritmust';

  @override
  String get quest_hydrate => 'Érd el a vízcélod felét';

  @override
  String get quest_steady => 'Védd meg a sorozatodat';

  @override
  String get badge_first_title => 'Első lépés';

  @override
  String get badge_first_desc => 'Rögzítsd az első böjtödet';

  @override
  String get badge_rhythm7_title => 'Ritmusőrző';

  @override
  String get badge_rhythm7_desc => 'Érj el 7 napos sorozatot';

  @override
  String get badge_rhythm3_title => 'Háromnapos ritmus';

  @override
  String get badge_rhythm3_desc => 'Érj el 3 napos sorozatot';

  @override
  String get badge_target1_title => 'Első cél';

  @override
  String get badge_target1_desc => 'Teljesítsd az első célböjtödet';

  @override
  String get badge_target3_title => 'Három lépés';

  @override
  String get badge_target3_desc => 'Teljesíts 3 célt';

  @override
  String get badge_water_title => 'Egyensúlyban';

  @override
  String get badge_water_desc => 'Teljesítsd a napi vízcélt';

  @override
  String get badge_support_title => 'Öntudatos';

  @override
  String get badge_support_desc => 'Használd a támogatási módot';

  @override
  String get badge_hours10_title => '10 óra';

  @override
  String get badge_hours10_desc => 'Rögzíts összesen 10 órát';

  @override
  String get badge_target10_title => 'Erős tízes';

  @override
  String get badge_target10_desc => 'Teljesíts 10 célt';

  @override
  String get badge_target20_title => 'Húsz cél';

  @override
  String get badge_target20_desc => 'Teljesíts 20 célt';

  @override
  String get badge_fast16_title => '16 óra';

  @override
  String get badge_fast16_desc => 'Érj el 16 órát egy böjt során';

  @override
  String get badge_hours50_title => '50 óra';

  @override
  String get badge_hours50_desc => 'Rögzíts összesen 50 órát';

  @override
  String get badge_hours100_title => 'Száz óra';

  @override
  String get badge_hours100_desc => 'Rögzíts összesen 100 órát';

  @override
  String get badge_target30_title => 'Harminc cél';

  @override
  String get badge_target30_desc => 'Teljesíts 30 célt';

  @override
  String get badge_rhythm30_title => '30 napos ritmus';

  @override
  String get badge_rhythm30_desc => 'Érj el 30 napos sorozatot';

  @override
  String get paywall_restoreSuccess => 'Vásárlások visszaállítva!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'A böjt $percent százaléka teljesítve';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour ó';
  }

  @override
  String get paywall_lifetime => 'Élethosszig';

  @override
  String get paywall_once => 'egyszeri';

  @override
  String get paywall_processing => 'Feldolgozás…';

  @override
  String get paywall_continue => 'Folytatás';

  @override
  String get paywall_productsUnavailable =>
      'A vásárlások jelenleg nem érhetők el. Próbáld újra később.';

  @override
  String get paywall_purchaseFailed => 'A vásárlást nem sikerült befejezni.';

  @override
  String get paywall_nothingToRestore => 'Nem található korábbi vásárlás.';

  @override
  String get paywall_restoreFailed =>
      'A vásárlásokat nem sikerült visszaállítani.';

  @override
  String get paywall_terms => 'Felhasználási feltételek';

  @override
  String get permission_notificationDesc =>
      'Böjtemlékeztetők, fázisfrissítések és befejezési értesítések';

  @override
  String get profile_privacyChoices => 'Adatvédelmi beállítások';

  @override
  String get paywall_autoRenewInfo =>
      'Az előfizetések automatikusan megújulnak, ha legalább 24 órával az időszak vége előtt nem mondod le őket. Az App Store beállításaiban bármikor kezelheted vagy lemondhatod őket.';

  @override
  String paywall_perMonth(String price) {
    return '$price / hónap';
  }

  @override
  String paywall_savePercent(int percent) {
    return '$percent% megtakarítás';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days napos ingyenes próbaidőszak';
  }

  @override
  String get paywall_startFreeTrial => 'Ingyenes próba indítása';

  @override
  String get paywall_retry => 'Újra';

  @override
  String get paywall_alreadyOwned =>
      'Már rendelkezel ezzel az előfizetéssel. Koppints a Vásárlások visszaállítása lehetőségre.';

  @override
  String get paywall_storeUnavailable =>
      'Az áruház most nem érhető el. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String get paywall_secureNote =>
      'Bármikor lemondható. A fizetést az áruházi fiókod terheljük.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Az előfizetések automatikusan megújulnak, ha legalább 24 órával az időszak vége előtt nem mondod le őket. Kezelés vagy lemondás: Google Play > Előfizetések.';

  @override
  String get paywall_allPlansDesc =>
      'Feloldja a 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat és Warrior programot';

  @override
  String get paywall_noAdsDesc =>
      'A szalag- és teljes képernyős reklámok teljesen kikapcsolnak';

  @override
  String get foodScan_title => 'MI-ételszkenner';

  @override
  String get foodScan_scanCta => 'Étkezés beolvasása';

  @override
  String get foodScan_scanCtaDesc =>
      'Fotózd le a tányérod, és megkapod a kalória- és makrotápanyag-becslést';

  @override
  String get foodScan_introTitle => 'Fotózd le a tányérod';

  @override
  String get foodScan_introDesc =>
      'Az MI elemzi a fényképet, és megbecsüli a kalóriát, fehérjét, szénhidrátot és zsírt.';

  @override
  String get foodScan_tipLight => 'A jó, egyenletes fény pontosabb becslést ad';

  @override
  String get foodScan_tipFrame => 'A teljes tányér férjen bele a képbe';

  @override
  String get foodScan_tipScale =>
      'Legyen a képen evőeszköz vagy kéz, hogy megbecsülhető legyen az adag';

  @override
  String get foodScan_takePhoto => 'Fénykép készítése';

  @override
  String get foodScan_chooseFromGallery => 'Kiválasztás a galériából';

  @override
  String foodScan_scansLeft(int count) {
    return 'Ma még $count beolvasás maradt';
  }

  @override
  String get foodScan_quotaReached =>
      'Elhasználtad a mai beolvasásokat. Próbáld újra holnap.';

  @override
  String get foodScan_privacyNote =>
      'A fényképet elemzésre elküldjük a Google Gemini API-jának, és nem tároljuk a szervereinken.';

  @override
  String get foodScan_consentTitle => 'Elküldöd a fotókat a Google Gemininek?';

  @override
  String get foodScan_consentBody =>
      'A kalória és a makrotápanyagok becsléséhez minden általad készített vagy kiválasztott ételfotót elküldünk a Google Gemini MI-szolgáltatásának. A fotót csak ehhez az elemzéshez használjuk, és nem tároljuk a szervereinken.';

  @override
  String get foodScan_consentAgree => 'Elfogadom és folytatom';

  @override
  String get foodScan_analyzing => 'Az étkezés elemzése…';

  @override
  String get foodScan_analyzingHint =>
      'Ez általában néhány másodpercet vesz igénybe';

  @override
  String get foodScan_detectedItems => 'Felismert tételek';

  @override
  String get foodScan_disclaimer =>
      'Az MI becslései hozzávetőlegesek. Koppints egy tételre a javításhoz.';

  @override
  String get foodScan_lowConfidence =>
      'A modell bizonytalan ezzel a képpel kapcsolatban. Mentés előtt ellenőrizd az értékeket.';

  @override
  String get foodScan_save => 'Hozzáadás az étkezésekhez';

  @override
  String get foodScan_retake => 'Új fénykép';

  @override
  String get foodScan_retry => 'Újra';

  @override
  String get foodScan_editItem => 'Tétel szerkesztése';

  @override
  String get foodScan_portion => 'Adag';

  @override
  String get foodScan_saveEdit => 'Mentés';

  @override
  String get foodScan_premiumTitle => 'Premium funkció';

  @override
  String get foodScan_premiumDesc =>
      'A fényképes kalóriaelemzés a Premium része.';

  @override
  String get foodScan_upgrade => 'Premium megtekintése';

  @override
  String get foodScan_errorNetwork =>
      'Nincs kapcsolat. Ellenőrizd az internetet, és próbáld újra.';

  @override
  String get foodScan_errorRateLimited =>
      'Most túl sok beolvasás történik. Próbáld újra néhány perc múlva.';

  @override
  String get foodScan_errorUnavailable =>
      'A képelemzés jelenleg nem érhető el.';

  @override
  String get foodScan_errorServer =>
      'Az elemzési szolgáltatás hibába ütközött. Próbáld újra hamarosan.';

  @override
  String get foodScan_errorNoFood =>
      'A fényképen nem található étel. Készíts tisztább képet a tányérról.';

  @override
  String get foodScan_errorUnreadable =>
      'A fényképet nem sikerült elemezni. Próbálj másikat.';

  @override
  String get paywall_aiFoodScan => 'MI-ételszkenner';

  @override
  String get paywall_aiFoodScanDesc =>
      'Fotózz le egy étkezést, és másodpercek alatt rögzítsd a kalóriákat és makrotápanyagokat';
}
