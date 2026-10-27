// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'God morgon';

  @override
  String get greeting_afternoon => 'God eftermiddag';

  @override
  String get greeting_evening => 'God kväll';

  @override
  String get tab_timer => 'Hem';

  @override
  String get tab_explore => 'Utforska';

  @override
  String get tab_stats => 'Rapport';

  @override
  String get tab_meals => 'Måltider';

  @override
  String get tab_achievements => 'Utmärkelser';

  @override
  String get tab_profile => 'Konto';

  @override
  String get timer_fasting => 'Fastetid';

  @override
  String get timer_remaining => 'Återstår';

  @override
  String get timer_elapsed => 'Förfluten';

  @override
  String get timer_start => 'Starta';

  @override
  String get timer_stop => 'Stoppa';

  @override
  String get timer_completed => 'Grattis!';

  @override
  String get timer_completedMessage => 'Du har slutfört fastan!';

  @override
  String get timer_selectPlan => 'Välj fasteplan';

  @override
  String get timer_stopConfirm =>
      'Är du säker på att du vill avsluta fastan i förtid?';

  @override
  String get timer_stopTitle => 'Avsluta fastan';

  @override
  String get timer_cancel => 'Avbryt';

  @override
  String get timer_confirmStop => 'Ja, avsluta';

  @override
  String get phase_anabolic => 'Anabol';

  @override
  String get phase_anabolicDesc => 'Matsmältning pågår';

  @override
  String get phase_catabolic => 'Katabol';

  @override
  String get phase_catabolicDesc => 'Energiomställning';

  @override
  String get phase_fatBurning => 'Fettförbränning';

  @override
  String get phase_fatBurningDesc => 'Fettförbränningen har börjat';

  @override
  String get phase_ketosis => 'Ketos';

  @override
  String get phase_ketosisDesc => 'Ketonproduktionen är aktiv';

  @override
  String get phase_autophagy => 'Autofagi';

  @override
  String get phase_autophagyDesc => 'Cellförnyelse';

  @override
  String get stats_title => 'Statistik';

  @override
  String get stats_week => 'Vecka';

  @override
  String get stats_month => 'Månad';

  @override
  String get stats_year => 'År';

  @override
  String get stats_totalFasts => 'Totalt antal fastor';

  @override
  String get stats_average => 'Genomsnitt';

  @override
  String get stats_fastDuration => 'fastans längd';

  @override
  String get stats_streak => 'Svit';

  @override
  String get stats_daysConsecutive => 'dagar i följd';

  @override
  String get stats_success => 'Framgång';

  @override
  String get stats_completion => 'slutfört';

  @override
  String get stats_weeklyFasting => 'Veckofasta';

  @override
  String get stats_monthlyView => 'Månadsvy';

  @override
  String get stats_weightChange => 'Viktförändring';

  @override
  String get heatmap_none => 'Ingen';

  @override
  String get heatmap_low => 'Låg';

  @override
  String get heatmap_good => 'Bra';

  @override
  String get heatmap_full => 'Full';

  @override
  String get meals_title => 'Måltidsplanerare';

  @override
  String get meals_eatingWindow => 'Ätfönster';

  @override
  String get meals_windowOpen => 'Öppet';

  @override
  String get meals_windowFasting => 'Fasta';

  @override
  String get meals_calories => 'Kalorier';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Kolhydrater';

  @override
  String get meals_fat => 'Fett';

  @override
  String get meals_todayMeals => 'Dagens måltider';

  @override
  String get meals_noMeals => 'Inga måltider har lagts till ännu';

  @override
  String get meals_breakfastSuggestions => 'Förslag för att bryta fastan';

  @override
  String get meals_addMeal => 'Lägg till måltid';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Användare';

  @override
  String profile_planActive(String plan) {
    return 'Planen $plan är aktiv';
  }

  @override
  String get profile_upgradePremium => 'Uppgradera till Premium';

  @override
  String get profile_premiumDesc => 'Alla fasteplaner utan reklam';

  @override
  String get profile_bodyMetrics => 'Kroppsmått';

  @override
  String get profile_height => 'Längd';

  @override
  String get profile_weight => 'Vikt';

  @override
  String get profile_targetWeight => 'Målvikt';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Inställningar';

  @override
  String get profile_notifications => 'Aviseringar';

  @override
  String get profile_darkTheme => 'Mörkt tema';

  @override
  String get profile_waterReminder => 'Vattenpåminnelse';

  @override
  String get profile_phaseNotifications => 'Fasaviseringar';

  @override
  String get profile_language => 'Språk';

  @override
  String get profile_about => 'Om';

  @override
  String get profile_rateApp => 'Betygsätt appen';

  @override
  String get profile_share => 'Dela';

  @override
  String get profile_privacyPolicy => 'Integritetspolicy';

  @override
  String get profile_version => 'Version';

  @override
  String get onboarding_welcome => 'Välkommen';

  @override
  String get onboarding_welcomeDesc =>
      'Ta kontroll över din resa med\nperiodisk fasta';

  @override
  String get onboarding_featureTimer => 'Smart fastetimer';

  @override
  String get onboarding_featureStats => 'Detaljerad statistik och diagram';

  @override
  String get onboarding_featureMeals => 'Måltidsplanerare och receptförslag';

  @override
  String get onboarding_getStarted => 'Kom igång';

  @override
  String get onboarding_selectGoal => 'Vad är ditt mål?';

  @override
  String get onboarding_selectGoalDesc => 'Du kan välja flera';

  @override
  String get onboarding_goalWeight => 'Gå ner i vikt';

  @override
  String get onboarding_goalWeightDesc => 'Hälsosam viktnedgång';

  @override
  String get onboarding_goalHealth => 'Förbättra hälsan';

  @override
  String get onboarding_goalHealthDesc => 'Allmän hälsa och immunförsvar';

  @override
  String get onboarding_goalEnergy => 'Mer energi';

  @override
  String get onboarding_goalEnergyDesc => 'Energi hela dagen';

  @override
  String get onboarding_goalMental => 'Mental klarhet';

  @override
  String get onboarding_goalMentalDesc => 'Fokus och klarhet';

  @override
  String get onboarding_goalLongevity => 'Långt liv';

  @override
  String get onboarding_goalLongevityDesc =>
      'Cellförnyelse och hälsosamt åldrande';

  @override
  String get onboarding_goalDiscipline => 'Disciplin';

  @override
  String get onboarding_goalDisciplineDesc => 'Bygg upp självdisciplin';

  @override
  String get onboarding_selectPlan => 'Välj din plan';

  @override
  String get onboarding_selectPlanDesc =>
      'Välj den fasteplan som passar dig bäst';

  @override
  String get onboarding_bodyInfo => 'Ange dina uppgifter';

  @override
  String get onboarding_bodyInfoDesc => 'För personliga rekommendationer';

  @override
  String get onboarding_gender => 'Kön';

  @override
  String get onboarding_male => 'Man';

  @override
  String get onboarding_female => 'Kvinna';

  @override
  String get onboarding_age => 'Ålder';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Dessa uppgifter lagras endast på din enhet och används för kaloriberäkningar.';

  @override
  String get onboarding_permissions => 'Sista steget';

  @override
  String get onboarding_permissionsDesc =>
      'Aktivera behörigheter för bästa möjliga upplevelse';

  @override
  String get onboarding_next => 'Fortsätt';

  @override
  String get onboarding_start => 'Nu kör vi!';

  @override
  String get onboarding_skipForNow => 'Konfigurera senare';

  @override
  String get waterAdded => '250 ml vatten tillagt';

  @override
  String get languageSelect => 'Välj språk';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Uppgradera till Premium';

  @override
  String get paywall_subtitle => 'Lås upp alla fasteplaner och ta bort reklam';

  @override
  String get paywall_allPlans => 'Alla fasteplaner';

  @override
  String get paywall_advancedStats => 'Avancerad statistik';

  @override
  String get paywall_mealPlanner => 'Måltidsplanerare';

  @override
  String get paywall_themes => 'Anpassa tema';

  @override
  String get paywall_noAds => 'Ingen reklam';

  @override
  String get paywall_weekly => 'Veckovis';

  @override
  String get paywall_monthly => 'Månadsvis';

  @override
  String get paywall_yearly => 'Årsvis';

  @override
  String get paywall_bestValue => 'Bäst värde';

  @override
  String get paywall_freeTrial => 'Gratis provperiod (3 dagar)';

  @override
  String get paywall_restore => 'Återställ köp';

  @override
  String get paywall_premiumActive => 'Premium är aktivt!';

  @override
  String get paywall_premiumActiveDesc =>
      'Alla fasteplaner är upplåsta och reklamen är avstängd';

  @override
  String get water_title => 'Vattenintag';

  @override
  String get water_addWater => 'Lägg till vatten';

  @override
  String get water_goal => 'Mål';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Avbryt';

  @override
  String get common_save => 'Spara';

  @override
  String get common_delete => 'Ta bort';

  @override
  String get common_hours => 'timmar';

  @override
  String get common_minutes => 'minuter';

  @override
  String get common_days => 'dagar';

  @override
  String get common_enable => 'Aktivera';

  @override
  String get streakCard_currentStreak => 'Nuvarande svit';

  @override
  String get streakCard_longestStreak => 'Längsta svit';

  @override
  String get streakCard_totalSessions => 'Totalt antal fastor';

  @override
  String get meals_mealType => 'Måltidstyp';

  @override
  String get meals_breakfast => 'Frukost';

  @override
  String get meals_lunch => 'Lunch';

  @override
  String get meals_dinner => 'Middag';

  @override
  String get meals_snack => 'Mellanmål';

  @override
  String get meals_carbohydrate => 'Kolhydrat';

  @override
  String get meals_add => 'Lägg till';

  @override
  String get meals_mealName => 'Måltidens namn';

  @override
  String get bodyMetrics_title => 'Kroppsmått';

  @override
  String get bodyMetrics_weight => 'Vikt';

  @override
  String get bodyMetrics_target => 'Mål';

  @override
  String get bodyMetrics_save => 'Spara';

  @override
  String get bodyMetrics_history => 'Historik';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Inga uppgifter ännu';

  @override
  String get meals_quickAdd => 'Snabbtillägg';

  @override
  String get meals_manualEntry => 'Manuell inmatning';

  @override
  String meals_added(String name) {
    return '$name har lagts till';
  }

  @override
  String get meals_nameCalorieRequired => 'Namn och kalorier krävs';

  @override
  String get bodyMetrics_addWeight => 'Lägg till vikt';

  @override
  String get bodyMetrics_hintWeight => 't.ex. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Ange en giltig vikt';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg sparat';
  }

  @override
  String get completion_duration => 'Längd';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Senaste fas';

  @override
  String get completion_earlyTitle => 'Fastan är avslutad';

  @override
  String get completion_earlyMessage =>
      'Dagens tid sparades. Din serie och dina framsteg ändrades inte eftersom målet inte slutfördes.';

  @override
  String get timer_remainingTime => 'Återstående tid';

  @override
  String get timer_ready => 'Redo att starta';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Börja i dag!';

  @override
  String get streak_goodStart => 'Bra start!';

  @override
  String get streak_goingGreat => 'Det går utmärkt!';

  @override
  String get streak_superb => 'Suveränt!';

  @override
  String get streak_legendary => 'Legendariskt!';

  @override
  String get streak_incredible => 'Otroligt!';

  @override
  String get weight_noRecord =>
      'Inga viktregistreringar ännu\nLägg till dem under Profil > Kroppsmått';

  @override
  String get day_mon => 'Mån';

  @override
  String get day_tue => 'Tis';

  @override
  String get day_wed => 'Ons';

  @override
  String get day_thu => 'Tor';

  @override
  String get day_fri => 'Fre';

  @override
  String get day_sat => 'Lör';

  @override
  String get day_sun => 'Sön';

  @override
  String get day_short_mon => 'M';

  @override
  String get day_short_tue => 'T';

  @override
  String get day_short_wed => 'O';

  @override
  String get day_short_thu => 'T';

  @override
  String get day_short_fri => 'F';

  @override
  String get day_short_sat => 'L';

  @override
  String get day_short_sun => 'S';

  @override
  String get month_jan => 'Januari';

  @override
  String get month_feb => 'Februari';

  @override
  String get month_mar => 'Mars';

  @override
  String get month_apr => 'April';

  @override
  String get month_may => 'Maj';

  @override
  String get month_jun => 'Juni';

  @override
  String get month_jul => 'Juli';

  @override
  String get month_aug => 'Augusti';

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
    return 'Fasta ($hours t)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Äta ($hours t)';
  }

  @override
  String get recipe_oatSmoothie => 'Havresmoothie';

  @override
  String get recipe_avocadoToast => 'Avokadotoast';

  @override
  String get recipe_yogurtBowl => 'Yoghurtskål';

  @override
  String get elapsed_time => 'Förfluten tid';

  @override
  String get fast_ends_on => 'Din fasta slutar kl.';

  @override
  String get end_fasting => 'Avsluta fastan';

  @override
  String get start_fasting => 'Starta fastan';

  @override
  String get water_tracker => 'Vattenspårare';

  @override
  String get weight_tracker => 'Viktspårare';

  @override
  String get drink => 'Drick';

  @override
  String get log_weight => 'Registrera vikt';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Viktnedgång';

  @override
  String get current_weight => 'Nuvarande vikt';

  @override
  String get goal_weight => 'Målvikt';

  @override
  String get daily_goal => 'Dagligt mål';

  @override
  String completed_percent(String percent) {
    return '$percent% slutfört';
  }

  @override
  String get explore => 'Utforska';

  @override
  String get achievements => 'Prestationer';

  @override
  String get profile_theme => 'Utseende';

  @override
  String get theme_select => 'Välj utseende';

  @override
  String get theme_system => 'Systemstandard';

  @override
  String get theme_light => 'Ljust';

  @override
  String get theme_dark => 'Mörkt';

  @override
  String get language_system => 'Systemspråk';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Slutljud';

  @override
  String get profile_calmGamification => 'Lugn spelifiering';

  @override
  String get profile_calmGamificationDesc =>
      'Minskar pressen från liga och säsong';

  @override
  String get profile_editName => 'Redigera ditt namn';

  @override
  String get profile_name => 'Namn';

  @override
  String get circle_title => 'Fastecirkel';

  @override
  String get circle_you => 'Du';

  @override
  String get circle_tagline => 'Tillsammans, utan press.';

  @override
  String get circle_privacy =>
      'Vikt och privata mått förblir dolda. Endast framsteg och stöd visas.';

  @override
  String circle_sendSupport(int count) {
    return 'Skicka stöd · $count';
  }

  @override
  String get circle_inviteCopied => 'Inbjudningskoden har kopierats';

  @override
  String get circle_createInvite => 'Skapa privat inbjudan';

  @override
  String get crisis_nameTitle => 'Sätt först ord på vad som händer';

  @override
  String get crisis_nameDesc => 'Det kan vara hunger, vana eller känslor.';

  @override
  String get crisis_waterTitle => 'Drick ett glas vatten';

  @override
  String get crisis_waterDesc => 'Ta sedan tre långsamma andetag.';

  @override
  String get crisis_delayTitle => 'Skjut upp beslutet i 10 minuter';

  @override
  String get crisis_delayDesc =>
      'Om du mår dåligt är det inte ett misslyckande att avsluta fastan.';

  @override
  String get crisis_hunger => 'Hunger';

  @override
  String get crisis_habit => 'Vana';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Ge det 10 minuter';

  @override
  String get stats_storyEmpty =>
      'Din första fasta inleder din personliga berättelse.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Du fastade $sessions gånger under perioden, höll rytmen i $hours timmar och nådde en slutförandegrad på $rate%.';
  }

  @override
  String get stats_storyTitle => 'Berättelsen om din rytm';

  @override
  String get home_todayRhythm => 'Dagens rytm';

  @override
  String get home_finalHourSupport => 'Stöd under sista timmen';

  @override
  String get home_needSupport => 'Jag behöver lite stöd';

  @override
  String get home_todaySummary => 'Dagen i korthet';

  @override
  String get home_dayStreak => 'dagar i följd';

  @override
  String home_weightGoal(String weight) {
    return 'mål $weight kg';
  }

  @override
  String get weather_steady => 'Din rytm är stabil';

  @override
  String get weather_gentle => 'En lugn dag';

  @override
  String get weather_water => 'Ett glas vatten kan hjälpa.';

  @override
  String get weather_listen => 'Du har kommit långt; lyssna på kroppen.';

  @override
  String get weather_onPlan => 'Dagens tempo passar din plan.';

  @override
  String get weather_challenging =>
      'Den här timmen har varit svår förut; stödläget är redo.';

  @override
  String get replay_copied => 'Fasteöversikt kopierad';

  @override
  String get replay_button => 'Översikt';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Jag slutförde min $plan-fasta på $hours t $minutes min · $phase';
  }

  @override
  String get journey_label => 'Metabolisk resa';

  @override
  String get journey_now => 'Nu';

  @override
  String journey_next(String time, String phase) {
    return '$time till $phase';
  }

  @override
  String get phase_estimateShort =>
      'Fasernas tidpunkter är allmänna uppskattningar, inte medicinska mätningar.';

  @override
  String phase_hours(int start, int end) {
    return 'Timmar $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Denna tidsangivelse är en allmän uppskattning. Metaboliska reaktioner kan variera mellan personer.';

  @override
  String get bmi_underweight => 'Undervikt';

  @override
  String get bmi_normal => 'Normalvikt';

  @override
  String get bmi_overweight => 'Övervikt';

  @override
  String get bmi_obese => 'Fetma';

  @override
  String get notification_halfwayTitle => 'Halvvägs! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Du har slutfört hälften av din $plan-fasta. Fortsätt så!';
  }

  @override
  String get notification_phaseCatabolic => 'Katabol fas har börjat 📉';

  @override
  String get notification_phaseFatBurning => 'Fettförbränningen har börjat! 🔥';

  @override
  String get notification_phaseKetosis => 'Du är i ketos ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagi är aktiv! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Du har slutfört din $plan-fasta! Ditt ätfönster är öppet.';
  }

  @override
  String get notification_waterTitle => 'Drick vatten 💧';

  @override
  String get notification_waterBody =>
      'Kom ihåg att dricka mycket vatten under fastan!';

  @override
  String get notification_windowTitle => 'Ätfönstret stängs ⏰';

  @override
  String get notification_windowBody => 'Ditt ätfönster stängs om 30 minuter.';

  @override
  String notification_streakTitle(int days) {
    return '$days dagar i följd! 🔥';
  }

  @override
  String get notification_streakBody => 'Det går jättebra! Fortsätt så i dag.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Fasta pågår – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Återstår: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Fasta startad – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Mål: $hours timmar';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get explore_guide => 'Fasteguide';

  @override
  String get explore_guideDesc => 'Allt du behöver veta om periodisk fasta';

  @override
  String get explore_circleDesc => 'Dela stillsamt stöd med din privata grupp.';

  @override
  String get explore_faq => 'Vanliga frågor';

  @override
  String get explore_education =>
      'Innehållet är endast avsett som allmän information och utgör inte medicinsk diagnos eller behandlingsråd.';

  @override
  String get explore_safety => 'Hälsa och säkerhet';

  @override
  String get explore_safetyDesc =>
      'Om du har ett medicinskt tillstånd, tar läkemedel regelbundet, har oroande symtom, är gravid eller ammar bör du rådfråga kvalificerad vårdpersonal innan du fastar. Avsluta om du mår dåligt.';

  @override
  String get explore_sources => 'Källor';

  @override
  String get explore_sourcesDesc =>
      'Innehållet har förenklats från nedanstående offentliga hälsokällor.';

  @override
  String get explore_sourceError => 'Källan kunde inte öppnas';

  @override
  String get explore_rules => 'Viktiga regler';

  @override
  String get explore_rule1 => 'Ät inte kaloririk mat under fastan';

  @override
  String get explore_rule2 => 'Drick mycket vatten och vätska';

  @override
  String get explore_rule3 => 'Ät balanserat under ätfönstret';

  @override
  String get explore_rule4 => 'Avsluta fastan om du mår dåligt';

  @override
  String get explore_rule5 => 'Gravida eller ammande bör inte fasta';

  @override
  String get explore_rule6 => 'Rådfråga läkare om du har en kronisk sjukdom';

  @override
  String get tip_water => 'Håll vätskebalansen';

  @override
  String get tip_waterDesc =>
      'Drick vatten när du är törstig och få i dig vätska till måltiderna. Behovet kan variera med hälsa, väder och aktivitet.';

  @override
  String get tip_food => 'Ät rätt';

  @override
  String get tip_foodDesc =>
      'Välj protein- och fiberrika livsmedel samt nyttiga fetter under ätfönstret. Undvik processad mat.';

  @override
  String get tip_sleep => 'Sov gott';

  @override
  String get tip_sleepDesc =>
      'Regelbunden och tillräcklig sömn stödjer det allmänna välbefinnandet. Planera fastan så att den inte stör sömnen.';

  @override
  String get tip_exercise => 'Lätt träning';

  @override
  String get tip_exerciseDesc =>
      'Du kan promenera lugnt eller göra yoga under fastan. Undvik hård träning, särskilt de första veckorna medan kroppen anpassar sig.';

  @override
  String get tip_drinks => 'Tillåtna drycker';

  @override
  String get tip_drinksDesc =>
      'Under fastan kan du dricka vatten, rent te och svart kaffe utan socker eller mjölk. Dessa drycker bryter inte fastan.';

  @override
  String get faq_drinks => 'Vad kan jag dricka under fastan?';

  @override
  String get faq_drinksAnswer =>
      'Du kan dricka vatten, rent te och svart kaffe utan socker eller mjölk. Kaloririka drycker bryter fastan.';

  @override
  String get faq_plan => 'Vilken fasteplan ska jag välja?';

  @override
  String get faq_planAnswer =>
      'Om du är ny kan du börja med 12:12 eller 14:10. Om du har erfarenhet kan du prova 16:8 eller 18:6. 20:4 och OMAD är för erfarna.';

  @override
  String get faq_exercise => 'Kan jag träna under fastan?';

  @override
  String get faq_exerciseAnswer =>
      'Ja, men undvik intensiva träningspass. Lätt konditionsträning, promenader och yoga är idealiskt. Lägg styrketräningen nära ätfönstret.';

  @override
  String get faq_weight => 'Hjälper fasta vid viktnedgång?';

  @override
  String get faq_weightAnswer =>
      'För vissa kan ett begränsat ätfönster minska det totala energiintaget. Resultaten varierar och långtidseffekterna undersöks fortfarande.';

  @override
  String get plan_12_desc => 'Nybörjarnivå';

  @override
  String get plan_12_detail =>
      'Perfekt för nybörjare. Fasta i 12 timmar, inklusive sovtiden.';

  @override
  String get plan_16_desc => 'Populäraste planen';

  @override
  String get plan_16_detail =>
      'Den vanligaste planen för periodisk fasta: 16 timmars fasta och ett ätfönster på 8 timmar, vanligtvis från lunch till middag.';

  @override
  String get plan_18_desc => 'Mellannivå';

  @override
  String get plan_18_detail =>
      '18 timmars fasta och ett ätfönster på 6 timmar. Längre fettförbränning.';

  @override
  String get plan_20_desc => 'Avancerad nivå';

  @override
  String get plan_20_detail =>
      '20 timmars fasta och ett ätfönster på 4 timmar. Perfekt för att nå ketos och autofagi.';

  @override
  String get plan_omad_desc => 'En måltid om dagen';

  @override
  String get plan_omad_detail =>
      'En måltid om dagen: 23 timmars fasta och ett ätfönster på 1 timme. Expertnivå.';

  @override
  String get plan_52_desc => '2 dagar i veckan';

  @override
  String get plan_52_detail =>
      'Ät normalt i 5 dagar och begränsa dig till cirka 500 kalorier i 2 dagar. Ett alternativt upplägg.';

  @override
  String get plan_ese_desc => '24 timmars fasta';

  @override
  String get plan_ese_detail =>
      'Fasta i 24 timmar 1–2 gånger i veckan. För erfarna.';

  @override
  String get plan_warrior_desc => 'Krigardieten';

  @override
  String get plan_warrior_detail =>
      'Ät lätt under dagen och huvudmålet inom ett fyra timmar långt ätfönster på kvällen.';

  @override
  String get award_first_title => 'Första steget';

  @override
  String get award_first_desc => 'Slutför din första fasta';

  @override
  String get award_rhythm3_title => 'Tredagarsrytm';

  @override
  String get award_rhythm3_desc => 'Håll rytmen i tre dagar';

  @override
  String get award_hours24_title => '24 timmar';

  @override
  String get award_hours24_desc => 'Fasta i totalt 24 timmar';

  @override
  String get award_week_title => 'En veckas rytm';

  @override
  String get award_week_desc => 'Bygg en sju dagar lång svit';

  @override
  String get award_fasts10_title => '10 fastor';

  @override
  String get award_fasts10_desc => 'Slutför tio fastor';

  @override
  String get award_hours100_title => '100 timmar';

  @override
  String get award_hours100_desc => 'Nå totalt 100 timmar';

  @override
  String get award_rhythm30_title => '30-dagarsrytm';

  @override
  String get award_rhythm30_desc => 'Bygg en trettio dagar lång svit';

  @override
  String get award_fasts50_title => '50 fastor';

  @override
  String get award_fasts50_desc => 'Slutför femtio fastor';

  @override
  String get award_hours500_title => '500 timmar';

  @override
  String get award_hours500_desc => 'Nå totalt 500 timmar';

  @override
  String get award_fasts100_title => '100 fastor';

  @override
  String get award_fasts100_desc => 'Slutför hundra fastor';

  @override
  String get award_rhythm90_title => '90-dagarsrytm';

  @override
  String get award_rhythm90_desc => 'Bygg en nittio dagar lång svit';

  @override
  String get award_year_title => 'Ett års resa';

  @override
  String get award_year_desc => 'Nå en rytm på 365 dagar';

  @override
  String get awards_loadError => 'Framstegen kunde inte läsas in';

  @override
  String get awards_journeyComplete => 'Resan är slutförd';

  @override
  String get awards_nextGoal => 'Nästa mål';

  @override
  String get awards_allYours => 'Alla prestationer är dina';

  @override
  String get awards_dayStreak => 'dagar i följd';

  @override
  String get awards_fasts => 'fastor';

  @override
  String get awards_total => 'totalt';

  @override
  String get awards_stageStart => 'Start';

  @override
  String get awards_stageRhythm => 'Rytm';

  @override
  String get awards_stageEndurance => 'Uthållighet';

  @override
  String get awards_stageMastery => 'Bemästring';

  @override
  String get awards_completed => 'Slutförd';

  @override
  String awards_fastsRemaining(int count) {
    return '$count fastor kvar';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count dagar kvar';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count timmar kvar';
  }

  @override
  String get common_retry => 'Försök igen';

  @override
  String get game_title => 'Framstegscenter';

  @override
  String get game_quests => 'Dagens uppdrag';

  @override
  String get game_questsDesc => 'Små steg, en hållbar rytm.';

  @override
  String get game_season => 'Säsong med 30 steg';

  @override
  String get game_seasonDesc => 'Ett samlarmärke för vart femte steg.';

  @override
  String get game_badges => 'Märkessamling';

  @override
  String game_shields(int count) {
    return '$count rytmsköldar';
  }

  @override
  String get game_shieldsDesc =>
      'Du får en för var sjunde slutförande. En missad dag raderar aldrig dina framsteg.';

  @override
  String get game_league => 'Privat veckoliga';

  @override
  String game_leagueDesc(int percent) {
    return 'Din rytmpoäng ligger i den $percent:e percentilen i en privat lokal modell. Vikt och extrem fasta rangordnas aldrig.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Nivå $level, $xp erfarenhetspoäng';
  }

  @override
  String get game_explorer => 'Rytmupptäckare';

  @override
  String get game_streak => 'Svit';

  @override
  String get game_targets => 'Mål';

  @override
  String get game_best => 'Bäst';

  @override
  String get quest_rhythm => 'Bygg dagens rytm';

  @override
  String get quest_hydrate => 'Nå halva ditt vattenmål';

  @override
  String get quest_steady => 'Skydda din svit';

  @override
  String get badge_first_title => 'Första steget';

  @override
  String get badge_first_desc => 'Registrera din första fasta';

  @override
  String get badge_rhythm7_title => 'Rytmhållare';

  @override
  String get badge_rhythm7_desc => 'Nå en svit på 7 dagar';

  @override
  String get badge_rhythm3_title => 'Tredagarsrytm';

  @override
  String get badge_rhythm3_desc => 'Nå en svit på 3 dagar';

  @override
  String get badge_target1_title => 'Första målet';

  @override
  String get badge_target1_desc => 'Slutför din första målfasta';

  @override
  String get badge_target3_title => 'Tre steg';

  @override
  String get badge_target3_desc => 'Slutför 3 mål';

  @override
  String get badge_water_title => 'I balans';

  @override
  String get badge_water_desc => 'Nå dagens vattenmål';

  @override
  String get badge_support_title => 'Självmedveten';

  @override
  String get badge_support_desc => 'Använd stödläget';

  @override
  String get badge_hours10_title => '10 timmar';

  @override
  String get badge_hours10_desc => 'Registrera totalt 10 timmar';

  @override
  String get badge_target10_title => 'Tio starka';

  @override
  String get badge_target10_desc => 'Slutför 10 mål';

  @override
  String get badge_target20_title => 'Tjugo mål';

  @override
  String get badge_target20_desc => 'Slutför 20 mål';

  @override
  String get badge_fast16_title => '16 timmar';

  @override
  String get badge_fast16_desc => 'Nå 16 timmar under en fasta';

  @override
  String get badge_hours50_title => '50 timmar';

  @override
  String get badge_hours50_desc => 'Registrera totalt 50 timmar';

  @override
  String get badge_hours100_title => 'Hundra timmar';

  @override
  String get badge_hours100_desc => 'Registrera totalt 100 timmar';

  @override
  String get badge_target30_title => 'Trettio mål';

  @override
  String get badge_target30_desc => 'Slutför 30 mål';

  @override
  String get badge_rhythm30_title => '30-dagarsrytm';

  @override
  String get badge_rhythm30_desc => 'Nå en svit på 30 dagar';

  @override
  String get paywall_restoreSuccess => 'Köpen har återställts!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Fastan är $percent procent slutförd';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour t';
  }

  @override
  String get paywall_lifetime => 'Livstid';

  @override
  String get paywall_once => 'engångsbelopp';

  @override
  String get paywall_processing => 'Bearbetar…';

  @override
  String get paywall_continue => 'Fortsätt';

  @override
  String get paywall_productsUnavailable =>
      'Köp är inte tillgängliga just nu. Försök igen senare.';

  @override
  String get paywall_purchaseFailed => 'Köpet kunde inte slutföras.';

  @override
  String get paywall_nothingToRestore => 'Inget tidigare köp hittades.';

  @override
  String get paywall_restoreFailed => 'Köpen kunde inte återställas.';

  @override
  String get paywall_terms => 'Användarvillkor';

  @override
  String get permission_notificationDesc =>
      'Fastepåminnelser, fasuppdateringar och slutaviseringar';

  @override
  String get profile_privacyChoices => 'Integritetsval';

  @override
  String get paywall_autoRenewInfo =>
      'Prenumerationer förnyas automatiskt om de inte sägs upp minst 24 timmar innan perioden löper ut. Hantera eller säg upp när som helst i App Store-inställningarna.';

  @override
  String paywall_perMonth(String price) {
    return '$price / månad';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Spara $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days dagars gratis provperiod';
  }

  @override
  String get paywall_startFreeTrial => 'Starta gratis provperiod';

  @override
  String get paywall_retry => 'Försök igen';

  @override
  String get paywall_alreadyOwned =>
      'Du har redan den här prenumerationen. Tryck på Återställ köp.';

  @override
  String get paywall_storeUnavailable =>
      'Butiken kan inte nås just nu. Kontrollera anslutningen och försök igen.';

  @override
  String get paywall_secureNote =>
      'Säg upp när som helst. Betalningen debiteras ditt butikskonto.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Prenumerationer förnyas automatiskt om de inte sägs upp minst 24 timmar innan perioden löper ut. Hantera eller säg upp under Google Play > Prenumerationer.';

  @override
  String get paywall_allPlansDesc =>
      'Låser upp 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat och Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Banderoll- och helskärmsreklam stängs av helt';

  @override
  String get foodScan_title => 'AI-matskanning';

  @override
  String get foodScan_scanCta => 'Skanna måltid';

  @override
  String get foodScan_scanCtaDesc =>
      'Fotografera tallriken och få kalorier och makronäringsämnen';

  @override
  String get foodScan_introTitle => 'Fotografera din tallrik';

  @override
  String get foodScan_introDesc =>
      'AI läser bilden och uppskattar kalorier, protein, kolhydrater och fett.';

  @override
  String get foodScan_tipLight =>
      'Bra och jämnt ljus ger en bättre uppskattning';

  @override
  String get foodScan_tipFrame => 'Se till att hela tallriken syns i bilden';

  @override
  String get foodScan_tipScale =>
      'Ta med bestick eller en hand så att portionsstorleken kan uppskattas';

  @override
  String get foodScan_takePhoto => 'Ta foto';

  @override
  String get foodScan_chooseFromGallery => 'Välj från galleri';

  @override
  String foodScan_scansLeft(int count) {
    return '$count skanningar kvar i dag';
  }

  @override
  String get foodScan_quotaReached =>
      'Du har använt dagens skanningar. Försök igen i morgon.';

  @override
  String get foodScan_privacyNote =>
      'Bilden skickas till Googles Gemini API för analys och lagras inte på våra servrar.';

  @override
  String get foodScan_consentTitle => 'Skicka foton till Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'För att uppskatta kalorier och makronäringsämnen skickas varje måltidsfoto du tar eller väljer till Googles AI-tjänst Gemini. Fotot används bara för den här analysen och sparas inte på våra servrar.';

  @override
  String get foodScan_consentAgree => 'Godkänn och fortsätt';

  @override
  String get foodScan_analyzing => 'Analyserar din måltid…';

  @override
  String get foodScan_analyzingHint => 'Det tar vanligtvis några sekunder';

  @override
  String get foodScan_detectedItems => 'Identifierade livsmedel';

  @override
  String get foodScan_disclaimer =>
      'AI-uppskattningar är ungefärliga. Tryck på ett livsmedel för att korrigera det.';

  @override
  String get foodScan_lowConfidence =>
      'Modellen är osäker på bilden. Kontrollera värdena innan du sparar.';

  @override
  String get foodScan_save => 'Lägg till i måltider';

  @override
  String get foodScan_retake => 'Nytt foto';

  @override
  String get foodScan_retry => 'Försök igen';

  @override
  String get foodScan_editItem => 'Redigera livsmedel';

  @override
  String get foodScan_portion => 'Portion';

  @override
  String get foodScan_saveEdit => 'Spara';

  @override
  String get foodScan_premiumTitle => 'En Premium-funktion';

  @override
  String get foodScan_premiumDesc =>
      'Kalorianalys från bilder ingår i Premium.';

  @override
  String get foodScan_upgrade => 'Visa Premium';

  @override
  String get foodScan_errorNetwork =>
      'Ingen anslutning. Kontrollera internet och försök igen.';

  @override
  String get foodScan_errorRateLimited =>
      'För många skanningar pågår just nu. Försök igen om några minuter.';

  @override
  String get foodScan_errorUnavailable =>
      'Bildanalys är inte tillgänglig just nu.';

  @override
  String get foodScan_errorServer =>
      'Analystjänsten har problem. Försök igen snart.';

  @override
  String get foodScan_errorNoFood =>
      'Ingen mat hittades i bilden. Ta en tydligare bild av tallriken.';

  @override
  String get foodScan_errorUnreadable =>
      'Bilden kunde inte analyseras. Prova en annan.';

  @override
  String get paywall_aiFoodScan => 'AI-matskanning';

  @override
  String get paywall_aiFoodScanDesc =>
      'Fotografera en måltid och registrera kalorier och makronäringsämnen på några sekunder';
}
