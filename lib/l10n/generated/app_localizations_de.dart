// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Guten Morgen';

  @override
  String get greeting_afternoon => 'Guten Tag';

  @override
  String get greeting_evening => 'Guten Abend';

  @override
  String get tab_timer => 'Heim';

  @override
  String get tab_explore => 'Erkunden';

  @override
  String get tab_stats => 'Bericht';

  @override
  String get tab_meals => 'Mahlzeiten';

  @override
  String get tab_achievements => 'Auszeichnungen';

  @override
  String get tab_profile => 'Konto';

  @override
  String get timer_fasting => 'Fastenzeit';

  @override
  String get timer_remaining => 'Übrig';

  @override
  String get timer_elapsed => 'Vergangen';

  @override
  String get timer_start => 'Start';

  @override
  String get timer_stop => 'Stoppen';

  @override
  String get timer_completed => 'Glückwunsch!';

  @override
  String get timer_completedMessage => 'Du hast dein Fasten erfolgreich abgeschlossen!';

  @override
  String get timer_selectPlan => 'Wählen Sie Fastenplan';

  @override
  String get timer_stopConfirm => 'Sind Sie sicher, dass Sie das Fasten vorzeitig beenden möchten?';

  @override
  String get timer_stopTitle => 'Schluss schnell';

  @override
  String get timer_cancel => 'Stornieren';

  @override
  String get timer_confirmStop => 'Ja, Ende';

  @override
  String get phase_anabolic => 'Anabol';

  @override
  String get phase_anabolicDesc => 'Verdauung läuft';

  @override
  String get phase_catabolic => 'Katabolisch';

  @override
  String get phase_catabolicDesc => 'Energiewende';

  @override
  String get phase_fatBurning => 'Fettverbrennung';

  @override
  String get phase_fatBurningDesc => 'Die Fettverbrennung begann';

  @override
  String get phase_ketosis => 'Ketose';

  @override
  String get phase_ketosisDesc => 'Ketonproduktion aktiv';

  @override
  String get phase_autophagy => 'Autophagie';

  @override
  String get phase_autophagyDesc => 'Zellerneuerung';

  @override
  String get stats_title => 'Statistiken';

  @override
  String get stats_week => 'Woche';

  @override
  String get stats_month => 'Monat';

  @override
  String get stats_year => 'Jahr';

  @override
  String get stats_totalFasts => 'Gesamtfasten';

  @override
  String get stats_average => 'Durchschnitt';

  @override
  String get stats_fastDuration => 'schnelle Dauer';

  @override
  String get stats_streak => 'Strähne';

  @override
  String get stats_daysConsecutive => 'aufeinanderfolgende Tage';

  @override
  String get stats_success => 'Erfolg';

  @override
  String get stats_completion => 'Fertigstellung';

  @override
  String get stats_weeklyFasting => 'Wöchentliches Fasten';

  @override
  String get stats_monthlyView => 'Monatsansicht';

  @override
  String get stats_weightChange => 'Gewichtsveränderung';

  @override
  String get heatmap_none => 'Keiner';

  @override
  String get heatmap_low => 'Niedrig';

  @override
  String get heatmap_good => 'Gut';

  @override
  String get heatmap_full => 'Voll';

  @override
  String get meals_title => 'Essensplaner';

  @override
  String get meals_eatingWindow => 'Essfenster';

  @override
  String get meals_windowOpen => 'Offen';

  @override
  String get meals_windowFasting => 'Fasten';

  @override
  String get meals_calories => 'Kalorien';

  @override
  String get meals_protein => 'Protein';

  @override
  String get meals_carbs => 'Kohlenhydrate';

  @override
  String get meals_fat => 'Fett';

  @override
  String get meals_todayMeals => 'Die heutigen Mahlzeiten';

  @override
  String get meals_noMeals => 'Es wurden noch keine Mahlzeiten hinzugefügt';

  @override
  String get meals_breakfastSuggestions => 'Frühstücksvorschläge';

  @override
  String get meals_addMeal => 'Mahlzeit hinzufügen';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Benutzer';

  @override
  String profile_planActive(String plan) {
    return '$plan Plan aktiv';
  }

  @override
  String get profile_upgradePremium => 'Upgrade auf Premium';

  @override
  String get profile_premiumDesc => 'Alle Pläne, erweiterte Statistiken und mehr';

  @override
  String get profile_bodyMetrics => 'Körpermetriken';

  @override
  String get profile_height => 'Höhe';

  @override
  String get profile_weight => 'Gewicht';

  @override
  String get profile_targetWeight => 'Zielgewicht';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Einstellungen';

  @override
  String get profile_notifications => 'Benachrichtigungen';

  @override
  String get profile_darkTheme => 'Dunkles Thema';

  @override
  String get profile_waterReminder => 'Wasser-Erinnerung';

  @override
  String get profile_phaseNotifications => 'Phasenbenachrichtigungen';

  @override
  String get profile_language => 'Sprache';

  @override
  String get profile_about => 'Um';

  @override
  String get profile_rateApp => 'App bewerten';

  @override
  String get profile_share => 'Aktie';

  @override
  String get profile_privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get profile_version => 'Version';

  @override
  String get onboarding_welcome => 'Willkommen';

  @override
  String get onboarding_welcomeDesc => 'Übernehmen Sie die Kontrolle über Ihr\nintermittierende Fastenreise';

  @override
  String get onboarding_featureTimer => 'Intelligenter Fasten-Timer';

  @override
  String get onboarding_featureStats => 'Detaillierte Statistiken und Diagramme';

  @override
  String get onboarding_featureMeals => 'Speiseplaner und Rezeptvorschläge';

  @override
  String get onboarding_getStarted => 'Legen Sie los';

  @override
  String get onboarding_selectGoal => 'Was ist Ihr Ziel?';

  @override
  String get onboarding_selectGoalDesc => 'Sie können mehrere auswählen';

  @override
  String get onboarding_goalWeight => 'Gewicht verlieren';

  @override
  String get onboarding_goalWeightDesc => 'Gesunder Gewichtsverlust';

  @override
  String get onboarding_goalHealth => 'Gesundheit verbessern';

  @override
  String get onboarding_goalHealthDesc => 'Allgemeine Gesundheit und Immunität';

  @override
  String get onboarding_goalEnergy => 'Mehr Energie';

  @override
  String get onboarding_goalEnergyDesc => 'Energie den ganzen Tag';

  @override
  String get onboarding_goalMental => 'Geistige Klarheit';

  @override
  String get onboarding_goalMentalDesc => 'Konzentration und Klarheit';

  @override
  String get onboarding_goalLongevity => 'Langlebigkeit';

  @override
  String get onboarding_goalLongevityDesc => 'Zellerneuerung und Anti-Aging';

  @override
  String get onboarding_goalDiscipline => 'Disziplin';

  @override
  String get onboarding_goalDisciplineDesc => 'Bauen Sie Selbstdisziplin auf';

  @override
  String get onboarding_selectPlan => 'Wählen Sie Ihren Plan';

  @override
  String get onboarding_selectPlanDesc => 'Wählen Sie den für Sie besten Fastenplan';

  @override
  String get onboarding_bodyInfo => 'Geben Sie Ihre Daten ein';

  @override
  String get onboarding_bodyInfoDesc => 'Für personalisierte Empfehlungen';

  @override
  String get onboarding_gender => 'Geschlecht';

  @override
  String get onboarding_male => 'Männlich';

  @override
  String get onboarding_female => 'Weiblich';

  @override
  String get onboarding_age => 'Alter';

  @override
  String get onboarding_bodyInfoDisclaimer => 'Diese Informationen werden nur auf Ihrem Gerät gespeichert und für Kalorienberechnungen verwendet.';

  @override
  String get onboarding_permissions => 'Letzter Schritt';

  @override
  String get onboarding_permissionsDesc => 'Aktivieren Sie Berechtigungen für das beste Erlebnis';

  @override
  String get onboarding_next => 'Weitermachen';

  @override
  String get onboarding_start => 'Lass uns gehen!';

  @override
  String get onboarding_skipForNow => 'Später einrichten';

  @override
  String get waterAdded => '+250 ml Wasser hinzugefügt';

  @override
  String get languageSelect => 'Wählen Sie Sprache aus';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get paywall_title => 'Upgrade auf Premium';

  @override
  String get paywall_subtitle => 'Schalten Sie alle Funktionen frei';

  @override
  String get paywall_allPlans => 'Alle Fastenpläne';

  @override
  String get paywall_advancedStats => 'Erweiterte Statistiken';

  @override
  String get paywall_mealPlanner => 'Essensplaner';

  @override
  String get paywall_themes => 'Theme-Anpassung';

  @override
  String get paywall_noAds => 'Keine Werbung';

  @override
  String get paywall_weekly => 'Wöchentlich';

  @override
  String get paywall_monthly => 'Monatlich';

  @override
  String get paywall_yearly => 'Jährlich';

  @override
  String get paywall_bestValue => 'Am besten';

  @override
  String get paywall_freeTrial => 'Kostenlose Testversion (3 Tage)';

  @override
  String get paywall_restore => 'Einkäufe wiederherstellen';

  @override
  String get paywall_premiumActive => 'Premium Aktiv!';

  @override
  String get paywall_premiumActiveDesc => 'Sie haben alle Funktionen freigeschaltet';

  @override
  String get water_title => 'Wasseraufnahme';

  @override
  String get water_addWater => 'Wasser hinzufügen';

  @override
  String get water_goal => 'Ziel';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Stornieren';

  @override
  String get common_save => 'Speichern';

  @override
  String get common_delete => 'Löschen';

  @override
  String get common_hours => 'Std.';

  @override
  String get common_minutes => 'Minuten';

  @override
  String get common_days => 'Tage';

  @override
  String get common_enable => 'Aktivieren';

  @override
  String get streakCard_currentStreak => 'Aktueller Streak';

  @override
  String get streakCard_longestStreak => 'Längster Streak';

  @override
  String get streakCard_totalSessions => 'Gesamtfasten';

  @override
  String get meals_mealType => 'Art der Mahlzeit';

  @override
  String get meals_breakfast => 'Frühstück';

  @override
  String get meals_lunch => 'Mittagessen';

  @override
  String get meals_dinner => 'Abendessen';

  @override
  String get meals_snack => 'Snack';

  @override
  String get meals_carbohydrate => 'Kohlenhydrat';

  @override
  String get meals_add => 'Hinzufügen';

  @override
  String get meals_mealName => 'Name der Mahlzeit';

  @override
  String get bodyMetrics_title => 'Körpermetriken';

  @override
  String get bodyMetrics_weight => 'Gewicht';

  @override
  String get bodyMetrics_target => 'Ziel';

  @override
  String get bodyMetrics_save => 'Speichern';

  @override
  String get bodyMetrics_history => 'Geschichte';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Noch keine Daten';

  @override
  String get meals_quickAdd => 'Schnell hinzufügen';

  @override
  String get meals_manualEntry => 'Manuelle Eingabe';

  @override
  String meals_added(String name) {
    return '$name hinzugefügt';
  }

  @override
  String get meals_nameCalorieRequired => 'Name und Kalorien sind erforderlich';

  @override
  String get bodyMetrics_addWeight => 'Gewicht hinzufügen';

  @override
  String get bodyMetrics_hintWeight => 'z.B. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Geben Sie ein gültiges Gewicht ein';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg eingespart';
  }

  @override
  String get completion_duration => 'Dauer';

  @override
  String get completion_plan => 'Planen';

  @override
  String get completion_lastPhase => 'Letzte Phase';

  @override
  String get timer_remainingTime => 'Verbleibende Zeit';

  @override
  String get timer_ready => 'Bereit zum Start';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Beginnen Sie noch heute!';

  @override
  String get streak_goodStart => 'Guter Anfang!';

  @override
  String get streak_goingGreat => 'Läuft super!';

  @override
  String get streak_superb => 'Super!';

  @override
  String get streak_legendary => 'Legendär!';

  @override
  String get streak_incredible => 'Unglaublich!';

  @override
  String get weight_noRecord => 'Noch keine Gewichtsaufzeichnungen\nAus Profil > Körpermetriken hinzufügen';

  @override
  String get day_mon => 'Mo';

  @override
  String get day_tue => 'Di';

  @override
  String get day_wed => 'Heiraten';

  @override
  String get day_thu => 'Do';

  @override
  String get day_fri => 'Fr';

  @override
  String get day_sat => 'Sa';

  @override
  String get day_sun => 'Sonne';

  @override
  String get day_short_mon => 'M';

  @override
  String get day_short_tue => 'T';

  @override
  String get day_short_wed => 'W';

  @override
  String get day_short_thu => 'T';

  @override
  String get day_short_fri => 'F';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'S';

  @override
  String get month_jan => 'Januar';

  @override
  String get month_feb => 'Februar';

  @override
  String get month_mar => 'Marsch';

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
  String get month_dec => 'Dezember';

  @override
  String meals_fastingWindow(String hours) {
    return 'Fasten (${hours}h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Essen (${hours}h)';
  }

  @override
  String get recipe_oatSmoothie => 'Hafer-Smoothie';

  @override
  String get recipe_avocadoToast => 'Avocado-Toast';

  @override
  String get recipe_yogurtBowl => 'Joghurtschüssel';

  @override
  String get elapsed_time => 'Verstrichene Zeit';

  @override
  String get fast_ends_on => 'Dein Fasten endet um';

  @override
  String get end_fasting => 'Schluss mit dem Fasten';

  @override
  String get start_fasting => 'Beginnen Sie mit dem Fasten';

  @override
  String get water_tracker => 'Wasser-Tracker';

  @override
  String get weight_tracker => 'Gewichtstracker';

  @override
  String get drink => 'Trinken';

  @override
  String get log_weight => 'Stammgewicht';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Gewicht verloren';

  @override
  String get current_weight => 'Aktuelles Gewicht';

  @override
  String get goal_weight => 'Zielgewicht';

  @override
  String get daily_goal => 'Tagesziel';

  @override
  String completed_percent(String percent) {
    return '$percent% Abgeschlossen';
  }

  @override
  String get explore => 'Erkunden';

  @override
  String get achievements => 'Erfolge';

  @override
  String get profile_theme => 'Aussehen';

  @override
  String get theme_select => 'Aussehen wählen';

  @override
  String get theme_system => 'Systemstandard';

  @override
  String get theme_light => 'Licht';

  @override
  String get theme_dark => 'Dunkel';

  @override
  String get language_system => 'Systemsprache';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languagePortugueseBrazil => 'Português (Brasilien)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get profile_completionSound => 'Abschlusssound';

  @override
  String get profile_calmGamification => 'Ruhige Gamifizierung';

  @override
  String get profile_calmGamificationDesc => 'Reduziert den Liga- und Saisondruck';

  @override
  String get profile_editName => 'Bearbeiten Sie Ihren Namen';

  @override
  String get profile_name => 'Name';

  @override
  String get circle_title => 'Fastenkreis';

  @override
  String get circle_you => 'Du';

  @override
  String get circle_tagline => 'Gemeinsam, ohne Druck.';

  @override
  String get circle_privacy => 'Gewicht und private Messwerte bleiben verborgen. Nur Fortschritt und Unterstützung sind sichtbar.';

  @override
  String circle_sendSupport(int count) {
    return 'Senden Sie Unterstützung · $count';
  }

  @override
  String get circle_inviteCopied => 'Einladungscode kopiert';

  @override
  String get circle_createInvite => 'Erstellen Sie eine private Einladung';

  @override
  String get crisis_nameTitle => 'Benennen Sie zunächst, was passiert';

  @override
  String get crisis_nameDesc => 'Es kann Hunger, Gewohnheit oder Emotion sein.';

  @override
  String get crisis_waterTitle => 'Trinken Sie ein Glas Wasser';

  @override
  String get crisis_waterDesc => 'Dann machen Sie drei langsame Atemzüge.';

  @override
  String get crisis_delayTitle => 'Verzögern Sie die Entscheidung um 10 Minuten';

  @override
  String get crisis_delayDesc => 'Wenn Sie sich unwohl fühlen, ist das Beenden des Fastens kein Misserfolg.';

  @override
  String get crisis_hunger => 'Hunger';

  @override
  String get crisis_habit => 'Gewohnheit';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Geben Sie ihm 10 Minuten Zeit';

  @override
  String get stats_storyEmpty => 'Mit Ihrem ersten Fasten beginnt Ihre persönliche Geschichte.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Sie haben in diesem Zeitraum $sessions-mal gefastet, Ihren Rhythmus $hours Stunden lang beibehalten und eine Erfolgsquote von $rate % erreicht.';
  }

  @override
  String get stats_storyTitle => 'Die Geschichte deines Rhythmus';

  @override
  String get home_todayRhythm => 'Der heutige Rhythmus';

  @override
  String get home_finalHourSupport => 'Support in der letzten Stunde';

  @override
  String get home_needSupport => 'Ich brauche ein wenig Unterstützung';

  @override
  String get home_todaySummary => 'Heute auf einen Blick';

  @override
  String get home_dayStreak => 'Tagessträhne';

  @override
  String home_weightGoal(String weight) {
    return 'Ziel $weight kg';
  }

  @override
  String get weather_steady => 'Dein Rhythmus ist stabil';

  @override
  String get weather_gentle => 'Ein sanfter Tag';

  @override
  String get weather_water => 'Ein Glas Wasser kann helfen.';

  @override
  String get weather_listen => 'Du bist weit gekommen; Hören Sie auf Ihren Körper.';

  @override
  String get weather_onPlan => 'Das heutige Tempo entspricht Ihrem Plan.';

  @override
  String get weather_challenging => 'Diese Stunde war vorher eine Herausforderung; Der Support-Modus ist bereit.';

  @override
  String get replay_copied => 'Fasting Replay kopiert';

  @override
  String get replay_button => 'Wiederholung';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Ich habe mein $plan schnell in ${hours}h ${minutes}m · $phase fertiggestellt';
  }

  @override
  String get journey_label => 'Stoffwechselreise';

  @override
  String get journey_now => 'Jetzt';

  @override
  String journey_next(String time, String phase) {
    return '$time bis $phase';
  }

  @override
  String get phase_estimateShort => 'Das Phasentiming ist eine allgemeine Schätzung, keine medizinische Messung.';

  @override
  String phase_hours(int start, int end) {
    return 'Stunden $start–$end';
  }

  @override
  String get phase_estimateLong => 'Bei diesem Zeitpunkt handelt es sich um eine allgemeine Schätzung. Stoffwechselreaktionen können von Mensch zu Mensch unterschiedlich sein.';

  @override
  String get bmi_underweight => 'Untergewicht';

  @override
  String get bmi_normal => 'Normal';

  @override
  String get bmi_overweight => 'Übergewicht';

  @override
  String get bmi_obese => 'Fettleibig';

  @override
  String get notification_halfwayTitle => 'Auf halbem Weg! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Du hast die Hälfte deines $plan schnell abgeschlossen. Weitermachen!';
  }

  @override
  String get notification_phaseCatabolic => 'In die katabole Phase eingetreten 📉';

  @override
  String get notification_phaseFatBurning => 'Die Fettverbrennung hat begonnen! 🔥';

  @override
  String get notification_phaseKetosis => 'Du bist in Ketose ⚡';

  @override
  String get notification_phaseAutophagy => 'Autophagie aktiv! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Du hast deinen $plan schnell fertiggestellt! Ihr Essensfenster ist geöffnet.';
  }

  @override
  String get notification_waterTitle => 'Wasser trinken 💧';

  @override
  String get notification_waterBody => 'Vergessen Sie nicht, während des Fastens viel Wasser zu trinken!';

  @override
  String get notification_windowTitle => 'Essfenster schließen ⏰';

  @override
  String get notification_windowBody => 'Ihr Essfenster schließt sich in 30 Minuten.';

  @override
  String notification_streakTitle(int days) {
    return '$days Day Streak! 🔥';
  }

  @override
  String get notification_streakBody => 'Du machst das großartig! Machen Sie heute weiter so.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Fasten im Gange – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Verbleibend: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Fasten begonnen - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Ziel: $hours Stunden';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get explore_guide => 'Fastenführer';

  @override
  String get explore_guideDesc => 'Alles, was Sie über intermittierendes Fasten wissen müssen';

  @override
  String get explore_circleDesc => 'Teilen Sie stille Unterstützung mit Ihrer privaten Gruppe.';

  @override
  String get explore_faq => 'Häufig gestellte Fragen';

  @override
  String get explore_education => 'Dieser Inhalt dient nur der allgemeinen Aufklärung und stellt keine medizinische Diagnose oder Behandlungsberatung dar.';

  @override
  String get explore_safety => 'Gesundheit und Sicherheit';

  @override
  String get explore_safetyDesc => 'Wenn Sie an einer Krankheit leiden, regelmäßig Medikamente einnehmen, besorgniserregende Symptome haben, schwanger sind oder stillen, konsultieren Sie vor dem Fasten einen qualifizierten Arzt. Hören Sie auf, wenn Sie sich unwohl fühlen.';

  @override
  String get explore_sources => 'Quellen';

  @override
  String get explore_sourcesDesc => 'Der Inhalt ist aus den unten aufgeführten Referenzen zum Thema öffentliche Gesundheit vereinfacht.';

  @override
  String get explore_sourceError => 'Die Quelle konnte nicht geöffnet werden';

  @override
  String get explore_rules => 'Wichtige Regeln';

  @override
  String get explore_rule1 => 'Nehmen Sie während des Fastens keine kalorienreichen Lebensmittel zu sich';

  @override
  String get explore_rule2 => 'Trinken Sie viel Wasser und Flüssigkeit';

  @override
  String get explore_rule3 => 'Ernähren Sie sich während Ihres Essfensters ausgewogen';

  @override
  String get explore_rule4 => 'Hören Sie auf zu fasten, wenn Sie sich unwohl fühlen';

  @override
  String get explore_rule5 => 'Schwangere und stillende Frauen sollten nicht fasten';

  @override
  String get explore_rule6 => 'Konsultieren Sie Ihren Arzt, wenn Sie an chronischen Erkrankungen leiden';

  @override
  String get tip_water => 'Bleiben Sie hydriert';

  @override
  String get tip_waterDesc => 'Trinken Sie Wasser, wenn Sie durstig sind, und nehmen Sie Flüssigkeit zu den Mahlzeiten zu sich. Die Bedürfnisse können je nach Gesundheitszustand, Wetter und Aktivität variieren.';

  @override
  String get tip_food => 'Essen Sie richtig';

  @override
  String get tip_foodDesc => 'Wählen Sie während der Essensfenster proteinreiche Lebensmittel mit Ballaststoffen und gesunden Fetten. Vermeiden Sie verarbeitete Lebensmittel.';

  @override
  String get tip_sleep => 'Schlaf gut';

  @override
  String get tip_sleepDesc => 'Regelmäßiger, ausreichender Schlaf unterstützt das allgemeine Wohlbefinden. Planen Sie das Fasten so ein, dass es Ihren Schlaf nicht stört.';

  @override
  String get tip_exercise => 'Leichte Übung';

  @override
  String get tip_exerciseDesc => 'Während des Fastens können Sie leichte Spaziergänge oder Yoga machen. Vermeiden Sie schwere körperliche Betätigung, insbesondere in den ersten Wochen, bis sich Ihr Körper daran gewöhnt hat.';

  @override
  String get tip_drinks => 'Erlaubte Getränke';

  @override
  String get tip_drinksDesc => 'Während des Fastens können Sie Wasser, einfachen Tee und schwarzen Kaffee (kein Zucker, keine Milch) zu sich nehmen. Diese Getränke brechen Ihr Fasten nicht.';

  @override
  String get faq_drinks => 'Was kann ich während des Fastens trinken?';

  @override
  String get faq_drinksAnswer => 'Sie können Wasser, einfachen Tee und schwarzen Kaffee (ohne Zucker/Milch) trinken. Kalorienhaltige Getränke brechen das Fasten.';

  @override
  String get faq_plan => 'Welchen Fastenplan soll ich wählen?';

  @override
  String get faq_planAnswer => 'Wenn Sie neu sind, beginnen Sie mit 12:12 oder 14:10. Wenn Sie Erfahrung haben, versuchen Sie es mit 16:8 oder 18:6. 20:4 und OMAD sind für fortgeschrittene Schneller.';

  @override
  String get faq_exercise => 'Kann ich während des Fastens Sport treiben?';

  @override
  String get faq_exerciseAnswer => 'Ja, aber vermeiden Sie intensive Trainingseinheiten. Leichtes Cardiotraining, Walking und Yoga sind ideal. Wenn Sie Gewichte heben, planen Sie die Übungen in der Nähe Ihres Essensfensters ein.';

  @override
  String get faq_weight => 'Hilft Fasten beim Abnehmen?';

  @override
  String get faq_weightAnswer => 'Bei manchen Menschen kann die Begrenzung der Essenszeit die Gesamtenergieaufnahme verringern. Die Ergebnisse variieren und die langfristigen Auswirkungen werden noch untersucht.';

  @override
  String get plan_12_desc => 'Anfängerniveau';

  @override
  String get plan_12_detail => 'Ideal für Anfänger. Schnelle 12 Stunden inklusive Ihrer Schlafzeit.';

  @override
  String get plan_16_desc => 'Beliebtester Plan';

  @override
  String get plan_16_detail => 'Der gebräuchlichste IF-Plan. 16 Stunden Fasten, 8 Stunden Essensfenster. Normalerweise Mittag- bis Abendessen.';

  @override
  String get plan_18_desc => 'Mittelstufe';

  @override
  String get plan_18_detail => '18 Stunden Fasten, 6 Stunden Essensfenster. Längere Fettverbrennungsdauer.';

  @override
  String get plan_20_desc => 'Fortgeschrittenes Niveau';

  @override
  String get plan_20_detail => '20 Stunden Fasten, 4 Stunden Essensfenster. Ideal zum Erreichen von Ketose und Autophagie.';

  @override
  String get plan_omad_desc => 'Eine Mahlzeit am Tag';

  @override
  String get plan_omad_detail => 'Eine Mahlzeit am Tag. 23 Stunden Fasten, 1 Stunde Essensfenster. Expertenniveau.';

  @override
  String get plan_52_desc => '2 Tage pro Woche';

  @override
  String get plan_52_detail => 'Essen Sie 5 Tage lang normal, an 2 Tagen nur ~500 Kalorien. Ein alternativer Ansatz.';

  @override
  String get plan_ese_desc => '24 Stunden schnell';

  @override
  String get plan_ese_detail => 'Fasten Sie 1–2 Mal pro Woche 24 Stunden lang. Für fortgeschrittene Benutzer.';

  @override
  String get plan_warrior_desc => 'Kriegerdiät';

  @override
  String get plan_warrior_detail => 'Essen Sie tagsüber wenig (Obst, Gemüse) und nehmen Sie Ihre Hauptmahlzeit in einem 4-Stunden-Fenster am Abend ein.';

  @override
  String get award_first_title => 'Erster Schritt';

  @override
  String get award_first_desc => 'Schließe dein erstes Fasten ab';

  @override
  String get award_rhythm3_title => '3-Tage-Rhythmus';

  @override
  String get award_rhythm3_desc => 'Behalten Sie Ihren Rhythmus drei Tage lang bei';

  @override
  String get award_hours24_title => '24 Stunden';

  @override
  String get award_hours24_desc => 'Insgesamt 24 Stunden lang schnell';

  @override
  String get award_week_title => 'Einwöchiger Rhythmus';

  @override
  String get award_week_desc => 'Bauen Sie eine Sieben-Tage-Strecke auf';

  @override
  String get award_fasts10_title => '10 Fasten';

  @override
  String get award_fasts10_desc => 'Schließe zehn Fasten ab';

  @override
  String get award_hours100_title => '100 Stunden';

  @override
  String get award_hours100_desc => 'Erreiche insgesamt 100 Stunden';

  @override
  String get award_rhythm30_title => '30-Tage-Rhythmus';

  @override
  String get award_rhythm30_desc => 'Bauen Sie eine 30-Tage-Strecke auf';

  @override
  String get award_fasts50_title => '50 Fasten';

  @override
  String get award_fasts50_desc => 'Schließe fünfzig Fastenzeiten ab';

  @override
  String get award_hours500_title => '500 Stunden';

  @override
  String get award_hours500_desc => 'Erreiche insgesamt 500 Stunden';

  @override
  String get award_fasts100_title => '100 Fasten';

  @override
  String get award_fasts100_desc => 'Schließe einhundert Fasten ab';

  @override
  String get award_rhythm90_title => '90-Tage-Rhythmus';

  @override
  String get award_rhythm90_desc => 'Bauen Sie eine 90-Tage-Serie auf';

  @override
  String get award_year_title => 'Einjährige Reise';

  @override
  String get award_year_desc => 'Erreichen Sie einen 365-Tage-Rhythmus';

  @override
  String get awards_loadError => 'Der Fortschritt konnte nicht geladen werden';

  @override
  String get awards_journeyComplete => 'Reise abgeschlossen';

  @override
  String get awards_nextGoal => 'Nächstes Ziel';

  @override
  String get awards_allYours => 'Jeder Erfolg gehört dir';

  @override
  String get awards_dayStreak => 'Tagessträhne';

  @override
  String get awards_fasts => 'fastet';

  @override
  String get awards_total => 'gesamt';

  @override
  String get awards_stageStart => 'Start';

  @override
  String get awards_stageRhythm => 'Rhythmus';

  @override
  String get awards_stageEndurance => 'Ausdauer';

  @override
  String get awards_stageMastery => 'Meisterschaft';

  @override
  String get awards_completed => 'Vollendet';

  @override
  String awards_fastsRemaining(int count) {
    return '$count fastet zum Mitnehmen';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count noch Tage';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count noch Stunden';
  }

  @override
  String get common_retry => 'Versuchen Sie es erneut';

  @override
  String get game_title => 'Fortschrittszentrum';

  @override
  String get game_quests => 'Die heutigen Quests';

  @override
  String get game_questsDesc => 'Kleine Schritte, nachhaltiger Rhythmus.';

  @override
  String get game_season => '30-Schritte-Saison';

  @override
  String get game_seasonDesc => 'Bei jedem fünften Schritt ein Sammelsiegel.';

  @override
  String get game_badges => 'Abzeichensammlung';

  @override
  String game_shields(int count) {
    return '$count Rhythmusschilde';
  }

  @override
  String get game_shieldsDesc => 'Alle sieben Abschlüsse verdient. Ein verpasster Tag macht Ihren Fortschritt nie zunichte.';

  @override
  String get game_league => 'Private wöchentliche Liga';

  @override
  String game_leagueDesc(int percent) {
    return 'Ihr Rhythmus-Score liegt im $percent-Perzentil eines privaten lokalen Modells. Gewicht und extremes Fasten werden nie gewertet.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Level $level, $xp Erfahrungspunkte';
  }

  @override
  String get game_explorer => 'Rhythmus-Explorer';

  @override
  String get game_streak => 'Strähne';

  @override
  String get game_targets => 'Ziele';

  @override
  String get game_best => 'Am besten';

  @override
  String get quest_rhythm => 'Bauen Sie den heutigen Rhythmus auf';

  @override
  String get quest_hydrate => 'Erreichen Sie die Hälfte Ihres Wasserziels';

  @override
  String get quest_steady => 'Schützen Sie Ihren Streak';

  @override
  String get badge_first_title => 'Erster Schritt';

  @override
  String get badge_first_desc => 'Melden Sie Ihr erstes Fasten an';

  @override
  String get badge_rhythm7_title => 'Rhythmusbewahrer';

  @override
  String get badge_rhythm7_desc => 'Erreichen Sie eine 7-Tage-Strecke';

  @override
  String get badge_rhythm3_title => 'Drei-Tage-Rhythmus';

  @override
  String get badge_rhythm3_desc => 'Erreichen Sie eine 3-Tages-Serie';

  @override
  String get badge_target1_title => 'Erstes Ziel';

  @override
  String get badge_target1_desc => 'Schließe dein erstes Ziel schnell ab';

  @override
  String get badge_target3_title => 'Drei Schritte';

  @override
  String get badge_target3_desc => 'Erfülle 3 Ziele';

  @override
  String get badge_water_title => 'Ausgewogen';

  @override
  String get badge_water_desc => 'Erreichen Sie das tägliche Wasserziel';

  @override
  String get badge_support_title => 'Selbstbewusst';

  @override
  String get badge_support_desc => 'Verwenden Sie den Support-Modus';

  @override
  String get badge_hours10_title => '10 Stunden';

  @override
  String get badge_hours10_desc => 'Protokollieren Sie insgesamt 10 Stunden';

  @override
  String get badge_target10_title => 'Zehn stark';

  @override
  String get badge_target10_desc => 'Erfülle 10 Ziele';

  @override
  String get badge_target20_title => 'Zwanzig Ziele';

  @override
  String get badge_target20_desc => 'Erfülle 20 Ziele';

  @override
  String get badge_fast16_title => '16 Stunden';

  @override
  String get badge_fast16_desc => 'Erreichen Sie 16 Stunden in einem Schnelldurchlauf';

  @override
  String get badge_hours50_title => '50 Stunden';

  @override
  String get badge_hours50_desc => 'Protokollieren Sie insgesamt 50 Stunden';

  @override
  String get badge_hours100_title => 'Hundert Stunden';

  @override
  String get badge_hours100_desc => 'Protokollieren Sie insgesamt 100 Stunden';

  @override
  String get badge_target30_title => 'Dreißig Ziele';

  @override
  String get badge_target30_desc => 'Schließe 30 Ziele ab';

  @override
  String get badge_rhythm30_title => '30-Tage-Rhythmus';

  @override
  String get badge_rhythm30_desc => 'Erreichen Sie eine 30-Tage-Strecke';

  @override
  String get paywall_restoreSuccess => 'Einkäufe wiederhergestellt!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Fastenfortschritt $percent Prozent';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}h';
  }

  @override
  String get paywall_lifetime => 'Lebenslang';

  @override
  String get paywall_once => 'einmalig';

  @override
  String get paywall_processing => 'Wird verarbeitet…';

  @override
  String get paywall_continue => 'Weiter';

  @override
  String get paywall_productsUnavailable => 'Käufe sind derzeit nicht verfügbar. Bitte versuchen Sie es später erneut.';

  @override
  String get paywall_purchaseFailed => 'Der Kauf konnte nicht abgeschlossen werden.';

  @override
  String get paywall_nothingToRestore => 'Es wurde kein früherer Kauf gefunden.';

  @override
  String get paywall_restoreFailed => 'Käufe konnten nicht wiederhergestellt werden.';

  @override
  String get paywall_terms => 'Nutzungsbedingungen';

  @override
  String get permission_notificationDesc => 'Fastenerinnerungen, Phasenaktualisierungen und Abschlussmeldungen';

  @override
  String get profile_privacyChoices => 'Datenschutzeinstellungen';

  @override
  String get paywall_autoRenewInfo => 'Abonnements verlängern sich automatisch, sofern sie nicht mindestens 24 Stunden vor Ablauf gekündigt werden. Verwaltung jederzeit in den App-Store-Einstellungen.';
}
