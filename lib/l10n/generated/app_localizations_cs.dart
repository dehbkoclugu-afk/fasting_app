// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Dobré ráno';

  @override
  String get greeting_afternoon => 'Dobré odpoledne';

  @override
  String get greeting_evening => 'Dobrý večer';

  @override
  String get tab_timer => 'Domů';

  @override
  String get tab_explore => 'Objevovat';

  @override
  String get tab_stats => 'Přehled';

  @override
  String get tab_meals => 'Jídla';

  @override
  String get tab_achievements => 'Ocenění';

  @override
  String get tab_profile => 'Účet';

  @override
  String get timer_fasting => 'Doba půstu';

  @override
  String get timer_remaining => 'Zbývá';

  @override
  String get timer_elapsed => 'Uplynulo';

  @override
  String get timer_start => 'Spustit';

  @override
  String get timer_stop => 'Ukončit';

  @override
  String get timer_completed => 'Gratulujeme!';

  @override
  String get timer_completedMessage => 'Úspěšně jste dokončili půst!';

  @override
  String get timer_selectPlan => 'Vyberte plán půstu';

  @override
  String get timer_stopConfirm => 'Opravdu chcete půst ukončit dříve?';

  @override
  String get timer_stopTitle => 'Ukončit půst';

  @override
  String get timer_cancel => 'Zrušit';

  @override
  String get timer_confirmStop => 'Ano, ukončit';

  @override
  String get phase_anabolic => 'Anabolická fáze';

  @override
  String get phase_anabolicDesc => 'Probíhá trávení';

  @override
  String get phase_catabolic => 'Katabolická fáze';

  @override
  String get phase_catabolicDesc => 'Přechod zdroje energie';

  @override
  String get phase_fatBurning => 'Spalování tuků';

  @override
  String get phase_fatBurningDesc => 'Spalování tuků začalo';

  @override
  String get phase_ketosis => 'Ketóza';

  @override
  String get phase_ketosisDesc => 'Tvorba ketonů je aktivní';

  @override
  String get phase_autophagy => 'Autofagie';

  @override
  String get phase_autophagyDesc => 'Obnova buněk';

  @override
  String get stats_title => 'Statistiky';

  @override
  String get stats_week => 'Týden';

  @override
  String get stats_month => 'Měsíc';

  @override
  String get stats_year => 'Rok';

  @override
  String get stats_totalFasts => 'Celkem půstů';

  @override
  String get stats_average => 'Průměr';

  @override
  String get stats_fastDuration => 'délka půstu';

  @override
  String get stats_streak => 'Série';

  @override
  String get stats_daysConsecutive => 'dnů v řadě';

  @override
  String get stats_success => 'Úspěšnost';

  @override
  String get stats_completion => 'dokončeno';

  @override
  String get stats_weeklyFasting => 'Týdenní půst';

  @override
  String get stats_monthlyView => 'Měsíční přehled';

  @override
  String get stats_weightChange => 'Změna hmotnosti';

  @override
  String get heatmap_none => 'Žádná';

  @override
  String get heatmap_low => 'Nízká';

  @override
  String get heatmap_good => 'Dobrá';

  @override
  String get heatmap_full => 'Plná';

  @override
  String get meals_title => 'Plánovač jídel';

  @override
  String get meals_eatingWindow => 'Jídelní okno';

  @override
  String get meals_windowOpen => 'Otevřené';

  @override
  String get meals_windowFasting => 'Půst';

  @override
  String get meals_calories => 'Kalorie';

  @override
  String get meals_protein => 'Bílkoviny';

  @override
  String get meals_carbs => 'Sacharidy';

  @override
  String get meals_fat => 'Tuky';

  @override
  String get meals_todayMeals => 'Dnešní jídla';

  @override
  String get meals_noMeals => 'Zatím nebylo přidáno žádné jídlo';

  @override
  String get meals_breakfastSuggestions => 'Tipy na přerušení půstu';

  @override
  String get meals_addMeal => 'Přidat jídlo';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Uživatel';

  @override
  String profile_planActive(String plan) {
    return 'Plán $plan je aktivní';
  }

  @override
  String get profile_upgradePremium => 'Přejít na Premium';

  @override
  String get profile_premiumDesc => 'Všechny plány půstu bez reklam';

  @override
  String get profile_bodyMetrics => 'Tělesné údaje';

  @override
  String get profile_height => 'Výška';

  @override
  String get profile_weight => 'Hmotnost';

  @override
  String get profile_targetWeight => 'Cílová hmotnost';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Nastavení';

  @override
  String get profile_notifications => 'Oznámení';

  @override
  String get profile_darkTheme => 'Tmavý motiv';

  @override
  String get profile_waterReminder => 'Připomínka pití';

  @override
  String get profile_phaseNotifications => 'Oznámení o fázích';

  @override
  String get profile_language => 'Jazyk';

  @override
  String get profile_about => 'O aplikaci';

  @override
  String get profile_rateApp => 'Ohodnotit aplikaci';

  @override
  String get profile_share => 'Sdílet';

  @override
  String get profile_privacyPolicy => 'Zásady ochrany soukromí';

  @override
  String get profile_version => 'Verze';

  @override
  String get onboarding_welcome => 'Vítejte';

  @override
  String get onboarding_welcomeDesc =>
      'Převezměte kontrolu nad svou cestou\ns přerušovaným půstem';

  @override
  String get onboarding_featureTimer => 'Chytrý časovač půstu';

  @override
  String get onboarding_featureStats => 'Podrobné statistiky a grafy';

  @override
  String get onboarding_featureMeals => 'Plánovač jídel a tipy na recepty';

  @override
  String get onboarding_getStarted => 'Začít';

  @override
  String get onboarding_selectGoal => 'Jaký je váš cíl?';

  @override
  String get onboarding_selectGoalDesc => 'Můžete vybrat více možností';

  @override
  String get onboarding_goalWeight => 'Zhubnout';

  @override
  String get onboarding_goalWeightDesc => 'Zdravé hubnutí';

  @override
  String get onboarding_goalHealth => 'Zlepšit zdraví';

  @override
  String get onboarding_goalHealthDesc => 'Celkové zdraví a imunita';

  @override
  String get onboarding_goalEnergy => 'Více energie';

  @override
  String get onboarding_goalEnergyDesc => 'Energie po celý den';

  @override
  String get onboarding_goalMental => 'Duševní jasnost';

  @override
  String get onboarding_goalMentalDesc => 'Soustředění a jasná mysl';

  @override
  String get onboarding_goalLongevity => 'Dlouhověkost';

  @override
  String get onboarding_goalLongevityDesc => 'Obnova buněk a zdravé stárnutí';

  @override
  String get onboarding_goalDiscipline => 'Disciplína';

  @override
  String get onboarding_goalDisciplineDesc => 'Rozvíjet sebekázeň';

  @override
  String get onboarding_selectPlan => 'Vyberte si plán';

  @override
  String get onboarding_selectPlanDesc =>
      'Vyberte si plán půstu, který vám nejlépe vyhovuje';

  @override
  String get onboarding_bodyInfo => 'Zadejte své údaje';

  @override
  String get onboarding_bodyInfoDesc => 'Pro osobní doporučení';

  @override
  String get onboarding_gender => 'Pohlaví';

  @override
  String get onboarding_male => 'Muž';

  @override
  String get onboarding_female => 'Žena';

  @override
  String get onboarding_age => 'Věk';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Tyto informace se ukládají pouze ve vašem zařízení a používají se k výpočtu kalorií.';

  @override
  String get onboarding_permissions => 'Poslední krok';

  @override
  String get onboarding_permissionsDesc =>
      'Pro nejlepší zážitek povolte oprávnění';

  @override
  String get onboarding_next => 'Pokračovat';

  @override
  String get onboarding_start => 'Jdeme na to!';

  @override
  String get onboarding_skipForNow => 'Nastavit později';

  @override
  String get waterAdded => 'Přidáno 250 ml vody';

  @override
  String get languageSelect => 'Vyberte jazyk';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Přejít na Premium';

  @override
  String get paywall_subtitle =>
      'Odemkněte všechny plány půstu a odstraňte reklamy';

  @override
  String get paywall_allPlans => 'Všechny plány půstu';

  @override
  String get paywall_advancedStats => 'Pokročilé statistiky';

  @override
  String get paywall_mealPlanner => 'Plánovač jídel';

  @override
  String get paywall_themes => 'Přizpůsobení motivu';

  @override
  String get paywall_noAds => 'Bez reklam';

  @override
  String get paywall_weekly => 'Týdně';

  @override
  String get paywall_monthly => 'Měsíčně';

  @override
  String get paywall_yearly => 'Ročně';

  @override
  String get paywall_bestValue => 'Nejvýhodnější';

  @override
  String get paywall_freeTrial => 'Bezplatná zkušební verze (3 dny)';

  @override
  String get paywall_restore => 'Obnovit nákupy';

  @override
  String get paywall_premiumActive => 'Premium je aktivní!';

  @override
  String get paywall_premiumActiveDesc =>
      'Všechny plány půstu jsou odemčené a reklamy vypnuté';

  @override
  String get water_title => 'Příjem vody';

  @override
  String get water_addWater => 'Přidat vodu';

  @override
  String get water_goal => 'Cíl';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Zrušit';

  @override
  String get common_save => 'Uložit';

  @override
  String get common_delete => 'Smazat';

  @override
  String get common_hours => 'hodin';

  @override
  String get common_minutes => 'minut';

  @override
  String get common_days => 'dnů';

  @override
  String get common_enable => 'Povolit';

  @override
  String get streakCard_currentStreak => 'Aktuální série';

  @override
  String get streakCard_longestStreak => 'Nejdelší série';

  @override
  String get streakCard_totalSessions => 'Celkem půstů';

  @override
  String get meals_mealType => 'Typ jídla';

  @override
  String get meals_breakfast => 'Snídaně';

  @override
  String get meals_lunch => 'Oběd';

  @override
  String get meals_dinner => 'Večeře';

  @override
  String get meals_snack => 'Svačina';

  @override
  String get meals_carbohydrate => 'Sacharidy';

  @override
  String get meals_add => 'Přidat';

  @override
  String get meals_mealName => 'Název jídla';

  @override
  String get bodyMetrics_title => 'Tělesné údaje';

  @override
  String get bodyMetrics_weight => 'Hmotnost';

  @override
  String get bodyMetrics_target => 'Cíl';

  @override
  String get bodyMetrics_save => 'Uložit';

  @override
  String get bodyMetrics_history => 'Historie';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Zatím žádné údaje';

  @override
  String get meals_quickAdd => 'Rychlé přidání';

  @override
  String get meals_manualEntry => 'Ruční zadání';

  @override
  String meals_added(String name) {
    return 'Položka $name byla přidána';
  }

  @override
  String get meals_nameCalorieRequired => 'Je nutné zadat název a kalorie';

  @override
  String get bodyMetrics_addWeight => 'Přidat hmotnost';

  @override
  String get bodyMetrics_hintWeight => 'např. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Zadejte platnou hmotnost';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'Uloženo $value kg';
  }

  @override
  String get completion_duration => 'Doba trvání';

  @override
  String get completion_plan => 'Plán';

  @override
  String get completion_lastPhase => 'Poslední fáze';

  @override
  String get completion_earlyTitle => 'Půst ukončen';

  @override
  String get completion_earlyMessage =>
      'Dnešní doba byla uložena. Série ani postup v úspěších se nezměnily, protože cíl nebyl splněn.';

  @override
  String get timer_remainingTime => 'Zbývající čas';

  @override
  String get timer_ready => 'Připraveno ke spuštění';

  @override
  String get streak_status => 'Stav';

  @override
  String get streak_startToday => 'Začněte dnes!';

  @override
  String get streak_goodStart => 'Dobrý začátek!';

  @override
  String get streak_goingGreat => 'Jde vám to skvěle!';

  @override
  String get streak_superb => 'Výborně!';

  @override
  String get streak_legendary => 'Legendární!';

  @override
  String get streak_incredible => 'Neuvěřitelné!';

  @override
  String get weight_noRecord =>
      'Zatím žádné záznamy hmotnosti\nPřidejte je v Profil > Tělesné údaje';

  @override
  String get day_mon => 'Po';

  @override
  String get day_tue => 'Út';

  @override
  String get day_wed => 'St';

  @override
  String get day_thu => 'Čt';

  @override
  String get day_fri => 'Pá';

  @override
  String get day_sat => 'So';

  @override
  String get day_sun => 'Ne';

  @override
  String get day_short_mon => 'P';

  @override
  String get day_short_tue => 'Ú';

  @override
  String get day_short_wed => 'S';

  @override
  String get day_short_thu => 'Č';

  @override
  String get day_short_fri => 'P';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'N';

  @override
  String get month_jan => 'Leden';

  @override
  String get month_feb => 'Únor';

  @override
  String get month_mar => 'Březen';

  @override
  String get month_apr => 'Duben';

  @override
  String get month_may => 'Květen';

  @override
  String get month_jun => 'Červen';

  @override
  String get month_jul => 'Červenec';

  @override
  String get month_aug => 'Srpen';

  @override
  String get month_sep => 'Září';

  @override
  String get month_oct => 'Říjen';

  @override
  String get month_nov => 'Listopad';

  @override
  String get month_dec => 'Prosinec';

  @override
  String meals_fastingWindow(String hours) {
    return 'Půst ($hours h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Jídlo ($hours h)';
  }

  @override
  String get recipe_oatSmoothie => 'Ovesné smoothie';

  @override
  String get recipe_avocadoToast => 'Avokádový toast';

  @override
  String get recipe_yogurtBowl => 'Jogurtová miska';

  @override
  String get elapsed_time => 'Uplynulý čas';

  @override
  String get fast_ends_on => 'Váš půst končí v';

  @override
  String get end_fasting => 'Ukončit půst';

  @override
  String get start_fasting => 'Zahájit půst';

  @override
  String get water_tracker => 'Sledování vody';

  @override
  String get weight_tracker => 'Sledování hmotnosti';

  @override
  String get drink => 'Napít se';

  @override
  String get log_weight => 'Zapsat hmotnost';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Úbytek hmotnosti';

  @override
  String get current_weight => 'Aktuální hmotnost';

  @override
  String get goal_weight => 'Cílová hmotnost';

  @override
  String get daily_goal => 'Denní cíl';

  @override
  String completed_percent(String percent) {
    return 'Dokončeno $percent%';
  }

  @override
  String get explore => 'Objevovat';

  @override
  String get achievements => 'Úspěchy';

  @override
  String get profile_theme => 'Vzhled';

  @override
  String get theme_select => 'Vyberte vzhled';

  @override
  String get theme_system => 'Podle systému';

  @override
  String get theme_light => 'Světlý';

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
  String get profile_completionSound => 'Zvuk dokončení';

  @override
  String get profile_calmGamification => 'Klidná gamifikace';

  @override
  String get profile_calmGamificationDesc =>
      'Snižuje tlak spojený s ligou a sezónou';

  @override
  String get profile_editName => 'Upravit jméno';

  @override
  String get profile_name => 'Jméno';

  @override
  String get circle_title => 'Půstový kruh';

  @override
  String get circle_you => 'Vy';

  @override
  String get circle_tagline => 'Společně, bez tlaku.';

  @override
  String get circle_privacy =>
      'Hmotnost a soukromé údaje zůstávají skryté. Viditelný je pouze pokrok a podpora.';

  @override
  String circle_sendSupport(int count) {
    return 'Poslat podporu · $count';
  }

  @override
  String get circle_inviteCopied => 'Kód pozvánky zkopírován';

  @override
  String get circle_createInvite => 'Vytvořit soukromou pozvánku';

  @override
  String get crisis_nameTitle => 'Nejprve pojmenujte, co se děje';

  @override
  String get crisis_nameDesc => 'Může jít o hlad, zvyk nebo emoci.';

  @override
  String get crisis_waterTitle => 'Vypijte sklenici vody';

  @override
  String get crisis_waterDesc => 'Potom se třikrát pomalu nadechněte.';

  @override
  String get crisis_delayTitle => 'Odložte rozhodnutí o 10 minut';

  @override
  String get crisis_delayDesc =>
      'Pokud se necítíte dobře, ukončení půstu není selhání.';

  @override
  String get crisis_hunger => 'Hlad';

  @override
  String get crisis_habit => 'Zvyk';

  @override
  String get crisis_stress => 'Stres';

  @override
  String get crisis_tenMore => 'Dejte tomu 10 minut';

  @override
  String get stats_storyEmpty => 'Vaším prvním půstem začne váš osobní příběh.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'V tomto období jste se postili ${sessions}krát, udrželi rytmus po dobu $hours hodin a dosáhli $rate% úspěšnosti dokončení.';
  }

  @override
  String get stats_storyTitle => 'Příběh vašeho rytmu';

  @override
  String get home_todayRhythm => 'Dnešní rytmus';

  @override
  String get home_finalHourSupport => 'Podpora v poslední hodině';

  @override
  String get home_needSupport => 'Potřebuji trochu podpory';

  @override
  String get home_todaySummary => 'Dnešek v kostce';

  @override
  String get home_dayStreak => 'dnů v řadě';

  @override
  String home_weightGoal(String weight) {
    return 'cíl $weight kg';
  }

  @override
  String get weather_steady => 'Váš rytmus je stabilní';

  @override
  String get weather_gentle => 'Klidný den';

  @override
  String get weather_water => 'Sklenice vody může pomoci.';

  @override
  String get weather_listen =>
      'Ušli jste dlouhou cestu; naslouchejte svému tělu.';

  @override
  String get weather_onPlan => 'Dnešní tempo odpovídá vašemu plánu.';

  @override
  String get weather_challenging =>
      'Tato hodina pro vás dříve byla náročná; režim podpory je připraven.';

  @override
  String get replay_copied => 'Rekapitulace půstu zkopírována';

  @override
  String get replay_button => 'Rekapitulace';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Dokončil(a) jsem půst $plan za $hours h $minutes min · $phase';
  }

  @override
  String get journey_label => 'Metabolická cesta';

  @override
  String get journey_now => 'Nyní';

  @override
  String journey_next(String time, String phase) {
    return 'Do fáze $phase zbývá $time';
  }

  @override
  String get phase_estimateShort =>
      'Časování fází je obecný odhad, nikoli lékařské měření.';

  @override
  String phase_hours(int start, int end) {
    return 'Hodiny $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Toto časování je obecný odhad. Metabolické reakce se mohou u jednotlivých lidí lišit.';

  @override
  String get bmi_underweight => 'Podváha';

  @override
  String get bmi_normal => 'Normální hmotnost';

  @override
  String get bmi_overweight => 'Nadváha';

  @override
  String get bmi_obese => 'Obezita';

  @override
  String get notification_halfwayTitle => 'Jste v polovině! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Dokončili jste polovinu půstu $plan. Jen tak dál!';
  }

  @override
  String get notification_phaseCatabolic => 'Vstup do katabolické fáze 📉';

  @override
  String get notification_phaseFatBurning => 'Spalování tuků začalo! 🔥';

  @override
  String get notification_phaseKetosis => 'Jste v ketóze ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagie je aktivní! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Dokončili jste půst $plan! Vaše jídelní okno je otevřené.';
  }

  @override
  String get notification_waterTitle => 'Napijte se vody 💧';

  @override
  String get notification_waterBody =>
      'Během půstu nezapomínejte pít dostatek vody!';

  @override
  String get notification_windowTitle => 'Jídelní okno se zavírá ⏰';

  @override
  String get notification_windowBody =>
      'Vaše jídelní okno se zavře za 30 minut.';

  @override
  String notification_streakTitle(int days) {
    return '$days dnů v řadě! 🔥';
  }

  @override
  String get notification_streakBody => 'Vedete si skvěle! Pokračujte i dnes.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Probíhá půst – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Zbývá: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Půst zahájen – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Cíl: $hours hodin';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get explore_guide => 'Průvodce půstem';

  @override
  String get explore_guideDesc =>
      'Vše, co potřebujete vědět o přerušovaném půstu';

  @override
  String get explore_circleDesc =>
      'Sdílejte tichou podporu se svou soukromou skupinou.';

  @override
  String get explore_faq => 'Časté dotazy';

  @override
  String get explore_education =>
      'Tento obsah slouží pouze k obecnému vzdělávání a nepředstavuje lékařskou diagnózu ani doporučení léčby.';

  @override
  String get explore_safety => 'Zdraví a bezpečnost';

  @override
  String get explore_safetyDesc =>
      'Pokud máte zdravotní potíže, pravidelně užíváte léky, máte znepokojivé příznaky, jste těhotná nebo kojíte, poraďte se před půstem s kvalifikovaným zdravotníkem. Pokud se necítíte dobře, půst ukončete.';

  @override
  String get explore_sources => 'Zdroje';

  @override
  String get explore_sourcesDesc =>
      'Obsah je zjednodušen z níže uvedených veřejně dostupných zdravotnických zdrojů.';

  @override
  String get explore_sourceError => 'Zdroj se nepodařilo otevřít';

  @override
  String get explore_rules => 'Důležitá pravidla';

  @override
  String get explore_rule1 => 'Během půstu nekonzumujte kalorické potraviny';

  @override
  String get explore_rule2 => 'Pijte dostatek vody a tekutin';

  @override
  String get explore_rule3 => 'Během jídelního okna jezte vyváženě';

  @override
  String get explore_rule4 => 'Pokud se necítíte dobře, půst ukončete';

  @override
  String get explore_rule5 => 'Těhotné a kojící ženy by se neměly postit';

  @override
  String get explore_rule6 =>
      'Pokud máte chronické onemocnění, poraďte se s lékařem';

  @override
  String get tip_water => 'Doplňujte tekutiny';

  @override
  String get tip_waterDesc =>
      'Když máte žízeň, pijte vodu a přijímejte tekutiny také s jídlem. Potřeba se může lišit podle zdravotního stavu, počasí a aktivity.';

  @override
  String get tip_food => 'Jezte správně';

  @override
  String get tip_foodDesc =>
      'Během jídelních oken vybírejte potraviny bohaté na bílkoviny a vlákninu a zdravé tuky. Vyhýbejte se průmyslově zpracovaným potravinám.';

  @override
  String get tip_sleep => 'Dobře spěte';

  @override
  String get tip_sleepDesc =>
      'Pravidelný a dostatečný spánek podporuje celkovou pohodu. Naplánujte půst tak, aby nenarušoval váš spánek.';

  @override
  String get tip_exercise => 'Lehký pohyb';

  @override
  String get tip_exerciseDesc =>
      'Během půstu můžete lehce chodit nebo cvičit jógu. Vyhněte se náročnému cvičení, zejména v prvních týdnech, než se tělo přizpůsobí.';

  @override
  String get tip_drinks => 'Povolené nápoje';

  @override
  String get tip_drinksDesc =>
      'Během půstu můžete pít vodu, čistý čaj a černou kávu (bez cukru a mléka). Tyto nápoje půst nepřeruší.';

  @override
  String get faq_drinks => 'Co mohu během půstu pít?';

  @override
  String get faq_drinksAnswer =>
      'Můžete pít vodu, čistý čaj a černou kávu (bez cukru a mléka). Kalorické nápoje půst přerušují.';

  @override
  String get faq_plan => 'Který plán půstu si mám vybrat?';

  @override
  String get faq_planAnswer =>
      'Pokud začínáte, zvolte 12:12 nebo 14:10. Máte-li zkušenosti, zkuste 16:8 nebo 18:6. Plány 20:4 a OMAD jsou pro pokročilé.';

  @override
  String get faq_exercise => 'Mohu během půstu cvičit?';

  @override
  String get faq_exerciseAnswer =>
      'Ano, ale vyhněte se intenzivnímu tréninku. Ideální je lehké kardio, chůze a jóga. Silový trénink naplánujte blízko jídelního okna.';

  @override
  String get faq_weight => 'Pomáhá půst při hubnutí?';

  @override
  String get faq_weightAnswer =>
      'U některých lidí může omezení doby jídla snížit celkový příjem energie. Výsledky se liší a dlouhodobé účinky se stále zkoumají.';

  @override
  String get plan_12_desc => 'Pro začátečníky';

  @override
  String get plan_12_detail =>
      'Ideální pro začátečníky. Postěte se 12 hodin včetně doby spánku.';

  @override
  String get plan_16_desc => 'Nejoblíbenější plán';

  @override
  String get plan_16_detail =>
      'Nejběžnější plán přerušovaného půstu: 16 hodin půstu a 8hodinové jídelní okno, obvykle od oběda do večeře.';

  @override
  String get plan_18_desc => 'Středně pokročilí';

  @override
  String get plan_18_detail =>
      '18 hodin půstu a 6hodinové jídelní okno. Delší doba spalování tuků.';

  @override
  String get plan_20_desc => 'Pro pokročilé';

  @override
  String get plan_20_detail =>
      '20 hodin půstu a 4hodinové jídelní okno. Ideální pro dosažení ketózy a autofagie.';

  @override
  String get plan_omad_desc => 'Jedno jídlo denně';

  @override
  String get plan_omad_detail =>
      'Jedno jídlo denně: 23 hodin půstu a 1hodinové jídelní okno. Pro experty.';

  @override
  String get plan_52_desc => '2 dny v týdnu';

  @override
  String get plan_52_detail =>
      'Pět dní jezte normálně a dva dny omezte příjem přibližně na 500 kalorií. Alternativní přístup.';

  @override
  String get plan_ese_desc => '24hodinový půst';

  @override
  String get plan_ese_detail =>
      'Držte 24hodinový půst 1–2krát týdně. Pro pokročilé.';

  @override
  String get plan_warrior_desc => 'Válečnická dieta';

  @override
  String get plan_warrior_detail =>
      'Přes den jezte lehce (ovoce a zeleninu) a hlavní jídlo si dejte během čtyřhodinového večerního okna.';

  @override
  String get award_first_title => 'První krok';

  @override
  String get award_first_desc => 'Dokončete svůj první půst';

  @override
  String get award_rhythm3_title => 'Třídenní rytmus';

  @override
  String get award_rhythm3_desc => 'Udržte rytmus po tři dny';

  @override
  String get award_hours24_title => '24 hodin';

  @override
  String get award_hours24_desc => 'Postěte se celkem 24 hodin';

  @override
  String get award_week_title => 'Týdenní rytmus';

  @override
  String get award_week_desc => 'Vytvořte sedmidenní sérii';

  @override
  String get award_fasts10_title => '10 půstů';

  @override
  String get award_fasts10_desc => 'Dokončete deset půstů';

  @override
  String get award_hours100_title => '100 hodin';

  @override
  String get award_hours100_desc => 'Dosáhněte celkem 100 hodin';

  @override
  String get award_rhythm30_title => '30denní rytmus';

  @override
  String get award_rhythm30_desc => 'Vytvořte třicetidenní sérii';

  @override
  String get award_fasts50_title => '50 půstů';

  @override
  String get award_fasts50_desc => 'Dokončete padesát půstů';

  @override
  String get award_hours500_title => '500 hodin';

  @override
  String get award_hours500_desc => 'Dosáhněte celkem 500 hodin';

  @override
  String get award_fasts100_title => '100 půstů';

  @override
  String get award_fasts100_desc => 'Dokončete sto půstů';

  @override
  String get award_rhythm90_title => '90denní rytmus';

  @override
  String get award_rhythm90_desc => 'Vytvořte devadesátidenní sérii';

  @override
  String get award_year_title => 'Roční cesta';

  @override
  String get award_year_desc => 'Dosáhněte rytmu 365 dnů';

  @override
  String get awards_loadError => 'Pokrok se nepodařilo načíst';

  @override
  String get awards_journeyComplete => 'Cesta dokončena';

  @override
  String get awards_nextGoal => 'Další cíl';

  @override
  String get awards_allYours => 'Všechny úspěchy jsou vaše';

  @override
  String get awards_dayStreak => 'dnů v řadě';

  @override
  String get awards_fasts => 'půstů';

  @override
  String get awards_total => 'celkem';

  @override
  String get awards_stageStart => 'Začátek';

  @override
  String get awards_stageRhythm => 'Rytmus';

  @override
  String get awards_stageEndurance => 'Vytrvalost';

  @override
  String get awards_stageMastery => 'Mistrovství';

  @override
  String get awards_completed => 'Dokončeno';

  @override
  String awards_fastsRemaining(int count) {
    return 'Zbývá $count půstů';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Zbývá $count dnů';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Zbývá $count hodin';
  }

  @override
  String get common_retry => 'Zkusit znovu';

  @override
  String get game_title => 'Centrum pokroku';

  @override
  String get game_quests => 'Dnešní úkoly';

  @override
  String get game_questsDesc => 'Malé kroky, udržitelný rytmus.';

  @override
  String get game_season => 'Sezóna o 30 krocích';

  @override
  String get game_seasonDesc =>
      'Za každý pátý krok získáte sběratelskou pečeť.';

  @override
  String get game_badges => 'Sbírka odznaků';

  @override
  String game_shields(int count) {
    return '$count štítů rytmu';
  }

  @override
  String get game_shieldsDesc =>
      'Jeden získáte za každých sedm dokončení. Vynechaný den nikdy nesmaže váš pokrok.';

  @override
  String get game_league => 'Soukromá týdenní liga';

  @override
  String game_leagueDesc(int percent) {
    return 'Vaše skóre rytmu je na $percent. percentilu soukromého místního modelu. Hmotnost ani extrémní půst se nikdy nehodnotí.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Úroveň $level, $xp zkušenostních bodů';
  }

  @override
  String get game_explorer => 'Průzkumník rytmu';

  @override
  String get game_streak => 'Série';

  @override
  String get game_targets => 'Cíle';

  @override
  String get game_best => 'Nejlepší';

  @override
  String get quest_rhythm => 'Budujte dnešní rytmus';

  @override
  String get quest_hydrate => 'Dosáhněte poloviny cíle příjmu vody';

  @override
  String get quest_steady => 'Chraňte svou sérii';

  @override
  String get badge_first_title => 'První krok';

  @override
  String get badge_first_desc => 'Zaznamenejte svůj první půst';

  @override
  String get badge_rhythm7_title => 'Strážce rytmu';

  @override
  String get badge_rhythm7_desc => 'Dosáhněte série 7 dnů';

  @override
  String get badge_rhythm3_title => 'Třídenní rytmus';

  @override
  String get badge_rhythm3_desc => 'Dosáhněte série 3 dnů';

  @override
  String get badge_target1_title => 'První cíl';

  @override
  String get badge_target1_desc => 'Dokončete svůj první cílový půst';

  @override
  String get badge_target3_title => 'Tři kroky';

  @override
  String get badge_target3_desc => 'Dokončete 3 cíle';

  @override
  String get badge_water_title => 'V rovnováze';

  @override
  String get badge_water_desc => 'Splňte denní cíl příjmu vody';

  @override
  String get badge_support_title => 'Sebevědomí';

  @override
  String get badge_support_desc => 'Použijte režim podpory';

  @override
  String get badge_hours10_title => '10 hodin';

  @override
  String get badge_hours10_desc => 'Zaznamenejte celkem 10 hodin';

  @override
  String get badge_target10_title => 'Silná desítka';

  @override
  String get badge_target10_desc => 'Dokončete 10 cílů';

  @override
  String get badge_target20_title => 'Dvacet cílů';

  @override
  String get badge_target20_desc => 'Dokončete 20 cílů';

  @override
  String get badge_fast16_title => '16 hodin';

  @override
  String get badge_fast16_desc => 'Dosáhněte 16 hodin během jednoho půstu';

  @override
  String get badge_hours50_title => '50 hodin';

  @override
  String get badge_hours50_desc => 'Zaznamenejte celkem 50 hodin';

  @override
  String get badge_hours100_title => 'Sto hodin';

  @override
  String get badge_hours100_desc => 'Zaznamenejte celkem 100 hodin';

  @override
  String get badge_target30_title => 'Třicet cílů';

  @override
  String get badge_target30_desc => 'Dokončete 30 cílů';

  @override
  String get badge_rhythm30_title => '30denní rytmus';

  @override
  String get badge_rhythm30_desc => 'Dosáhněte série 30 dnů';

  @override
  String get paywall_restoreSuccess => 'Nákupy byly obnoveny!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Průběh půstu: $percent procent';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour h';
  }

  @override
  String get paywall_lifetime => 'Doživotně';

  @override
  String get paywall_once => 'jednorázově';

  @override
  String get paywall_processing => 'Zpracovává se…';

  @override
  String get paywall_continue => 'Pokračovat';

  @override
  String get paywall_productsUnavailable =>
      'Nákupy nyní nejsou dostupné. Zkuste to prosím později.';

  @override
  String get paywall_purchaseFailed => 'Nákup se nepodařilo dokončit.';

  @override
  String get paywall_nothingToRestore => 'Nebyl nalezen žádný předchozí nákup.';

  @override
  String get paywall_restoreFailed => 'Nákupy se nepodařilo obnovit.';

  @override
  String get paywall_terms => 'Podmínky použití';

  @override
  String get permission_notificationDesc =>
      'Připomínky půstu, aktualizace fází a oznámení o dokončení';

  @override
  String get profile_privacyChoices => 'Nastavení soukromí';

  @override
  String get paywall_autoRenewInfo =>
      'Předplatné se automaticky obnoví, pokud je nezrušíte alespoň 24 hodin před koncem období. Kdykoli je můžete spravovat nebo zrušit v nastavení App Storu.';

  @override
  String paywall_perMonth(String price) {
    return '$price / měsíc';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Ušetříte $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Bezplatná zkušební verze na $days dnů';
  }

  @override
  String get paywall_startFreeTrial => 'Spustit bezplatnou zkušební verzi';

  @override
  String get paywall_retry => 'Zkusit znovu';

  @override
  String get paywall_alreadyOwned =>
      'Toto předplatné už vlastníte. Klepněte na „Obnovit nákupy“.';

  @override
  String get paywall_storeUnavailable =>
      'Obchod nyní není dostupný. Zkontrolujte připojení a zkuste to znovu.';

  @override
  String get paywall_secureNote =>
      'Předplatné můžete kdykoli zrušit. Platba bude účtována na váš účet v obchodě.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Předplatné se automaticky obnoví, pokud je nezrušíte alespoň 24 hodin před koncem období. Kdykoli je můžete spravovat nebo zrušit v Google Play > Předplatná.';

  @override
  String get paywall_allPlansDesc =>
      'Odemkne 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat a Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Bannerové reklamy i reklamy přes celou obrazovku se zcela vypnou';

  @override
  String get foodScan_title => 'AI sken jídla';

  @override
  String get foodScan_scanCta => 'Naskenovat jídlo';

  @override
  String get foodScan_scanCtaDesc =>
      'Vyfoťte talíř a zjistěte odhad kalorií a makroživin';

  @override
  String get foodScan_introTitle => 'Vyfoťte svůj talíř';

  @override
  String get foodScan_introDesc =>
      'AI snímek přečte a odhadne kalorie, bílkoviny, sacharidy a tuky.';

  @override
  String get foodScan_tipLight => 'Dobré a rovnoměrné osvětlení zpřesní odhad';

  @override
  String get foodScan_tipFrame => 'Do záběru umístěte celý talíř';

  @override
  String get foodScan_tipScale =>
      'Přidejte do záběru příbor nebo ruku, aby bylo možné odhadnout velikost porce';

  @override
  String get foodScan_takePhoto => 'Pořídit fotografii';

  @override
  String get foodScan_chooseFromGallery => 'Vybrat z galerie';

  @override
  String foodScan_scansLeft(int count) {
    return 'Dnes zbývá $count skenů';
  }

  @override
  String get foodScan_quotaReached =>
      'Dnešní skeny jste vyčerpali. Zkuste to znovu zítra.';

  @override
  String get foodScan_privacyNote =>
      'Fotografie se odešle k analýze do rozhraní Gemini API společnosti Google a na našich serverech se neukládá.';

  @override
  String get foodScan_consentTitle => 'Odeslat fotky do Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Pro odhad kalorií a makroživin se každá fotka jídla, kterou pořídíte nebo vyberete, odešle do služby umělé inteligence Google Gemini. Fotka se použije jen pro tuto analýzu a na našich serverech se neukládá.';

  @override
  String get foodScan_consentAgree => 'Souhlasím a pokračovat';

  @override
  String get foodScan_analyzing => 'Analyzujeme vaše jídlo…';

  @override
  String get foodScan_analyzingHint => 'Obvykle to trvá několik sekund';

  @override
  String get foodScan_detectedItems => 'Rozpoznané položky';

  @override
  String get foodScan_disclaimer =>
      'Odhady AI jsou pouze orientační. Klepnutím na položku ji můžete opravit.';

  @override
  String get foodScan_lowConfidence =>
      'Model si tímto snímkem není jistý. Před uložením údaje zkontrolujte.';

  @override
  String get foodScan_save => 'Přidat k jídlům';

  @override
  String get foodScan_retake => 'Nová fotografie';

  @override
  String get foodScan_retry => 'Zkusit znovu';

  @override
  String get foodScan_editItem => 'Upravit položku';

  @override
  String get foodScan_portion => 'Porce';

  @override
  String get foodScan_saveEdit => 'Uložit';

  @override
  String get foodScan_premiumTitle => 'Funkce Premium';

  @override
  String get foodScan_premiumDesc =>
      'Analýza kalorií z fotografie je součástí Premium.';

  @override
  String get foodScan_upgrade => 'Zobrazit Premium';

  @override
  String get foodScan_errorNetwork =>
      'Bez připojení. Zkontrolujte internet a zkuste to znovu.';

  @override
  String get foodScan_errorRateLimited =>
      'Právě probíhá příliš mnoho skenů. Zkuste to znovu za několik minut.';

  @override
  String get foodScan_errorUnavailable =>
      'Analýza fotografií nyní není dostupná.';

  @override
  String get foodScan_errorServer =>
      'Služba analýzy má potíže. Zkuste to znovu za chvíli.';

  @override
  String get foodScan_errorNoFood =>
      'Na této fotografii nebylo nalezeno žádné jídlo. Zkuste pořídit zřetelnější snímek talíře.';

  @override
  String get foodScan_errorUnreadable =>
      'Tuto fotografii se nepodařilo analyzovat. Zkuste jinou.';

  @override
  String get paywall_aiFoodScan => 'AI sken jídla';

  @override
  String get paywall_aiFoodScanDesc =>
      'Vyfoťte jídlo a během několika sekund zaznamenejte jeho kalorie a makroživiny';
}
