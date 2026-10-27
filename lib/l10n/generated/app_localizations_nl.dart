// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Goedemorgen';

  @override
  String get greeting_afternoon => 'Goedemiddag';

  @override
  String get greeting_evening => 'Goedenavond';

  @override
  String get tab_timer => 'Start';

  @override
  String get tab_explore => 'Ontdekken';

  @override
  String get tab_stats => 'Rapport';

  @override
  String get tab_meals => 'Maaltijden';

  @override
  String get tab_achievements => 'Beloningen';

  @override
  String get tab_profile => 'Account';

  @override
  String get timer_fasting => 'Vastentijd';

  @override
  String get timer_remaining => 'Resterend';

  @override
  String get timer_elapsed => 'Verstreken';

  @override
  String get timer_start => 'Starten';

  @override
  String get timer_stop => 'Stoppen';

  @override
  String get timer_completed => 'Gefeliciteerd!';

  @override
  String get timer_completedMessage => 'Je hebt je vasten succesvol voltooid!';

  @override
  String get timer_selectPlan => 'Kies een vastenplan';

  @override
  String get timer_stopConfirm =>
      'Weet je zeker dat je het vasten voortijdig wilt beëindigen?';

  @override
  String get timer_stopTitle => 'Vasten beëindigen';

  @override
  String get timer_cancel => 'Annuleren';

  @override
  String get timer_confirmStop => 'Ja, beëindigen';

  @override
  String get phase_anabolic => 'Anabool';

  @override
  String get phase_anabolicDesc => 'Spijsvertering bezig';

  @override
  String get phase_catabolic => 'Katabool';

  @override
  String get phase_catabolicDesc => 'Energietransitie';

  @override
  String get phase_fatBurning => 'Vetverbranding';

  @override
  String get phase_fatBurningDesc => 'Vetverbranding is begonnen';

  @override
  String get phase_ketosis => 'Ketose';

  @override
  String get phase_ketosisDesc => 'Ketonproductie actief';

  @override
  String get phase_autophagy => 'Autofagie';

  @override
  String get phase_autophagyDesc => 'Celvernieuwing';

  @override
  String get stats_title => 'Statistieken';

  @override
  String get stats_week => 'Week';

  @override
  String get stats_month => 'Maand';

  @override
  String get stats_year => 'Jaar';

  @override
  String get stats_totalFasts => 'Totaal aantal vastenperiodes';

  @override
  String get stats_average => 'Gemiddelde';

  @override
  String get stats_fastDuration => 'vastenduur';

  @override
  String get stats_streak => 'Reeks';

  @override
  String get stats_daysConsecutive => 'opeenvolgende dagen';

  @override
  String get stats_success => 'Succes';

  @override
  String get stats_completion => 'voltooiing';

  @override
  String get stats_weeklyFasting => 'Wekelijks vasten';

  @override
  String get stats_monthlyView => 'Maandoverzicht';

  @override
  String get stats_weightChange => 'Gewichtsverandering';

  @override
  String get heatmap_none => 'Geen';

  @override
  String get heatmap_low => 'Laag';

  @override
  String get heatmap_good => 'Goed';

  @override
  String get heatmap_full => 'Volledig';

  @override
  String get meals_title => 'Maaltijdplanner';

  @override
  String get meals_eatingWindow => 'Eetvenster';

  @override
  String get meals_windowOpen => 'Open';

  @override
  String get meals_windowFasting => 'Vasten';

  @override
  String get meals_calories => 'Calorieën';

  @override
  String get meals_protein => 'Eiwitten';

  @override
  String get meals_carbs => 'Koolhydraten';

  @override
  String get meals_fat => 'Vet';

  @override
  String get meals_todayMeals => 'Maaltijden van vandaag';

  @override
  String get meals_noMeals => 'Nog geen maaltijden toegevoegd';

  @override
  String get meals_breakfastSuggestions => 'Suggesties om het vasten te breken';

  @override
  String get meals_addMeal => 'Maaltijd toevoegen';

  @override
  String get profile_title => 'Profiel';

  @override
  String get profile_user => 'Gebruiker';

  @override
  String profile_planActive(String plan) {
    return 'Plan $plan actief';
  }

  @override
  String get profile_upgradePremium => 'Upgraden naar Premium';

  @override
  String get profile_premiumDesc => 'Alle vastenplannen, zonder advertenties';

  @override
  String get profile_bodyMetrics => 'Lichaamsmetingen';

  @override
  String get profile_height => 'Lengte';

  @override
  String get profile_weight => 'Gewicht';

  @override
  String get profile_targetWeight => 'Streefgewicht';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Instellingen';

  @override
  String get profile_notifications => 'Meldingen';

  @override
  String get profile_darkTheme => 'Donker thema';

  @override
  String get profile_waterReminder => 'Waterherinnering';

  @override
  String get profile_phaseNotifications => 'Fasemeldingen';

  @override
  String get profile_language => 'Taal';

  @override
  String get profile_about => 'Over';

  @override
  String get profile_rateApp => 'App beoordelen';

  @override
  String get profile_share => 'Delen';

  @override
  String get profile_privacyPolicy => 'Privacybeleid';

  @override
  String get profile_version => 'Versie';

  @override
  String get onboarding_welcome => 'Welkom';

  @override
  String get onboarding_welcomeDesc =>
      'Neem de regie over je\nreis met periodiek vasten';

  @override
  String get onboarding_featureTimer => 'Slimme vastentimer';

  @override
  String get onboarding_featureStats =>
      'Gedetailleerde statistieken en grafieken';

  @override
  String get onboarding_featureMeals => 'Maaltijdplanner en receptsuggesties';

  @override
  String get onboarding_getStarted => 'Aan de slag';

  @override
  String get onboarding_selectGoal => 'Wat is je doel?';

  @override
  String get onboarding_selectGoalDesc => 'Je kunt meerdere doelen kiezen';

  @override
  String get onboarding_goalWeight => 'Afvallen';

  @override
  String get onboarding_goalWeightDesc => 'Gezond gewichtsverlies';

  @override
  String get onboarding_goalHealth => 'Gezondheid verbeteren';

  @override
  String get onboarding_goalHealthDesc => 'Algemene gezondheid en weerstand';

  @override
  String get onboarding_goalEnergy => 'Meer energie';

  @override
  String get onboarding_goalEnergyDesc => 'De hele dag energie';

  @override
  String get onboarding_goalMental => 'Mentale helderheid';

  @override
  String get onboarding_goalMentalDesc => 'Focus en helderheid';

  @override
  String get onboarding_goalLongevity => 'Lang leven';

  @override
  String get onboarding_goalLongevityDesc =>
      'Celvernieuwing en gezond ouder worden';

  @override
  String get onboarding_goalDiscipline => 'Discipline';

  @override
  String get onboarding_goalDisciplineDesc => 'Zelfdiscipline opbouwen';

  @override
  String get onboarding_selectPlan => 'Kies je plan';

  @override
  String get onboarding_selectPlanDesc =>
      'Kies het vastenplan dat het beste bij je past';

  @override
  String get onboarding_bodyInfo => 'Vul je gegevens in';

  @override
  String get onboarding_bodyInfoDesc => 'Voor persoonlijke aanbevelingen';

  @override
  String get onboarding_gender => 'Geslacht';

  @override
  String get onboarding_male => 'Man';

  @override
  String get onboarding_female => 'Vrouw';

  @override
  String get onboarding_age => 'Leeftijd';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Deze informatie wordt alleen op je apparaat opgeslagen en gebruikt voor calorieberekeningen.';

  @override
  String get onboarding_permissions => 'Laatste stap';

  @override
  String get onboarding_permissionsDesc =>
      'Schakel machtigingen in voor de beste ervaring';

  @override
  String get onboarding_next => 'Doorgaan';

  @override
  String get onboarding_start => 'Aan de slag!';

  @override
  String get onboarding_skipForNow => 'Later instellen';

  @override
  String get waterAdded => '+250 ml water toegevoegd';

  @override
  String get languageSelect => 'Taal kiezen';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Upgraden naar Premium';

  @override
  String get paywall_subtitle =>
      'Ontgrendel alle vastenplannen en verwijder advertenties';

  @override
  String get paywall_allPlans => 'Alle vastenplannen';

  @override
  String get paywall_advancedStats => 'Geavanceerde statistieken';

  @override
  String get paywall_mealPlanner => 'Maaltijdplanner';

  @override
  String get paywall_themes => 'Thema aanpassen';

  @override
  String get paywall_noAds => 'Geen advertenties';

  @override
  String get paywall_weekly => 'Wekelijks';

  @override
  String get paywall_monthly => 'Maandelijks';

  @override
  String get paywall_yearly => 'Jaarlijks';

  @override
  String get paywall_bestValue => 'Beste keuze';

  @override
  String get paywall_freeTrial => 'Gratis proefperiode (3 dagen)';

  @override
  String get paywall_restore => 'Aankopen herstellen';

  @override
  String get paywall_premiumActive => 'Premium actief!';

  @override
  String get paywall_premiumActiveDesc =>
      'Alle vastenplannen zijn ontgrendeld en advertenties zijn uitgeschakeld';

  @override
  String get water_title => 'Waterinname';

  @override
  String get water_addWater => 'Water toevoegen';

  @override
  String get water_goal => 'Doel';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Annuleren';

  @override
  String get common_save => 'Opslaan';

  @override
  String get common_delete => 'Verwijderen';

  @override
  String get common_hours => 'uur';

  @override
  String get common_minutes => 'minuten';

  @override
  String get common_days => 'dagen';

  @override
  String get common_enable => 'Inschakelen';

  @override
  String get streakCard_currentStreak => 'Huidige reeks';

  @override
  String get streakCard_longestStreak => 'Langste reeks';

  @override
  String get streakCard_totalSessions => 'Totaal aantal vastenperiodes';

  @override
  String get meals_mealType => 'Maaltijdtype';

  @override
  String get meals_breakfast => 'Ontbijt';

  @override
  String get meals_lunch => 'Lunch';

  @override
  String get meals_dinner => 'Avondeten';

  @override
  String get meals_snack => 'Tussendoortje';

  @override
  String get meals_carbohydrate => 'Koolhydraten';

  @override
  String get meals_add => 'Toevoegen';

  @override
  String get meals_mealName => 'Naam van maaltijd';

  @override
  String get bodyMetrics_title => 'Lichaamsmetingen';

  @override
  String get bodyMetrics_weight => 'Gewicht';

  @override
  String get bodyMetrics_target => 'Doel';

  @override
  String get bodyMetrics_save => 'Opslaan';

  @override
  String get bodyMetrics_history => 'Geschiedenis';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Nog geen gegevens';

  @override
  String get meals_quickAdd => 'Snel toevoegen';

  @override
  String get meals_manualEntry => 'Handmatig invoeren';

  @override
  String meals_added(String name) {
    return '$name toegevoegd';
  }

  @override
  String get meals_nameCalorieRequired => 'Naam en calorieën zijn verplicht';

  @override
  String get bodyMetrics_addWeight => 'Gewicht toevoegen';

  @override
  String get bodyMetrics_hintWeight => 'bijv. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Voer een geldig gewicht in';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg opgeslagen';
  }

  @override
  String get completion_duration => 'Duur';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Laatste fase';

  @override
  String get completion_earlyTitle => 'Vasten beëindigd';

  @override
  String get completion_earlyMessage =>
      'De tijd van vandaag is opgeslagen. Je reeks en prestatievoortgang zijn niet gewijzigd omdat het doel niet is behaald.';

  @override
  String get timer_remainingTime => 'Resterende tijd';

  @override
  String get timer_ready => 'Klaar om te starten';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Begin vandaag!';

  @override
  String get streak_goodStart => 'Goed begin!';

  @override
  String get streak_goingGreat => 'Je bent goed bezig!';

  @override
  String get streak_superb => 'Geweldig!';

  @override
  String get streak_legendary => 'Legendarisch!';

  @override
  String get streak_incredible => 'Ongelooflijk!';

  @override
  String get weight_noRecord =>
      'Nog geen gewichtsmetingen\nVoeg ze toe via Profiel > Lichaamsmetingen';

  @override
  String get day_mon => 'Ma';

  @override
  String get day_tue => 'Di';

  @override
  String get day_wed => 'Wo';

  @override
  String get day_thu => 'Do';

  @override
  String get day_fri => 'Vr';

  @override
  String get day_sat => 'Za';

  @override
  String get day_sun => 'Zo';

  @override
  String get day_short_mon => 'M';

  @override
  String get day_short_tue => 'D';

  @override
  String get day_short_wed => 'W';

  @override
  String get day_short_thu => 'D';

  @override
  String get day_short_fri => 'V';

  @override
  String get day_short_sat => 'Z';

  @override
  String get day_short_sun => 'Z';

  @override
  String get month_jan => 'Januari';

  @override
  String get month_feb => 'Februari';

  @override
  String get month_mar => 'Maart';

  @override
  String get month_apr => 'April';

  @override
  String get month_may => 'Mei';

  @override
  String get month_jun => 'Juni';

  @override
  String get month_jul => 'Juli';

  @override
  String get month_aug => 'Augustus';

  @override
  String get month_sep => 'September';

  @override
  String get month_oct => 'Oktober';

  @override
  String get month_nov => 'November';

  @override
  String get month_dec => 'December';

  @override
  String meals_fastingWindow(String hours) {
    return 'Vasten ($hours u)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Eten ($hours u)';
  }

  @override
  String get recipe_oatSmoothie => 'Havermoutsmoothie';

  @override
  String get recipe_avocadoToast => 'Avocadotoast';

  @override
  String get recipe_yogurtBowl => 'Yoghurtkom';

  @override
  String get elapsed_time => 'Verstreken tijd';

  @override
  String get fast_ends_on => 'Je vasten eindigt om';

  @override
  String get end_fasting => 'Vasten beëindigen';

  @override
  String get start_fasting => 'Vasten starten';

  @override
  String get water_tracker => 'Watertracker';

  @override
  String get weight_tracker => 'Gewichtstracker';

  @override
  String get drink => 'Drinken';

  @override
  String get log_weight => 'Gewicht registreren';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Gewicht verloren';

  @override
  String get current_weight => 'Huidig gewicht';

  @override
  String get goal_weight => 'Streefgewicht';

  @override
  String get daily_goal => 'Dagelijks doel';

  @override
  String completed_percent(String percent) {
    return '$percent% voltooid';
  }

  @override
  String get explore => 'Ontdekken';

  @override
  String get achievements => 'Prestaties';

  @override
  String get profile_theme => 'Weergave';

  @override
  String get theme_select => 'Weergave kiezen';

  @override
  String get theme_system => 'Systeemstandaard';

  @override
  String get theme_light => 'Licht';

  @override
  String get theme_dark => 'Donker';

  @override
  String get language_system => 'Systeemtaal';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Voltooiingsgeluid';

  @override
  String get profile_calmGamification => 'Rustige gamificatie';

  @override
  String get profile_calmGamificationDesc =>
      'Vermindert de druk van competities en seizoenen';

  @override
  String get profile_editName => 'Je naam bewerken';

  @override
  String get profile_name => 'Naam';

  @override
  String get circle_title => 'Vastenkring';

  @override
  String get circle_you => 'Jij';

  @override
  String get circle_tagline => 'Samen, zonder druk.';

  @override
  String get circle_privacy =>
      'Gewicht en persoonlijke metingen blijven verborgen. Alleen voortgang en steun zijn zichtbaar.';

  @override
  String circle_sendSupport(int count) {
    return 'Steun sturen · $count';
  }

  @override
  String get circle_inviteCopied => 'Uitnodigingscode gekopieerd';

  @override
  String get circle_createInvite => 'Privé-uitnodiging maken';

  @override
  String get crisis_nameTitle => 'Benoem eerst wat er gebeurt';

  @override
  String get crisis_nameDesc => 'Het kan honger, gewoonte of emotie zijn.';

  @override
  String get crisis_waterTitle => 'Drink een glas water';

  @override
  String get crisis_waterDesc => 'Adem daarna drie keer langzaam in en uit.';

  @override
  String get crisis_delayTitle => 'Stel de beslissing 10 minuten uit';

  @override
  String get crisis_delayDesc =>
      'Als je je niet goed voelt, is stoppen met vasten geen mislukking.';

  @override
  String get crisis_hunger => 'Honger';

  @override
  String get crisis_habit => 'Gewoonte';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Geef het 10 minuten';

  @override
  String get stats_storyEmpty =>
      'Je eerste vastenperiode begint jouw persoonlijke verhaal.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Je hebt in deze periode $sessions keer gevast, je ritme $hours uur volgehouden en een voltooiingspercentage van $rate% bereikt.';
  }

  @override
  String get stats_storyTitle => 'Het verhaal van jouw ritme';

  @override
  String get home_todayRhythm => 'Het ritme van vandaag';

  @override
  String get home_finalHourSupport => 'Steun voor het laatste uur';

  @override
  String get home_needSupport => 'Ik heb wat steun nodig';

  @override
  String get home_todaySummary => 'Vandaag in één oogopslag';

  @override
  String get home_dayStreak => 'dagen op rij';

  @override
  String home_weightGoal(String weight) {
    return 'doel $weight kg';
  }

  @override
  String get weather_steady => 'Je ritme is stabiel';

  @override
  String get weather_gentle => 'Een rustige dag';

  @override
  String get weather_water => 'Een glas water kan helpen.';

  @override
  String get weather_listen =>
      'Je bent al ver gekomen; luister naar je lichaam.';

  @override
  String get weather_onPlan => 'Het tempo van vandaag past bij je plan.';

  @override
  String get weather_challenging =>
      'Dit uur was eerder lastig; de ondersteuningsmodus staat klaar.';

  @override
  String get replay_copied => 'Vastenoverzicht gekopieerd';

  @override
  String get replay_button => 'Overzicht';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Ik voltooide mijn vasten volgens $plan in $hours u $minutes min · $phase';
  }

  @override
  String get journey_label => 'Metabole reis';

  @override
  String get journey_now => 'Nu';

  @override
  String journey_next(String time, String phase) {
    return 'Nog $time tot $phase';
  }

  @override
  String get phase_estimateShort =>
      'De timing van fasen is een algemene schatting, geen medische meting.';

  @override
  String phase_hours(int start, int end) {
    return 'Uur $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Deze timing is een algemene schatting. Metabole reacties verschillen per persoon.';

  @override
  String get bmi_underweight => 'Ondergewicht';

  @override
  String get bmi_normal => 'Gezond gewicht';

  @override
  String get bmi_overweight => 'Overgewicht';

  @override
  String get bmi_obese => 'Obesitas';

  @override
  String get notification_halfwayTitle => 'Je bent halverwege! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Je hebt de helft van je vasten volgens $plan voltooid. Ga zo door!';
  }

  @override
  String get notification_phaseCatabolic => 'Katabole fase bereikt 📉';

  @override
  String get notification_phaseFatBurning => 'Vetverbranding begonnen! 🔥';

  @override
  String get notification_phaseKetosis => 'Je bent in ketose ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagie actief! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Je hebt je vasten volgens $plan voltooid! Je eetvenster is open.';
  }

  @override
  String get notification_waterTitle => 'Drink water 💧';

  @override
  String get notification_waterBody =>
      'Vergeet niet voldoende water te drinken tijdens het vasten!';

  @override
  String get notification_windowTitle => 'Eetvenster sluit bijna ⏰';

  @override
  String get notification_windowBody => 'Je eetvenster sluit over 30 minuten.';

  @override
  String notification_streakTitle(int days) {
    return 'Reeks van $days dagen! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Je bent goed bezig! Houd het vandaag vol.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Vasten bezig - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Resterend: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Vasten gestart - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Doel: $hours uur';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours u $minutes min';
  }

  @override
  String get explore_guide => 'Vastengids';

  @override
  String get explore_guideDesc =>
      'Alles wat je moet weten over periodiek vasten';

  @override
  String get explore_circleDesc => 'Deel rustige steun met je privégroep.';

  @override
  String get explore_faq => 'Veelgestelde vragen';

  @override
  String get explore_education =>
      'Deze inhoud is uitsluitend bedoeld voor algemene voorlichting en is geen medische diagnose of behandeladvies.';

  @override
  String get explore_safety => 'Gezondheid en veiligheid';

  @override
  String get explore_safetyDesc =>
      'Heb je een medische aandoening, gebruik je regelmatig medicijnen, heb je zorgwekkende klachten, ben je zwanger of geef je borstvoeding? Raadpleeg dan vóór het vasten een bevoegde zorgverlener. Stop als je je niet goed voelt.';

  @override
  String get explore_sources => 'Bronnen';

  @override
  String get explore_sourcesDesc =>
      'De inhoud is vereenvoudigd op basis van de onderstaande bronnen voor volksgezondheid.';

  @override
  String get explore_sourceError => 'De bron kon niet worden geopend';

  @override
  String get explore_rules => 'Belangrijke regels';

  @override
  String get explore_rule1 =>
      'Gebruik tijdens het vasten geen calorierijk eten';

  @override
  String get explore_rule2 => 'Drink voldoende water en andere vloeistoffen';

  @override
  String get explore_rule3 => 'Eet evenwichtig tijdens je eetvenster';

  @override
  String get explore_rule4 => 'Stop met vasten als je je niet goed voelt';

  @override
  String get explore_rule5 =>
      'Zwangere vrouwen en vrouwen die borstvoeding geven, moeten niet vasten';

  @override
  String get explore_rule6 =>
      'Raadpleeg je arts als je een chronische aandoening hebt';

  @override
  String get tip_water => 'Blijf gehydrateerd';

  @override
  String get tip_waterDesc =>
      'Drink water wanneer je dorst hebt en neem vocht bij de maaltijden. Je behoefte kan verschillen door gezondheid, weer en activiteit.';

  @override
  String get tip_food => 'Eet gezond';

  @override
  String get tip_foodDesc =>
      'Kies tijdens eetvensters voor eiwitrijke voeding met vezels en gezonde vetten. Vermijd sterk bewerkte voeding.';

  @override
  String get tip_sleep => 'Slaap goed';

  @override
  String get tip_sleepDesc =>
      'Regelmatige en voldoende slaap ondersteunt je algemene welzijn. Plan het vasten zo dat het je slaap niet verstoort.';

  @override
  String get tip_exercise => 'Lichte beweging';

  @override
  String get tip_exerciseDesc =>
      'Tijdens het vasten kun je rustig wandelen of yoga doen. Vermijd zware inspanning, vooral in de eerste weken terwijl je lichaam zich aanpast.';

  @override
  String get tip_drinks => 'Toegestane dranken';

  @override
  String get tip_drinksDesc =>
      'Tijdens het vasten kun je water, thee zonder toevoegingen en zwarte koffie drinken (zonder suiker of melk). Deze dranken verbreken het vasten niet.';

  @override
  String get faq_drinks => 'Wat kan ik drinken tijdens het vasten?';

  @override
  String get faq_drinksAnswer =>
      'Je kunt water, thee zonder toevoegingen en zwarte koffie drinken (zonder suiker of melk). Calorierijke dranken verbreken het vasten.';

  @override
  String get faq_plan => 'Welk vastenplan moet ik kiezen?';

  @override
  String get faq_planAnswer =>
      'Begin als nieuwkomer met 12:12 of 14:10. Heb je ervaring, probeer dan 16:8 of 18:6. 20:4 en OMAD zijn bedoeld voor gevorderden.';

  @override
  String get faq_exercise => 'Kan ik sporten tijdens het vasten?';

  @override
  String get faq_exerciseAnswer =>
      'Ja, maar vermijd intensieve trainingen. Lichte cardio, wandelen en yoga zijn ideaal. Plan krachttraining dicht bij je eetvenster.';

  @override
  String get faq_weight => 'Helpt vasten bij gewichtsverlies?';

  @override
  String get faq_weightAnswer =>
      'Voor sommige mensen kan een beperkt eetvenster de totale energie-inname verlagen. Resultaten verschillen en de langetermijneffecten worden nog onderzocht.';

  @override
  String get plan_12_desc => 'Beginnersniveau';

  @override
  String get plan_12_detail =>
      'Ideaal voor beginners. Vast 12 uur, inclusief je slaaptijd.';

  @override
  String get plan_16_desc => 'Populairste plan';

  @override
  String get plan_16_detail =>
      'Het meest gebruikte plan voor periodiek vasten: 16 uur vasten en een eetvenster van 8 uur, meestal van lunch tot avondeten.';

  @override
  String get plan_18_desc => 'Gemiddeld niveau';

  @override
  String get plan_18_detail =>
      '18 uur vasten en een eetvenster van 6 uur. De vetverbranding duurt langer.';

  @override
  String get plan_20_desc => 'Gevorderd niveau';

  @override
  String get plan_20_detail =>
      '20 uur vasten en een eetvenster van 4 uur. Ideaal om ketose en autofagie te bereiken.';

  @override
  String get plan_omad_desc => 'Eén maaltijd per dag';

  @override
  String get plan_omad_detail =>
      'Eén maaltijd per dag: 23 uur vasten en een eetvenster van 1 uur. Expert-niveau.';

  @override
  String get plan_52_desc => '2 dagen per week';

  @override
  String get plan_52_detail =>
      'Eet 5 dagen normaal en beperk je op 2 dagen tot ongeveer 500 calorieën. Een alternatieve aanpak.';

  @override
  String get plan_ese_desc => '24 uur vasten';

  @override
  String get plan_ese_detail =>
      'Vast 1–2 keer per week 24 uur. Voor gevorderden.';

  @override
  String get plan_warrior_desc => 'Krijgersdieet';

  @override
  String get plan_warrior_detail =>
      'Eet overdag licht (fruit en groenten) en neem je hoofdmaaltijd binnen een eetvenster van 4 uur in de avond.';

  @override
  String get award_first_title => 'Eerste stap';

  @override
  String get award_first_desc => 'Voltooi je eerste vastenperiode';

  @override
  String get award_rhythm3_title => 'Driedaags ritme';

  @override
  String get award_rhythm3_desc => 'Houd je ritme drie dagen vol';

  @override
  String get award_hours24_title => '24 uur';

  @override
  String get award_hours24_desc => 'Vast in totaal 24 uur';

  @override
  String get award_week_title => 'Een week ritme';

  @override
  String get award_week_desc => 'Bouw een reeks van zeven dagen op';

  @override
  String get award_fasts10_title => '10 vastenperiodes';

  @override
  String get award_fasts10_desc => 'Voltooi tien vastenperiodes';

  @override
  String get award_hours100_title => '100 uur';

  @override
  String get award_hours100_desc => 'Bereik in totaal 100 uur';

  @override
  String get award_rhythm30_title => '30-daags ritme';

  @override
  String get award_rhythm30_desc => 'Bouw een reeks van dertig dagen op';

  @override
  String get award_fasts50_title => '50 vastenperiodes';

  @override
  String get award_fasts50_desc => 'Voltooi vijftig vastenperiodes';

  @override
  String get award_hours500_title => '500 uur';

  @override
  String get award_hours500_desc => 'Bereik in totaal 500 uur';

  @override
  String get award_fasts100_title => '100 vastenperiodes';

  @override
  String get award_fasts100_desc => 'Voltooi honderd vastenperiodes';

  @override
  String get award_rhythm90_title => '90-daags ritme';

  @override
  String get award_rhythm90_desc => 'Bouw een reeks van negentig dagen op';

  @override
  String get award_year_title => 'Een jaar onderweg';

  @override
  String get award_year_desc => 'Bereik een ritme van 365 dagen';

  @override
  String get awards_loadError => 'Voortgang kon niet worden geladen';

  @override
  String get awards_journeyComplete => 'Reis voltooid';

  @override
  String get awards_nextGoal => 'Volgend doel';

  @override
  String get awards_allYours => 'Alle prestaties zijn van jou';

  @override
  String get awards_dayStreak => 'dagen op rij';

  @override
  String get awards_fasts => 'vastenperiodes';

  @override
  String get awards_total => 'totaal';

  @override
  String get awards_stageStart => 'Begin';

  @override
  String get awards_stageRhythm => 'Ritme';

  @override
  String get awards_stageEndurance => 'Uithoudingsvermogen';

  @override
  String get awards_stageMastery => 'Meesterschap';

  @override
  String get awards_completed => 'Voltooid';

  @override
  String awards_fastsRemaining(int count) {
    return 'Nog $count vastenperiodes te gaan';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Nog $count dagen te gaan';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Nog $count uur te gaan';
  }

  @override
  String get common_retry => 'Opnieuw proberen';

  @override
  String get game_title => 'Voortgangshub';

  @override
  String get game_quests => 'Opdrachten van vandaag';

  @override
  String get game_questsDesc => 'Kleine stappen, een duurzaam ritme.';

  @override
  String get game_season => 'Seizoen van 30 stappen';

  @override
  String get game_seasonDesc =>
      'Na elke vijfde stap ontvang je een verzamelzegel.';

  @override
  String get game_badges => 'Badgeverzameling';

  @override
  String game_shields(int count) {
    return '$count ritmeschilden';
  }

  @override
  String get game_shieldsDesc =>
      'Je verdient er één na elke zeven voltooide stappen. Een gemiste dag wist je voortgang nooit.';

  @override
  String get game_league => 'Privé-weekcompetitie';

  @override
  String game_leagueDesc(int percent) {
    return 'Je ritmescore valt binnen het ${percent}e percentiel van een privé lokaal model. Gewicht en extreem vasten worden nooit gerangschikt.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Niveau $level, $xp ervaringspunten';
  }

  @override
  String get game_explorer => 'Ritmeverkenner';

  @override
  String get game_streak => 'Reeks';

  @override
  String get game_targets => 'Doelen';

  @override
  String get game_best => 'Beste';

  @override
  String get quest_rhythm => 'Bouw aan het ritme van vandaag';

  @override
  String get quest_hydrate => 'Bereik de helft van je waterdoel';

  @override
  String get quest_steady => 'Bescherm je reeks';

  @override
  String get badge_first_title => 'Eerste stap';

  @override
  String get badge_first_desc => 'Registreer je eerste vastenperiode';

  @override
  String get badge_rhythm7_title => 'Ritmebewaker';

  @override
  String get badge_rhythm7_desc => 'Bereik een reeks van 7 dagen';

  @override
  String get badge_rhythm3_title => 'Driedaags ritme';

  @override
  String get badge_rhythm3_desc => 'Bereik een reeks van 3 dagen';

  @override
  String get badge_target1_title => 'Eerste doel';

  @override
  String get badge_target1_desc => 'Voltooi je eerste vastendoel';

  @override
  String get badge_target3_title => 'Drie stappen';

  @override
  String get badge_target3_desc => 'Voltooi 3 doelen';

  @override
  String get badge_water_title => 'In balans';

  @override
  String get badge_water_desc => 'Behaal je dagelijkse waterdoel';

  @override
  String get badge_support_title => 'Zelfbewust';

  @override
  String get badge_support_desc => 'Gebruik de ondersteuningsmodus';

  @override
  String get badge_hours10_title => '10 uur';

  @override
  String get badge_hours10_desc => 'Registreer in totaal 10 uur';

  @override
  String get badge_target10_title => 'Tien keer sterk';

  @override
  String get badge_target10_desc => 'Voltooi 10 doelen';

  @override
  String get badge_target20_title => 'Twintig doelen';

  @override
  String get badge_target20_desc => 'Voltooi 20 doelen';

  @override
  String get badge_fast16_title => '16 uur';

  @override
  String get badge_fast16_desc => 'Bereik 16 uur in één vastenperiode';

  @override
  String get badge_hours50_title => '50 uur';

  @override
  String get badge_hours50_desc => 'Registreer in totaal 50 uur';

  @override
  String get badge_hours100_title => 'Honderd uur';

  @override
  String get badge_hours100_desc => 'Registreer in totaal 100 uur';

  @override
  String get badge_target30_title => 'Dertig doelen';

  @override
  String get badge_target30_desc => 'Voltooi 30 doelen';

  @override
  String get badge_rhythm30_title => '30-daags ritme';

  @override
  String get badge_rhythm30_desc => 'Bereik een reeks van 30 dagen';

  @override
  String get paywall_restoreSuccess => 'Aankopen hersteld!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Voortgang van vasten: $percent procent';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour u';
  }

  @override
  String get paywall_lifetime => 'Levenslang';

  @override
  String get paywall_once => 'eenmalig';

  @override
  String get paywall_processing => 'Bezig met verwerken…';

  @override
  String get paywall_continue => 'Doorgaan';

  @override
  String get paywall_productsUnavailable =>
      'Aankopen zijn momenteel niet beschikbaar. Probeer het later opnieuw.';

  @override
  String get paywall_purchaseFailed => 'De aankoop kon niet worden voltooid.';

  @override
  String get paywall_nothingToRestore => 'Er is geen eerdere aankoop gevonden.';

  @override
  String get paywall_restoreFailed => 'Aankopen konden niet worden hersteld.';

  @override
  String get paywall_terms => 'Gebruiksvoorwaarden';

  @override
  String get permission_notificationDesc =>
      'Herinneringen voor vasten, fase-updates en meldingen bij voltooiing';

  @override
  String get profile_privacyChoices => 'Privacykeuzes';

  @override
  String get paywall_autoRenewInfo =>
      'Abonnementen worden automatisch verlengd, tenzij ze minstens 24 uur voor het einde van de periode worden opgezegd. Je kunt je abonnement op elk moment beheren of opzeggen in de instellingen van de App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / maand';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Bespaar $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days dagen gratis proberen';
  }

  @override
  String get paywall_startFreeTrial => 'Gratis proefperiode starten';

  @override
  String get paywall_retry => 'Opnieuw proberen';

  @override
  String get paywall_alreadyOwned =>
      'Je hebt dit abonnement al. Tik op ‘Aankopen herstellen’.';

  @override
  String get paywall_storeUnavailable =>
      'De winkel is momenteel niet bereikbaar. Controleer je verbinding en probeer het opnieuw.';

  @override
  String get paywall_secureNote =>
      'Je kunt op elk moment opzeggen. De betaling wordt in rekening gebracht via je winkelaccount.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Abonnementen worden automatisch verlengd, tenzij ze minstens 24 uur voor het einde van de periode worden opgezegd. Je kunt je abonnement op elk moment beheren of opzeggen via Google Play > Abonnementen.';

  @override
  String get paywall_allPlansDesc =>
      'Ontgrendelt 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat en Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Banner- en interstitial-advertenties worden volledig uitgeschakeld';

  @override
  String get foodScan_title => 'AI-voedingsscan';

  @override
  String get foodScan_scanCta => 'Maaltijd scannen';

  @override
  String get foodScan_scanCtaDesc =>
      'Fotografeer je bord en ontvang een schatting van calorieën en macro\'s';

  @override
  String get foodScan_introTitle => 'Fotografeer je bord';

  @override
  String get foodScan_introDesc =>
      'AI leest de foto en schat de calorieën, eiwitten, koolhydraten en vetten.';

  @override
  String get foodScan_tipLight =>
      'Goed, gelijkmatig licht zorgt voor een betere schatting';

  @override
  String get foodScan_tipFrame =>
      'Zorg dat het hele bord binnen het kader past';

  @override
  String get foodScan_tipScale =>
      'Leg bestek of een hand in beeld om de portiegrootte te kunnen inschatten';

  @override
  String get foodScan_takePhoto => 'Foto maken';

  @override
  String get foodScan_chooseFromGallery => 'Uit galerij kiezen';

  @override
  String foodScan_scansLeft(int count) {
    return 'Vandaag nog $count scans over';
  }

  @override
  String get foodScan_quotaReached =>
      'Je hebt de scans van vandaag gebruikt. Probeer het morgen opnieuw.';

  @override
  String get foodScan_privacyNote =>
      'De foto wordt voor analyse naar de Gemini-API van Google gestuurd en wordt niet op onze servers opgeslagen.';

  @override
  String get foodScan_consentTitle => 'Foto\'s naar Google Gemini sturen?';

  @override
  String get foodScan_consentBody =>
      'Om calorieën en macro\'s te schatten, wordt elke maaltijdfoto die je maakt of kiest naar de AI-dienst Gemini van Google gestuurd. De foto wordt alleen voor deze analyse gebruikt en niet op onze servers opgeslagen.';

  @override
  String get foodScan_consentAgree => 'Akkoord en doorgaan';

  @override
  String get foodScan_analyzing => 'Je maaltijd wordt geanalyseerd…';

  @override
  String get foodScan_analyzingHint => 'Dit duurt meestal enkele seconden';

  @override
  String get foodScan_detectedItems => 'Herkende items';

  @override
  String get foodScan_disclaimer =>
      'AI-schattingen zijn bij benadering. Tik op een item om het te corrigeren.';

  @override
  String get foodScan_lowConfidence =>
      'Het model is niet zeker over deze foto. Controleer de waarden voordat je ze opslaat.';

  @override
  String get foodScan_save => 'Aan maaltijden toevoegen';

  @override
  String get foodScan_retake => 'Nieuwe foto';

  @override
  String get foodScan_retry => 'Opnieuw proberen';

  @override
  String get foodScan_editItem => 'Item bewerken';

  @override
  String get foodScan_portion => 'Portie';

  @override
  String get foodScan_saveEdit => 'Opslaan';

  @override
  String get foodScan_premiumTitle => 'Een Premium-functie';

  @override
  String get foodScan_premiumDesc =>
      'Calorieanalyse via een foto is inbegrepen bij Premium.';

  @override
  String get foodScan_upgrade => 'Premium bekijken';

  @override
  String get foodScan_errorNetwork =>
      'Geen verbinding. Controleer je internetverbinding en probeer het opnieuw.';

  @override
  String get foodScan_errorRateLimited =>
      'Er worden momenteel te veel scans uitgevoerd. Probeer het over een paar minuten opnieuw.';

  @override
  String get foodScan_errorUnavailable =>
      'Fotoanalyse is momenteel niet beschikbaar.';

  @override
  String get foodScan_errorServer =>
      'Er is een probleem met de analyseservice. Probeer het zo opnieuw.';

  @override
  String get foodScan_errorNoFood =>
      'Er is geen eten op deze foto gevonden. Maak een duidelijkere foto van het bord.';

  @override
  String get foodScan_errorUnreadable =>
      'Deze foto kon niet worden geanalyseerd. Probeer een andere foto.';

  @override
  String get paywall_aiFoodScan => 'AI-voedingsscan';

  @override
  String get paywall_aiFoodScanDesc =>
      'Fotografeer een maaltijd en registreer binnen enkele seconden de calorieën en macro\'s';
}
