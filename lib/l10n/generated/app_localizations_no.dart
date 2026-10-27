// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'God morgen';

  @override
  String get greeting_afternoon => 'God ettermiddag';

  @override
  String get greeting_evening => 'God kveld';

  @override
  String get tab_timer => 'Hjem';

  @override
  String get tab_explore => 'Utforsk';

  @override
  String get tab_stats => 'Rapport';

  @override
  String get tab_meals => 'Måltider';

  @override
  String get tab_achievements => 'Utmerkelser';

  @override
  String get tab_profile => 'Konto';

  @override
  String get timer_fasting => 'Fastetid';

  @override
  String get timer_remaining => 'Gjenstår';

  @override
  String get timer_elapsed => 'Forløpt';

  @override
  String get timer_start => 'Start';

  @override
  String get timer_stop => 'Stopp';

  @override
  String get timer_completed => 'Gratulerer!';

  @override
  String get timer_completedMessage => 'Du fullførte fasten!';

  @override
  String get timer_selectPlan => 'Velg fasteplan';

  @override
  String get timer_stopConfirm =>
      'Er du sikker på at du vil avslutte fasten tidlig?';

  @override
  String get timer_stopTitle => 'Avslutt faste';

  @override
  String get timer_cancel => 'Avbryt';

  @override
  String get timer_confirmStop => 'Ja, avslutt';

  @override
  String get phase_anabolic => 'Anabolsk';

  @override
  String get phase_anabolicDesc => 'Fordøyelsen pågår';

  @override
  String get phase_catabolic => 'Katabolsk';

  @override
  String get phase_catabolicDesc => 'Energiomstilling';

  @override
  String get phase_fatBurning => 'Fettforbrenning';

  @override
  String get phase_fatBurningDesc => 'Fettforbrenningen har startet';

  @override
  String get phase_ketosis => 'Ketose';

  @override
  String get phase_ketosisDesc => 'Ketonproduksjonen er aktiv';

  @override
  String get phase_autophagy => 'Autofagi';

  @override
  String get phase_autophagyDesc => 'Cellefornyelse';

  @override
  String get stats_title => 'Statistikk';

  @override
  String get stats_week => 'Uke';

  @override
  String get stats_month => 'Måned';

  @override
  String get stats_year => 'År';

  @override
  String get stats_totalFasts => 'Faster totalt';

  @override
  String get stats_average => 'Gjennomsnitt';

  @override
  String get stats_fastDuration => 'fastens varighet';

  @override
  String get stats_streak => 'Rekke';

  @override
  String get stats_daysConsecutive => 'dager på rad';

  @override
  String get stats_success => 'Suksess';

  @override
  String get stats_completion => 'fullført';

  @override
  String get stats_weeklyFasting => 'Ukentlig faste';

  @override
  String get stats_monthlyView => 'Månedsvisning';

  @override
  String get stats_weightChange => 'Vektendring';

  @override
  String get heatmap_none => 'Ingen';

  @override
  String get heatmap_low => 'Lav';

  @override
  String get heatmap_good => 'God';

  @override
  String get heatmap_full => 'Full';

  @override
  String get meals_title => 'Måltidsplanlegger';

  @override
  String get meals_eatingWindow => 'Spisevindu';

  @override
  String get meals_windowOpen => 'Åpent';

  @override
  String get meals_windowFasting => 'Faste';

  @override
  String get meals_calories => 'Kalorier';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Karbohydrater';

  @override
  String get meals_fat => 'Fett';

  @override
  String get meals_todayMeals => 'Dagens måltider';

  @override
  String get meals_noMeals => 'Ingen måltider er lagt til ennå';

  @override
  String get meals_breakfastSuggestions => 'Forslag til å bryte fasten';

  @override
  String get meals_addMeal => 'Legg til måltid';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Bruker';

  @override
  String profile_planActive(String plan) {
    return 'Planen $plan er aktiv';
  }

  @override
  String get profile_upgradePremium => 'Oppgrader til Premium';

  @override
  String get profile_premiumDesc => 'Alle fasteplaner uten reklame';

  @override
  String get profile_bodyMetrics => 'Kroppsmål';

  @override
  String get profile_height => 'Høyde';

  @override
  String get profile_weight => 'Vekt';

  @override
  String get profile_targetWeight => 'Målvekt';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Innstillinger';

  @override
  String get profile_notifications => 'Varsler';

  @override
  String get profile_darkTheme => 'Mørkt tema';

  @override
  String get profile_waterReminder => 'Vannpåminnelse';

  @override
  String get profile_phaseNotifications => 'Fasevarsler';

  @override
  String get profile_language => 'Språk';

  @override
  String get profile_about => 'Om';

  @override
  String get profile_rateApp => 'Vurder appen';

  @override
  String get profile_share => 'Del';

  @override
  String get profile_privacyPolicy => 'Personvernerklæring';

  @override
  String get profile_version => 'Versjon';

  @override
  String get onboarding_welcome => 'Velkommen';

  @override
  String get onboarding_welcomeDesc =>
      'Ta kontroll over reisen din med\nperiodisk faste';

  @override
  String get onboarding_featureTimer => 'Smart fastetidtaker';

  @override
  String get onboarding_featureStats => 'Detaljert statistikk og diagrammer';

  @override
  String get onboarding_featureMeals =>
      'Måltidsplanlegger og oppskriftsforslag';

  @override
  String get onboarding_getStarted => 'Kom i gang';

  @override
  String get onboarding_selectGoal => 'Hva er målet ditt?';

  @override
  String get onboarding_selectGoalDesc => 'Du kan velge flere';

  @override
  String get onboarding_goalWeight => 'Gå ned i vekt';

  @override
  String get onboarding_goalWeightDesc => 'Sunn vektnedgang';

  @override
  String get onboarding_goalHealth => 'Bedre helse';

  @override
  String get onboarding_goalHealthDesc => 'Generell helse og immunforsvar';

  @override
  String get onboarding_goalEnergy => 'Mer energi';

  @override
  String get onboarding_goalEnergyDesc => 'Energi gjennom hele dagen';

  @override
  String get onboarding_goalMental => 'Mental klarhet';

  @override
  String get onboarding_goalMentalDesc => 'Fokus og klarhet';

  @override
  String get onboarding_goalLongevity => 'Lang levetid';

  @override
  String get onboarding_goalLongevityDesc => 'Cellefornyelse og sunn aldring';

  @override
  String get onboarding_goalDiscipline => 'Disiplin';

  @override
  String get onboarding_goalDisciplineDesc => 'Bygg selvdisiplin';

  @override
  String get onboarding_selectPlan => 'Velg planen din';

  @override
  String get onboarding_selectPlanDesc =>
      'Velg fasteplanen som passer best for deg';

  @override
  String get onboarding_bodyInfo => 'Oppgi informasjonen din';

  @override
  String get onboarding_bodyInfoDesc => 'For personlige anbefalinger';

  @override
  String get onboarding_gender => 'Kjønn';

  @override
  String get onboarding_male => 'Mann';

  @override
  String get onboarding_female => 'Kvinne';

  @override
  String get onboarding_age => 'Alder';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Denne informasjonen lagres bare på enheten din og brukes til kaloriberegninger.';

  @override
  String get onboarding_permissions => 'Siste trinn';

  @override
  String get onboarding_permissionsDesc =>
      'Aktiver tillatelser for den beste opplevelsen';

  @override
  String get onboarding_next => 'Fortsett';

  @override
  String get onboarding_start => 'Sett i gang!';

  @override
  String get onboarding_skipForNow => 'Konfigurer senere';

  @override
  String get waterAdded => '250 ml vann lagt til';

  @override
  String get languageSelect => 'Velg språk';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Oppgrader til Premium';

  @override
  String get paywall_subtitle => 'Lås opp alle fasteplaner og fjern reklame';

  @override
  String get paywall_allPlans => 'Alle fasteplaner';

  @override
  String get paywall_advancedStats => 'Avansert statistikk';

  @override
  String get paywall_mealPlanner => 'Måltidsplanlegger';

  @override
  String get paywall_themes => 'Tilpass tema';

  @override
  String get paywall_noAds => 'Ingen reklame';

  @override
  String get paywall_weekly => 'Ukentlig';

  @override
  String get paywall_monthly => 'Månedlig';

  @override
  String get paywall_yearly => 'Årlig';

  @override
  String get paywall_bestValue => 'Best verdi';

  @override
  String get paywall_freeTrial => 'Gratis prøveperiode (3 dager)';

  @override
  String get paywall_restore => 'Gjenopprett kjøp';

  @override
  String get paywall_premiumActive => 'Premium er aktivt!';

  @override
  String get paywall_premiumActiveDesc =>
      'Alle fasteplaner er låst opp, og reklame er slått av';

  @override
  String get water_title => 'Vanninntak';

  @override
  String get water_addWater => 'Legg til vann';

  @override
  String get water_goal => 'Mål';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Avbryt';

  @override
  String get common_save => 'Lagre';

  @override
  String get common_delete => 'Slett';

  @override
  String get common_hours => 'timer';

  @override
  String get common_minutes => 'minutter';

  @override
  String get common_days => 'dager';

  @override
  String get common_enable => 'Aktiver';

  @override
  String get streakCard_currentStreak => 'Nåværende rekke';

  @override
  String get streakCard_longestStreak => 'Lengste rekke';

  @override
  String get streakCard_totalSessions => 'Faster totalt';

  @override
  String get meals_mealType => 'Måltidstype';

  @override
  String get meals_breakfast => 'Frokost';

  @override
  String get meals_lunch => 'Lunsj';

  @override
  String get meals_dinner => 'Middag';

  @override
  String get meals_snack => 'Mellommåltid';

  @override
  String get meals_carbohydrate => 'Karbohydrat';

  @override
  String get meals_add => 'Legg til';

  @override
  String get meals_mealName => 'Navn på måltid';

  @override
  String get bodyMetrics_title => 'Kroppsmål';

  @override
  String get bodyMetrics_weight => 'Vekt';

  @override
  String get bodyMetrics_target => 'Mål';

  @override
  String get bodyMetrics_save => 'Lagre';

  @override
  String get bodyMetrics_history => 'Historikk';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Ingen data ennå';

  @override
  String get meals_quickAdd => 'Hurtigtillegg';

  @override
  String get meals_manualEntry => 'Manuell registrering';

  @override
  String meals_added(String name) {
    return '$name er lagt til';
  }

  @override
  String get meals_nameCalorieRequired => 'Navn og kalorier er påkrevd';

  @override
  String get bodyMetrics_addWeight => 'Legg til vekt';

  @override
  String get bodyMetrics_hintWeight => 'f.eks. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Oppgi en gyldig vekt';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg lagret';
  }

  @override
  String get completion_duration => 'Varighet';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Siste fase';

  @override
  String get completion_earlyTitle => 'Fasten er avsluttet';

  @override
  String get completion_earlyMessage =>
      'Dagens tid ble lagret. Rekken og fremdriften for prestasjoner ble ikke endret fordi målet ikke ble nådd.';

  @override
  String get timer_remainingTime => 'Gjenværende tid';

  @override
  String get timer_ready => 'Klar til å starte';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Start i dag!';

  @override
  String get streak_goodStart => 'God start!';

  @override
  String get streak_goingGreat => 'Dette går flott!';

  @override
  String get streak_superb => 'Suverent!';

  @override
  String get streak_legendary => 'Legendarisk!';

  @override
  String get streak_incredible => 'Utrolig!';

  @override
  String get weight_noRecord =>
      'Ingen vektregistreringer ennå\nLegg dem til under Profil > Kroppsmål';

  @override
  String get day_mon => 'Man';

  @override
  String get day_tue => 'Tir';

  @override
  String get day_wed => 'Ons';

  @override
  String get day_thu => 'Tor';

  @override
  String get day_fri => 'Fre';

  @override
  String get day_sat => 'Lør';

  @override
  String get day_sun => 'Søn';

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
  String get month_jan => 'Januar';

  @override
  String get month_feb => 'Februar';

  @override
  String get month_mar => 'Mars';

  @override
  String get month_apr => 'April';

  @override
  String get month_may => 'Mai';

  @override
  String get month_jun => 'Juni';

  @override
  String get month_jul => 'Juli';

  @override
  String get month_aug => 'August';

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
    return 'Faste ($hours t)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Spising ($hours t)';
  }

  @override
  String get recipe_oatSmoothie => 'Havresmoothie';

  @override
  String get recipe_avocadoToast => 'Avokadotoast';

  @override
  String get recipe_yogurtBowl => 'Yoghurtskål';

  @override
  String get elapsed_time => 'Forløpt tid';

  @override
  String get fast_ends_on => 'Fasten din avsluttes kl.';

  @override
  String get end_fasting => 'Avslutt faste';

  @override
  String get start_fasting => 'Start faste';

  @override
  String get water_tracker => 'Vannmåler';

  @override
  String get weight_tracker => 'Vektmåler';

  @override
  String get drink => 'Drikk';

  @override
  String get log_weight => 'Registrer vekt';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Vekttap';

  @override
  String get current_weight => 'Nåværende vekt';

  @override
  String get goal_weight => 'Målvekt';

  @override
  String get daily_goal => 'Daglig mål';

  @override
  String completed_percent(String percent) {
    return '$percent% fullført';
  }

  @override
  String get explore => 'Utforsk';

  @override
  String get achievements => 'Prestasjoner';

  @override
  String get profile_theme => 'Utseende';

  @override
  String get theme_select => 'Velg utseende';

  @override
  String get theme_system => 'Systemstandard';

  @override
  String get theme_light => 'Lyst';

  @override
  String get theme_dark => 'Mørkt';

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
  String get profile_completionSound => 'Fullføringslyd';

  @override
  String get profile_calmGamification => 'Rolig spillifisering';

  @override
  String get profile_calmGamificationDesc =>
      'Reduserer presset fra liga og sesong';

  @override
  String get profile_editName => 'Rediger navnet ditt';

  @override
  String get profile_name => 'Navn';

  @override
  String get circle_title => 'Fastekrets';

  @override
  String get circle_you => 'Deg';

  @override
  String get circle_tagline => 'Sammen, uten press.';

  @override
  String get circle_privacy =>
      'Vekt og private målinger forblir skjult. Bare fremgang og støtte er synlig.';

  @override
  String circle_sendSupport(int count) {
    return 'Send støtte · $count';
  }

  @override
  String get circle_inviteCopied => 'Invitasjonskode kopiert';

  @override
  String get circle_createInvite => 'Opprett privat invitasjon';

  @override
  String get crisis_nameTitle => 'Sett først ord på det som skjer';

  @override
  String get crisis_nameDesc => 'Det kan være sult, vane eller følelser.';

  @override
  String get crisis_waterTitle => 'Drikk et glass vann';

  @override
  String get crisis_waterDesc => 'Ta deretter tre rolige pust.';

  @override
  String get crisis_delayTitle => 'Utsett avgjørelsen i 10 minutter';

  @override
  String get crisis_delayDesc =>
      'Hvis du føler deg uvel, er det ikke et nederlag å avslutte fasten.';

  @override
  String get crisis_hunger => 'Sult';

  @override
  String get crisis_habit => 'Vane';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Gi det 10 minutter';

  @override
  String get stats_storyEmpty =>
      'Din første faste blir starten på din personlige historie.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Du fastet $sessions ganger i denne perioden, holdt rytmen i $hours timer og nådde en fullføringsgrad på $rate%.';
  }

  @override
  String get stats_storyTitle => 'Historien om rytmen din';

  @override
  String get home_todayRhythm => 'Dagens rytme';

  @override
  String get home_finalHourSupport => 'Støtte i den siste timen';

  @override
  String get home_needSupport => 'Jeg trenger litt støtte';

  @override
  String get home_todaySummary => 'Dagen i korte trekk';

  @override
  String get home_dayStreak => 'dager på rad';

  @override
  String home_weightGoal(String weight) {
    return 'mål $weight kg';
  }

  @override
  String get weather_steady => 'Rytmen din er stabil';

  @override
  String get weather_gentle => 'En rolig dag';

  @override
  String get weather_water => 'Et glass vann kan hjelpe.';

  @override
  String get weather_listen => 'Du har kommet langt; lytt til kroppen din.';

  @override
  String get weather_onPlan => 'Dagens tempo passer til planen din.';

  @override
  String get weather_challenging =>
      'Denne timen har vært krevende før; støttemodus er klar.';

  @override
  String get replay_copied => 'Fasteoppsummering kopiert';

  @override
  String get replay_button => 'Oppsummering';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Jeg fullførte $plan-fasten på $hours t $minutes min · $phase';
  }

  @override
  String get journey_label => 'Metabolsk reise';

  @override
  String get journey_now => 'Nå';

  @override
  String journey_next(String time, String phase) {
    return '$time til $phase';
  }

  @override
  String get phase_estimateShort =>
      'Tidspunktene for fasene er generelle anslag, ikke medisinske målinger.';

  @override
  String phase_hours(int start, int end) {
    return 'Time $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Dette tidspunktet er et generelt anslag. Metabolske reaksjoner kan variere fra person til person.';

  @override
  String get bmi_underweight => 'Undervekt';

  @override
  String get bmi_normal => 'Normalvekt';

  @override
  String get bmi_overweight => 'Overvekt';

  @override
  String get bmi_obese => 'Fedme';

  @override
  String get notification_halfwayTitle => 'Halvveis! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Du har fullført halvparten av $plan-fasten. Fortsett slik!';
  }

  @override
  String get notification_phaseCatabolic => 'Katabolsk fase nådd 📉';

  @override
  String get notification_phaseFatBurning =>
      'Fettforbrenningen har startet! 🔥';

  @override
  String get notification_phaseKetosis => 'Du er i ketose ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagi er aktiv! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Du har fullført $plan-fasten! Spisevinduet ditt er åpent.';
  }

  @override
  String get notification_waterTitle => 'Drikk vann 💧';

  @override
  String get notification_waterBody => 'Husk å drikke nok vann under fasten!';

  @override
  String get notification_windowTitle => 'Spisevinduet lukkes ⏰';

  @override
  String get notification_windowBody =>
      'Spisevinduet ditt lukkes om 30 minutter.';

  @override
  String notification_streakTitle(int days) {
    return '$days dager på rad! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Du gjør det kjempebra! Fortsett slik i dag.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Faste pågår – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Gjenstår: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Faste startet – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Mål: $hours timer';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get explore_guide => 'Fasteguide';

  @override
  String get explore_guideDesc => 'Alt du trenger å vite om periodisk faste';

  @override
  String get explore_circleDesc =>
      'Del stille støtte med den private gruppen din.';

  @override
  String get explore_faq => 'Ofte stilte spørsmål';

  @override
  String get explore_education =>
      'Dette innholdet er kun til generell informasjon og er ikke en medisinsk diagnose eller behandlingsråd.';

  @override
  String get explore_safety => 'Helse og sikkerhet';

  @override
  String get explore_safetyDesc =>
      'Hvis du har en sykdom, tar faste medisiner, har bekymringsfulle symptomer, er gravid eller ammer, bør du rådføre deg med kvalifisert helsepersonell før du faster. Stopp hvis du føler deg uvel.';

  @override
  String get explore_sources => 'Kilder';

  @override
  String get explore_sourcesDesc =>
      'Innholdet er forenklet fra de offentlige helsekildene nedenfor.';

  @override
  String get explore_sourceError => 'Kilden kunne ikke åpnes';

  @override
  String get explore_rules => 'Viktige regler';

  @override
  String get explore_rule1 => 'Ikke innta kaloriholdig mat under fasten';

  @override
  String get explore_rule2 => 'Drikk rikelig med vann og væske';

  @override
  String get explore_rule3 => 'Spis balansert i spisevinduet';

  @override
  String get explore_rule4 => 'Stopp fasten hvis du føler deg uvel';

  @override
  String get explore_rule5 => 'Gravide eller ammende bør ikke faste';

  @override
  String get explore_rule6 =>
      'Rådfør deg med legen hvis du har kroniske sykdommer';

  @override
  String get tip_water => 'Hold væskebalansen';

  @override
  String get tip_waterDesc =>
      'Drikk vann når du er tørst, og få i deg væske til måltidene. Behovet kan variere med helse, vær og aktivitet.';

  @override
  String get tip_food => 'Spis riktig';

  @override
  String get tip_foodDesc =>
      'Velg proteinrike og fiberrike matvarer samt sunt fett i spisevinduene. Unngå bearbeidet mat.';

  @override
  String get tip_sleep => 'Sov godt';

  @override
  String get tip_sleepDesc =>
      'Regelmessig og tilstrekkelig søvn støtter generell velvære. Planlegg fasten slik at den ikke forstyrrer søvnen.';

  @override
  String get tip_exercise => 'Lett trening';

  @override
  String get tip_exerciseDesc =>
      'Du kan gå rolige turer eller gjøre yoga under fasten. Unngå hard trening, særlig de første ukene mens kroppen tilpasser seg.';

  @override
  String get tip_drinks => 'Tillatte drikker';

  @override
  String get tip_drinksDesc =>
      'Under fasten kan du drikke vann, ren te og svart kaffe uten sukker eller melk. Disse drikkene bryter ikke fasten.';

  @override
  String get faq_drinks => 'Hva kan jeg drikke under fasten?';

  @override
  String get faq_drinksAnswer =>
      'Du kan drikke vann, ren te og svart kaffe uten sukker eller melk. Kaloriholdige drikker bryter fasten.';

  @override
  String get faq_plan => 'Hvilken fasteplan bør jeg velge?';

  @override
  String get faq_planAnswer =>
      'Hvis du er ny, begynn med 12:12 eller 14:10. Har du erfaring, kan du prøve 16:8 eller 18:6. 20:4 og OMAD er for viderekomne.';

  @override
  String get faq_exercise => 'Kan jeg trene under fasten?';

  @override
  String get faq_exerciseAnswer =>
      'Ja, men unngå intensive økter. Lett kondisjonstrening, gåturer og yoga er ideelt. Legg styrketreningen nær spisevinduet.';

  @override
  String get faq_weight => 'Hjelper faste med vektnedgang?';

  @override
  String get faq_weightAnswer =>
      'For noen kan et begrenset spisevindu redusere det totale energiinntaket. Resultatene varierer, og langtidseffektene undersøkes fortsatt.';

  @override
  String get plan_12_desc => 'Nybegynnernivå';

  @override
  String get plan_12_detail =>
      'Ideell for nybegynnere. Fast i 12 timer, inkludert sovetiden.';

  @override
  String get plan_16_desc => 'Mest populære plan';

  @override
  String get plan_16_detail =>
      'Den vanligste planen for periodisk faste: 16 timers faste og et spisevindu på 8 timer, vanligvis fra lunsj til middag.';

  @override
  String get plan_18_desc => 'Mellomnivå';

  @override
  String get plan_18_detail =>
      '18 timers faste og et spisevindu på 6 timer. Lengre fettforbrenning.';

  @override
  String get plan_20_desc => 'Avansert nivå';

  @override
  String get plan_20_detail =>
      '20 timers faste og et spisevindu på 4 timer. Ideell for å nå ketose og autofagi.';

  @override
  String get plan_omad_desc => 'Ett måltid om dagen';

  @override
  String get plan_omad_detail =>
      'Ett måltid om dagen: 23 timers faste og et spisevindu på 1 time. Ekspertnivå.';

  @override
  String get plan_52_desc => '2 dager i uken';

  @override
  String get plan_52_detail =>
      'Spis normalt i 5 dager, og begrens deg til rundt 500 kalorier i 2 dager. En alternativ tilnærming.';

  @override
  String get plan_ese_desc => '24 timers faste';

  @override
  String get plan_ese_detail =>
      'Fast i 24 timer 1–2 ganger i uken. For viderekomne.';

  @override
  String get plan_warrior_desc => 'Krigerdiett';

  @override
  String get plan_warrior_detail =>
      'Spis lett på dagtid, og ta hovedmåltidet i et fire timers spisevindu om kvelden.';

  @override
  String get award_first_title => 'Første steg';

  @override
  String get award_first_desc => 'Fullfør din første faste';

  @override
  String get award_rhythm3_title => 'Tredagersrytme';

  @override
  String get award_rhythm3_desc => 'Hold rytmen i tre dager';

  @override
  String get award_hours24_title => '24 timer';

  @override
  String get award_hours24_desc => 'Fast i totalt 24 timer';

  @override
  String get award_week_title => 'En ukes rytme';

  @override
  String get award_week_desc => 'Bygg en rekke på sju dager';

  @override
  String get award_fasts10_title => '10 faster';

  @override
  String get award_fasts10_desc => 'Fullfør ti faster';

  @override
  String get award_hours100_title => '100 timer';

  @override
  String get award_hours100_desc => 'Nå 100 timer totalt';

  @override
  String get award_rhythm30_title => '30-dagersrytme';

  @override
  String get award_rhythm30_desc => 'Bygg en rekke på tretti dager';

  @override
  String get award_fasts50_title => '50 faster';

  @override
  String get award_fasts50_desc => 'Fullfør femti faster';

  @override
  String get award_hours500_title => '500 timer';

  @override
  String get award_hours500_desc => 'Nå 500 timer totalt';

  @override
  String get award_fasts100_title => '100 faster';

  @override
  String get award_fasts100_desc => 'Fullfør hundre faster';

  @override
  String get award_rhythm90_title => '90-dagersrytme';

  @override
  String get award_rhythm90_desc => 'Bygg en rekke på nitti dager';

  @override
  String get award_year_title => 'Ett års reise';

  @override
  String get award_year_desc => 'Nå en rytme på 365 dager';

  @override
  String get awards_loadError => 'Fremdriften kunne ikke lastes inn';

  @override
  String get awards_journeyComplete => 'Reisen er fullført';

  @override
  String get awards_nextGoal => 'Neste mål';

  @override
  String get awards_allYours => 'Alle prestasjonene er dine';

  @override
  String get awards_dayStreak => 'dager på rad';

  @override
  String get awards_fasts => 'faster';

  @override
  String get awards_total => 'totalt';

  @override
  String get awards_stageStart => 'Start';

  @override
  String get awards_stageRhythm => 'Rytme';

  @override
  String get awards_stageEndurance => 'Utholdenhet';

  @override
  String get awards_stageMastery => 'Mestring';

  @override
  String get awards_completed => 'Fullført';

  @override
  String awards_fastsRemaining(int count) {
    return '$count faster igjen';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count dager igjen';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count timer igjen';
  }

  @override
  String get common_retry => 'Prøv igjen';

  @override
  String get game_title => 'Fremdriftssenter';

  @override
  String get game_quests => 'Dagens oppdrag';

  @override
  String get game_questsDesc => 'Små steg, en bærekraftig rytme.';

  @override
  String get game_season => 'Sesong med 30 steg';

  @override
  String get game_seasonDesc => 'Et samlemerke for hvert femte steg.';

  @override
  String get game_badges => 'Merkesamling';

  @override
  String game_shields(int count) {
    return '$count rytmeskjold';
  }

  @override
  String get game_shieldsDesc =>
      'Du får ett for hver sju fullføringer. En utelatt dag sletter aldri fremdriften.';

  @override
  String get game_league => 'Privat ukesliga';

  @override
  String game_leagueDesc(int percent) {
    return 'Rytmepoengsummen din er i $percent. persentil i en privat lokal modell. Vekt og ekstrem faste blir aldri rangert.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Nivå $level, $xp erfaringspoeng';
  }

  @override
  String get game_explorer => 'Rytmeutforsker';

  @override
  String get game_streak => 'Rekke';

  @override
  String get game_targets => 'Mål';

  @override
  String get game_best => 'Beste';

  @override
  String get quest_rhythm => 'Bygg dagens rytme';

  @override
  String get quest_hydrate => 'Nå halvparten av vannmålet';

  @override
  String get quest_steady => 'Beskytt rekken din';

  @override
  String get badge_first_title => 'Første steg';

  @override
  String get badge_first_desc => 'Registrer din første faste';

  @override
  String get badge_rhythm7_title => 'Rytmeholder';

  @override
  String get badge_rhythm7_desc => 'Nå en rekke på 7 dager';

  @override
  String get badge_rhythm3_title => 'Tredagersrytme';

  @override
  String get badge_rhythm3_desc => 'Nå en rekke på 3 dager';

  @override
  String get badge_target1_title => 'Første mål';

  @override
  String get badge_target1_desc => 'Fullfør din første målfaste';

  @override
  String get badge_target3_title => 'Tre steg';

  @override
  String get badge_target3_desc => 'Fullfør 3 mål';

  @override
  String get badge_water_title => 'I balanse';

  @override
  String get badge_water_desc => 'Nå dagens vannmål';

  @override
  String get badge_support_title => 'Selvbevisst';

  @override
  String get badge_support_desc => 'Bruk støttemodus';

  @override
  String get badge_hours10_title => '10 timer';

  @override
  String get badge_hours10_desc => 'Registrer 10 timer totalt';

  @override
  String get badge_target10_title => 'Ti sterke';

  @override
  String get badge_target10_desc => 'Fullfør 10 mål';

  @override
  String get badge_target20_title => 'Tjue mål';

  @override
  String get badge_target20_desc => 'Fullfør 20 mål';

  @override
  String get badge_fast16_title => '16 timer';

  @override
  String get badge_fast16_desc => 'Nå 16 timer i én faste';

  @override
  String get badge_hours50_title => '50 timer';

  @override
  String get badge_hours50_desc => 'Registrer 50 timer totalt';

  @override
  String get badge_hours100_title => 'Hundre timer';

  @override
  String get badge_hours100_desc => 'Registrer 100 timer totalt';

  @override
  String get badge_target30_title => 'Tretti mål';

  @override
  String get badge_target30_desc => 'Fullfør 30 mål';

  @override
  String get badge_rhythm30_title => '30-dagersrytme';

  @override
  String get badge_rhythm30_desc => 'Nå en rekke på 30 dager';

  @override
  String get paywall_restoreSuccess => 'Kjøpene er gjenopprettet!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Fasten er $percent prosent fullført';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour t';
  }

  @override
  String get paywall_lifetime => 'Livstid';

  @override
  String get paywall_once => 'engangsbeløp';

  @override
  String get paywall_processing => 'Behandler…';

  @override
  String get paywall_continue => 'Fortsett';

  @override
  String get paywall_productsUnavailable =>
      'Kjøp er ikke tilgjengelige akkurat nå. Prøv igjen senere.';

  @override
  String get paywall_purchaseFailed => 'Kjøpet kunne ikke fullføres.';

  @override
  String get paywall_nothingToRestore => 'Fant ingen tidligere kjøp.';

  @override
  String get paywall_restoreFailed => 'Kjøpene kunne ikke gjenopprettes.';

  @override
  String get paywall_terms => 'Vilkår for bruk';

  @override
  String get permission_notificationDesc =>
      'Fastepåminnelser, faseoppdateringer og fullføringsvarsler';

  @override
  String get profile_privacyChoices => 'Personvernvalg';

  @override
  String get paywall_autoRenewInfo =>
      'Abonnementer fornyes automatisk med mindre de sies opp minst 24 timer før perioden utløper. Administrer eller si opp når som helst i App Store-innstillingene.';

  @override
  String paywall_perMonth(String price) {
    return '$price / måned';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Spar $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days dagers gratis prøveperiode';
  }

  @override
  String get paywall_startFreeTrial => 'Start gratis prøveperiode';

  @override
  String get paywall_retry => 'Prøv igjen';

  @override
  String get paywall_alreadyOwned =>
      'Du har allerede dette abonnementet. Trykk på Gjenopprett kjøp.';

  @override
  String get paywall_storeUnavailable =>
      'Kan ikke nå butikken akkurat nå. Kontroller tilkoblingen og prøv igjen.';

  @override
  String get paywall_secureNote =>
      'Si opp når som helst. Betalingen belastes butikkontoen din.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Abonnementer fornyes automatisk med mindre de sies opp minst 24 timer før perioden utløper. Administrer eller si opp under Google Play > Abonnementer.';

  @override
  String get paywall_allPlansDesc =>
      'Låser opp 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat og Warrior';

  @override
  String get paywall_noAdsDesc => 'Banner- og fullskjermreklame slås helt av';

  @override
  String get foodScan_title => 'KI-matskanning';

  @override
  String get foodScan_scanCta => 'Skann måltid';

  @override
  String get foodScan_scanCtaDesc =>
      'Ta bilde av tallerkenen og få kalorier og makronæringsstoffer';

  @override
  String get foodScan_introTitle => 'Ta bilde av tallerkenen';

  @override
  String get foodScan_introDesc =>
      'KI leser bildet og anslår kalorier, protein, karbohydrater og fett.';

  @override
  String get foodScan_tipLight => 'Godt og jevnt lys gir et bedre anslag';

  @override
  String get foodScan_tipFrame => 'Pass på at hele tallerkenen er med i bildet';

  @override
  String get foodScan_tipScale =>
      'Ta med bestikk eller en hånd, slik at porsjonsstørrelsen kan anslås';

  @override
  String get foodScan_takePhoto => 'Ta bilde';

  @override
  String get foodScan_chooseFromGallery => 'Velg fra galleri';

  @override
  String foodScan_scansLeft(int count) {
    return '$count skanninger igjen i dag';
  }

  @override
  String get foodScan_quotaReached =>
      'Du har brukt dagens skanninger. Prøv igjen i morgen.';

  @override
  String get foodScan_privacyNote =>
      'Bildet sendes til Googles Gemini API for analyse og lagres ikke på serverne våre.';

  @override
  String get foodScan_consentTitle => 'Sende bilder til Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'For å anslå kalorier og makronæringsstoffer sendes hvert måltidsbilde du tar eller velger, til Googles KI-tjeneste Gemini. Bildet brukes bare til denne analysen og lagres ikke på serverne våre.';

  @override
  String get foodScan_consentAgree => 'Godta og fortsett';

  @override
  String get foodScan_analyzing => 'Analyserer måltidet…';

  @override
  String get foodScan_analyzingHint => 'Dette tar vanligvis noen sekunder';

  @override
  String get foodScan_detectedItems => 'Gjenkjente matvarer';

  @override
  String get foodScan_disclaimer =>
      'KI-anslag er omtrentlige. Trykk på en matvare for å rette den.';

  @override
  String get foodScan_lowConfidence =>
      'Modellen er usikker på dette bildet. Kontroller tallene før du lagrer.';

  @override
  String get foodScan_save => 'Legg til i måltider';

  @override
  String get foodScan_retake => 'Nytt bilde';

  @override
  String get foodScan_retry => 'Prøv igjen';

  @override
  String get foodScan_editItem => 'Rediger matvare';

  @override
  String get foodScan_portion => 'Porsjon';

  @override
  String get foodScan_saveEdit => 'Lagre';

  @override
  String get foodScan_premiumTitle => 'En Premium-funksjon';

  @override
  String get foodScan_premiumDesc =>
      'Kalorianalyse fra bilder er inkludert i Premium.';

  @override
  String get foodScan_upgrade => 'Se Premium';

  @override
  String get foodScan_errorNetwork =>
      'Ingen forbindelse. Kontroller internett og prøv igjen.';

  @override
  String get foodScan_errorRateLimited =>
      'Det er for mange skanninger akkurat nå. Prøv igjen om noen minutter.';

  @override
  String get foodScan_errorUnavailable =>
      'Bildeanalyse er ikke tilgjengelig akkurat nå.';

  @override
  String get foodScan_errorServer =>
      'Analysetjenesten har problemer. Prøv igjen snart.';

  @override
  String get foodScan_errorNoFood =>
      'Fant ingen mat i dette bildet. Prøv et tydeligere bilde av tallerkenen.';

  @override
  String get foodScan_errorUnreadable =>
      'Dette bildet kunne ikke analyseres. Prøv et annet.';

  @override
  String get paywall_aiFoodScan => 'KI-matskanning';

  @override
  String get paywall_aiFoodScanDesc =>
      'Ta bilde av et måltid og registrer kalorier og makronæringsstoffer på få sekunder';
}
