// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Buongiorno';

  @override
  String get greeting_afternoon => 'Buon pomeriggio';

  @override
  String get greeting_evening => 'Buonasera';

  @override
  String get tab_timer => 'Home';

  @override
  String get tab_explore => 'Esplora';

  @override
  String get tab_stats => 'Report';

  @override
  String get tab_meals => 'Pasti';

  @override
  String get tab_achievements => 'Premi';

  @override
  String get tab_profile => 'Account';

  @override
  String get timer_fasting => 'Tempo di digiuno';

  @override
  String get timer_remaining => 'Rimanente';

  @override
  String get timer_elapsed => 'Trascorso';

  @override
  String get timer_start => 'Inizia';

  @override
  String get timer_stop => 'Termina';

  @override
  String get timer_completed => 'Congratulazioni!';

  @override
  String get timer_completedMessage =>
      'Hai completato il digiuno con successo!';

  @override
  String get timer_selectPlan => 'Seleziona il piano di digiuno';

  @override
  String get timer_stopConfirm =>
      'Vuoi davvero terminare il digiuno in anticipo?';

  @override
  String get timer_stopTitle => 'Termina il digiuno';

  @override
  String get timer_cancel => 'Annulla';

  @override
  String get timer_confirmStop => 'Sì, termina';

  @override
  String get phase_anabolic => 'Anabolica';

  @override
  String get phase_anabolicDesc => 'Digestione in corso';

  @override
  String get phase_catabolic => 'Catabolica';

  @override
  String get phase_catabolicDesc => 'Transizione energetica';

  @override
  String get phase_fatBurning => 'Combustione dei grassi';

  @override
  String get phase_fatBurningDesc => 'La combustione dei grassi è iniziata';

  @override
  String get phase_ketosis => 'Chetosi';

  @override
  String get phase_ketosisDesc => 'Produzione di chetoni attiva';

  @override
  String get phase_autophagy => 'Autofagia';

  @override
  String get phase_autophagyDesc => 'Rinnovamento cellulare';

  @override
  String get stats_title => 'Statistiche';

  @override
  String get stats_week => 'Settimana';

  @override
  String get stats_month => 'Mese';

  @override
  String get stats_year => 'Anno';

  @override
  String get stats_totalFasts => 'Digiuni totali';

  @override
  String get stats_average => 'Media';

  @override
  String get stats_fastDuration => 'durata del digiuno';

  @override
  String get stats_streak => 'Serie';

  @override
  String get stats_daysConsecutive => 'giorni consecutivi';

  @override
  String get stats_success => 'Successo';

  @override
  String get stats_completion => 'completamento';

  @override
  String get stats_weeklyFasting => 'Digiuno settimanale';

  @override
  String get stats_monthlyView => 'Vista mensile';

  @override
  String get stats_weightChange => 'Variazione di peso';

  @override
  String get heatmap_none => 'Nessuno';

  @override
  String get heatmap_low => 'Basso';

  @override
  String get heatmap_good => 'Buono';

  @override
  String get heatmap_full => 'Completo';

  @override
  String get meals_title => 'Pianificatore dei pasti';

  @override
  String get meals_eatingWindow => 'Finestra alimentare';

  @override
  String get meals_windowOpen => 'Aperta';

  @override
  String get meals_windowFasting => 'Digiuno';

  @override
  String get meals_calories => 'Calorie';

  @override
  String get meals_protein => 'Proteine';

  @override
  String get meals_carbs => 'Carboidrati';

  @override
  String get meals_fat => 'Grassi';

  @override
  String get meals_todayMeals => 'Pasti di oggi';

  @override
  String get meals_noMeals => 'Non hai ancora aggiunto pasti';

  @override
  String get meals_breakfastSuggestions =>
      'Suggerimenti per interrompere il digiuno';

  @override
  String get meals_addMeal => 'Aggiungi pasto';

  @override
  String get profile_title => 'Profilo';

  @override
  String get profile_user => 'Utente';

  @override
  String profile_planActive(String plan) {
    return 'Piano $plan attivo';
  }

  @override
  String get profile_upgradePremium => 'Passa a Premium';

  @override
  String get profile_premiumDesc =>
      'Tutti i piani di digiuno, senza pubblicità';

  @override
  String get profile_bodyMetrics => 'Misure corporee';

  @override
  String get profile_height => 'Altezza';

  @override
  String get profile_weight => 'Peso';

  @override
  String get profile_targetWeight => 'Peso obiettivo';

  @override
  String get profile_bmi => 'IMC';

  @override
  String get profile_settings => 'Impostazioni';

  @override
  String get profile_notifications => 'Notifiche';

  @override
  String get profile_darkTheme => 'Tema scuro';

  @override
  String get profile_waterReminder => 'Promemoria acqua';

  @override
  String get profile_phaseNotifications => 'Notifiche delle fasi';

  @override
  String get profile_language => 'Lingua';

  @override
  String get profile_about => 'Informazioni';

  @override
  String get profile_rateApp => 'Valuta l\'app';

  @override
  String get profile_share => 'Condividi';

  @override
  String get profile_privacyPolicy => 'Informativa sulla privacy';

  @override
  String get profile_version => 'Versione';

  @override
  String get onboarding_welcome => 'Benvenuto';

  @override
  String get onboarding_welcomeDesc =>
      'Prendi il controllo del tuo\npercorso di digiuno intermittente';

  @override
  String get onboarding_featureTimer => 'Timer di digiuno intelligente';

  @override
  String get onboarding_featureStats => 'Statistiche e grafici dettagliati';

  @override
  String get onboarding_featureMeals =>
      'Pianificatore dei pasti e suggerimenti di ricette';

  @override
  String get onboarding_getStarted => 'Inizia';

  @override
  String get onboarding_selectGoal => 'Qual è il tuo obiettivo?';

  @override
  String get onboarding_selectGoalDesc => 'Puoi selezionarne più di uno';

  @override
  String get onboarding_goalWeight => 'Perdere peso';

  @override
  String get onboarding_goalWeightDesc => 'Perdita di peso sana';

  @override
  String get onboarding_goalHealth => 'Migliorare la salute';

  @override
  String get onboarding_goalHealthDesc =>
      'Salute generale e difese immunitarie';

  @override
  String get onboarding_goalEnergy => 'Più energia';

  @override
  String get onboarding_goalEnergyDesc => 'Energia per tutta la giornata';

  @override
  String get onboarding_goalMental => 'Chiarezza mentale';

  @override
  String get onboarding_goalMentalDesc => 'Concentrazione e lucidità';

  @override
  String get onboarding_goalLongevity => 'Longevità';

  @override
  String get onboarding_goalLongevityDesc =>
      'Rinnovamento cellulare e azione antietà';

  @override
  String get onboarding_goalDiscipline => 'Disciplina';

  @override
  String get onboarding_goalDisciplineDesc => 'Sviluppa l\'autodisciplina';

  @override
  String get onboarding_selectPlan => 'Scegli il tuo piano';

  @override
  String get onboarding_selectPlanDesc =>
      'Seleziona il piano di digiuno più adatto a te';

  @override
  String get onboarding_bodyInfo => 'Inserisci i tuoi dati';

  @override
  String get onboarding_bodyInfoDesc => 'Per consigli personalizzati';

  @override
  String get onboarding_gender => 'Genere';

  @override
  String get onboarding_male => 'Uomo';

  @override
  String get onboarding_female => 'Donna';

  @override
  String get onboarding_age => 'Età';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Queste informazioni vengono salvate solo sul tuo dispositivo e utilizzate per il calcolo delle calorie.';

  @override
  String get onboarding_permissions => 'Ultimo passaggio';

  @override
  String get onboarding_permissionsDesc =>
      'Abilita le autorizzazioni per un\'esperienza ottimale';

  @override
  String get onboarding_next => 'Continua';

  @override
  String get onboarding_start => 'Cominciamo!';

  @override
  String get onboarding_skipForNow => 'Configura più tardi';

  @override
  String get waterAdded => '+250 ml di acqua aggiunti';

  @override
  String get languageSelect => 'Seleziona la lingua';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Passa a Premium';

  @override
  String get paywall_subtitle =>
      'Sblocca tutti i piani di digiuno e rimuovi la pubblicità';

  @override
  String get paywall_allPlans => 'Tutti i piani di digiuno';

  @override
  String get paywall_advancedStats => 'Statistiche avanzate';

  @override
  String get paywall_mealPlanner => 'Pianificatore dei pasti';

  @override
  String get paywall_themes => 'Personalizzazione del tema';

  @override
  String get paywall_noAds => 'Nessuna pubblicità';

  @override
  String get paywall_weekly => 'Settimanale';

  @override
  String get paywall_monthly => 'Mensile';

  @override
  String get paywall_yearly => 'Annuale';

  @override
  String get paywall_bestValue => 'Migliore';

  @override
  String get paywall_freeTrial => 'Prova gratuita (3 giorni)';

  @override
  String get paywall_restore => 'Ripristina acquisti';

  @override
  String get paywall_premiumActive => 'Premium attivo!';

  @override
  String get paywall_premiumActiveDesc =>
      'Tutti i piani di digiuno sono sbloccati e la pubblicità è disattivata';

  @override
  String get water_title => 'Assunzione di acqua';

  @override
  String get water_addWater => 'Aggiungi acqua';

  @override
  String get water_goal => 'Obiettivo';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Annulla';

  @override
  String get common_save => 'Salva';

  @override
  String get common_delete => 'Elimina';

  @override
  String get common_hours => 'ore';

  @override
  String get common_minutes => 'minuti';

  @override
  String get common_days => 'giorni';

  @override
  String get common_enable => 'Abilita';

  @override
  String get streakCard_currentStreak => 'Serie attuale';

  @override
  String get streakCard_longestStreak => 'Serie più lunga';

  @override
  String get streakCard_totalSessions => 'Digiuni totali';

  @override
  String get meals_mealType => 'Tipo di pasto';

  @override
  String get meals_breakfast => 'Colazione';

  @override
  String get meals_lunch => 'Pranzo';

  @override
  String get meals_dinner => 'Cena';

  @override
  String get meals_snack => 'Spuntino';

  @override
  String get meals_carbohydrate => 'Carboidrati';

  @override
  String get meals_add => 'Aggiungi';

  @override
  String get meals_mealName => 'Nome del pasto';

  @override
  String get bodyMetrics_title => 'Misure corporee';

  @override
  String get bodyMetrics_weight => 'Peso';

  @override
  String get bodyMetrics_target => 'Obiettivo';

  @override
  String get bodyMetrics_save => 'Salva';

  @override
  String get bodyMetrics_history => 'Cronologia';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'IMC: $value';
  }

  @override
  String get bodyMetrics_noData => 'Nessun dato';

  @override
  String get meals_quickAdd => 'Aggiunta rapida';

  @override
  String get meals_manualEntry => 'Inserimento manuale';

  @override
  String meals_added(String name) {
    return '$name aggiunto';
  }

  @override
  String get meals_nameCalorieRequired => 'Nome e calorie sono obbligatori';

  @override
  String get bodyMetrics_addWeight => 'Aggiungi peso';

  @override
  String get bodyMetrics_hintWeight => 'es. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Inserisci un peso valido';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg salvati';
  }

  @override
  String get completion_duration => 'Durata';

  @override
  String get completion_plan => 'Piano';

  @override
  String get completion_lastPhase => 'Ultima fase';

  @override
  String get completion_earlyTitle => 'Digiuno terminato';

  @override
  String get completion_earlyMessage =>
      'La durata di oggi è stata salvata. La serie e i progressi degli obiettivi non sono cambiati perché il traguardo non è stato completato.';

  @override
  String get timer_remainingTime => 'Tempo rimanente';

  @override
  String get timer_ready => 'Pronto per iniziare';

  @override
  String get streak_status => 'Stato';

  @override
  String get streak_startToday => 'Inizia oggi!';

  @override
  String get streak_goodStart => 'Ottimo inizio!';

  @override
  String get streak_goingGreat => 'Stai andando alla grande!';

  @override
  String get streak_superb => 'Superbo!';

  @override
  String get streak_legendary => 'Leggendario!';

  @override
  String get streak_incredible => 'Incredibile!';

  @override
  String get weight_noRecord =>
      'Nessuna registrazione del peso\nAggiungila da Profilo > Misure corporee';

  @override
  String get day_mon => 'Lun';

  @override
  String get day_tue => 'Mar';

  @override
  String get day_wed => 'Mer';

  @override
  String get day_thu => 'Gio';

  @override
  String get day_fri => 'Ven';

  @override
  String get day_sat => 'Sab';

  @override
  String get day_sun => 'Dom';

  @override
  String get day_short_mon => 'L';

  @override
  String get day_short_tue => 'M';

  @override
  String get day_short_wed => 'M';

  @override
  String get day_short_thu => 'G';

  @override
  String get day_short_fri => 'V';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'D';

  @override
  String get month_jan => 'Gennaio';

  @override
  String get month_feb => 'Febbraio';

  @override
  String get month_mar => 'Marzo';

  @override
  String get month_apr => 'Aprile';

  @override
  String get month_may => 'Maggio';

  @override
  String get month_jun => 'Giugno';

  @override
  String get month_jul => 'Luglio';

  @override
  String get month_aug => 'Agosto';

  @override
  String get month_sep => 'Settembre';

  @override
  String get month_oct => 'Ottobre';

  @override
  String get month_nov => 'Novembre';

  @override
  String get month_dec => 'Dicembre';

  @override
  String meals_fastingWindow(String hours) {
    return 'Digiuno ($hours h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Alimentazione ($hours h)';
  }

  @override
  String get recipe_oatSmoothie => 'Frullato d\'avena';

  @override
  String get recipe_avocadoToast => 'Toast all\'avocado';

  @override
  String get recipe_yogurtBowl => 'Ciotola di yogurt';

  @override
  String get elapsed_time => 'Tempo trascorso';

  @override
  String get fast_ends_on => 'Il digiuno termina alle';

  @override
  String get end_fasting => 'Termina il digiuno';

  @override
  String get start_fasting => 'Inizia il digiuno';

  @override
  String get water_tracker => 'Monitoraggio dell\'acqua';

  @override
  String get weight_tracker => 'Monitoraggio del peso';

  @override
  String get drink => 'Bevi';

  @override
  String get log_weight => 'Registra il peso';

  @override
  String get bmi => 'IMC';

  @override
  String get weight_lost => 'Peso perso';

  @override
  String get current_weight => 'Peso attuale';

  @override
  String get goal_weight => 'Peso obiettivo';

  @override
  String get daily_goal => 'Obiettivo giornaliero';

  @override
  String completed_percent(String percent) {
    return '$percent% completato';
  }

  @override
  String get explore => 'Esplora';

  @override
  String get achievements => 'Traguardi';

  @override
  String get profile_theme => 'Aspetto';

  @override
  String get theme_select => 'Scegli l\'aspetto';

  @override
  String get theme_system => 'Predefinito di sistema';

  @override
  String get theme_light => 'Chiaro';

  @override
  String get theme_dark => 'Scuro';

  @override
  String get language_system => 'Lingua di sistema';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Suono di completamento';

  @override
  String get profile_calmGamification => 'Gamification tranquilla';

  @override
  String get profile_calmGamificationDesc =>
      'Riduce la pressione di leghe e stagioni';

  @override
  String get profile_editName => 'Modifica il tuo nome';

  @override
  String get profile_name => 'Nome';

  @override
  String get circle_title => 'Cerchia del digiuno';

  @override
  String get circle_you => 'Tu';

  @override
  String get circle_tagline => 'Insieme, senza pressioni.';

  @override
  String get circle_privacy =>
      'Il peso e le misure private restano nascosti. Sono visibili solo i progressi e il sostegno.';

  @override
  String circle_sendSupport(int count) {
    return 'Invia sostegno · $count';
  }

  @override
  String get circle_inviteCopied => 'Codice di invito copiato';

  @override
  String get circle_createInvite => 'Crea un invito privato';

  @override
  String get crisis_nameTitle => 'Prima, dai un nome a ciò che sta accadendo';

  @override
  String get crisis_nameDesc => 'Potrebbe essere fame, abitudine o emozione.';

  @override
  String get crisis_waterTitle => 'Bevi un bicchiere d\'acqua';

  @override
  String get crisis_waterDesc => 'Poi fai tre respiri lenti.';

  @override
  String get crisis_delayTitle => 'Rimanda la decisione di 10 minuti';

  @override
  String get crisis_delayDesc =>
      'Se non ti senti bene, interrompere il digiuno non è un fallimento.';

  @override
  String get crisis_hunger => 'Fame';

  @override
  String get crisis_habit => 'Abitudine';

  @override
  String get crisis_stress => 'Stress';

  @override
  String get crisis_tenMore => 'Aspetta 10 minuti';

  @override
  String get stats_storyEmpty =>
      'Il tuo primo digiuno darà inizio alla tua storia personale.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'In questo periodo hai digiunato $sessions volte, hai mantenuto il ritmo per $hours ore e hai raggiunto un tasso di completamento del $rate%.';
  }

  @override
  String get stats_storyTitle => 'La storia del tuo ritmo';

  @override
  String get home_todayRhythm => 'Il ritmo di oggi';

  @override
  String get home_finalHourSupport => 'Supporto per l\'ultima ora';

  @override
  String get home_needSupport => 'Ho bisogno di un po\' di sostegno';

  @override
  String get home_todaySummary => 'Oggi in breve';

  @override
  String get home_dayStreak => 'giorni consecutivi';

  @override
  String home_weightGoal(String weight) {
    return 'obiettivo $weight kg';
  }

  @override
  String get weather_steady => 'Il tuo ritmo è stabile';

  @override
  String get weather_gentle => 'Una giornata tranquilla';

  @override
  String get weather_water => 'Un bicchiere d\'acqua potrebbe aiutare.';

  @override
  String get weather_listen => 'Hai fatto molta strada; ascolta il tuo corpo.';

  @override
  String get weather_onPlan => 'Il ritmo di oggi è in linea con il tuo piano.';

  @override
  String get weather_challenging =>
      'Quest\'ora è già stata difficile in passato; la modalità supporto è pronta.';

  @override
  String get replay_copied => 'Riepilogo del digiuno copiato';

  @override
  String get replay_button => 'Riepilogo';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Ho completato il digiuno $plan in $hours h $minutes min · $phase';
  }

  @override
  String get journey_label => 'Percorso metabolico';

  @override
  String get journey_now => 'Ora';

  @override
  String journey_next(String time, String phase) {
    return '$time alla fase $phase';
  }

  @override
  String get phase_estimateShort =>
      'Le tempistiche delle fasi sono stime generali, non misurazioni mediche.';

  @override
  String phase_hours(int start, int end) {
    return 'Ore $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Queste tempistiche sono stime generali. Le risposte metaboliche possono variare da persona a persona.';

  @override
  String get bmi_underweight => 'Sottopeso';

  @override
  String get bmi_normal => 'Normopeso';

  @override
  String get bmi_overweight => 'Sovrappeso';

  @override
  String get bmi_obese => 'Obesità';

  @override
  String get notification_halfwayTitle => 'Sei a metà! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Hai completato metà del digiuno $plan. Continua così!';
  }

  @override
  String get notification_phaseCatabolic =>
      'Sei entrato nella fase catabolica 📉';

  @override
  String get notification_phaseFatBurning =>
      'La combustione dei grassi è iniziata! 🔥';

  @override
  String get notification_phaseKetosis => 'Sei in chetosi ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagia attiva! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Hai completato il digiuno $plan! La finestra alimentare è aperta.';
  }

  @override
  String get notification_waterTitle => 'Bevi acqua 💧';

  @override
  String get notification_waterBody =>
      'Non dimenticare di bere molta acqua durante il digiuno!';

  @override
  String get notification_windowTitle =>
      'La finestra alimentare sta per chiudersi ⏰';

  @override
  String get notification_windowBody =>
      'La finestra alimentare si chiuderà tra 30 minuti.';

  @override
  String notification_streakTitle(int days) {
    return 'Serie di $days giorni! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Stai andando alla grande! Continua così oggi.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Digiuno in corso - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Rimanente: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Digiuno iniziato - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Obiettivo: $hours ore';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get explore_guide => 'Guida al digiuno';

  @override
  String get explore_guideDesc =>
      'Tutto ciò che devi sapere sul digiuno intermittente';

  @override
  String get explore_circleDesc =>
      'Condividi un sostegno discreto con il tuo gruppo privato.';

  @override
  String get explore_faq => 'Domande frequenti';

  @override
  String get explore_education =>
      'Questo contenuto ha esclusivamente finalità educative generali e non costituisce diagnosi medica né consiglio terapeutico.';

  @override
  String get explore_safety => 'Salute e sicurezza';

  @override
  String get explore_safetyDesc =>
      'Se hai una patologia, assumi farmaci regolarmente, presenti sintomi preoccupanti, sei in gravidanza o stai allattando, consulta un professionista sanitario qualificato prima di digiunare. Interrompi il digiuno se non ti senti bene.';

  @override
  String get explore_sources => 'Fonti';

  @override
  String get explore_sourcesDesc =>
      'I contenuti sono semplificati a partire dalle fonti di sanità pubblica riportate di seguito.';

  @override
  String get explore_sourceError => 'Impossibile aprire la fonte';

  @override
  String get explore_rules => 'Regole importanti';

  @override
  String get explore_rule1 =>
      'Non consumare alimenti calorici durante il digiuno';

  @override
  String get explore_rule2 => 'Bevi molta acqua e altri liquidi';

  @override
  String get explore_rule3 =>
      'Segui un\'alimentazione equilibrata durante la finestra alimentare';

  @override
  String get explore_rule4 => 'Interrompi il digiuno se non ti senti bene';

  @override
  String get explore_rule5 =>
      'Le donne in gravidanza o che allattano non dovrebbero digiunare';

  @override
  String get explore_rule6 => 'Consulta il medico se hai patologie croniche';

  @override
  String get tip_water => 'Mantieniti idratato';

  @override
  String get tip_waterDesc =>
      'Bevi quando hai sete e assumi liquidi durante i pasti. Il fabbisogno può variare in base a salute, clima e attività.';

  @override
  String get tip_food => 'Mangia bene';

  @override
  String get tip_foodDesc =>
      'Durante le finestre alimentari, scegli alimenti ricchi di proteine, fibre e grassi sani. Evita gli alimenti trasformati.';

  @override
  String get tip_sleep => 'Dormi bene';

  @override
  String get tip_sleepDesc =>
      'Un sonno regolare e sufficiente favorisce il benessere generale. Organizza il digiuno in modo che non disturbi il sonno.';

  @override
  String get tip_exercise => 'Attività fisica leggera';

  @override
  String get tip_exerciseDesc =>
      'Durante il digiuno puoi camminare o fare yoga leggero. Evita l\'attività intensa, soprattutto nelle prime settimane, finché il corpo non si adatta.';

  @override
  String get tip_drinks => 'Bevande consentite';

  @override
  String get tip_drinksDesc =>
      'Durante il digiuno puoi bere acqua, tè non zuccherato e caffè nero (senza zucchero né latte). Queste bevande non interrompono il digiuno.';

  @override
  String get faq_drinks => 'Cosa posso bere durante il digiuno?';

  @override
  String get faq_drinksAnswer =>
      'Puoi bere acqua, tè non zuccherato e caffè nero (senza zucchero né latte). Le bevande caloriche interrompono il digiuno.';

  @override
  String get faq_plan => 'Quale piano di digiuno dovrei scegliere?';

  @override
  String get faq_planAnswer =>
      'Se sei alle prime armi, inizia con 12:12 o 14:10. Se hai esperienza, prova 16:8 o 18:6. I piani 20:4 e OMAD sono indicati per chi è più esperto.';

  @override
  String get faq_exercise => 'Posso allenarmi durante il digiuno?';

  @override
  String get faq_exerciseAnswer =>
      'Sì, ma evita gli allenamenti intensi. Cardio leggero, camminata e yoga sono ideali. Se sollevi pesi, allenati vicino alla finestra alimentare.';

  @override
  String get faq_weight => 'Il digiuno aiuta a perdere peso?';

  @override
  String get faq_weightAnswer =>
      'Per alcune persone, limitare l\'orario dei pasti può ridurre l\'apporto energetico totale. I risultati variano e gli effetti a lungo termine sono ancora oggetto di studio.';

  @override
  String get plan_12_desc => 'Livello principiante';

  @override
  String get plan_12_detail =>
      'Ideale per chi inizia. Digiuna per 12 ore, includendo le ore di sonno.';

  @override
  String get plan_16_desc => 'Piano più popolare';

  @override
  String get plan_16_detail =>
      'Il piano di digiuno intermittente più comune: 16 ore di digiuno e 8 ore di finestra alimentare, di solito dal pranzo alla cena.';

  @override
  String get plan_18_desc => 'Livello intermedio';

  @override
  String get plan_18_detail =>
      '18 ore di digiuno e 6 ore di finestra alimentare. La fase di combustione dei grassi dura più a lungo.';

  @override
  String get plan_20_desc => 'Livello avanzato';

  @override
  String get plan_20_detail =>
      '20 ore di digiuno e 4 ore di finestra alimentare. Ideale per raggiungere la chetosi e l\'autofagia.';

  @override
  String get plan_omad_desc => 'Un pasto al giorno';

  @override
  String get plan_omad_detail =>
      'Un solo pasto al giorno: 23 ore di digiuno e 1 ora di finestra alimentare. Livello esperto.';

  @override
  String get plan_52_desc => '2 giorni a settimana';

  @override
  String get plan_52_detail =>
      'Mangia normalmente per 5 giorni e limita l\'apporto a circa 500 calorie negli altri 2. Un approccio alternativo.';

  @override
  String get plan_ese_desc => 'Digiuno di 24 ore';

  @override
  String get plan_ese_detail =>
      'Digiuna per 24 ore 1–2 volte a settimana. Per utenti avanzati.';

  @override
  String get plan_warrior_desc => 'Dieta del guerriero';

  @override
  String get plan_warrior_detail =>
      'Mangia leggero durante il giorno (frutta e verdura) e consuma il pasto principale in una finestra serale di 4 ore.';

  @override
  String get award_first_title => 'Primo passo';

  @override
  String get award_first_desc => 'Completa il tuo primo digiuno';

  @override
  String get award_rhythm3_title => 'Ritmo di 3 giorni';

  @override
  String get award_rhythm3_desc => 'Mantieni il ritmo per tre giorni';

  @override
  String get award_hours24_title => '24 ore';

  @override
  String get award_hours24_desc => 'Raggiungi 24 ore totali di digiuno';

  @override
  String get award_week_title => 'Ritmo di una settimana';

  @override
  String get award_week_desc => 'Costruisci una serie di sette giorni';

  @override
  String get award_fasts10_title => '10 digiuni';

  @override
  String get award_fasts10_desc => 'Completa dieci digiuni';

  @override
  String get award_hours100_title => '100 ore';

  @override
  String get award_hours100_desc => 'Raggiungi 100 ore totali';

  @override
  String get award_rhythm30_title => 'Ritmo di 30 giorni';

  @override
  String get award_rhythm30_desc => 'Costruisci una serie di trenta giorni';

  @override
  String get award_fasts50_title => '50 digiuni';

  @override
  String get award_fasts50_desc => 'Completa cinquanta digiuni';

  @override
  String get award_hours500_title => '500 ore';

  @override
  String get award_hours500_desc => 'Raggiungi 500 ore totali';

  @override
  String get award_fasts100_title => '100 digiuni';

  @override
  String get award_fasts100_desc => 'Completa cento digiuni';

  @override
  String get award_rhythm90_title => 'Ritmo di 90 giorni';

  @override
  String get award_rhythm90_desc => 'Costruisci una serie di novanta giorni';

  @override
  String get award_year_title => 'Percorso di un anno';

  @override
  String get award_year_desc => 'Raggiungi un ritmo di 365 giorni';

  @override
  String get awards_loadError => 'Impossibile caricare i progressi';

  @override
  String get awards_journeyComplete => 'Percorso completato';

  @override
  String get awards_nextGoal => 'Prossimo obiettivo';

  @override
  String get awards_allYours => 'Hai conquistato ogni traguardo';

  @override
  String get awards_dayStreak => 'giorni consecutivi';

  @override
  String get awards_fasts => 'digiuni';

  @override
  String get awards_total => 'totale';

  @override
  String get awards_stageStart => 'Inizio';

  @override
  String get awards_stageRhythm => 'Ritmo';

  @override
  String get awards_stageEndurance => 'Resistenza';

  @override
  String get awards_stageMastery => 'Maestria';

  @override
  String get awards_completed => 'Completato';

  @override
  String awards_fastsRemaining(int count) {
    return 'Mancano $count digiuni';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Mancano $count giorni';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Mancano $count ore';
  }

  @override
  String get common_retry => 'Riprova';

  @override
  String get game_title => 'Centro progressi';

  @override
  String get game_quests => 'Missioni di oggi';

  @override
  String get game_questsDesc => 'Piccoli passi, un ritmo sostenibile.';

  @override
  String get game_season => 'Stagione di 30 tappe';

  @override
  String get game_seasonDesc => 'Un sigillo da collezionare ogni cinque tappe.';

  @override
  String get game_badges => 'Collezione di badge';

  @override
  String game_shields(int count) {
    return '$count scudi del ritmo';
  }

  @override
  String get game_shieldsDesc =>
      'Ne ottieni uno ogni sette completamenti. Un giorno saltato non cancella mai i tuoi progressi.';

  @override
  String get game_league => 'Lega settimanale privata';

  @override
  String game_leagueDesc(int percent) {
    return 'Il tuo punteggio di ritmo si trova nel $percent° percentile di un modello locale privato. Il peso e i digiuni estremi non entrano mai in classifica.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Livello $level, $xp punti esperienza';
  }

  @override
  String get game_explorer => 'Esploratore del ritmo';

  @override
  String get game_streak => 'Serie';

  @override
  String get game_targets => 'Obiettivi';

  @override
  String get game_best => 'Migliore';

  @override
  String get quest_rhythm => 'Costruisci il ritmo di oggi';

  @override
  String get quest_hydrate => 'Raggiungi metà dell\'obiettivo di idratazione';

  @override
  String get quest_steady => 'Proteggi la tua serie';

  @override
  String get badge_first_title => 'Primo passo';

  @override
  String get badge_first_desc => 'Registra il tuo primo digiuno';

  @override
  String get badge_rhythm7_title => 'Custode del ritmo';

  @override
  String get badge_rhythm7_desc => 'Raggiungi una serie di 7 giorni';

  @override
  String get badge_rhythm3_title => 'Ritmo di tre giorni';

  @override
  String get badge_rhythm3_desc => 'Raggiungi una serie di 3 giorni';

  @override
  String get badge_target1_title => 'Primo obiettivo';

  @override
  String get badge_target1_desc => 'Completa il tuo primo digiuno obiettivo';

  @override
  String get badge_target3_title => 'Tre passi';

  @override
  String get badge_target3_desc => 'Completa 3 obiettivi';

  @override
  String get badge_water_title => 'In equilibrio';

  @override
  String get badge_water_desc =>
      'Completa l\'obiettivo giornaliero di idratazione';

  @override
  String get badge_support_title => 'Consapevole';

  @override
  String get badge_support_desc => 'Usa la modalità supporto';

  @override
  String get badge_hours10_title => '10 ore';

  @override
  String get badge_hours10_desc => 'Registra 10 ore totali';

  @override
  String get badge_target10_title => 'Dieci traguardi';

  @override
  String get badge_target10_desc => 'Completa 10 obiettivi';

  @override
  String get badge_target20_title => 'Venti obiettivi';

  @override
  String get badge_target20_desc => 'Completa 20 obiettivi';

  @override
  String get badge_fast16_title => '16 ore';

  @override
  String get badge_fast16_desc => 'Raggiungi 16 ore in un singolo digiuno';

  @override
  String get badge_hours50_title => '50 ore';

  @override
  String get badge_hours50_desc => 'Registra 50 ore totali';

  @override
  String get badge_hours100_title => 'Cento ore';

  @override
  String get badge_hours100_desc => 'Registra 100 ore totali';

  @override
  String get badge_target30_title => 'Trenta obiettivi';

  @override
  String get badge_target30_desc => 'Completa 30 obiettivi';

  @override
  String get badge_rhythm30_title => 'Ritmo di 30 giorni';

  @override
  String get badge_rhythm30_desc => 'Raggiungi una serie di 30 giorni';

  @override
  String get paywall_restoreSuccess => 'Acquisti ripristinati!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Avanzamento del digiuno: $percent percento';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour h';
  }

  @override
  String get paywall_lifetime => 'A vita';

  @override
  String get paywall_once => 'una tantum';

  @override
  String get paywall_processing => 'Elaborazione…';

  @override
  String get paywall_continue => 'Continua';

  @override
  String get paywall_productsUnavailable =>
      'Gli acquisti non sono disponibili al momento. Riprova più tardi.';

  @override
  String get paywall_purchaseFailed => 'Impossibile completare l\'acquisto.';

  @override
  String get paywall_nothingToRestore =>
      'Non è stato trovato alcun acquisto precedente.';

  @override
  String get paywall_restoreFailed => 'Impossibile ripristinare gli acquisti.';

  @override
  String get paywall_terms => 'Termini di utilizzo';

  @override
  String get permission_notificationDesc =>
      'Promemoria di digiuno, aggiornamenti delle fasi e notifiche di completamento';

  @override
  String get profile_privacyChoices => 'Scelte sulla privacy';

  @override
  String get paywall_autoRenewInfo =>
      'Gli abbonamenti si rinnovano automaticamente se non vengono annullati almeno 24 ore prima della fine del periodo. Puoi gestirli o annullarli in qualsiasi momento nelle impostazioni dell\'App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / mese';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Risparmia il $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Prova gratuita di $days giorni';
  }

  @override
  String get paywall_startFreeTrial => 'Inizia la prova gratuita';

  @override
  String get paywall_retry => 'Riprova';

  @override
  String get paywall_alreadyOwned =>
      'Possiedi già questo abbonamento. Tocca “Ripristina acquisti”.';

  @override
  String get paywall_storeUnavailable =>
      'Impossibile raggiungere lo store. Controlla la connessione e riprova.';

  @override
  String get paywall_secureNote =>
      'Puoi annullare in qualsiasi momento. Il pagamento viene addebitato sul tuo account dello store.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Gli abbonamenti si rinnovano automaticamente se non vengono annullati almeno 24 ore prima della fine del periodo. Puoi gestirli o annullarli in qualsiasi momento in Google Play > Abbonamenti.';

  @override
  String get paywall_allPlansDesc =>
      'Sblocca 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat e Warrior';

  @override
  String get paywall_noAdsDesc =>
      'I banner e gli annunci interstitial vengono disattivati completamente';

  @override
  String get foodScan_title => 'Scansione alimentare con IA';

  @override
  String get foodScan_scanCta => 'Scansiona il pasto';

  @override
  String get foodScan_scanCtaDesc =>
      'Fotografa il piatto e ottieni calorie e macronutrienti';

  @override
  String get foodScan_introTitle => 'Fotografa il tuo piatto';

  @override
  String get foodScan_introDesc =>
      'L\'IA legge la foto e stima calorie, proteine, carboidrati e grassi.';

  @override
  String get foodScan_tipLight =>
      'Una luce buona e uniforme consente una stima migliore';

  @override
  String get foodScan_tipFrame => 'Inquadra l\'intero piatto';

  @override
  String get foodScan_tipScale =>
      'Includi posate o una mano per aiutare a stimare le porzioni';

  @override
  String get foodScan_takePhoto => 'Scatta una foto';

  @override
  String get foodScan_chooseFromGallery => 'Scegli dalla galleria';

  @override
  String foodScan_scansLeft(int count) {
    return '$count scansioni rimaste oggi';
  }

  @override
  String get foodScan_quotaReached =>
      'Hai esaurito le scansioni di oggi. Riprova domani.';

  @override
  String get foodScan_privacyNote =>
      'La foto viene inviata all\'API Gemini di Google per l\'analisi e non viene archiviata sui nostri server.';

  @override
  String get foodScan_consentTitle => 'Inviare le foto a Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Per stimare calorie e macronutrienti, ogni foto del pasto che scatti o scegli viene inviata al servizio di IA Gemini di Google. La foto viene usata solo per questa analisi e non viene conservata sui nostri server.';

  @override
  String get foodScan_consentAgree => 'Accetta e continua';

  @override
  String get foodScan_analyzing => 'Analisi del pasto…';

  @override
  String get foodScan_analyzingHint => 'Di solito bastano pochi secondi';

  @override
  String get foodScan_detectedItems => 'Alimenti rilevati';

  @override
  String get foodScan_disclaimer =>
      'Le stime dell\'IA sono approssimative. Tocca un alimento per correggerlo.';

  @override
  String get foodScan_lowConfidence =>
      'Il modello non è sicuro di questa foto. Controlla i valori prima di salvare.';

  @override
  String get foodScan_save => 'Aggiungi ai pasti';

  @override
  String get foodScan_retake => 'Nuova foto';

  @override
  String get foodScan_retry => 'Riprova';

  @override
  String get foodScan_editItem => 'Modifica alimento';

  @override
  String get foodScan_portion => 'Porzione';

  @override
  String get foodScan_saveEdit => 'Salva';

  @override
  String get foodScan_premiumTitle => 'Una funzione Premium';

  @override
  String get foodScan_premiumDesc =>
      'L\'analisi delle calorie da foto è inclusa in Premium.';

  @override
  String get foodScan_upgrade => 'Scopri Premium';

  @override
  String get foodScan_errorNetwork =>
      'Nessuna connessione. Controlla Internet e riprova.';

  @override
  String get foodScan_errorRateLimited =>
      'Troppe scansioni in questo momento. Riprova tra qualche minuto.';

  @override
  String get foodScan_errorUnavailable =>
      'L\'analisi delle foto non è disponibile al momento.';

  @override
  String get foodScan_errorServer =>
      'Il servizio di analisi sta riscontrando problemi. Riprova tra poco.';

  @override
  String get foodScan_errorNoFood =>
      'Nessun alimento trovato nella foto. Prova con un\'immagine più nitida del piatto.';

  @override
  String get foodScan_errorUnreadable =>
      'Impossibile analizzare questa foto. Provane un\'altra.';

  @override
  String get paywall_aiFoodScan => 'Scansione alimentare con IA';

  @override
  String get paywall_aiFoodScanDesc =>
      'Fotografa un pasto e registra calorie e macronutrienti in pochi secondi';
}
