// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Dobré ráno';

  @override
  String get greeting_afternoon => 'Dobré popoludnie';

  @override
  String get greeting_evening => 'Dobrý večer';

  @override
  String get tab_timer => 'Domov';

  @override
  String get tab_explore => 'Objavovať';

  @override
  String get tab_stats => 'Prehľad';

  @override
  String get tab_meals => 'Jedlá';

  @override
  String get tab_achievements => 'Ocenenia';

  @override
  String get tab_profile => 'Účet';

  @override
  String get timer_fasting => 'Čas pôstu';

  @override
  String get timer_remaining => 'Zostáva';

  @override
  String get timer_elapsed => 'Uplynulo';

  @override
  String get timer_start => 'Spustiť';

  @override
  String get timer_stop => 'Ukončiť';

  @override
  String get timer_completed => 'Gratulujeme!';

  @override
  String get timer_completedMessage => 'Úspešne ste dokončili pôst!';

  @override
  String get timer_selectPlan => 'Vyberte plán pôstu';

  @override
  String get timer_stopConfirm => 'Naozaj chcete pôst ukončiť skôr?';

  @override
  String get timer_stopTitle => 'Ukončiť pôst';

  @override
  String get timer_cancel => 'Zrušiť';

  @override
  String get timer_confirmStop => 'Áno, ukončiť';

  @override
  String get phase_anabolic => 'Anabolická fáza';

  @override
  String get phase_anabolicDesc => 'Prebieha trávenie';

  @override
  String get phase_catabolic => 'Katabolická fáza';

  @override
  String get phase_catabolicDesc => 'Prechod zdroja energie';

  @override
  String get phase_fatBurning => 'Spaľovanie tukov';

  @override
  String get phase_fatBurningDesc => 'Spaľovanie tukov sa začalo';

  @override
  String get phase_ketosis => 'Ketóza';

  @override
  String get phase_ketosisDesc => 'Tvorba ketónov je aktívna';

  @override
  String get phase_autophagy => 'Autofágia';

  @override
  String get phase_autophagyDesc => 'Obnova buniek';

  @override
  String get stats_title => 'Štatistiky';

  @override
  String get stats_week => 'Týždeň';

  @override
  String get stats_month => 'Mesiac';

  @override
  String get stats_year => 'Rok';

  @override
  String get stats_totalFasts => 'Pôsty spolu';

  @override
  String get stats_average => 'Priemer';

  @override
  String get stats_fastDuration => 'dĺžka pôstu';

  @override
  String get stats_streak => 'Séria';

  @override
  String get stats_daysConsecutive => 'dní za sebou';

  @override
  String get stats_success => 'Úspešnosť';

  @override
  String get stats_completion => 'dokončenie';

  @override
  String get stats_weeklyFasting => 'Týždenný pôst';

  @override
  String get stats_monthlyView => 'Mesačný prehľad';

  @override
  String get stats_weightChange => 'Zmena hmotnosti';

  @override
  String get heatmap_none => 'Žiadna';

  @override
  String get heatmap_low => 'Nízka';

  @override
  String get heatmap_good => 'Dobrá';

  @override
  String get heatmap_full => 'Plná';

  @override
  String get meals_title => 'Plánovač jedál';

  @override
  String get meals_eatingWindow => 'Okno jedenia';

  @override
  String get meals_windowOpen => 'Otvorené';

  @override
  String get meals_windowFasting => 'Pôst';

  @override
  String get meals_calories => 'Kalórie';

  @override
  String get meals_protein => 'Bielkoviny';

  @override
  String get meals_carbs => 'Sacharidy';

  @override
  String get meals_fat => 'Tuky';

  @override
  String get meals_todayMeals => 'Dnešné jedlá';

  @override
  String get meals_noMeals => 'Zatiaľ nebolo pridané žiadne jedlo';

  @override
  String get meals_breakfastSuggestions => 'Tipy na prerušenie pôstu';

  @override
  String get meals_addMeal => 'Pridať jedlo';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Používateľ';

  @override
  String profile_planActive(String plan) {
    return 'Plán $plan je aktívny';
  }

  @override
  String get profile_upgradePremium => 'Prejsť na Premium';

  @override
  String get profile_premiumDesc => 'Všetky plány pôstu bez reklám';

  @override
  String get profile_bodyMetrics => 'Telesné údaje';

  @override
  String get profile_height => 'Výška';

  @override
  String get profile_weight => 'Hmotnosť';

  @override
  String get profile_targetWeight => 'Cieľová hmotnosť';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Nastavenia';

  @override
  String get profile_notifications => 'Upozornenia';

  @override
  String get profile_darkTheme => 'Tmavý motív';

  @override
  String get profile_waterReminder => 'Pripomienka pitia';

  @override
  String get profile_phaseNotifications => 'Upozornenia na fázy';

  @override
  String get profile_language => 'Jazyk';

  @override
  String get profile_about => 'O aplikácii';

  @override
  String get profile_rateApp => 'Ohodnotiť aplikáciu';

  @override
  String get profile_share => 'Zdieľať';

  @override
  String get profile_privacyPolicy => 'Zásady ochrany súkromia';

  @override
  String get profile_version => 'Verzia';

  @override
  String get onboarding_welcome => 'Vitajte';

  @override
  String get onboarding_welcomeDesc =>
      'Prevezmite kontrolu nad svojou cestou\ns prerušovaným pôstom';

  @override
  String get onboarding_featureTimer => 'Inteligentný časovač pôstu';

  @override
  String get onboarding_featureStats => 'Podrobné štatistiky a grafy';

  @override
  String get onboarding_featureMeals => 'Plánovač jedál a tipy na recepty';

  @override
  String get onboarding_getStarted => 'Začať';

  @override
  String get onboarding_selectGoal => 'Aký je váš cieľ?';

  @override
  String get onboarding_selectGoalDesc => 'Môžete vybrať viac možností';

  @override
  String get onboarding_goalWeight => 'Schudnúť';

  @override
  String get onboarding_goalWeightDesc => 'Zdravé chudnutie';

  @override
  String get onboarding_goalHealth => 'Zlepšiť zdravie';

  @override
  String get onboarding_goalHealthDesc => 'Celkové zdravie a imunita';

  @override
  String get onboarding_goalEnergy => 'Viac energie';

  @override
  String get onboarding_goalEnergyDesc => 'Energia počas celého dňa';

  @override
  String get onboarding_goalMental => 'Duševná jasnosť';

  @override
  String get onboarding_goalMentalDesc => 'Sústredenie a jasná myseľ';

  @override
  String get onboarding_goalLongevity => 'Dlhovekosť';

  @override
  String get onboarding_goalLongevityDesc => 'Obnova buniek a zdravé starnutie';

  @override
  String get onboarding_goalDiscipline => 'Disciplína';

  @override
  String get onboarding_goalDisciplineDesc => 'Rozvíjať sebadisciplínu';

  @override
  String get onboarding_selectPlan => 'Vyberte si plán';

  @override
  String get onboarding_selectPlanDesc =>
      'Vyberte si plán pôstu, ktorý vám najviac vyhovuje';

  @override
  String get onboarding_bodyInfo => 'Zadajte svoje údaje';

  @override
  String get onboarding_bodyInfoDesc => 'Pre osobné odporúčania';

  @override
  String get onboarding_gender => 'Pohlavie';

  @override
  String get onboarding_male => 'Muž';

  @override
  String get onboarding_female => 'Žena';

  @override
  String get onboarding_age => 'Vek';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Tieto údaje sa ukladajú iba vo vašom zariadení a používajú sa na výpočet kalórií.';

  @override
  String get onboarding_permissions => 'Posledný krok';

  @override
  String get onboarding_permissionsDesc =>
      'Pre najlepší zážitok povoľte oprávnenia';

  @override
  String get onboarding_next => 'Pokračovať';

  @override
  String get onboarding_start => 'Poďme na to!';

  @override
  String get onboarding_skipForNow => 'Nastaviť neskôr';

  @override
  String get waterAdded => 'Pridaných 250 ml vody';

  @override
  String get languageSelect => 'Vyberte jazyk';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Prejsť na Premium';

  @override
  String get paywall_subtitle =>
      'Odomknite všetky plány pôstu a odstráňte reklamy';

  @override
  String get paywall_allPlans => 'Všetky plány pôstu';

  @override
  String get paywall_advancedStats => 'Pokročilé štatistiky';

  @override
  String get paywall_mealPlanner => 'Plánovač jedál';

  @override
  String get paywall_themes => 'Prispôsobenie motívu';

  @override
  String get paywall_noAds => 'Bez reklám';

  @override
  String get paywall_weekly => 'Týždenne';

  @override
  String get paywall_monthly => 'Mesačne';

  @override
  String get paywall_yearly => 'Ročne';

  @override
  String get paywall_bestValue => 'Najvýhodnejšie';

  @override
  String get paywall_freeTrial => 'Bezplatná skúšobná verzia (3 dni)';

  @override
  String get paywall_restore => 'Obnoviť nákupy';

  @override
  String get paywall_premiumActive => 'Premium je aktívne!';

  @override
  String get paywall_premiumActiveDesc =>
      'Všetky plány pôstu sú odomknuté a reklamy vypnuté';

  @override
  String get water_title => 'Príjem vody';

  @override
  String get water_addWater => 'Pridať vodu';

  @override
  String get water_goal => 'Cieľ';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Zrušiť';

  @override
  String get common_save => 'Uložiť';

  @override
  String get common_delete => 'Odstrániť';

  @override
  String get common_hours => 'hodín';

  @override
  String get common_minutes => 'minút';

  @override
  String get common_days => 'dní';

  @override
  String get common_enable => 'Povoliť';

  @override
  String get streakCard_currentStreak => 'Aktuálna séria';

  @override
  String get streakCard_longestStreak => 'Najdlhšia séria';

  @override
  String get streakCard_totalSessions => 'Pôsty spolu';

  @override
  String get meals_mealType => 'Typ jedla';

  @override
  String get meals_breakfast => 'Raňajky';

  @override
  String get meals_lunch => 'Obed';

  @override
  String get meals_dinner => 'Večera';

  @override
  String get meals_snack => 'Desiata';

  @override
  String get meals_carbohydrate => 'Sacharidy';

  @override
  String get meals_add => 'Pridať';

  @override
  String get meals_mealName => 'Názov jedla';

  @override
  String get bodyMetrics_title => 'Telesné údaje';

  @override
  String get bodyMetrics_weight => 'Hmotnosť';

  @override
  String get bodyMetrics_target => 'Cieľ';

  @override
  String get bodyMetrics_save => 'Uložiť';

  @override
  String get bodyMetrics_history => 'História';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Zatiaľ žiadne údaje';

  @override
  String get meals_quickAdd => 'Rýchle pridanie';

  @override
  String get meals_manualEntry => 'Ručné zadanie';

  @override
  String meals_added(String name) {
    return 'Položka $name bola pridaná';
  }

  @override
  String get meals_nameCalorieRequired => 'Je potrebné zadať názov a kalórie';

  @override
  String get bodyMetrics_addWeight => 'Pridať hmotnosť';

  @override
  String get bodyMetrics_hintWeight => 'napr. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Zadajte platnú hmotnosť';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'Uložené: $value kg';
  }

  @override
  String get completion_duration => 'Trvanie';

  @override
  String get completion_plan => 'Plán';

  @override
  String get completion_lastPhase => 'Posledná fáza';

  @override
  String get completion_earlyTitle => 'Pôst ukončený';

  @override
  String get completion_earlyMessage =>
      'Dnešný čas bol uložený. Séria ani postup v úspechoch sa nezmenili, pretože cieľ nebol splnený.';

  @override
  String get timer_remainingTime => 'Zostávajúci čas';

  @override
  String get timer_ready => 'Pripravené na spustenie';

  @override
  String get streak_status => 'Stav';

  @override
  String get streak_startToday => 'Začnite dnes!';

  @override
  String get streak_goodStart => 'Dobrý začiatok!';

  @override
  String get streak_goingGreat => 'Ide vám to skvele!';

  @override
  String get streak_superb => 'Výborne!';

  @override
  String get streak_legendary => 'Legendárne!';

  @override
  String get streak_incredible => 'Neuveriteľné!';

  @override
  String get weight_noRecord =>
      'Zatiaľ žiadne záznamy hmotnosti\nPridajte ich v Profil > Telesné údaje';

  @override
  String get day_mon => 'Po';

  @override
  String get day_tue => 'Ut';

  @override
  String get day_wed => 'St';

  @override
  String get day_thu => 'Št';

  @override
  String get day_fri => 'Pi';

  @override
  String get day_sat => 'So';

  @override
  String get day_sun => 'Ne';

  @override
  String get day_short_mon => 'P';

  @override
  String get day_short_tue => 'U';

  @override
  String get day_short_wed => 'S';

  @override
  String get day_short_thu => 'Š';

  @override
  String get day_short_fri => 'P';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'N';

  @override
  String get month_jan => 'Január';

  @override
  String get month_feb => 'Február';

  @override
  String get month_mar => 'Marec';

  @override
  String get month_apr => 'Apríl';

  @override
  String get month_may => 'Máj';

  @override
  String get month_jun => 'Jún';

  @override
  String get month_jul => 'Júl';

  @override
  String get month_aug => 'August';

  @override
  String get month_sep => 'September';

  @override
  String get month_oct => 'Október';

  @override
  String get month_nov => 'November';

  @override
  String get month_dec => 'December';

  @override
  String meals_fastingWindow(String hours) {
    return 'Pôst ($hours h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Jedenie ($hours h)';
  }

  @override
  String get recipe_oatSmoothie => 'Ovsené smoothie';

  @override
  String get recipe_avocadoToast => 'Avokádový toast';

  @override
  String get recipe_yogurtBowl => 'Jogurtová miska';

  @override
  String get elapsed_time => 'Uplynulý čas';

  @override
  String get fast_ends_on => 'Váš pôst sa končí o';

  @override
  String get end_fasting => 'Ukončiť pôst';

  @override
  String get start_fasting => 'Začať pôst';

  @override
  String get water_tracker => 'Sledovanie vody';

  @override
  String get weight_tracker => 'Sledovanie hmotnosti';

  @override
  String get drink => 'Napiť sa';

  @override
  String get log_weight => 'Zaznamenať hmotnosť';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Úbytok hmotnosti';

  @override
  String get current_weight => 'Aktuálna hmotnosť';

  @override
  String get goal_weight => 'Cieľová hmotnosť';

  @override
  String get daily_goal => 'Denný cieľ';

  @override
  String completed_percent(String percent) {
    return 'Dokončené na $percent%';
  }

  @override
  String get explore => 'Objavovať';

  @override
  String get achievements => 'Úspechy';

  @override
  String get profile_theme => 'Vzhľad';

  @override
  String get theme_select => 'Vyberte vzhľad';

  @override
  String get theme_system => 'Podľa systému';

  @override
  String get theme_light => 'Svetlý';

  @override
  String get theme_dark => 'Tmavý';

  @override
  String get language_system => 'Jazyk systému';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Zvuk dokončenia';

  @override
  String get profile_calmGamification => 'Pokojné herné prvky';

  @override
  String get profile_calmGamificationDesc => 'Znižuje tlak ligy a sezóny';

  @override
  String get profile_editName => 'Upraviť meno';

  @override
  String get profile_name => 'Meno';

  @override
  String get circle_title => 'Pôstny kruh';

  @override
  String get circle_you => 'Vy';

  @override
  String get circle_tagline => 'Spolu, bez tlaku.';

  @override
  String get circle_privacy =>
      'Hmotnosť a súkromné údaje zostávajú skryté. Viditeľný je iba pokrok a podpora.';

  @override
  String circle_sendSupport(int count) {
    return 'Poslať podporu · $count';
  }

  @override
  String get circle_inviteCopied => 'Kód pozvánky skopírovaný';

  @override
  String get circle_createInvite => 'Vytvoriť súkromnú pozvánku';

  @override
  String get crisis_nameTitle => 'Najprv pomenujte, čo sa deje';

  @override
  String get crisis_nameDesc => 'Môže ísť o hlad, zvyk alebo emóciu.';

  @override
  String get crisis_waterTitle => 'Vypite pohár vody';

  @override
  String get crisis_waterDesc => 'Potom sa trikrát pomaly nadýchnite.';

  @override
  String get crisis_delayTitle => 'Odložte rozhodnutie o 10 minút';

  @override
  String get crisis_delayDesc =>
      'Ak sa necítite dobre, ukončenie pôstu nie je zlyhanie.';

  @override
  String get crisis_hunger => 'Hlad';

  @override
  String get crisis_habit => 'Zvyk';

  @override
  String get crisis_stress => 'Stres';

  @override
  String get crisis_tenMore => 'Dajte tomu 10 minút';

  @override
  String get stats_storyEmpty =>
      'Vaším prvým pôstom sa začne váš osobný príbeh.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'V tomto období ste sa postili $sessions-krát, udržali rytmus $hours hodín a dosiahli $rate% mieru dokončenia.';
  }

  @override
  String get stats_storyTitle => 'Príbeh vášho rytmu';

  @override
  String get home_todayRhythm => 'Dnešný rytmus';

  @override
  String get home_finalHourSupport => 'Podpora v poslednej hodine';

  @override
  String get home_needSupport => 'Potrebujem trochu podpory';

  @override
  String get home_todaySummary => 'Dnešok v skratke';

  @override
  String get home_dayStreak => 'dní za sebou';

  @override
  String home_weightGoal(String weight) {
    return 'cieľ $weight kg';
  }

  @override
  String get weather_steady => 'Váš rytmus je stabilný';

  @override
  String get weather_gentle => 'Pokojný deň';

  @override
  String get weather_water => 'Pohár vody môže pomôcť.';

  @override
  String get weather_listen => 'Prešli ste dlhú cestu; počúvajte svoje telo.';

  @override
  String get weather_onPlan => 'Dnešné tempo zodpovedá vášmu plánu.';

  @override
  String get weather_challenging =>
      'Táto hodina bola predtým náročná; režim podpory je pripravený.';

  @override
  String get replay_copied => 'Rekapitulácia pôstu skopírovaná';

  @override
  String get replay_button => 'Rekapitulácia';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Dokončil(a) som pôst $plan za $hours h $minutes min · $phase';
  }

  @override
  String get journey_label => 'Metabolická cesta';

  @override
  String get journey_now => 'Teraz';

  @override
  String journey_next(String time, String phase) {
    return 'Do fázy $phase zostáva $time';
  }

  @override
  String get phase_estimateShort =>
      'Načasovanie fáz je všeobecný odhad, nie lekárske meranie.';

  @override
  String phase_hours(int start, int end) {
    return 'Hodiny $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Toto načasovanie je všeobecný odhad. Metabolické reakcie sa môžu medzi ľuďmi líšiť.';

  @override
  String get bmi_underweight => 'Podváha';

  @override
  String get bmi_normal => 'Normálna hmotnosť';

  @override
  String get bmi_overweight => 'Nadváha';

  @override
  String get bmi_obese => 'Obezita';

  @override
  String get notification_halfwayTitle => 'Ste v polovici! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Dokončili ste polovicu pôstu $plan. Pokračujte!';
  }

  @override
  String get notification_phaseCatabolic => 'Vstup do katabolickej fázy 📉';

  @override
  String get notification_phaseFatBurning => 'Spaľovanie tukov sa začalo! 🔥';

  @override
  String get notification_phaseKetosis => 'Ste v ketóze ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofágia je aktívna! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Dokončili ste pôst $plan! Vaše okno jedenia je otvorené.';
  }

  @override
  String get notification_waterTitle => 'Napite sa vody 💧';

  @override
  String get notification_waterBody =>
      'Počas pôstu nezabúdajte piť dostatok vody!';

  @override
  String get notification_windowTitle => 'Okno jedenia sa zatvára ⏰';

  @override
  String get notification_windowBody =>
      'Vaše okno jedenia sa zatvorí o 30 minút.';

  @override
  String notification_streakTitle(int days) {
    return '$days dní za sebou! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Ide vám to skvele! Pokračujte aj dnes.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Prebieha pôst – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Zostáva: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Pôst sa začal – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Cieľ: $hours hodín';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get explore_guide => 'Sprievodca pôstom';

  @override
  String get explore_guideDesc =>
      'Všetko, čo potrebujete vedieť o prerušovanom pôste';

  @override
  String get explore_circleDesc =>
      'Zdieľajte tichú podporu so svojou súkromnou skupinou.';

  @override
  String get explore_faq => 'Časté otázky';

  @override
  String get explore_education =>
      'Tento obsah slúži iba na všeobecné vzdelávanie a nepredstavuje lekársku diagnózu ani radu o liečbe.';

  @override
  String get explore_safety => 'Zdravie a bezpečnosť';

  @override
  String get explore_safetyDesc =>
      'Ak máte zdravotné ťažkosti, pravidelne užívate lieky, máte znepokojujúce príznaky, ste tehotná alebo dojčíte, poraďte sa pred pôstom s kvalifikovaným zdravotníkom. Ak sa necítite dobre, pôst ukončite.';

  @override
  String get explore_sources => 'Zdroje';

  @override
  String get explore_sourcesDesc =>
      'Obsah je zjednodušený z nižšie uvedených verejných zdravotníckych zdrojov.';

  @override
  String get explore_sourceError => 'Zdroj sa nepodarilo otvoriť';

  @override
  String get explore_rules => 'Dôležité pravidlá';

  @override
  String get explore_rule1 => 'Počas pôstu nekonzumujte kalorické potraviny';

  @override
  String get explore_rule2 => 'Pite dostatok vody a tekutín';

  @override
  String get explore_rule3 => 'Počas okna jedenia jedzte vyvážene';

  @override
  String get explore_rule4 => 'Ak sa necítite dobre, pôst ukončite';

  @override
  String get explore_rule5 => 'Tehotné alebo dojčiace ženy by sa nemali postiť';

  @override
  String get explore_rule6 =>
      'Ak máte chronické ochorenie, poraďte sa s lekárom';

  @override
  String get tip_water => 'Dopĺňajte tekutiny';

  @override
  String get tip_waterDesc =>
      'Keď ste smädní, pite vodu a prijímajte tekutiny aj s jedlom. Potreba sa môže líšiť podľa zdravia, počasia a aktivity.';

  @override
  String get tip_food => 'Jedzte správne';

  @override
  String get tip_foodDesc =>
      'Počas okien jedenia si vyberajte potraviny bohaté na bielkoviny a vlákninu a zdravé tuky. Vyhýbajte sa spracovaným potravinám.';

  @override
  String get tip_sleep => 'Dobre spite';

  @override
  String get tip_sleepDesc =>
      'Pravidelný a dostatočný spánok podporuje celkovú pohodu. Naplánujte pôst tak, aby nenarúšal váš spánok.';

  @override
  String get tip_exercise => 'Ľahký pohyb';

  @override
  String get tip_exerciseDesc =>
      'Počas pôstu môžete ľahko kráčať alebo cvičiť jogu. Vyhnite sa náročnému cvičeniu, najmä v prvých týždňoch, kým si telo zvykne.';

  @override
  String get tip_drinks => 'Povolené nápoje';

  @override
  String get tip_drinksDesc =>
      'Počas pôstu môžete piť vodu, čistý čaj a čiernu kávu bez cukru a mlieka. Tieto nápoje pôst neprerušia.';

  @override
  String get faq_drinks => 'Čo môžem počas pôstu piť?';

  @override
  String get faq_drinksAnswer =>
      'Môžete piť vodu, čistý čaj a čiernu kávu bez cukru a mlieka. Kalorické nápoje pôst prerušujú.';

  @override
  String get faq_plan => 'Ktorý plán pôstu si mám vybrať?';

  @override
  String get faq_planAnswer =>
      'Ak začínate, zvoľte 12:12 alebo 14:10. Ak máte skúsenosti, skúste 16:8 alebo 18:6. Plány 20:4 a OMAD sú pre pokročilých.';

  @override
  String get faq_exercise => 'Môžem počas pôstu cvičiť?';

  @override
  String get faq_exerciseAnswer =>
      'Áno, ale vyhnite sa intenzívnym tréningom. Ideálne sú ľahké kardio, chôdza a joga. Silový tréning naplánujte blízko okna jedenia.';

  @override
  String get faq_weight => 'Pomáha pôst pri chudnutí?';

  @override
  String get faq_weightAnswer =>
      'U niektorých ľudí môže obmedzenie času jedenia znížiť celkový príjem energie. Výsledky sa líšia a dlhodobé účinky sa stále skúmajú.';

  @override
  String get plan_12_desc => 'Pre začiatočníkov';

  @override
  String get plan_12_detail =>
      'Ideálne pre začiatočníkov. Postite sa 12 hodín vrátane spánku.';

  @override
  String get plan_16_desc => 'Najobľúbenejší plán';

  @override
  String get plan_16_detail =>
      'Najbežnejší plán prerušovaného pôstu: 16 hodín pôstu a 8-hodinové okno jedenia, zvyčajne od obeda do večere.';

  @override
  String get plan_18_desc => 'Stredne pokročilí';

  @override
  String get plan_18_detail =>
      '18 hodín pôstu a 6-hodinové okno jedenia. Dlhšie spaľovanie tukov.';

  @override
  String get plan_20_desc => 'Pre pokročilých';

  @override
  String get plan_20_detail =>
      '20 hodín pôstu a 4-hodinové okno jedenia. Ideálne na dosiahnutie ketózy a autofágie.';

  @override
  String get plan_omad_desc => 'Jedno jedlo denne';

  @override
  String get plan_omad_detail =>
      'Jedno jedlo denne: 23 hodín pôstu a 1-hodinové okno jedenia. Pre expertov.';

  @override
  String get plan_52_desc => '2 dni v týždni';

  @override
  String get plan_52_detail =>
      'Päť dní jedzte normálne a dva dni obmedzte príjem približne na 500 kalórií. Alternatívny prístup.';

  @override
  String get plan_ese_desc => '24-hodinový pôst';

  @override
  String get plan_ese_detail =>
      'Držte 24-hodinový pôst 1–2-krát týždenne. Pre pokročilých.';

  @override
  String get plan_warrior_desc => 'Bojovnícka diéta';

  @override
  String get plan_warrior_detail =>
      'Cez deň jedzte ľahko a hlavné jedlo si dajte počas štvorhodinového večerného okna.';

  @override
  String get award_first_title => 'Prvý krok';

  @override
  String get award_first_desc => 'Dokončite svoj prvý pôst';

  @override
  String get award_rhythm3_title => 'Trojdňový rytmus';

  @override
  String get award_rhythm3_desc => 'Udržte rytmus tri dni';

  @override
  String get award_hours24_title => '24 hodín';

  @override
  String get award_hours24_desc => 'Postite sa spolu 24 hodín';

  @override
  String get award_week_title => 'Týždenný rytmus';

  @override
  String get award_week_desc => 'Vytvorte sedemdňovú sériu';

  @override
  String get award_fasts10_title => '10 pôstov';

  @override
  String get award_fasts10_desc => 'Dokončite desať pôstov';

  @override
  String get award_hours100_title => '100 hodín';

  @override
  String get award_hours100_desc => 'Dosiahnite spolu 100 hodín';

  @override
  String get award_rhythm30_title => '30-dňový rytmus';

  @override
  String get award_rhythm30_desc => 'Vytvorte tridsaťdňovú sériu';

  @override
  String get award_fasts50_title => '50 pôstov';

  @override
  String get award_fasts50_desc => 'Dokončite päťdesiat pôstov';

  @override
  String get award_hours500_title => '500 hodín';

  @override
  String get award_hours500_desc => 'Dosiahnite spolu 500 hodín';

  @override
  String get award_fasts100_title => '100 pôstov';

  @override
  String get award_fasts100_desc => 'Dokončite sto pôstov';

  @override
  String get award_rhythm90_title => '90-dňový rytmus';

  @override
  String get award_rhythm90_desc => 'Vytvorte deväťdesiatdňovú sériu';

  @override
  String get award_year_title => 'Ročná cesta';

  @override
  String get award_year_desc => 'Dosiahnite rytmus 365 dní';

  @override
  String get awards_loadError => 'Pokrok sa nepodarilo načítať';

  @override
  String get awards_journeyComplete => 'Cesta dokončená';

  @override
  String get awards_nextGoal => 'Ďalší cieľ';

  @override
  String get awards_allYours => 'Všetky úspechy sú vaše';

  @override
  String get awards_dayStreak => 'dní za sebou';

  @override
  String get awards_fasts => 'pôstov';

  @override
  String get awards_total => 'spolu';

  @override
  String get awards_stageStart => 'Začiatok';

  @override
  String get awards_stageRhythm => 'Rytmus';

  @override
  String get awards_stageEndurance => 'Vytrvalosť';

  @override
  String get awards_stageMastery => 'Majstrovstvo';

  @override
  String get awards_completed => 'Dokončené';

  @override
  String awards_fastsRemaining(int count) {
    return 'Zostáva $count pôstov';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Zostáva $count dní';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Zostáva $count hodín';
  }

  @override
  String get common_retry => 'Skúsiť znova';

  @override
  String get game_title => 'Centrum pokroku';

  @override
  String get game_quests => 'Dnešné úlohy';

  @override
  String get game_questsDesc => 'Malé kroky, udržateľný rytmus.';

  @override
  String get game_season => 'Sezóna s 30 krokmi';

  @override
  String get game_seasonDesc =>
      'Za každý piaty krok získate zberateľskú pečať.';

  @override
  String get game_badges => 'Zbierka odznakov';

  @override
  String game_shields(int count) {
    return '$count štítov rytmu';
  }

  @override
  String get game_shieldsDesc =>
      'Jeden získate za každých sedem dokončení. Vynechaný deň nikdy nevymaže váš pokrok.';

  @override
  String get game_league => 'Súkromná týždenná liga';

  @override
  String game_leagueDesc(int percent) {
    return 'Vaše skóre rytmu je na $percent. percentile súkromného lokálneho modelu. Hmotnosť ani extrémny pôst sa nikdy nehodnotia.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Úroveň $level, $xp skúsenostných bodov';
  }

  @override
  String get game_explorer => 'Prieskumník rytmu';

  @override
  String get game_streak => 'Séria';

  @override
  String get game_targets => 'Ciele';

  @override
  String get game_best => 'Najlepšie';

  @override
  String get quest_rhythm => 'Budujte dnešný rytmus';

  @override
  String get quest_hydrate => 'Dosiahnite polovicu cieľa príjmu vody';

  @override
  String get quest_steady => 'Chráňte svoju sériu';

  @override
  String get badge_first_title => 'Prvý krok';

  @override
  String get badge_first_desc => 'Zaznamenajte svoj prvý pôst';

  @override
  String get badge_rhythm7_title => 'Strážca rytmu';

  @override
  String get badge_rhythm7_desc => 'Dosiahnite sériu 7 dní';

  @override
  String get badge_rhythm3_title => 'Trojdňový rytmus';

  @override
  String get badge_rhythm3_desc => 'Dosiahnite sériu 3 dní';

  @override
  String get badge_target1_title => 'Prvý cieľ';

  @override
  String get badge_target1_desc => 'Dokončite svoj prvý cieľový pôst';

  @override
  String get badge_target3_title => 'Tri kroky';

  @override
  String get badge_target3_desc => 'Dokončite 3 ciele';

  @override
  String get badge_water_title => 'V rovnováhe';

  @override
  String get badge_water_desc => 'Splňte denný cieľ príjmu vody';

  @override
  String get badge_support_title => 'Sebavedomie';

  @override
  String get badge_support_desc => 'Použite režim podpory';

  @override
  String get badge_hours10_title => '10 hodín';

  @override
  String get badge_hours10_desc => 'Zaznamenajte spolu 10 hodín';

  @override
  String get badge_target10_title => 'Silná desiatka';

  @override
  String get badge_target10_desc => 'Dokončite 10 cieľov';

  @override
  String get badge_target20_title => 'Dvadsať cieľov';

  @override
  String get badge_target20_desc => 'Dokončite 20 cieľov';

  @override
  String get badge_fast16_title => '16 hodín';

  @override
  String get badge_fast16_desc => 'Dosiahnite 16 hodín v jednom pôste';

  @override
  String get badge_hours50_title => '50 hodín';

  @override
  String get badge_hours50_desc => 'Zaznamenajte spolu 50 hodín';

  @override
  String get badge_hours100_title => 'Sto hodín';

  @override
  String get badge_hours100_desc => 'Zaznamenajte spolu 100 hodín';

  @override
  String get badge_target30_title => 'Tridsať cieľov';

  @override
  String get badge_target30_desc => 'Dokončite 30 cieľov';

  @override
  String get badge_rhythm30_title => '30-dňový rytmus';

  @override
  String get badge_rhythm30_desc => 'Dosiahnite sériu 30 dní';

  @override
  String get paywall_restoreSuccess => 'Nákupy boli obnovené!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Priebeh pôstu: $percent percent';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour h';
  }

  @override
  String get paywall_lifetime => 'Doživotne';

  @override
  String get paywall_once => 'jednorazovo';

  @override
  String get paywall_processing => 'Spracúva sa…';

  @override
  String get paywall_continue => 'Pokračovať';

  @override
  String get paywall_productsUnavailable =>
      'Nákupy momentálne nie sú dostupné. Skúste to neskôr.';

  @override
  String get paywall_purchaseFailed => 'Nákup sa nepodarilo dokončiť.';

  @override
  String get paywall_nothingToRestore =>
      'Nenašiel sa žiadny predchádzajúci nákup.';

  @override
  String get paywall_restoreFailed => 'Nákupy sa nepodarilo obnoviť.';

  @override
  String get paywall_terms => 'Podmienky používania';

  @override
  String get permission_notificationDesc =>
      'Pripomienky pôstu, aktualizácie fáz a upozornenia na dokončenie';

  @override
  String get profile_privacyChoices => 'Nastavenia súkromia';

  @override
  String get paywall_autoRenewInfo =>
      'Predplatné sa automaticky obnoví, ak ho nezrušíte aspoň 24 hodín pred koncom obdobia. Kedykoľvek ho môžete spravovať alebo zrušiť v nastaveniach App Storu.';

  @override
  String paywall_perMonth(String price) {
    return '$price / mesiac';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Ušetríte $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Bezplatná skúšobná verzia na $days dní';
  }

  @override
  String get paywall_startFreeTrial => 'Spustiť bezplatnú skúšobnú verziu';

  @override
  String get paywall_retry => 'Skúsiť znova';

  @override
  String get paywall_alreadyOwned =>
      'Toto predplatné už vlastníte. Klepnite na Obnoviť nákupy.';

  @override
  String get paywall_storeUnavailable =>
      'Obchod momentálne nie je dostupný. Skontrolujte pripojenie a skúste to znova.';

  @override
  String get paywall_secureNote =>
      'Kedykoľvek zrušiteľné. Platba sa účtuje na váš účet v obchode.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Predplatné sa automaticky obnoví, ak ho nezrušíte aspoň 24 hodín pred koncom obdobia. Správa alebo zrušenie: Google Play > Predplatné.';

  @override
  String get paywall_allPlansDesc =>
      'Odomkne 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat a Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Bannerové reklamy aj reklamy na celú obrazovku sa úplne vypnú';

  @override
  String get foodScan_title => 'AI sken jedla';

  @override
  String get foodScan_scanCta => 'Naskenovať jedlo';

  @override
  String get foodScan_scanCtaDesc =>
      'Odfoťte tanier a získajte odhad kalórií a makroživín';

  @override
  String get foodScan_introTitle => 'Odfoťte svoj tanier';

  @override
  String get foodScan_introDesc =>
      'AI prečíta fotografiu a odhadne kalórie, bielkoviny, sacharidy a tuky.';

  @override
  String get foodScan_tipLight =>
      'Dobré a rovnomerné svetlo poskytne lepší odhad';

  @override
  String get foodScan_tipFrame => 'Umiestnite celý tanier do záberu';

  @override
  String get foodScan_tipScale =>
      'Pridajte do záberu príbor alebo ruku, aby sa dala odhadnúť veľkosť porcie';

  @override
  String get foodScan_takePhoto => 'Odfotiť';

  @override
  String get foodScan_chooseFromGallery => 'Vybrať z galérie';

  @override
  String foodScan_scansLeft(int count) {
    return 'Dnes zostáva $count skenov';
  }

  @override
  String get foodScan_quotaReached =>
      'Dnešné skeny ste vyčerpali. Skúste to znova zajtra.';

  @override
  String get foodScan_privacyNote =>
      'Fotografia sa odošle na analýzu do rozhrania Gemini API spoločnosti Google a neukladá sa na našich serveroch.';

  @override
  String get foodScan_consentTitle => 'Odoslať fotky do Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Na odhad kalórií a makroživín sa každá fotka jedla, ktorú odfotíte alebo vyberiete, odošle do služby umelej inteligencie Google Gemini. Fotka sa použije len na túto analýzu a na našich serveroch sa neukladá.';

  @override
  String get foodScan_consentAgree => 'Súhlasím a pokračovať';

  @override
  String get foodScan_analyzing => 'Analyzujeme vaše jedlo…';

  @override
  String get foodScan_analyzingHint => 'Zvyčajne to trvá niekoľko sekúnd';

  @override
  String get foodScan_detectedItems => 'Rozpoznané položky';

  @override
  String get foodScan_disclaimer =>
      'Odhady AI sú orientačné. Klepnutím na položku ju môžete opraviť.';

  @override
  String get foodScan_lowConfidence =>
      'Model si nie je touto fotografiou istý. Pred uložením skontrolujte hodnoty.';

  @override
  String get foodScan_save => 'Pridať k jedlám';

  @override
  String get foodScan_retake => 'Nová fotografia';

  @override
  String get foodScan_retry => 'Skúsiť znova';

  @override
  String get foodScan_editItem => 'Upraviť položku';

  @override
  String get foodScan_portion => 'Porcia';

  @override
  String get foodScan_saveEdit => 'Uložiť';

  @override
  String get foodScan_premiumTitle => 'Funkcia Premium';

  @override
  String get foodScan_premiumDesc =>
      'Analýza kalórií z fotografie je súčasťou Premium.';

  @override
  String get foodScan_upgrade => 'Zobraziť Premium';

  @override
  String get foodScan_errorNetwork =>
      'Bez pripojenia. Skontrolujte internet a skúste to znova.';

  @override
  String get foodScan_errorRateLimited =>
      'Práve prebieha príliš veľa skenov. Skúste to znova o pár minút.';

  @override
  String get foodScan_errorUnavailable =>
      'Analýza fotografií momentálne nie je dostupná.';

  @override
  String get foodScan_errorServer =>
      'Služba analýzy má problémy. Skúste to čoskoro znova.';

  @override
  String get foodScan_errorNoFood =>
      'Na tejto fotografii sa nenašlo žiadne jedlo. Skúste jasnejší záber taniera.';

  @override
  String get foodScan_errorUnreadable =>
      'Túto fotografiu sa nepodarilo analyzovať. Skúste inú.';

  @override
  String get paywall_aiFoodScan => 'AI sken jedla';

  @override
  String get paywall_aiFoodScanDesc =>
      'Odfoťte jedlo a za pár sekúnd zaznamenajte kalórie a makroživiny';
}
