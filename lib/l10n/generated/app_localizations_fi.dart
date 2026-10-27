// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Hyvää huomenta';

  @override
  String get greeting_afternoon => 'Hyvää iltapäivää';

  @override
  String get greeting_evening => 'Hyvää iltaa';

  @override
  String get tab_timer => 'Koti';

  @override
  String get tab_explore => 'Tutustu';

  @override
  String get tab_stats => 'Raportti';

  @override
  String get tab_meals => 'Ateriat';

  @override
  String get tab_achievements => 'Palkinnot';

  @override
  String get tab_profile => 'Tili';

  @override
  String get timer_fasting => 'Paastoaika';

  @override
  String get timer_remaining => 'Jäljellä';

  @override
  String get timer_elapsed => 'Kulunut';

  @override
  String get timer_start => 'Aloita';

  @override
  String get timer_stop => 'Lopeta';

  @override
  String get timer_completed => 'Onneksi olkoon!';

  @override
  String get timer_completedMessage => 'Suoritit paastosi onnistuneesti!';

  @override
  String get timer_selectPlan => 'Valitse paasto-ohjelma';

  @override
  String get timer_stopConfirm =>
      'Haluatko varmasti lopettaa paaston etuajassa?';

  @override
  String get timer_stopTitle => 'Lopeta paasto';

  @override
  String get timer_cancel => 'Peruuta';

  @override
  String get timer_confirmStop => 'Kyllä, lopeta';

  @override
  String get phase_anabolic => 'Anabolinen';

  @override
  String get phase_anabolicDesc => 'Ruoansulatus käynnissä';

  @override
  String get phase_catabolic => 'Katabolinen';

  @override
  String get phase_catabolicDesc => 'Energialähde vaihtuu';

  @override
  String get phase_fatBurning => 'Rasvanpoltto';

  @override
  String get phase_fatBurningDesc => 'Rasvanpoltto on alkanut';

  @override
  String get phase_ketosis => 'Ketoosi';

  @override
  String get phase_ketosisDesc => 'Ketonien tuotanto on aktiivista';

  @override
  String get phase_autophagy => 'Autofagia';

  @override
  String get phase_autophagyDesc => 'Solujen uusiutuminen';

  @override
  String get stats_title => 'Tilastot';

  @override
  String get stats_week => 'Viikko';

  @override
  String get stats_month => 'Kuukausi';

  @override
  String get stats_year => 'Vuosi';

  @override
  String get stats_totalFasts => 'Paastoja yhteensä';

  @override
  String get stats_average => 'Keskiarvo';

  @override
  String get stats_fastDuration => 'paaston kesto';

  @override
  String get stats_streak => 'Putki';

  @override
  String get stats_daysConsecutive => 'peräkkäistä päivää';

  @override
  String get stats_success => 'Onnistuminen';

  @override
  String get stats_completion => 'suoritettu';

  @override
  String get stats_weeklyFasting => 'Viikoittainen paasto';

  @override
  String get stats_monthlyView => 'Kuukausinäkymä';

  @override
  String get stats_weightChange => 'Painonmuutos';

  @override
  String get heatmap_none => 'Ei lainkaan';

  @override
  String get heatmap_low => 'Vähän';

  @override
  String get heatmap_good => 'Hyvä';

  @override
  String get heatmap_full => 'Täysi';

  @override
  String get meals_title => 'Ateriasuunnittelija';

  @override
  String get meals_eatingWindow => 'Syömisikkuna';

  @override
  String get meals_windowOpen => 'Avoinna';

  @override
  String get meals_windowFasting => 'Paasto';

  @override
  String get meals_calories => 'Kalorit';

  @override
  String get meals_protein => 'Proteiini';

  @override
  String get meals_carbs => 'Hiilihydraatit';

  @override
  String get meals_fat => 'Rasva';

  @override
  String get meals_todayMeals => 'Tämän päivän ateriat';

  @override
  String get meals_noMeals => 'Aterioita ei ole vielä lisätty';

  @override
  String get meals_breakfastSuggestions => 'Ehdotuksia paaston rikkomiseen';

  @override
  String get meals_addMeal => 'Lisää ateria';

  @override
  String get profile_title => 'Profiili';

  @override
  String get profile_user => 'Käyttäjä';

  @override
  String profile_planActive(String plan) {
    return 'Ohjelma $plan on aktiivinen';
  }

  @override
  String get profile_upgradePremium => 'Päivitä Premiumiin';

  @override
  String get profile_premiumDesc => 'Kaikki paasto-ohjelmat ilman mainoksia';

  @override
  String get profile_bodyMetrics => 'Kehon mitat';

  @override
  String get profile_height => 'Pituus';

  @override
  String get profile_weight => 'Paino';

  @override
  String get profile_targetWeight => 'Tavoitepaino';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Asetukset';

  @override
  String get profile_notifications => 'Ilmoitukset';

  @override
  String get profile_darkTheme => 'Tumma teema';

  @override
  String get profile_waterReminder => 'Vesimuistutus';

  @override
  String get profile_phaseNotifications => 'Vaiheilmoitukset';

  @override
  String get profile_language => 'Kieli';

  @override
  String get profile_about => 'Tietoja';

  @override
  String get profile_rateApp => 'Arvostele sovellus';

  @override
  String get profile_share => 'Jaa';

  @override
  String get profile_privacyPolicy => 'Tietosuojakäytäntö';

  @override
  String get profile_version => 'Versio';

  @override
  String get onboarding_welcome => 'Tervetuloa';

  @override
  String get onboarding_welcomeDesc =>
      'Ota ajoittaisen paaston matkasi\nhaltuun';

  @override
  String get onboarding_featureTimer => 'Älykäs paastoajastin';

  @override
  String get onboarding_featureStats => 'Yksityiskohtaiset tilastot ja kaaviot';

  @override
  String get onboarding_featureMeals =>
      'Ateriasuunnittelija ja reseptiehdotukset';

  @override
  String get onboarding_getStarted => 'Aloita';

  @override
  String get onboarding_selectGoal => 'Mikä on tavoitteesi?';

  @override
  String get onboarding_selectGoalDesc => 'Voit valita useita';

  @override
  String get onboarding_goalWeight => 'Pudota painoa';

  @override
  String get onboarding_goalWeightDesc => 'Terveellinen painonpudotus';

  @override
  String get onboarding_goalHealth => 'Paranna terveyttä';

  @override
  String get onboarding_goalHealthDesc => 'Yleinen terveys ja vastustuskyky';

  @override
  String get onboarding_goalEnergy => 'Lisää energiaa';

  @override
  String get onboarding_goalEnergyDesc => 'Energiaa koko päiväksi';

  @override
  String get onboarding_goalMental => 'Mielen selkeys';

  @override
  String get onboarding_goalMentalDesc => 'Keskittyminen ja selkeys';

  @override
  String get onboarding_goalLongevity => 'Pitkäikäisyys';

  @override
  String get onboarding_goalLongevityDesc =>
      'Solujen uusiutuminen ja terve ikääntyminen';

  @override
  String get onboarding_goalDiscipline => 'Itsekuri';

  @override
  String get onboarding_goalDisciplineDesc => 'Kehitä itsekuria';

  @override
  String get onboarding_selectPlan => 'Valitse ohjelmasi';

  @override
  String get onboarding_selectPlanDesc =>
      'Valitse sinulle parhaiten sopiva paasto-ohjelma';

  @override
  String get onboarding_bodyInfo => 'Anna tietosi';

  @override
  String get onboarding_bodyInfoDesc => 'Henkilökohtaisia suosituksia varten';

  @override
  String get onboarding_gender => 'Sukupuoli';

  @override
  String get onboarding_male => 'Mies';

  @override
  String get onboarding_female => 'Nainen';

  @override
  String get onboarding_age => 'Ikä';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Nämä tiedot tallennetaan vain laitteellesi ja niitä käytetään kalorilaskelmiin.';

  @override
  String get onboarding_permissions => 'Viimeinen vaihe';

  @override
  String get onboarding_permissionsDesc =>
      'Ota käyttöoikeudet käyttöön parasta kokemusta varten';

  @override
  String get onboarding_next => 'Jatka';

  @override
  String get onboarding_start => 'Aloitetaan!';

  @override
  String get onboarding_skipForNow => 'Määritä myöhemmin';

  @override
  String get waterAdded => '250 ml vettä lisätty';

  @override
  String get languageSelect => 'Valitse kieli';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Päivitä Premiumiin';

  @override
  String get paywall_subtitle =>
      'Avaa kaikki paasto-ohjelmat ja poista mainokset';

  @override
  String get paywall_allPlans => 'Kaikki paasto-ohjelmat';

  @override
  String get paywall_advancedStats => 'Edistyneet tilastot';

  @override
  String get paywall_mealPlanner => 'Ateriasuunnittelija';

  @override
  String get paywall_themes => 'Teeman mukautus';

  @override
  String get paywall_noAds => 'Ei mainoksia';

  @override
  String get paywall_weekly => 'Viikoittain';

  @override
  String get paywall_monthly => 'Kuukausittain';

  @override
  String get paywall_yearly => 'Vuosittain';

  @override
  String get paywall_bestValue => 'Paras vastine';

  @override
  String get paywall_freeTrial => 'Maksuton kokeilu (3 päivää)';

  @override
  String get paywall_restore => 'Palauta ostokset';

  @override
  String get paywall_premiumActive => 'Premium on aktiivinen!';

  @override
  String get paywall_premiumActiveDesc =>
      'Kaikki paasto-ohjelmat on avattu ja mainokset poistettu';

  @override
  String get water_title => 'Veden saanti';

  @override
  String get water_addWater => 'Lisää vettä';

  @override
  String get water_goal => 'Tavoite';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Peruuta';

  @override
  String get common_save => 'Tallenna';

  @override
  String get common_delete => 'Poista';

  @override
  String get common_hours => 'tuntia';

  @override
  String get common_minutes => 'minuuttia';

  @override
  String get common_days => 'päivää';

  @override
  String get common_enable => 'Ota käyttöön';

  @override
  String get streakCard_currentStreak => 'Nykyinen putki';

  @override
  String get streakCard_longestStreak => 'Pisin putki';

  @override
  String get streakCard_totalSessions => 'Paastoja yhteensä';

  @override
  String get meals_mealType => 'Ateriatyyppi';

  @override
  String get meals_breakfast => 'Aamiainen';

  @override
  String get meals_lunch => 'Lounas';

  @override
  String get meals_dinner => 'Päivällinen';

  @override
  String get meals_snack => 'Välipala';

  @override
  String get meals_carbohydrate => 'Hiilihydraatti';

  @override
  String get meals_add => 'Lisää';

  @override
  String get meals_mealName => 'Aterian nimi';

  @override
  String get bodyMetrics_title => 'Kehon mitat';

  @override
  String get bodyMetrics_weight => 'Paino';

  @override
  String get bodyMetrics_target => 'Tavoite';

  @override
  String get bodyMetrics_save => 'Tallenna';

  @override
  String get bodyMetrics_history => 'Historia';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Ei vielä tietoja';

  @override
  String get meals_quickAdd => 'Pikalisäys';

  @override
  String get meals_manualEntry => 'Manuaalinen syöttö';

  @override
  String meals_added(String name) {
    return '$name lisätty';
  }

  @override
  String get meals_nameCalorieRequired => 'Nimi ja kalorit ovat pakollisia';

  @override
  String get bodyMetrics_addWeight => 'Lisää paino';

  @override
  String get bodyMetrics_hintWeight => 'esim. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Anna kelvollinen paino';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg tallennettu';
  }

  @override
  String get completion_duration => 'Kesto';

  @override
  String get completion_plan => 'Ohjelma';

  @override
  String get completion_lastPhase => 'Viimeinen vaihe';

  @override
  String get completion_earlyTitle => 'Paasto päättyi';

  @override
  String get completion_earlyMessage =>
      'Tämän päivän aika tallennettiin. Putki ja saavutusten edistyminen eivät muuttuneet, koska tavoitetta ei saavutettu.';

  @override
  String get timer_remainingTime => 'Jäljellä oleva aika';

  @override
  String get timer_ready => 'Valmis aloittamaan';

  @override
  String get streak_status => 'Tila';

  @override
  String get streak_startToday => 'Aloita tänään!';

  @override
  String get streak_goodStart => 'Hyvä alku!';

  @override
  String get streak_goingGreat => 'Hienosti menee!';

  @override
  String get streak_superb => 'Loistavaa!';

  @override
  String get streak_legendary => 'Legendaarista!';

  @override
  String get streak_incredible => 'Uskomatonta!';

  @override
  String get weight_noRecord =>
      'Painomerkintöjä ei vielä ole\nLisää niitä kohdassa Profiili > Kehon mitat';

  @override
  String get day_mon => 'Ma';

  @override
  String get day_tue => 'Ti';

  @override
  String get day_wed => 'Ke';

  @override
  String get day_thu => 'To';

  @override
  String get day_fri => 'Pe';

  @override
  String get day_sat => 'La';

  @override
  String get day_sun => 'Su';

  @override
  String get day_short_mon => 'M';

  @override
  String get day_short_tue => 'T';

  @override
  String get day_short_wed => 'K';

  @override
  String get day_short_thu => 'T';

  @override
  String get day_short_fri => 'P';

  @override
  String get day_short_sat => 'L';

  @override
  String get day_short_sun => 'S';

  @override
  String get month_jan => 'Tammikuu';

  @override
  String get month_feb => 'Helmikuu';

  @override
  String get month_mar => 'Maaliskuu';

  @override
  String get month_apr => 'Huhtikuu';

  @override
  String get month_may => 'Toukokuu';

  @override
  String get month_jun => 'Kesäkuu';

  @override
  String get month_jul => 'Heinäkuu';

  @override
  String get month_aug => 'Elokuu';

  @override
  String get month_sep => 'Syyskuu';

  @override
  String get month_oct => 'Lokakuu';

  @override
  String get month_nov => 'Marraskuu';

  @override
  String get month_dec => 'Joulukuu';

  @override
  String meals_fastingWindow(String hours) {
    return 'Paasto ($hours t)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Syöminen ($hours t)';
  }

  @override
  String get recipe_oatSmoothie => 'Kaurasmoothie';

  @override
  String get recipe_avocadoToast => 'Avokadoleipä';

  @override
  String get recipe_yogurtBowl => 'Jogurttikulho';

  @override
  String get elapsed_time => 'Kulunut aika';

  @override
  String get fast_ends_on => 'Paastosi päättyy klo';

  @override
  String get end_fasting => 'Lopeta paasto';

  @override
  String get start_fasting => 'Aloita paasto';

  @override
  String get water_tracker => 'Vesiseuranta';

  @override
  String get weight_tracker => 'Painonseuranta';

  @override
  String get drink => 'Juo';

  @override
  String get log_weight => 'Kirjaa paino';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Pudotettu paino';

  @override
  String get current_weight => 'Nykyinen paino';

  @override
  String get goal_weight => 'Tavoitepaino';

  @override
  String get daily_goal => 'Päivätavoite';

  @override
  String completed_percent(String percent) {
    return '$percent% suoritettu';
  }

  @override
  String get explore => 'Tutustu';

  @override
  String get achievements => 'Saavutukset';

  @override
  String get profile_theme => 'Ulkoasu';

  @override
  String get theme_select => 'Valitse ulkoasu';

  @override
  String get theme_system => 'Järjestelmän oletus';

  @override
  String get theme_light => 'Vaalea';

  @override
  String get theme_dark => 'Tumma';

  @override
  String get language_system => 'Järjestelmän kieli';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Valmistumisääni';

  @override
  String get profile_calmGamification => 'Rauhallinen pelillistäminen';

  @override
  String get profile_calmGamificationDesc =>
      'Vähentää liigan ja kauden aiheuttamaa painetta';

  @override
  String get profile_editName => 'Muokkaa nimeäsi';

  @override
  String get profile_name => 'Nimi';

  @override
  String get circle_title => 'Paastopiiri';

  @override
  String get circle_you => 'Sinä';

  @override
  String get circle_tagline => 'Yhdessä, ilman paineita.';

  @override
  String get circle_privacy =>
      'Paino ja yksityiset mittarit pysyvät piilossa. Vain edistyminen ja tuki näkyvät.';

  @override
  String circle_sendSupport(int count) {
    return 'Lähetä tukea · $count';
  }

  @override
  String get circle_inviteCopied => 'Kutsukoodi kopioitu';

  @override
  String get circle_createInvite => 'Luo yksityinen kutsu';

  @override
  String get crisis_nameTitle => 'Nimeä ensin, mitä tapahtuu';

  @override
  String get crisis_nameDesc => 'Kyse voi olla nälästä, tavasta tai tunteesta.';

  @override
  String get crisis_waterTitle => 'Juo lasillinen vettä';

  @override
  String get crisis_waterDesc => 'Hengitä sitten kolmesti hitaasti.';

  @override
  String get crisis_delayTitle => 'Siirrä päätöstä 10 minuutilla';

  @override
  String get crisis_delayDesc =>
      'Jos voit huonosti, paaston lopettaminen ei ole epäonnistuminen.';

  @override
  String get crisis_hunger => 'Nälkä';

  @override
  String get crisis_habit => 'Tapa';

  @override
  String get crisis_stress => 'Stressi';

  @override
  String get crisis_tenMore => 'Anna sille 10 minuuttia';

  @override
  String get stats_storyEmpty =>
      'Ensimmäinen paastosi aloittaa henkilökohtaisen tarinasi.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Paastosit tällä ajanjaksolla $sessions kertaa, säilytit rytmisi $hours tunnin ajan ja saavutit $rate%:n suoritusasteen.';
  }

  @override
  String get stats_storyTitle => 'Rytmisi tarina';

  @override
  String get home_todayRhythm => 'Tämän päivän rytmi';

  @override
  String get home_finalHourSupport => 'Tukea viimeiselle tunnille';

  @override
  String get home_needSupport => 'Tarvitsen hieman tukea';

  @override
  String get home_todaySummary => 'Tämä päivä yhdellä silmäyksellä';

  @override
  String get home_dayStreak => 'päivän putki';

  @override
  String home_weightGoal(String weight) {
    return 'tavoite $weight kg';
  }

  @override
  String get weather_steady => 'Rytmisi on vakaa';

  @override
  String get weather_gentle => 'Rauhallinen päivä';

  @override
  String get weather_water => 'Lasillinen vettä voi auttaa.';

  @override
  String get weather_listen => 'Olet päässyt pitkälle; kuuntele kehoasi.';

  @override
  String get weather_onPlan => 'Tämän päivän tahti vastaa ohjelmaasi.';

  @override
  String get weather_challenging =>
      'Tämä tunti on ollut aiemmin haastava; tukitila on valmiina.';

  @override
  String get replay_copied => 'Paastokooste kopioitu';

  @override
  String get replay_button => 'Kooste';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Suoritin $plan-paastoni ajassa $hours t $minutes min · $phase';
  }

  @override
  String get journey_label => 'Aineenvaihdunnan matka';

  @override
  String get journey_now => 'Nyt';

  @override
  String journey_next(String time, String phase) {
    return '$time vaiheeseen $phase';
  }

  @override
  String get phase_estimateShort =>
      'Vaiheiden ajoitus on yleinen arvio, ei lääketieteellinen mittaus.';

  @override
  String phase_hours(int start, int end) {
    return 'Tunnit $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Tämä ajoitus on yleinen arvio. Aineenvaihdunnan reaktiot voivat vaihdella ihmisestä toiseen.';

  @override
  String get bmi_underweight => 'Alipaino';

  @override
  String get bmi_normal => 'Normaalipaino';

  @override
  String get bmi_overweight => 'Ylipaino';

  @override
  String get bmi_obese => 'Lihavuus';

  @override
  String get notification_halfwayTitle => 'Puolivälissä! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Olet suorittanut puolet $plan-paastostasi. Jatka samaan malliin!';
  }

  @override
  String get notification_phaseCatabolic => 'Katabolinen vaihe saavutettu 📉';

  @override
  String get notification_phaseFatBurning => 'Rasvanpoltto alkoi! 🔥';

  @override
  String get notification_phaseKetosis => 'Olet ketoosissa ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagia on aktiivinen! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Suoritit $plan-paastosi! Syömisikkunasi on avoinna.';
  }

  @override
  String get notification_waterTitle => 'Juo vettä 💧';

  @override
  String get notification_waterBody =>
      'Muista juoda runsaasti vettä paaston aikana!';

  @override
  String get notification_windowTitle => 'Syömisikkuna sulkeutuu ⏰';

  @override
  String get notification_windowBody =>
      'Syömisikkunasi sulkeutuu 30 minuutin kuluttua.';

  @override
  String notification_streakTitle(int days) {
    return '$days päivän putki! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Sinulla menee hienosti! Jatka tänään samaan tapaan.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Paasto käynnissä – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Jäljellä: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Paasto aloitettu – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Tavoite: $hours tuntia';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get explore_guide => 'Paasto-opas';

  @override
  String get explore_guideDesc =>
      'Kaikki, mitä sinun tarvitsee tietää ajoittaisesta paastosta';

  @override
  String get explore_circleDesc =>
      'Jaa rauhallista tukea yksityisen ryhmäsi kanssa.';

  @override
  String get explore_faq => 'Usein kysytyt kysymykset';

  @override
  String get explore_education =>
      'Tämä sisältö on tarkoitettu vain yleiseksi tiedoksi, eikä se ole lääketieteellinen diagnoosi tai hoito-ohje.';

  @override
  String get explore_safety => 'Terveys ja turvallisuus';

  @override
  String get explore_safetyDesc =>
      'Jos sinulla on sairaus, käytät säännöllisesti lääkkeitä, sinulla on huolestuttavia oireita, olet raskaana tai imetät, keskustele pätevän terveydenhuollon ammattilaisen kanssa ennen paastoa. Lopeta, jos voit huonosti.';

  @override
  String get explore_sources => 'Lähteet';

  @override
  String get explore_sourcesDesc =>
      'Sisältö on yksinkertaistettu alla mainituista julkisista terveyslähteistä.';

  @override
  String get explore_sourceError => 'Lähdettä ei voitu avata';

  @override
  String get explore_rules => 'Tärkeät säännöt';

  @override
  String get explore_rule1 => 'Älä nauti kaloripitoisia ruokia paaston aikana';

  @override
  String get explore_rule2 => 'Juo runsaasti vettä ja muita nesteitä';

  @override
  String get explore_rule3 => 'Syö tasapainoisesti syömisikkunan aikana';

  @override
  String get explore_rule4 => 'Lopeta paasto, jos voit huonosti';

  @override
  String get explore_rule5 =>
      'Raskaana olevien tai imettävien ei tule paastota';

  @override
  String get explore_rule6 =>
      'Keskustele lääkärin kanssa, jos sinulla on pitkäaikaissairaus';

  @override
  String get tip_water => 'Huolehdi nesteytyksestä';

  @override
  String get tip_waterDesc =>
      'Juo vettä, kun janottaa, ja nauti nesteitä aterioiden yhteydessä. Tarve voi vaihdella terveyden, sään ja aktiivisuuden mukaan.';

  @override
  String get tip_food => 'Syö hyvin';

  @override
  String get tip_foodDesc =>
      'Valitse syömisikkunoiden aikana proteiini- ja kuitupitoisia ruokia sekä pehmeitä rasvoja. Vältä pitkälle jalostettuja ruokia.';

  @override
  String get tip_sleep => 'Nuku hyvin';

  @override
  String get tip_sleepDesc =>
      'Säännöllinen ja riittävä uni tukee yleistä hyvinvointia. Ajoita paasto niin, ettei se häiritse untasi.';

  @override
  String get tip_exercise => 'Kevyt liikunta';

  @override
  String get tip_exerciseDesc =>
      'Voit kävellä kevyesti tai harrastaa joogaa paaston aikana. Vältä raskasta liikuntaa etenkin ensimmäisinä viikkoina, kun kehosi totuttelee.';

  @override
  String get tip_drinks => 'Sallitut juomat';

  @override
  String get tip_drinksDesc =>
      'Paaston aikana voit juoda vettä, maustamatonta teetä ja mustaa kahvia ilman sokeria tai maitoa. Nämä juomat eivät katkaise paastoa.';

  @override
  String get faq_drinks => 'Mitä voin juoda paaston aikana?';

  @override
  String get faq_drinksAnswer =>
      'Voit juoda vettä, maustamatonta teetä ja mustaa kahvia ilman sokeria tai maitoa. Kaloripitoiset juomat katkaisevat paaston.';

  @override
  String get faq_plan => 'Mikä paasto-ohjelma minun kannattaa valita?';

  @override
  String get faq_planAnswer =>
      'Jos olet aloittelija, aloita 12:12- tai 14:10-ohjelmalla. Jos sinulla on kokemusta, kokeile 16:8- tai 18:6-ohjelmaa. 20:4 ja OMAD sopivat edistyneille.';

  @override
  String get faq_exercise => 'Voinko liikkua paaston aikana?';

  @override
  String get faq_exerciseAnswer =>
      'Kyllä, mutta vältä raskaita harjoituksia. Kevyt aerobinen liikunta, kävely ja jooga ovat ihanteellisia. Ajoita voimaharjoittelu lähelle syömisikkunaasi.';

  @override
  String get faq_weight => 'Auttaako paasto painonpudotuksessa?';

  @override
  String get faq_weightAnswer =>
      'Joillakin ihmisillä syömisajan rajoittaminen voi vähentää energian kokonaissaantia. Tulokset vaihtelevat, ja pitkäaikaisvaikutuksia tutkitaan edelleen.';

  @override
  String get plan_12_desc => 'Aloittelijataso';

  @override
  String get plan_12_detail =>
      'Sopii aloittelijoille. Paastoa 12 tuntia, myös nukkumisaika mukaan lukien.';

  @override
  String get plan_16_desc => 'Suosituin ohjelma';

  @override
  String get plan_16_detail =>
      'Yleisin ajoittaisen paaston ohjelma: 16 tuntia paastoa ja 8 tunnin syömisikkuna, tavallisesti lounaasta päivälliseen.';

  @override
  String get plan_18_desc => 'Keskitaso';

  @override
  String get plan_18_detail =>
      '18 tuntia paastoa ja 6 tunnin syömisikkuna. Rasvanpoltto kestää pidempään.';

  @override
  String get plan_20_desc => 'Edistynyt taso';

  @override
  String get plan_20_detail =>
      '20 tuntia paastoa ja 4 tunnin syömisikkuna. Sopii ketoosin ja autofagian saavuttamiseen.';

  @override
  String get plan_omad_desc => 'Yksi ateria päivässä';

  @override
  String get plan_omad_detail =>
      'Yksi ateria päivässä: 23 tuntia paastoa ja 1 tunnin syömisikkuna. Asiantuntijataso.';

  @override
  String get plan_52_desc => '2 päivää viikossa';

  @override
  String get plan_52_detail =>
      'Syö normaalisti 5 päivänä ja rajoita energiansaanti noin 500 kaloriin 2 päivänä. Vaihtoehtoinen lähestymistapa.';

  @override
  String get plan_ese_desc => '24 tunnin paasto';

  @override
  String get plan_ese_detail =>
      'Paastoa 24 tuntia 1–2 kertaa viikossa. Edistyneille.';

  @override
  String get plan_warrior_desc => 'Soturidieetti';

  @override
  String get plan_warrior_detail =>
      'Syö päivällä kevyesti ja pääateria neljän tunnin iltaikkunan aikana.';

  @override
  String get award_first_title => 'Ensimmäinen askel';

  @override
  String get award_first_desc => 'Suorita ensimmäinen paastosi';

  @override
  String get award_rhythm3_title => 'Kolmen päivän rytmi';

  @override
  String get award_rhythm3_desc => 'Säilytä rytmisi kolmen päivän ajan';

  @override
  String get award_hours24_title => '24 tuntia';

  @override
  String get award_hours24_desc => 'Paastoa yhteensä 24 tuntia';

  @override
  String get award_week_title => 'Viikon rytmi';

  @override
  String get award_week_desc => 'Luo seitsemän päivän putki';

  @override
  String get award_fasts10_title => '10 paastoa';

  @override
  String get award_fasts10_desc => 'Suorita kymmenen paastoa';

  @override
  String get award_hours100_title => '100 tuntia';

  @override
  String get award_hours100_desc => 'Saavuta yhteensä 100 tuntia';

  @override
  String get award_rhythm30_title => '30 päivän rytmi';

  @override
  String get award_rhythm30_desc => 'Luo kolmenkymmenen päivän putki';

  @override
  String get award_fasts50_title => '50 paastoa';

  @override
  String get award_fasts50_desc => 'Suorita viisikymmentä paastoa';

  @override
  String get award_hours500_title => '500 tuntia';

  @override
  String get award_hours500_desc => 'Saavuta yhteensä 500 tuntia';

  @override
  String get award_fasts100_title => '100 paastoa';

  @override
  String get award_fasts100_desc => 'Suorita sata paastoa';

  @override
  String get award_rhythm90_title => '90 päivän rytmi';

  @override
  String get award_rhythm90_desc => 'Luo yhdeksänkymmenen päivän putki';

  @override
  String get award_year_title => 'Vuoden matka';

  @override
  String get award_year_desc => 'Saavuta 365 päivän rytmi';

  @override
  String get awards_loadError => 'Edistymistä ei voitu ladata';

  @override
  String get awards_journeyComplete => 'Matka suoritettu';

  @override
  String get awards_nextGoal => 'Seuraava tavoite';

  @override
  String get awards_allYours => 'Kaikki saavutukset ovat sinun';

  @override
  String get awards_dayStreak => 'päivän putki';

  @override
  String get awards_fasts => 'paastoa';

  @override
  String get awards_total => 'yhteensä';

  @override
  String get awards_stageStart => 'Aloitus';

  @override
  String get awards_stageRhythm => 'Rytmi';

  @override
  String get awards_stageEndurance => 'Kestävyys';

  @override
  String get awards_stageMastery => 'Mestaruus';

  @override
  String get awards_completed => 'Suoritettu';

  @override
  String awards_fastsRemaining(int count) {
    return '$count paastoa jäljellä';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count päivää jäljellä';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count tuntia jäljellä';
  }

  @override
  String get common_retry => 'Yritä uudelleen';

  @override
  String get game_title => 'Edistymiskeskus';

  @override
  String get game_quests => 'Tämän päivän tehtävät';

  @override
  String get game_questsDesc => 'Pieniä askelia, kestävä rytmi.';

  @override
  String get game_season => '30 askeleen kausi';

  @override
  String get game_seasonDesc => 'Keräilysinetti joka viidennestä askeleesta.';

  @override
  String get game_badges => 'Merkkikokoelma';

  @override
  String game_shields(int count) {
    return '$count rytmikilpeä';
  }

  @override
  String get game_shieldsDesc =>
      'Saat yhden joka seitsemännestä suorituksesta. Väliin jäänyt päivä ei koskaan pyyhi edistymistäsi.';

  @override
  String get game_league => 'Yksityinen viikkoliiga';

  @override
  String game_leagueDesc(int percent) {
    return 'Rytmipisteesi on yksityisen paikallisen mallin $percent. prosenttipisteessä. Painoa ja äärimmäistä paastoa ei koskaan aseteta paremmuusjärjestykseen.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Taso $level, $xp kokemuspistettä';
  }

  @override
  String get game_explorer => 'Rytmin tutkija';

  @override
  String get game_streak => 'Putki';

  @override
  String get game_targets => 'Tavoitteet';

  @override
  String get game_best => 'Paras';

  @override
  String get quest_rhythm => 'Rakenna tämän päivän rytmi';

  @override
  String get quest_hydrate => 'Saavuta puolet vesitavoitteestasi';

  @override
  String get quest_steady => 'Suojaa putkeasi';

  @override
  String get badge_first_title => 'Ensimmäinen askel';

  @override
  String get badge_first_desc => 'Kirjaa ensimmäinen paastosi';

  @override
  String get badge_rhythm7_title => 'Rytmin ylläpitäjä';

  @override
  String get badge_rhythm7_desc => 'Saavuta 7 päivän putki';

  @override
  String get badge_rhythm3_title => 'Kolmen päivän rytmi';

  @override
  String get badge_rhythm3_desc => 'Saavuta 3 päivän putki';

  @override
  String get badge_target1_title => 'Ensimmäinen tavoite';

  @override
  String get badge_target1_desc => 'Suorita ensimmäinen tavoitepaastosi';

  @override
  String get badge_target3_title => 'Kolme askelta';

  @override
  String get badge_target3_desc => 'Suorita 3 tavoitetta';

  @override
  String get badge_water_title => 'Tasapainossa';

  @override
  String get badge_water_desc => 'Saavuta päivän vesitavoite';

  @override
  String get badge_support_title => 'Itsetietoinen';

  @override
  String get badge_support_desc => 'Käytä tukitilaa';

  @override
  String get badge_hours10_title => '10 tuntia';

  @override
  String get badge_hours10_desc => 'Kirjaa yhteensä 10 tuntia';

  @override
  String get badge_target10_title => 'Vahva kymmenikkö';

  @override
  String get badge_target10_desc => 'Suorita 10 tavoitetta';

  @override
  String get badge_target20_title => 'Kaksikymmentä tavoitetta';

  @override
  String get badge_target20_desc => 'Suorita 20 tavoitetta';

  @override
  String get badge_fast16_title => '16 tuntia';

  @override
  String get badge_fast16_desc => 'Saavuta 16 tuntia yhdessä paastossa';

  @override
  String get badge_hours50_title => '50 tuntia';

  @override
  String get badge_hours50_desc => 'Kirjaa yhteensä 50 tuntia';

  @override
  String get badge_hours100_title => 'Sata tuntia';

  @override
  String get badge_hours100_desc => 'Kirjaa yhteensä 100 tuntia';

  @override
  String get badge_target30_title => 'Kolmekymmentä tavoitetta';

  @override
  String get badge_target30_desc => 'Suorita 30 tavoitetta';

  @override
  String get badge_rhythm30_title => '30 päivän rytmi';

  @override
  String get badge_rhythm30_desc => 'Saavuta 30 päivän putki';

  @override
  String get paywall_restoreSuccess => 'Ostokset palautettu!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Paasto on edennyt $percent prosenttia';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour t';
  }

  @override
  String get paywall_lifetime => 'Elinikäinen';

  @override
  String get paywall_once => 'kertamaksu';

  @override
  String get paywall_processing => 'Käsitellään…';

  @override
  String get paywall_continue => 'Jatka';

  @override
  String get paywall_productsUnavailable =>
      'Ostokset eivät ole juuri nyt saatavilla. Yritä myöhemmin uudelleen.';

  @override
  String get paywall_purchaseFailed => 'Ostosta ei voitu suorittaa.';

  @override
  String get paywall_nothingToRestore => 'Aiemmin tehtyä ostosta ei löytynyt.';

  @override
  String get paywall_restoreFailed => 'Ostoksia ei voitu palauttaa.';

  @override
  String get paywall_terms => 'Käyttöehdot';

  @override
  String get permission_notificationDesc =>
      'Paastomuistutukset, vaiheen päivitykset ja valmistumisilmoitukset';

  @override
  String get profile_privacyChoices => 'Tietosuojavalinnat';

  @override
  String get paywall_autoRenewInfo =>
      'Tilaukset uusiutuvat automaattisesti, ellei niitä peruta vähintään 24 tuntia ennen jakson päättymistä. Hallitse tai peruuta milloin tahansa App Storen asetuksissa.';

  @override
  String paywall_perMonth(String price) {
    return '$price / kuukausi';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Säästä $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days päivän maksuton kokeilu';
  }

  @override
  String get paywall_startFreeTrial => 'Aloita maksuton kokeilu';

  @override
  String get paywall_retry => 'Yritä uudelleen';

  @override
  String get paywall_alreadyOwned =>
      'Omistat jo tämän tilauksen. Napauta Palauta ostokset.';

  @override
  String get paywall_storeUnavailable =>
      'Kauppaan ei saada juuri nyt yhteyttä. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get paywall_secureNote =>
      'Peruuta milloin tahansa. Maksu veloitetaan kauppatililtäsi.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Tilaukset uusiutuvat automaattisesti, ellei niitä peruta vähintään 24 tuntia ennen jakson päättymistä. Hallitse tai peruuta kohdassa Google Play > Tilaukset.';

  @override
  String get paywall_allPlansDesc =>
      'Avaa ohjelmat 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat ja Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Banneri- ja koko näytön mainokset poistetaan kokonaan';

  @override
  String get foodScan_title => 'Tekoälyruokaskannaus';

  @override
  String get foodScan_scanCta => 'Skannaa ateria';

  @override
  String get foodScan_scanCtaDesc =>
      'Kuvaa lautasesi ja saat arvion kaloreista ja makroravinteista';

  @override
  String get foodScan_introTitle => 'Kuvaa lautasesi';

  @override
  String get foodScan_introDesc =>
      'Tekoäly lukee kuvan ja arvioi kalorit, proteiinin, hiilihydraatit ja rasvan.';

  @override
  String get foodScan_tipLight => 'Hyvä ja tasainen valaistus parantaa arviota';

  @override
  String get foodScan_tipFrame => 'Sovita koko lautanen kuvaan';

  @override
  String get foodScan_tipScale =>
      'Ota kuvaan aterimet tai käsi, jotta annoskoko voidaan arvioida';

  @override
  String get foodScan_takePhoto => 'Ota kuva';

  @override
  String get foodScan_chooseFromGallery => 'Valitse galleriasta';

  @override
  String foodScan_scansLeft(int count) {
    return '$count skannausta jäljellä tänään';
  }

  @override
  String get foodScan_quotaReached =>
      'Olet käyttänyt tämän päivän skannaukset. Yritä huomenna uudelleen.';

  @override
  String get foodScan_privacyNote =>
      'Kuva lähetetään analysoitavaksi Googlen Gemini APIin, eikä sitä tallenneta palvelimillemme.';

  @override
  String get foodScan_consentTitle => 'Lähetetäänkö kuvat Google Geminille?';

  @override
  String get foodScan_consentBody =>
      'Kalorien ja makroravinteiden arvioimiseksi jokainen ottamasi tai valitsemasi ateriakuva lähetetään Googlen Gemini-tekoälypalveluun. Kuvaa käytetään vain tähän analyysiin, eikä sitä tallenneta palvelimillemme.';

  @override
  String get foodScan_consentAgree => 'Hyväksy ja jatka';

  @override
  String get foodScan_analyzing => 'Ateriaasi analysoidaan…';

  @override
  String get foodScan_analyzingHint => 'Tämä kestää yleensä muutaman sekunnin';

  @override
  String get foodScan_detectedItems => 'Tunnistetut tuotteet';

  @override
  String get foodScan_disclaimer =>
      'Tekoälyn arviot ovat suuntaa antavia. Korjaa tuotetta napauttamalla sitä.';

  @override
  String get foodScan_lowConfidence =>
      'Malli ei ole varma tästä kuvasta. Tarkista luvut ennen tallentamista.';

  @override
  String get foodScan_save => 'Lisää aterioihin';

  @override
  String get foodScan_retake => 'Uusi kuva';

  @override
  String get foodScan_retry => 'Yritä uudelleen';

  @override
  String get foodScan_editItem => 'Muokkaa tuotetta';

  @override
  String get foodScan_portion => 'Annos';

  @override
  String get foodScan_saveEdit => 'Tallenna';

  @override
  String get foodScan_premiumTitle => 'Premium-ominaisuus';

  @override
  String get foodScan_premiumDesc =>
      'Kuvan kalorianalyysi sisältyy Premiumiin.';

  @override
  String get foodScan_upgrade => 'Tutustu Premiumiin';

  @override
  String get foodScan_errorNetwork =>
      'Ei yhteyttä. Tarkista internetyhteys ja yritä uudelleen.';

  @override
  String get foodScan_errorRateLimited =>
      'Skannauksia tehdään juuri nyt liikaa. Yritä uudelleen muutaman minuutin kuluttua.';

  @override
  String get foodScan_errorUnavailable =>
      'Kuva-analyysi ei ole juuri nyt käytettävissä.';

  @override
  String get foodScan_errorServer =>
      'Analyysipalvelussa on ongelmia. Yritä pian uudelleen.';

  @override
  String get foodScan_errorNoFood =>
      'Kuvasta ei löytynyt ruokaa. Ota selkeämpi kuva lautasesta.';

  @override
  String get foodScan_errorUnreadable =>
      'Tätä kuvaa ei voitu analysoida. Kokeile toista kuvaa.';

  @override
  String get paywall_aiFoodScan => 'Tekoälyruokaskannaus';

  @override
  String get paywall_aiFoodScanDesc =>
      'Kuvaa ateria ja kirjaa sen kalorit ja makroravinteet sekunneissa';
}
