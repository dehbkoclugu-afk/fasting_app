// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Godmorgen';

  @override
  String get greeting_afternoon => 'God eftermiddag';

  @override
  String get greeting_evening => 'Godaften';

  @override
  String get tab_timer => 'Hjem';

  @override
  String get tab_explore => 'Udforsk';

  @override
  String get tab_stats => 'Rapport';

  @override
  String get tab_meals => 'Måltider';

  @override
  String get tab_achievements => 'Præmier';

  @override
  String get tab_profile => 'Konto';

  @override
  String get timer_fasting => 'Fastetid';

  @override
  String get timer_remaining => 'Resterende';

  @override
  String get timer_elapsed => 'Forløbet';

  @override
  String get timer_start => 'Start';

  @override
  String get timer_stop => 'Stop';

  @override
  String get timer_completed => 'Tillykke!';

  @override
  String get timer_completedMessage => 'Du har gennemført din faste!';

  @override
  String get timer_selectPlan => 'Vælg fasteplan';

  @override
  String get timer_stopConfirm =>
      'Er du sikker på, at du vil afslutte fasten før tid?';

  @override
  String get timer_stopTitle => 'Afslut faste';

  @override
  String get timer_cancel => 'Annuller';

  @override
  String get timer_confirmStop => 'Ja, afslut';

  @override
  String get phase_anabolic => 'Anabolsk';

  @override
  String get phase_anabolicDesc => 'Fordøjelsen er i gang';

  @override
  String get phase_catabolic => 'Katabolsk';

  @override
  String get phase_catabolicDesc => 'Energiomstilling';

  @override
  String get phase_fatBurning => 'Fedtforbrænding';

  @override
  String get phase_fatBurningDesc => 'Fedtforbrændingen er begyndt';

  @override
  String get phase_ketosis => 'Ketose';

  @override
  String get phase_ketosisDesc => 'Ketonproduktionen er aktiv';

  @override
  String get phase_autophagy => 'Autofagi';

  @override
  String get phase_autophagyDesc => 'Cellefornyelse';

  @override
  String get stats_title => 'Statistik';

  @override
  String get stats_week => 'Uge';

  @override
  String get stats_month => 'Måned';

  @override
  String get stats_year => 'År';

  @override
  String get stats_totalFasts => 'Faster i alt';

  @override
  String get stats_average => 'Gennemsnit';

  @override
  String get stats_fastDuration => 'fastens varighed';

  @override
  String get stats_streak => 'Serie';

  @override
  String get stats_daysConsecutive => 'dage i træk';

  @override
  String get stats_success => 'Succes';

  @override
  String get stats_completion => 'gennemført';

  @override
  String get stats_weeklyFasting => 'Ugentlig faste';

  @override
  String get stats_monthlyView => 'Månedsoversigt';

  @override
  String get stats_weightChange => 'Vægtændring';

  @override
  String get heatmap_none => 'Ingen';

  @override
  String get heatmap_low => 'Lav';

  @override
  String get heatmap_good => 'God';

  @override
  String get heatmap_full => 'Fuld';

  @override
  String get meals_title => 'Måltidsplanlægger';

  @override
  String get meals_eatingWindow => 'Spisevindue';

  @override
  String get meals_windowOpen => 'Åbent';

  @override
  String get meals_windowFasting => 'Faste';

  @override
  String get meals_calories => 'Kalorier';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Kulhydrater';

  @override
  String get meals_fat => 'Fedt';

  @override
  String get meals_todayMeals => 'Dagens måltider';

  @override
  String get meals_noMeals => 'Ingen måltider tilføjet endnu';

  @override
  String get meals_breakfastSuggestions => 'Forslag til at bryde fasten';

  @override
  String get meals_addMeal => 'Tilføj måltid';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Bruger';

  @override
  String profile_planActive(String plan) {
    return 'Planen $plan er aktiv';
  }

  @override
  String get profile_upgradePremium => 'Opgrader til Premium';

  @override
  String get profile_premiumDesc => 'Alle fasteplaner uden reklamer';

  @override
  String get profile_bodyMetrics => 'Kropsmålinger';

  @override
  String get profile_height => 'Højde';

  @override
  String get profile_weight => 'Vægt';

  @override
  String get profile_targetWeight => 'Målvægt';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Indstillinger';

  @override
  String get profile_notifications => 'Notifikationer';

  @override
  String get profile_darkTheme => 'Mørkt tema';

  @override
  String get profile_waterReminder => 'Påmindelse om vand';

  @override
  String get profile_phaseNotifications => 'Fasenotifikationer';

  @override
  String get profile_language => 'Sprog';

  @override
  String get profile_about => 'Om';

  @override
  String get profile_rateApp => 'Bedøm appen';

  @override
  String get profile_share => 'Del';

  @override
  String get profile_privacyPolicy => 'Privatlivspolitik';

  @override
  String get profile_version => 'Version';

  @override
  String get onboarding_welcome => 'Velkommen';

  @override
  String get onboarding_welcomeDesc =>
      'Tag styringen over din rejse med\nperiodisk faste';

  @override
  String get onboarding_featureTimer => 'Smart fastetimer';

  @override
  String get onboarding_featureStats => 'Detaljeret statistik og grafer';

  @override
  String get onboarding_featureMeals => 'Måltidsplanlægger og opskriftsforslag';

  @override
  String get onboarding_getStarted => 'Kom i gang';

  @override
  String get onboarding_selectGoal => 'Hvad er dit mål?';

  @override
  String get onboarding_selectGoalDesc => 'Du kan vælge flere';

  @override
  String get onboarding_goalWeight => 'Tab dig';

  @override
  String get onboarding_goalWeightDesc => 'Sundt vægttab';

  @override
  String get onboarding_goalHealth => 'Forbedr dit helbred';

  @override
  String get onboarding_goalHealthDesc => 'Generelt helbred og immunforsvar';

  @override
  String get onboarding_goalEnergy => 'Mere energi';

  @override
  String get onboarding_goalEnergyDesc => 'Energi hele dagen';

  @override
  String get onboarding_goalMental => 'Mental klarhed';

  @override
  String get onboarding_goalMentalDesc => 'Fokus og klarhed';

  @override
  String get onboarding_goalLongevity => 'Et langt liv';

  @override
  String get onboarding_goalLongevityDesc => 'Cellefornyelse og sund aldring';

  @override
  String get onboarding_goalDiscipline => 'Disciplin';

  @override
  String get onboarding_goalDisciplineDesc => 'Opbyg selvdisciplin';

  @override
  String get onboarding_selectPlan => 'Vælg din plan';

  @override
  String get onboarding_selectPlanDesc =>
      'Vælg den fasteplan, der passer bedst til dig';

  @override
  String get onboarding_bodyInfo => 'Indtast dine oplysninger';

  @override
  String get onboarding_bodyInfoDesc => 'Til personlige anbefalinger';

  @override
  String get onboarding_gender => 'Køn';

  @override
  String get onboarding_male => 'Mand';

  @override
  String get onboarding_female => 'Kvinde';

  @override
  String get onboarding_age => 'Alder';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Disse oplysninger gemmes kun på din enhed og bruges til kalorieberegninger.';

  @override
  String get onboarding_permissions => 'Sidste trin';

  @override
  String get onboarding_permissionsDesc =>
      'Aktivér tilladelser for at få den bedste oplevelse';

  @override
  String get onboarding_next => 'Fortsæt';

  @override
  String get onboarding_start => 'Lad os komme i gang!';

  @override
  String get onboarding_skipForNow => 'Konfigurer senere';

  @override
  String get waterAdded => '250 ml vand tilføjet';

  @override
  String get languageSelect => 'Vælg sprog';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Opgrader til Premium';

  @override
  String get paywall_subtitle =>
      'Lås op for alle fasteplaner, og fjern reklamer';

  @override
  String get paywall_allPlans => 'Alle fasteplaner';

  @override
  String get paywall_advancedStats => 'Avanceret statistik';

  @override
  String get paywall_mealPlanner => 'Måltidsplanlægger';

  @override
  String get paywall_themes => 'Tilpas tema';

  @override
  String get paywall_noAds => 'Ingen reklamer';

  @override
  String get paywall_weekly => 'Ugentligt';

  @override
  String get paywall_monthly => 'Månedligt';

  @override
  String get paywall_yearly => 'Årligt';

  @override
  String get paywall_bestValue => 'Bedste køb';

  @override
  String get paywall_freeTrial => 'Gratis prøveperiode (3 dage)';

  @override
  String get paywall_restore => 'Gendan køb';

  @override
  String get paywall_premiumActive => 'Premium er aktivt!';

  @override
  String get paywall_premiumActiveDesc =>
      'Alle fasteplaner er låst op, og reklamer er slået fra';

  @override
  String get water_title => 'Vandindtag';

  @override
  String get water_addWater => 'Tilføj vand';

  @override
  String get water_goal => 'Mål';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Annuller';

  @override
  String get common_save => 'Gem';

  @override
  String get common_delete => 'Slet';

  @override
  String get common_hours => 'timer';

  @override
  String get common_minutes => 'minutter';

  @override
  String get common_days => 'dage';

  @override
  String get common_enable => 'Aktivér';

  @override
  String get streakCard_currentStreak => 'Nuværende serie';

  @override
  String get streakCard_longestStreak => 'Længste serie';

  @override
  String get streakCard_totalSessions => 'Faster i alt';

  @override
  String get meals_mealType => 'Måltidstype';

  @override
  String get meals_breakfast => 'Morgenmad';

  @override
  String get meals_lunch => 'Frokost';

  @override
  String get meals_dinner => 'Aftensmad';

  @override
  String get meals_snack => 'Mellemmåltid';

  @override
  String get meals_carbohydrate => 'Kulhydrat';

  @override
  String get meals_add => 'Tilføj';

  @override
  String get meals_mealName => 'Måltidets navn';

  @override
  String get bodyMetrics_title => 'Kropsmålinger';

  @override
  String get bodyMetrics_weight => 'Vægt';

  @override
  String get bodyMetrics_target => 'Mål';

  @override
  String get bodyMetrics_save => 'Gem';

  @override
  String get bodyMetrics_history => 'Historik';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Ingen data endnu';

  @override
  String get meals_quickAdd => 'Hurtig tilføjelse';

  @override
  String get meals_manualEntry => 'Manuel indtastning';

  @override
  String meals_added(String name) {
    return '$name er tilføjet';
  }

  @override
  String get meals_nameCalorieRequired => 'Navn og kalorier er påkrævet';

  @override
  String get bodyMetrics_addWeight => 'Tilføj vægt';

  @override
  String get bodyMetrics_hintWeight => 'f.eks. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Indtast en gyldig vægt';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg gemt';
  }

  @override
  String get completion_duration => 'Varighed';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Seneste fase';

  @override
  String get completion_earlyTitle => 'Fasten er afsluttet';

  @override
  String get completion_earlyMessage =>
      'Dagens tid blev gemt. Din serie og dine præstationer blev ikke ændret, fordi målet ikke blev nået.';

  @override
  String get timer_remainingTime => 'Resterende tid';

  @override
  String get timer_ready => 'Klar til at starte';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Start i dag!';

  @override
  String get streak_goodStart => 'God start!';

  @override
  String get streak_goingGreat => 'Det går strålende!';

  @override
  String get streak_superb => 'Fantastisk!';

  @override
  String get streak_legendary => 'Legendarisk!';

  @override
  String get streak_incredible => 'Utroligt!';

  @override
  String get weight_noRecord =>
      'Ingen vægtregistreringer endnu\nTilføj dem under Profil > Kropsmålinger';

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
  String get month_mar => 'Marts';

  @override
  String get month_apr => 'April';

  @override
  String get month_may => 'Maj';

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
  String get month_dec => 'December';

  @override
  String meals_fastingWindow(String hours) {
    return 'Faste ($hours t)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Spisning ($hours t)';
  }

  @override
  String get recipe_oatSmoothie => 'Havresmoothie';

  @override
  String get recipe_avocadoToast => 'Avocadomad';

  @override
  String get recipe_yogurtBowl => 'Yoghurtskål';

  @override
  String get elapsed_time => 'Forløbet tid';

  @override
  String get fast_ends_on => 'Din faste slutter kl.';

  @override
  String get end_fasting => 'Afslut faste';

  @override
  String get start_fasting => 'Start faste';

  @override
  String get water_tracker => 'Vandmåler';

  @override
  String get weight_tracker => 'Vægtmåler';

  @override
  String get drink => 'Drik';

  @override
  String get log_weight => 'Registrer vægt';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Tabt vægt';

  @override
  String get current_weight => 'Nuværende vægt';

  @override
  String get goal_weight => 'Målvægt';

  @override
  String get daily_goal => 'Dagligt mål';

  @override
  String completed_percent(String percent) {
    return '$percent% gennemført';
  }

  @override
  String get explore => 'Udforsk';

  @override
  String get achievements => 'Præstationer';

  @override
  String get profile_theme => 'Udseende';

  @override
  String get theme_select => 'Vælg udseende';

  @override
  String get theme_system => 'Systemstandard';

  @override
  String get theme_light => 'Lyst';

  @override
  String get theme_dark => 'Mørkt';

  @override
  String get language_system => 'Systemsprog';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Afslutningslyd';

  @override
  String get profile_calmGamification => 'Rolig gamificering';

  @override
  String get profile_calmGamificationDesc =>
      'Mindsker presset fra liga og sæson';

  @override
  String get profile_editName => 'Rediger dit navn';

  @override
  String get profile_name => 'Navn';

  @override
  String get circle_title => 'Fastecirkel';

  @override
  String get circle_you => 'Dig';

  @override
  String get circle_tagline => 'Sammen, uden pres.';

  @override
  String get circle_privacy =>
      'Vægt og private målinger forbliver skjulte. Kun fremskridt og støtte er synlige.';

  @override
  String circle_sendSupport(int count) {
    return 'Send støtte · $count';
  }

  @override
  String get circle_inviteCopied => 'Invitationskoden er kopieret';

  @override
  String get circle_createInvite => 'Opret privat invitation';

  @override
  String get crisis_nameTitle => 'Sæt først ord på, hvad der sker';

  @override
  String get crisis_nameDesc => 'Det kan være sult, vane eller følelser.';

  @override
  String get crisis_waterTitle => 'Drik et glas vand';

  @override
  String get crisis_waterDesc => 'Tag derefter tre rolige vejrtrækninger.';

  @override
  String get crisis_delayTitle => 'Udskyd beslutningen i 10 minutter';

  @override
  String get crisis_delayDesc =>
      'Hvis du får det dårligt, er det ikke et nederlag at afslutte fasten.';

  @override
  String get crisis_hunger => 'Sult';

  @override
  String get crisis_habit => 'Vane';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Giv det 10 minutter';

  @override
  String get stats_storyEmpty =>
      'Din første faste bliver begyndelsen på din personlige historie.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Du fastede $sessions gange i denne periode, holdt rytmen i $hours timer og nåede en gennemførelsesrate på $rate%.';
  }

  @override
  String get stats_storyTitle => 'Historien om din rytme';

  @override
  String get home_todayRhythm => 'Dagens rytme';

  @override
  String get home_finalHourSupport => 'Støtte i den sidste time';

  @override
  String get home_needSupport => 'Jeg har brug for lidt støtte';

  @override
  String get home_todaySummary => 'Dagen i korte træk';

  @override
  String get home_dayStreak => 'dage i træk';

  @override
  String home_weightGoal(String weight) {
    return 'mål $weight kg';
  }

  @override
  String get weather_steady => 'Din rytme er stabil';

  @override
  String get weather_gentle => 'En rolig dag';

  @override
  String get weather_water => 'Et glas vand kan hjælpe.';

  @override
  String get weather_listen => 'Du er nået langt; lyt til din krop.';

  @override
  String get weather_onPlan => 'Dagens tempo passer til din plan.';

  @override
  String get weather_challenging =>
      'Denne time har tidligere været udfordrende; støttetilstanden er klar.';

  @override
  String get replay_copied => 'Fasteresumé kopieret';

  @override
  String get replay_button => 'Resumé';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Jeg gennemførte min $plan-faste på $hours t $minutes min · $phase';
  }

  @override
  String get journey_label => 'Metabolisk rejse';

  @override
  String get journey_now => 'Nu';

  @override
  String journey_next(String time, String phase) {
    return '$time til $phase';
  }

  @override
  String get phase_estimateShort =>
      'Tidspunkterne for faserne er generelle skøn, ikke medicinske målinger.';

  @override
  String phase_hours(int start, int end) {
    return 'Timer $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Dette tidspunkt er et generelt skøn. Metaboliske reaktioner kan variere fra person til person.';

  @override
  String get bmi_underweight => 'Undervægt';

  @override
  String get bmi_normal => 'Normalvægt';

  @override
  String get bmi_overweight => 'Overvægt';

  @override
  String get bmi_obese => 'Svær overvægt';

  @override
  String get notification_halfwayTitle => 'Halvvejs! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Du har gennemført halvdelen af din $plan-faste. Fortsæt sådan!';
  }

  @override
  String get notification_phaseCatabolic => 'Katabolsk fase nået 📉';

  @override
  String get notification_phaseFatBurning => 'Fedtforbrændingen er begyndt! 🔥';

  @override
  String get notification_phaseKetosis => 'Du er i ketose ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagi er aktiv! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Du har gennemført din $plan-faste! Dit spisevindue er åbent.';
  }

  @override
  String get notification_waterTitle => 'Drik vand 💧';

  @override
  String get notification_waterBody =>
      'Husk at drikke rigeligt med vand under fasten!';

  @override
  String get notification_windowTitle => 'Spisevinduet lukker ⏰';

  @override
  String get notification_windowBody =>
      'Dit spisevindue lukker om 30 minutter.';

  @override
  String notification_streakTitle(int days) {
    return '$days dage i træk! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Det går rigtig godt! Fortsæt sådan i dag.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Faste i gang – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Resterende: $time';
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
  String get explore_guideDesc =>
      'Alt, hvad du behøver at vide om periodisk faste';

  @override
  String get explore_circleDesc => 'Del stille støtte med din private gruppe.';

  @override
  String get explore_faq => 'Ofte stillede spørgsmål';

  @override
  String get explore_education =>
      'Dette indhold er kun til generel oplysning og er ikke en medicinsk diagnose eller behandlingsvejledning.';

  @override
  String get explore_safety => 'Sundhed og sikkerhed';

  @override
  String get explore_safetyDesc =>
      'Hvis du har en sygdom, tager fast medicin, har bekymrende symptomer, er gravid eller ammer, skal du tale med en kvalificeret sundhedsperson, før du faster. Stop, hvis du får det dårligt.';

  @override
  String get explore_sources => 'Kilder';

  @override
  String get explore_sourcesDesc =>
      'Indholdet er forenklet ud fra de offentlige sundhedskilder nedenfor.';

  @override
  String get explore_sourceError => 'Kilden kunne ikke åbnes';

  @override
  String get explore_rules => 'Vigtige regler';

  @override
  String get explore_rule1 => 'Indtag ikke kalorier under fasten';

  @override
  String get explore_rule2 => 'Drik rigeligt med vand og væske';

  @override
  String get explore_rule3 => 'Spis varieret og afbalanceret i dit spisevindue';

  @override
  String get explore_rule4 => 'Stop fasten, hvis du får det dårligt';

  @override
  String get explore_rule5 => 'Gravide og ammende bør ikke faste';

  @override
  String get explore_rule6 => 'Tal med din læge, hvis du har en kronisk sygdom';

  @override
  String get tip_water => 'Hold væskebalancen';

  @override
  String get tip_waterDesc =>
      'Drik vand, når du er tørstig, og få væske til måltiderne. Behovet kan variere med helbred, vejr og aktivitet.';

  @override
  String get tip_food => 'Spis sundt';

  @override
  String get tip_foodDesc =>
      'Vælg proteinrige og fiberrige fødevarer samt sunde fedtstoffer i spisevinduerne. Undgå forarbejdede fødevarer.';

  @override
  String get tip_sleep => 'Sov godt';

  @override
  String get tip_sleepDesc =>
      'Regelmæssig og tilstrækkelig søvn støtter dit generelle velbefindende. Planlæg fasten, så den ikke forstyrrer din søvn.';

  @override
  String get tip_exercise => 'Let motion';

  @override
  String get tip_exerciseDesc =>
      'Du kan gå rolige ture eller dyrke yoga under fasten. Undgå hård træning, især i de første uger, mens kroppen vænner sig til det.';

  @override
  String get tip_drinks => 'Tilladte drikkevarer';

  @override
  String get tip_drinksDesc =>
      'Under fasten kan du drikke vand, ren te og sort kaffe uden sukker eller mælk. Disse drikke bryder ikke fasten.';

  @override
  String get faq_drinks => 'Hvad må jeg drikke under fasten?';

  @override
  String get faq_drinksAnswer =>
      'Du kan drikke vand, ren te og sort kaffe uden sukker eller mælk. Kalorieholdige drikke bryder fasten.';

  @override
  String get faq_plan => 'Hvilken fasteplan skal jeg vælge?';

  @override
  String get faq_planAnswer =>
      'Hvis du er ny, så begynd med 12:12 eller 14:10. Har du erfaring, kan du prøve 16:8 eller 18:6. 20:4 og OMAD er for øvede.';

  @override
  String get faq_exercise => 'Må jeg træne under fasten?';

  @override
  String get faq_exerciseAnswer =>
      'Ja, men undgå intensiv træning. Let konditionstræning, gåture og yoga er ideelt. Læg styrketræning tæt på dit spisevindue.';

  @override
  String get faq_weight => 'Hjælper faste med vægttab?';

  @override
  String get faq_weightAnswer =>
      'For nogle kan et begrænset spisevindue sænke det samlede energiindtag. Resultaterne varierer, og langtidsvirkningerne undersøges stadig.';

  @override
  String get plan_12_desc => 'Begynderniveau';

  @override
  String get plan_12_detail =>
      'Ideel til begyndere. Fast i 12 timer inklusive din sovetid.';

  @override
  String get plan_16_desc => 'Mest populære plan';

  @override
  String get plan_16_detail =>
      'Den mest almindelige plan for periodisk faste: 16 timers faste og et spisevindue på 8 timer, typisk fra frokost til aftensmad.';

  @override
  String get plan_18_desc => 'Mellemniveau';

  @override
  String get plan_18_detail =>
      '18 timers faste og et spisevindue på 6 timer. Længere fedtforbrænding.';

  @override
  String get plan_20_desc => 'Avanceret niveau';

  @override
  String get plan_20_detail =>
      '20 timers faste og et spisevindue på 4 timer. Velegnet til at nå ketose og autofagi.';

  @override
  String get plan_omad_desc => 'Ét måltid om dagen';

  @override
  String get plan_omad_detail =>
      'Ét måltid om dagen: 23 timers faste og et spisevindue på 1 time. Ekspertniveau.';

  @override
  String get plan_52_desc => '2 dage om ugen';

  @override
  String get plan_52_detail =>
      'Spis normalt i 5 dage, og begræns dig til cirka 500 kalorier i 2 dage. En alternativ tilgang.';

  @override
  String get plan_ese_desc => '24 timers faste';

  @override
  String get plan_ese_detail => 'Fast i 24 timer 1–2 gange om ugen. For øvede.';

  @override
  String get plan_warrior_desc => 'Krigerdiet';

  @override
  String get plan_warrior_detail =>
      'Spis let i løbet af dagen (frugt og grønt), og spis dit hovedmåltid i et fire timers vindue om aftenen.';

  @override
  String get award_first_title => 'Første skridt';

  @override
  String get award_first_desc => 'Gennemfør din første faste';

  @override
  String get award_rhythm3_title => 'Tredagesrytme';

  @override
  String get award_rhythm3_desc => 'Hold rytmen i tre dage';

  @override
  String get award_hours24_title => '24 timer';

  @override
  String get award_hours24_desc => 'Fast i alt 24 timer';

  @override
  String get award_week_title => 'En uges rytme';

  @override
  String get award_week_desc => 'Opbyg en serie på syv dage';

  @override
  String get award_fasts10_title => '10 faster';

  @override
  String get award_fasts10_desc => 'Gennemfør ti faster';

  @override
  String get award_hours100_title => '100 timer';

  @override
  String get award_hours100_desc => 'Nå 100 timer i alt';

  @override
  String get award_rhythm30_title => '30-dagesrytme';

  @override
  String get award_rhythm30_desc => 'Opbyg en serie på tredive dage';

  @override
  String get award_fasts50_title => '50 faster';

  @override
  String get award_fasts50_desc => 'Gennemfør halvtreds faster';

  @override
  String get award_hours500_title => '500 timer';

  @override
  String get award_hours500_desc => 'Nå 500 timer i alt';

  @override
  String get award_fasts100_title => '100 faster';

  @override
  String get award_fasts100_desc => 'Gennemfør hundrede faster';

  @override
  String get award_rhythm90_title => '90-dagesrytme';

  @override
  String get award_rhythm90_desc => 'Opbyg en serie på halvfems dage';

  @override
  String get award_year_title => 'Et års rejse';

  @override
  String get award_year_desc => 'Nå en rytme på 365 dage';

  @override
  String get awards_loadError => 'Fremskridtet kunne ikke indlæses';

  @override
  String get awards_journeyComplete => 'Rejsen er fuldført';

  @override
  String get awards_nextGoal => 'Næste mål';

  @override
  String get awards_allYours => 'Alle præstationerne er dine';

  @override
  String get awards_dayStreak => 'dage i træk';

  @override
  String get awards_fasts => 'faster';

  @override
  String get awards_total => 'i alt';

  @override
  String get awards_stageStart => 'Start';

  @override
  String get awards_stageRhythm => 'Rytme';

  @override
  String get awards_stageEndurance => 'Udholdenhed';

  @override
  String get awards_stageMastery => 'Mestring';

  @override
  String get awards_completed => 'Gennemført';

  @override
  String awards_fastsRemaining(int count) {
    return '$count faster tilbage';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count dage tilbage';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count timer tilbage';
  }

  @override
  String get common_retry => 'Prøv igen';

  @override
  String get game_title => 'Fremskridtscenter';

  @override
  String get game_quests => 'Dagens opgaver';

  @override
  String get game_questsDesc => 'Små skridt, en holdbar rytme.';

  @override
  String get game_season => 'Sæson med 30 trin';

  @override
  String get game_seasonDesc => 'Et samlermærke for hvert femte trin.';

  @override
  String get game_badges => 'Mærkesamling';

  @override
  String game_shields(int count) {
    return '$count rytmeskjolde';
  }

  @override
  String get game_shieldsDesc =>
      'Du får ét for hver syv gennemførelser. En sprunget dag sletter aldrig dine fremskridt.';

  @override
  String get game_league => 'Privat ugentlig liga';

  @override
  String game_leagueDesc(int percent) {
    return 'Din rytmescore ligger i $percent. percentil i en privat lokal model. Vægt og ekstrem faste bliver aldrig rangeret.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Niveau $level, $xp erfaringspoint';
  }

  @override
  String get game_explorer => 'Rytmeudforsker';

  @override
  String get game_streak => 'Serie';

  @override
  String get game_targets => 'Mål';

  @override
  String get game_best => 'Bedste';

  @override
  String get quest_rhythm => 'Opbyg dagens rytme';

  @override
  String get quest_hydrate => 'Nå halvdelen af dit vandmål';

  @override
  String get quest_steady => 'Beskyt din serie';

  @override
  String get badge_first_title => 'Første skridt';

  @override
  String get badge_first_desc => 'Registrer din første faste';

  @override
  String get badge_rhythm7_title => 'Rytmeholder';

  @override
  String get badge_rhythm7_desc => 'Nå en serie på 7 dage';

  @override
  String get badge_rhythm3_title => 'Tredagesrytme';

  @override
  String get badge_rhythm3_desc => 'Nå en serie på 3 dage';

  @override
  String get badge_target1_title => 'Første mål';

  @override
  String get badge_target1_desc => 'Gennemfør din første målfaste';

  @override
  String get badge_target3_title => 'Tre skridt';

  @override
  String get badge_target3_desc => 'Gennemfør 3 mål';

  @override
  String get badge_water_title => 'I balance';

  @override
  String get badge_water_desc => 'Nå dagens vandmål';

  @override
  String get badge_support_title => 'Selvbevidst';

  @override
  String get badge_support_desc => 'Brug støttetilstand';

  @override
  String get badge_hours10_title => '10 timer';

  @override
  String get badge_hours10_desc => 'Registrer 10 timer i alt';

  @override
  String get badge_target10_title => 'Ti stærke';

  @override
  String get badge_target10_desc => 'Gennemfør 10 mål';

  @override
  String get badge_target20_title => 'Tyve mål';

  @override
  String get badge_target20_desc => 'Gennemfør 20 mål';

  @override
  String get badge_fast16_title => '16 timer';

  @override
  String get badge_fast16_desc => 'Nå 16 timer i én faste';

  @override
  String get badge_hours50_title => '50 timer';

  @override
  String get badge_hours50_desc => 'Registrer 50 timer i alt';

  @override
  String get badge_hours100_title => 'Hundrede timer';

  @override
  String get badge_hours100_desc => 'Registrer 100 timer i alt';

  @override
  String get badge_target30_title => 'Tredive mål';

  @override
  String get badge_target30_desc => 'Gennemfør 30 mål';

  @override
  String get badge_rhythm30_title => '30-dagesrytme';

  @override
  String get badge_rhythm30_desc => 'Nå en serie på 30 dage';

  @override
  String get paywall_restoreSuccess => 'Købene er gendannet!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Fasten er $percent procent gennemført';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour t';
  }

  @override
  String get paywall_lifetime => 'Livstid';

  @override
  String get paywall_once => 'engangsbeløb';

  @override
  String get paywall_processing => 'Behandler…';

  @override
  String get paywall_continue => 'Fortsæt';

  @override
  String get paywall_productsUnavailable =>
      'Køb er ikke tilgængelige lige nu. Prøv igen senere.';

  @override
  String get paywall_purchaseFailed => 'Købet kunne ikke gennemføres.';

  @override
  String get paywall_nothingToRestore =>
      'Der blev ikke fundet noget tidligere køb.';

  @override
  String get paywall_restoreFailed => 'Købene kunne ikke gendannes.';

  @override
  String get paywall_terms => 'Vilkår for brug';

  @override
  String get permission_notificationDesc =>
      'Fastepåmindelser, faseopdateringer og afslutningsnotifikationer';

  @override
  String get profile_privacyChoices => 'Valg for privatliv';

  @override
  String get paywall_autoRenewInfo =>
      'Abonnementer fornyes automatisk, medmindre de opsiges mindst 24 timer før periodens udløb. Administrer eller opsig når som helst i indstillingerne i App Store.';

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
    return '$days dages gratis prøveperiode';
  }

  @override
  String get paywall_startFreeTrial => 'Start gratis prøveperiode';

  @override
  String get paywall_retry => 'Prøv igen';

  @override
  String get paywall_alreadyOwned =>
      'Du ejer allerede dette abonnement. Tryk på »Gendan køb«.';

  @override
  String get paywall_storeUnavailable =>
      'Der kan ikke oprettes forbindelse til butikken lige nu. Kontrollér forbindelsen, og prøv igen.';

  @override
  String get paywall_secureNote =>
      'Opsig når som helst. Betalingen trækkes fra din butikskonto.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Abonnementer fornyes automatisk, medmindre de opsiges mindst 24 timer før periodens udløb. Administrer eller opsig når som helst under Google Play > Abonnementer.';

  @override
  String get paywall_allPlansDesc =>
      'Låser op for 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat og Warrior';

  @override
  String get paywall_noAdsDesc => 'Banner- og fuldskærmsreklamer slås helt fra';

  @override
  String get foodScan_title => 'AI-madscanning';

  @override
  String get foodScan_scanCta => 'Scan måltid';

  @override
  String get foodScan_scanCtaDesc =>
      'Tag et billede af din tallerken, og få kalorier og makronæringsstoffer';

  @override
  String get foodScan_introTitle => 'Tag et billede af din tallerken';

  @override
  String get foodScan_introDesc =>
      'AI aflæser billedet og anslår kalorier, protein, kulhydrater og fedt.';

  @override
  String get foodScan_tipLight => 'Godt og jævnt lys giver et bedre skøn';

  @override
  String get foodScan_tipFrame =>
      'Sørg for, at hele tallerkenen er med i billedet';

  @override
  String get foodScan_tipScale =>
      'Medtag bestik eller en hånd, så portionsstørrelsen kan vurderes';

  @override
  String get foodScan_takePhoto => 'Tag billede';

  @override
  String get foodScan_chooseFromGallery => 'Vælg fra galleri';

  @override
  String foodScan_scansLeft(int count) {
    return '$count scanninger tilbage i dag';
  }

  @override
  String get foodScan_quotaReached =>
      'Du har brugt dagens scanninger. Prøv igen i morgen.';

  @override
  String get foodScan_privacyNote =>
      'Billedet sendes til Googles Gemini API til analyse og gemmes ikke på vores servere.';

  @override
  String get foodScan_consentTitle => 'Send billeder til Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'For at anslå kalorier og makronæringsstoffer sendes hvert måltidsbillede, du tager eller vælger, til Googles AI-tjeneste Gemini. Billedet bruges kun til denne analyse og gemmes ikke på vores servere.';

  @override
  String get foodScan_consentAgree => 'Accepter og fortsæt';

  @override
  String get foodScan_analyzing => 'Analyserer dit måltid…';

  @override
  String get foodScan_analyzingHint => 'Det tager normalt et par sekunder';

  @override
  String get foodScan_detectedItems => 'Fundne fødevarer';

  @override
  String get foodScan_disclaimer =>
      'AI-skøn er omtrentlige. Tryk på en fødevare for at rette den.';

  @override
  String get foodScan_lowConfidence =>
      'Modellen er usikker på dette billede. Kontrollér tallene, før du gemmer.';

  @override
  String get foodScan_save => 'Føj til måltider';

  @override
  String get foodScan_retake => 'Nyt billede';

  @override
  String get foodScan_retry => 'Prøv igen';

  @override
  String get foodScan_editItem => 'Rediger fødevare';

  @override
  String get foodScan_portion => 'Portion';

  @override
  String get foodScan_saveEdit => 'Gem';

  @override
  String get foodScan_premiumTitle => 'En Premium-funktion';

  @override
  String get foodScan_premiumDesc =>
      'Kalorieanalyse fra billeder er inkluderet i Premium.';

  @override
  String get foodScan_upgrade => 'Se Premium';

  @override
  String get foodScan_errorNetwork =>
      'Ingen forbindelse. Kontrollér internettet, og prøv igen.';

  @override
  String get foodScan_errorRateLimited =>
      'Der er for mange scanninger lige nu. Prøv igen om et par minutter.';

  @override
  String get foodScan_errorUnavailable =>
      'Billedanalyse er ikke tilgængelig lige nu.';

  @override
  String get foodScan_errorServer =>
      'Analysetjenesten har problemer. Prøv igen om lidt.';

  @override
  String get foodScan_errorNoFood =>
      'Der blev ikke fundet mad på dette billede. Prøv et tydeligere billede af tallerkenen.';

  @override
  String get foodScan_errorUnreadable =>
      'Billedet kunne ikke analyseres. Prøv et andet.';

  @override
  String get paywall_aiFoodScan => 'AI-madscanning';

  @override
  String get paywall_aiFoodScanDesc =>
      'Tag et billede af et måltid, og registrer kalorier og makronæringsstoffer på få sekunder';
}
