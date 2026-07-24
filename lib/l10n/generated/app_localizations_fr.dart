// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Bonjour';

  @override
  String get greeting_afternoon => 'Bon après-midi';

  @override
  String get greeting_evening => 'Bonne soirée';

  @override
  String get tab_timer => 'Maison';

  @override
  String get tab_explore => 'Explorer';

  @override
  String get tab_stats => 'Rapport';

  @override
  String get tab_meals => 'Repas';

  @override
  String get tab_achievements => 'Récompenses';

  @override
  String get tab_profile => 'Compte';

  @override
  String get timer_fasting => 'Temps de jeûne';

  @override
  String get timer_remaining => 'Restant';

  @override
  String get timer_elapsed => 'Écoulé';

  @override
  String get timer_start => 'Commencer';

  @override
  String get timer_stop => 'Arrêt';

  @override
  String get timer_completed => 'Félicitations!';

  @override
  String get timer_completedMessage => 'Vous avez terminé votre jeûne avec succès !';

  @override
  String get timer_selectPlan => 'Sélectionnez un plan de jeûne';

  @override
  String get timer_stopConfirm => 'Etes-vous sûr de vouloir mettre fin au jeûne plus tôt ?';

  @override
  String get timer_stopTitle => 'Terminer rapidement';

  @override
  String get timer_cancel => 'Annuler';

  @override
  String get timer_confirmStop => 'Oui, fin';

  @override
  String get phase_anabolic => 'Anabolisant';

  @override
  String get phase_anabolicDesc => 'Digestion en cours';

  @override
  String get phase_catabolic => 'Catabolique';

  @override
  String get phase_catabolicDesc => 'Transition énergétique';

  @override
  String get phase_fatBurning => 'Brûler les graisses';

  @override
  String get phase_fatBurningDesc => 'La combustion des graisses a commencé';

  @override
  String get phase_ketosis => 'Cétose';

  @override
  String get phase_ketosisDesc => 'Production de cétone active';

  @override
  String get phase_autophagy => 'Autophagie';

  @override
  String get phase_autophagyDesc => 'Renouvellement cellulaire';

  @override
  String get stats_title => 'Statistiques';

  @override
  String get stats_week => 'Semaine';

  @override
  String get stats_month => 'Mois';

  @override
  String get stats_year => 'Année';

  @override
  String get stats_totalFasts => 'Jeûnes totaux';

  @override
  String get stats_average => 'Moyenne';

  @override
  String get stats_fastDuration => 'durée rapide';

  @override
  String get stats_streak => 'Traînée';

  @override
  String get stats_daysConsecutive => 'jours consécutifs';

  @override
  String get stats_success => 'Succès';

  @override
  String get stats_completion => 'achèvement';

  @override
  String get stats_weeklyFasting => 'Jeûne hebdomadaire';

  @override
  String get stats_monthlyView => 'Vue mensuelle';

  @override
  String get stats_weightChange => 'Changement de poids';

  @override
  String get heatmap_none => 'Aucun';

  @override
  String get heatmap_low => 'Faible';

  @override
  String get heatmap_good => 'Bien';

  @override
  String get heatmap_full => 'Complet';

  @override
  String get meals_title => 'Planificateur de repas';

  @override
  String get meals_eatingWindow => 'Fenêtre de restauration';

  @override
  String get meals_windowOpen => 'Ouvrir';

  @override
  String get meals_windowFasting => 'Jeûne';

  @override
  String get meals_calories => 'Calories';

  @override
  String get meals_protein => 'Protéine';

  @override
  String get meals_carbs => 'Crabes';

  @override
  String get meals_fat => 'Graisse';

  @override
  String get meals_todayMeals => 'Les repas d\'aujourd\'hui';

  @override
  String get meals_noMeals => 'Aucun repas ajouté pour l\'instant';

  @override
  String get meals_breakfastSuggestions => 'Suggestions de petit-déjeuner';

  @override
  String get meals_addMeal => 'Ajouter un repas';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Utilisateur';

  @override
  String profile_planActive(String plan) {
    return '$plan Forfait actif';
  }

  @override
  String get profile_upgradePremium => 'Passer à Premium';

  @override
  String get profile_premiumDesc => 'Tous les forfaits, statistiques avancées et plus encore';

  @override
  String get profile_bodyMetrics => 'Mesures corporelles';

  @override
  String get profile_height => 'Hauteur';

  @override
  String get profile_weight => 'Poids';

  @override
  String get profile_targetWeight => 'Poids cible';

  @override
  String get profile_bmi => 'IMC';

  @override
  String get profile_settings => 'Paramètres';

  @override
  String get profile_notifications => 'Notifications';

  @override
  String get profile_darkTheme => 'Thème sombre';

  @override
  String get profile_waterReminder => 'Rappel d\'eau';

  @override
  String get profile_phaseNotifications => 'Notifications de phases';

  @override
  String get profile_language => 'Langue';

  @override
  String get profile_about => 'À propos';

  @override
  String get profile_rateApp => 'Évaluer l\'application';

  @override
  String get profile_share => 'Partager';

  @override
  String get profile_privacyPolicy => 'politique de confidentialité';

  @override
  String get profile_version => 'Version';

  @override
  String get onboarding_welcome => 'Accueillir';

  @override
  String get onboarding_welcomeDesc => 'Prenez le contrôle de votre\nvoyage de jeûne intermittent';

  @override
  String get onboarding_featureTimer => 'Minuterie de jeûne intelligente';

  @override
  String get onboarding_featureStats => 'Statistiques et graphiques détaillés';

  @override
  String get onboarding_featureMeals => 'Planificateur de repas et suggestions de recettes';

  @override
  String get onboarding_getStarted => 'Commencer';

  @override
  String get onboarding_selectGoal => 'Quel est votre objectif ?';

  @override
  String get onboarding_selectGoalDesc => 'Vous pouvez sélectionner plusieurs';

  @override
  String get onboarding_goalWeight => 'Perdre du poids';

  @override
  String get onboarding_goalWeightDesc => 'Perte de poids saine';

  @override
  String get onboarding_goalHealth => 'Améliorer la santé';

  @override
  String get onboarding_goalHealthDesc => 'Santé générale et immunité';

  @override
  String get onboarding_goalEnergy => 'Plus d\'énergie';

  @override
  String get onboarding_goalEnergyDesc => 'De l\'énergie tout au long de la journée';

  @override
  String get onboarding_goalMental => 'Clarté mentale';

  @override
  String get onboarding_goalMentalDesc => 'Concentration et clarté';

  @override
  String get onboarding_goalLongevity => 'Longévité';

  @override
  String get onboarding_goalLongevityDesc => 'Renouvellement cellulaire et anti-âge';

  @override
  String get onboarding_goalDiscipline => 'Discipline';

  @override
  String get onboarding_goalDisciplineDesc => 'Développer l’autodiscipline';

  @override
  String get onboarding_selectPlan => 'Choisissez votre forfait';

  @override
  String get onboarding_selectPlanDesc => 'Sélectionnez le meilleur plan de jeûne pour vous';

  @override
  String get onboarding_bodyInfo => 'Entrez vos informations';

  @override
  String get onboarding_bodyInfoDesc => 'Pour des recommandations personnalisées';

  @override
  String get onboarding_gender => 'Genre';

  @override
  String get onboarding_male => 'Mâle';

  @override
  String get onboarding_female => 'Femelle';

  @override
  String get onboarding_age => 'Âge';

  @override
  String get onboarding_bodyInfoDisclaimer => 'Ces informations sont stockées uniquement sur votre appareil et utilisées pour le calcul des calories.';

  @override
  String get onboarding_permissions => 'Dernière étape';

  @override
  String get onboarding_permissionsDesc => 'Activez les autorisations pour la meilleure expérience';

  @override
  String get onboarding_next => 'Continuer';

  @override
  String get onboarding_start => 'Allons-y!';

  @override
  String get onboarding_skipForNow => 'Configurer plus tard';

  @override
  String get waterAdded => '+250 ml d\'eau ajoutée';

  @override
  String get languageSelect => 'Sélectionnez la langue';

  @override
  String get languageTurkish => 'Turc';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get paywall_title => 'Passer à Premium';

  @override
  String get paywall_subtitle => 'Débloquez toutes les fonctionnalités';

  @override
  String get paywall_allPlans => 'Tous les plans de jeûne';

  @override
  String get paywall_advancedStats => 'Statistiques avancées';

  @override
  String get paywall_mealPlanner => 'Planificateur de repas';

  @override
  String get paywall_healthKit => 'Intégration de HealthKit';

  @override
  String get paywall_themes => 'Personnalisation du thème';

  @override
  String get paywall_noAds => 'Aucune publicité';

  @override
  String get paywall_weekly => 'Hebdomadaire';

  @override
  String get paywall_monthly => 'Mensuel';

  @override
  String get paywall_yearly => 'Annuel';

  @override
  String get paywall_bestValue => 'Meilleur';

  @override
  String get paywall_freeTrial => 'Essai gratuit (3 jours)';

  @override
  String get paywall_restore => 'Restaurer les achats';

  @override
  String get paywall_premiumActive => 'Actif Premium !';

  @override
  String get paywall_premiumActiveDesc => 'Vous avez débloqué toutes les fonctionnalités';

  @override
  String get water_title => 'Prise d\'eau';

  @override
  String get water_addWater => 'Ajouter de l\'eau';

  @override
  String get water_goal => 'But';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'D\'ACCORD';

  @override
  String get common_cancel => 'Annuler';

  @override
  String get common_save => 'Sauvegarder';

  @override
  String get common_delete => 'Supprimer';

  @override
  String get common_hours => 'heures';

  @override
  String get common_minutes => 'minutes';

  @override
  String get common_days => 'jours';

  @override
  String get common_enable => 'Activer';

  @override
  String get streakCard_currentStreak => 'Série actuelle';

  @override
  String get streakCard_longestStreak => 'La plus longue séquence';

  @override
  String get streakCard_totalSessions => 'Jeûnes totaux';

  @override
  String get meals_mealType => 'Type de repas';

  @override
  String get meals_breakfast => 'Petit-déjeuner';

  @override
  String get meals_lunch => 'Déjeuner';

  @override
  String get meals_dinner => 'Dîner';

  @override
  String get meals_snack => 'Collation';

  @override
  String get meals_carbohydrate => 'Glucides';

  @override
  String get meals_add => 'Ajouter';

  @override
  String get meals_mealName => 'Nom du repas';

  @override
  String get bodyMetrics_title => 'Mesures corporelles';

  @override
  String get bodyMetrics_weight => 'Poids';

  @override
  String get bodyMetrics_target => 'Cible';

  @override
  String get bodyMetrics_save => 'Sauvegarder';

  @override
  String get bodyMetrics_history => 'Histoire';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'IMC : $value';
  }

  @override
  String get bodyMetrics_noData => 'Aucune donnée pour l\'instant';

  @override
  String get meals_quickAdd => 'Ajout rapide';

  @override
  String get meals_manualEntry => 'Saisie manuelle';

  @override
  String meals_added(String name) {
    return '$name ajouté';
  }

  @override
  String get meals_nameCalorieRequired => 'Le nom et les calories sont requis';

  @override
  String get bodyMetrics_addWeight => 'Ajouter du poids';

  @override
  String get bodyMetrics_hintWeight => 'par ex. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Entrez un poids valide';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg économisés';
  }

  @override
  String get completion_duration => 'Durée';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Dernière phase';

  @override
  String get timer_remainingTime => 'Temps restant';

  @override
  String get timer_ready => 'Prêt à démarrer';

  @override
  String get streak_status => 'Statut';

  @override
  String get streak_startToday => 'Commencez dès aujourd\'hui !';

  @override
  String get streak_goodStart => 'Bon début !';

  @override
  String get streak_goingGreat => 'Ça va super !';

  @override
  String get streak_superb => 'Superbe!';

  @override
  String get streak_legendary => 'Légendaire!';

  @override
  String get streak_incredible => 'Incroyable!';

  @override
  String get weight_noRecord => 'Aucun enregistrement de poids pour l\'instant\nAjouter depuis Profil > Mesures corporelles';

  @override
  String get day_mon => 'Lun';

  @override
  String get day_tue => 'Mar';

  @override
  String get day_wed => 'Épouser';

  @override
  String get day_thu => 'Jeu';

  @override
  String get day_fri => 'Ven';

  @override
  String get day_sat => 'Assis';

  @override
  String get day_sun => 'Soleil';

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
  String get month_jan => 'Janvier';

  @override
  String get month_feb => 'Février';

  @override
  String get month_mar => 'Mars';

  @override
  String get month_apr => 'Avril';

  @override
  String get month_may => 'Peut';

  @override
  String get month_jun => 'Juin';

  @override
  String get month_jul => 'Juillet';

  @override
  String get month_aug => 'Août';

  @override
  String get month_sep => 'Septembre';

  @override
  String get month_oct => 'Octobre';

  @override
  String get month_nov => 'Novembre';

  @override
  String get month_dec => 'Décembre';

  @override
  String meals_fastingWindow(String hours) {
    return 'Jeûne (${hours}h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Manger (${hours}h)';
  }

  @override
  String get recipe_oatSmoothie => 'Smoothie à l\'avoine';

  @override
  String get recipe_avocadoToast => 'Toast à l\'avocat';

  @override
  String get recipe_yogurtBowl => 'Bol de yaourt';

  @override
  String get elapsed_time => 'Temps écoulé';

  @override
  String get fast_ends_on => 'Votre jeûne se termine à';

  @override
  String get end_fasting => 'Mettre fin au jeûne';

  @override
  String get start_fasting => 'Commencez à jeûner';

  @override
  String get water_tracker => 'Traqueur d\'eau';

  @override
  String get weight_tracker => 'Suivi du poids';

  @override
  String get drink => 'Boire';

  @override
  String get log_weight => 'Poids du journal';

  @override
  String get bmi => 'IMC';

  @override
  String get weight_lost => 'Poids perdu';

  @override
  String get current_weight => 'Poids actuel';

  @override
  String get goal_weight => 'Poids objectif';

  @override
  String get daily_goal => 'Objectif quotidien';

  @override
  String completed_percent(String percent) {
    return '$percent% terminé';
  }

  @override
  String get explore => 'Explorer';

  @override
  String get achievements => 'Réalisations';

  @override
  String get profile_theme => 'Apparence';

  @override
  String get theme_select => 'Choisissez l\'apparence';

  @override
  String get theme_system => 'Valeur par défaut du système';

  @override
  String get theme_light => 'Lumière';

  @override
  String get theme_dark => 'Sombre';

  @override
  String get language_system => 'Langue du système';

  @override
  String get languageSpanish => 'espagnol';

  @override
  String get languagePortugueseBrazil => 'Portugais (Brésil)';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Son d\'achèvement';

  @override
  String get profile_calmGamification => 'Une gamification calme';

  @override
  String get profile_calmGamificationDesc => 'Réduit la pression de la ligue et de la saison';

  @override
  String get profile_editName => 'Modifiez votre nom';

  @override
  String get profile_name => 'Nom';

  @override
  String get circle_title => 'Cercle de jeûne';

  @override
  String get circle_you => 'Toi';

  @override
  String get circle_tagline => 'Ensemble, sans pression.';

  @override
  String get circle_privacy => 'Le poids et les mesures privées restent masqués. Seuls les progrès et le soutien sont visibles.';

  @override
  String circle_sendSupport(int count) {
    return 'Envoyer de l\'aide · $count';
  }

  @override
  String get circle_inviteCopied => 'Code d\'invitation copié';

  @override
  String get circle_createInvite => 'Créer une invitation privée';

  @override
  String get crisis_nameTitle => 'Tout d’abord, nommez ce qui se passe';

  @override
  String get crisis_nameDesc => 'Cela peut être la faim, l\'habitude ou l\'émotion.';

  @override
  String get crisis_waterTitle => 'Boire un verre d\'eau';

  @override
  String get crisis_waterDesc => 'Ensuite, prenez trois respirations lentes.';

  @override
  String get crisis_delayTitle => 'Retarder la décision de 10 minutes';

  @override
  String get crisis_delayDesc => 'Si vous ne vous sentez pas bien, mettre fin au jeûne n’est pas un échec.';

  @override
  String get crisis_hunger => 'Faim';

  @override
  String get crisis_habit => 'Habitude';

  @override
  String get crisis_stress => 'Stresser';

  @override
  String get crisis_tenMore => 'Donnez-lui 10 minutes';

  @override
  String get stats_storyEmpty => 'Votre premier jeûne commencera votre histoire personnelle.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Vous avez jeûné $sessions fois pendant cette période, gardé votre rythme pendant $hours heures et atteint un taux d\'achèvement de $rate%.';
  }

  @override
  String get stats_storyTitle => 'L\'histoire de ton rythme';

  @override
  String get home_todayRhythm => 'Le rythme d\'aujourd\'hui';

  @override
  String get home_finalHourSupport => 'Assistance de dernière heure';

  @override
  String get home_needSupport => 'j\'ai besoin d\'un peu de soutien';

  @override
  String get home_todaySummary => 'Aujourd\'hui en un coup d\'œil';

  @override
  String get home_dayStreak => 'séquence d\'une journée';

  @override
  String home_weightGoal(String weight) {
    return 'objectif $weight kg';
  }

  @override
  String get weather_steady => 'Ton rythme est stable';

  @override
  String get weather_gentle => 'Une douce journée';

  @override
  String get weather_water => 'Un verre d\'eau peut aider.';

  @override
  String get weather_listen => 'Vous êtes venu loin ; écoutez votre corps.';

  @override
  String get weather_onPlan => 'Le rythme d’aujourd’hui correspond à votre plan.';

  @override
  String get weather_challenging => 'Cette heure était un défi auparavant ; le mode support est prêt.';

  @override
  String get replay_copied => 'Jeûne Replay copié';

  @override
  String get replay_button => 'Rejouer';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'J\'ai terminé mon $plan rapidement en ${hours}h ${minutes}m · $phase';
  }

  @override
  String get journey_label => 'Voyage métabolique';

  @override
  String get journey_now => 'Maintenant';

  @override
  String journey_next(String time, String phase) {
    return '$time jusqu\'à $phase';
  }

  @override
  String get phase_estimateShort => 'La synchronisation des phases est une estimation générale et non une mesure médicale.';

  @override
  String phase_hours(int start, int end) {
    return 'Heures $start–$end';
  }

  @override
  String get phase_estimateLong => 'Ce timing est une estimation générale. Les réponses métaboliques peuvent varier d’une personne à l’autre.';

  @override
  String get bmi_underweight => 'Insuffisance pondérale';

  @override
  String get bmi_normal => 'Normale';

  @override
  String get bmi_overweight => 'Embonpoint';

  @override
  String get bmi_obese => 'Obèse';

  @override
  String get notification_halfwayTitle => 'À mi-chemin ! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Vous avez terminé rapidement la moitié de votre $plan. Continue!';
  }

  @override
  String get notification_phaseCatabolic => 'Entrée en phase catabolique 📉';

  @override
  String get notification_phaseFatBurning => 'La combustion des graisses a commencé ! 🔥';

  @override
  String get notification_phaseKetosis => 'Vous êtes en cétose ⚡';

  @override
  String get notification_phaseAutophagy => 'Autophagie active ! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Vous avez terminé votre $plan rapidement ! Votre fenêtre de restauration est ouverte.';
  }

  @override
  String get notification_waterTitle => 'Boire de l\'eau 💧';

  @override
  String get notification_waterBody => 'N’oubliez pas de boire beaucoup d’eau pendant le jeûne !';

  @override
  String get notification_windowTitle => 'Fermeture de la fenêtre de restauration ⏰';

  @override
  String get notification_windowBody => 'Votre fenêtre de restauration se fermera dans 30 minutes.';

  @override
  String notification_streakTitle(int days) {
    return 'Série de jours $days ! 🔥';
  }

  @override
  String get notification_streakBody => 'Vous allez très bien ! Continuez ainsi aujourd\'hui.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Jeûne en cours - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Restant : $time';
  }

  @override
  String notification_started(String plan) {
    return 'Jeûne commencé - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Cible : heures $hours';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get explore_guide => 'Guide du jeûne';

  @override
  String get explore_guideDesc => 'Tout ce qu’il faut savoir sur le jeûne intermittent';

  @override
  String get explore_circleDesc => 'Partagez un soutien discret avec votre groupe privé.';

  @override
  String get explore_faq => 'Foire aux questions';

  @override
  String get explore_education => 'Ce contenu est destiné uniquement à l’éducation générale et ne constitue pas un diagnostic médical ni un conseil de traitement.';

  @override
  String get explore_safety => 'Santé et sécurité';

  @override
  String get explore_safetyDesc => 'Si vous souffrez d\'un problème de santé, prenez régulièrement des médicaments, présentez des symptômes inquiétants, êtes enceinte ou allaitez, consultez un professionnel de la santé qualifié avant de jeûner. Arrêtez-vous si vous ne vous sentez pas bien.';

  @override
  String get explore_sources => 'Sources';

  @override
  String get explore_sourcesDesc => 'Le contenu est simplifié à partir des références de santé publique ci-dessous.';

  @override
  String get explore_sourceError => 'La source n\'a pas pu être ouverte';

  @override
  String get explore_rules => 'Règles importantes';

  @override
  String get explore_rule1 => 'Ne consommez pas d’aliments caloriques pendant le jeûne';

  @override
  String get explore_rule2 => 'Boire beaucoup d\'eau et de liquides';

  @override
  String get explore_rule3 => 'Mangez équilibré pendant votre fenêtre de repas';

  @override
  String get explore_rule4 => 'Arrêtez de jeûner si vous ne vous sentez pas bien';

  @override
  String get explore_rule5 => 'Les femmes enceintes ou allaitantes ne devraient pas jeûner';

  @override
  String get explore_rule6 => 'Consultez votre médecin si vous souffrez de maladies chroniques';

  @override
  String get tip_water => 'Restez hydraté';

  @override
  String get tip_waterDesc => 'Buvez de l’eau lorsque vous avez soif et incluez des liquides aux repas. Les besoins peuvent varier en fonction de la santé, de la météo et de l\'activité.';

  @override
  String get tip_food => 'Mangez bien';

  @override
  String get tip_foodDesc => 'Pendant les périodes de repas, choisissez des aliments riches en protéines, en fibres et en graisses saines. Évitez les aliments transformés.';

  @override
  String get tip_sleep => 'Dors bien';

  @override
  String get tip_sleepDesc => 'Un sommeil régulier et suffisant favorise le bien-être général. Planifiez le jeûne afin qu\'il ne perturbe pas votre sommeil.';

  @override
  String get tip_exercise => 'Exercice léger';

  @override
  String get tip_exerciseDesc => 'Vous pouvez faire de la marche légère ou du yoga tout en jeûnant. Évitez les exercices intenses, surtout pendant les premières semaines jusqu\'à ce que votre corps s\'adapte.';

  @override
  String get tip_drinks => 'Boissons autorisées';

  @override
  String get tip_drinksDesc => 'Pendant le jeûne, vous pouvez consommer de l’eau, du thé nature et du café noir (sans sucre, sans lait). Ces boissons ne rompront pas votre jeûne.';

  @override
  String get faq_drinks => 'Que puis-je boire pendant le jeûne ?';

  @override
  String get faq_drinksAnswer => 'Vous pouvez boire de l\'eau, du thé nature et du café noir (sans sucre ni lait). Les boissons caloriques rompent le jeûne.';

  @override
  String get faq_plan => 'Quel programme de jeûne dois-je choisir ?';

  @override
  String get faq_planAnswer => 'Si vous êtes nouveau, commencez par 12h12 ou 14h10. Si vous êtes expérimenté, essayez le 16:8 ou le 18:6. 20:4 et OMAD sont destinés aux jeûneurs avancés.';

  @override
  String get faq_exercise => 'Puis-je faire de l’exercice en jeûnant ?';

  @override
  String get faq_exerciseAnswer => 'Oui, mais évitez les entraînements intenses. Le cardio léger, la marche et le yoga sont idéaux. Si vous soulevez des poids, programmez-le près de votre fenêtre de repas.';

  @override
  String get faq_weight => 'Le jeûne aide-t-il à perdre du poids ?';

  @override
  String get faq_weightAnswer => 'Pour certaines personnes, limiter le temps consacré aux repas peut réduire l’apport énergétique total. Les résultats varient et les effets à long terme sont encore à l’étude.';

  @override
  String get plan_12_desc => 'Niveau débutant';

  @override
  String get plan_12_detail => 'Idéal pour les débutants. Rapide 12 heures incluant votre temps de sommeil.';

  @override
  String get plan_16_desc => 'Forfait le plus populaire';

  @override
  String get plan_16_detail => 'Le plan IF le plus courant. 16 heures de jeûne, 8 heures de repas. Généralement du déjeuner au dîner.';

  @override
  String get plan_18_desc => 'Niveau intermédiaire';

  @override
  String get plan_18_detail => '18 heures de jeûne, 6 heures de repas. Durée de combustion des graisses plus longue.';

  @override
  String get plan_20_desc => 'Niveau avancé';

  @override
  String get plan_20_detail => '20 heures de jeûne, 4 heures de repas. Idéal pour atteindre la cétose et l\'autophagie.';

  @override
  String get plan_omad_desc => 'Un repas par jour';

  @override
  String get plan_omad_detail => 'Un repas par jour. 23 heures de jeûne, 1 heure de repas. Niveau expert.';

  @override
  String get plan_52_desc => '2 jours par semaine';

  @override
  String get plan_52_detail => 'Mangez normalement 5 jours, seulement ~500 calories sur 2 jours. Une approche alternative.';

  @override
  String get plan_ese_desc => '24 heures rapide';

  @override
  String get plan_ese_detail => 'Jeûner pendant 24 heures 1 à 2 fois par semaine. Pour les utilisateurs avancés.';

  @override
  String get plan_warrior_desc => 'Régime guerrier';

  @override
  String get plan_warrior_detail => 'Mangez léger pendant la journée (fruits, légumes), prenez votre repas principal dans une fenêtre de 4 heures en soirée.';

  @override
  String get award_first_title => 'Premier pas';

  @override
  String get award_first_desc => 'Terminez votre premier jeûne';

  @override
  String get award_rhythm3_title => 'Rythme de 3 jours';

  @override
  String get award_rhythm3_desc => 'Gardez votre rythme pendant trois jours';

  @override
  String get award_hours24_title => '24 heures';

  @override
  String get award_hours24_desc => 'Rapide pendant 24 heures au total';

  @override
  String get award_week_title => 'Rythme d\'une semaine';

  @override
  String get award_week_desc => 'Construisez une séquence de sept jours';

  @override
  String get award_fasts10_title => '10 jeûnes';

  @override
  String get award_fasts10_desc => 'Effectuer dix jeûnes';

  @override
  String get award_hours100_title => '100 heures';

  @override
  String get award_hours100_desc => 'Atteindre 100 heures au total';

  @override
  String get award_rhythm30_title => 'Rythme de 30 jours';

  @override
  String get award_rhythm30_desc => 'Construisez une séquence de trente jours';

  @override
  String get award_fasts50_title => '50 jeûnes';

  @override
  String get award_fasts50_desc => 'Effectuer cinquante jeûnes';

  @override
  String get award_hours500_title => '500 heures';

  @override
  String get award_hours500_desc => 'Atteindre 500 heures au total';

  @override
  String get award_fasts100_title => '100 jeûnes';

  @override
  String get award_fasts100_desc => 'Effectuer cent jeûnes';

  @override
  String get award_rhythm90_title => 'Rythme de 90 jours';

  @override
  String get award_rhythm90_desc => 'Construisez une séquence de quatre-vingt-dix jours';

  @override
  String get award_year_title => 'Voyage d\'un an';

  @override
  String get award_year_desc => 'Atteignez un rythme de 365 jours';

  @override
  String get awards_loadError => 'La progression n\'a pas pu se charger';

  @override
  String get awards_journeyComplete => 'Voyage terminé';

  @override
  String get awards_nextGoal => 'Objectif suivant';

  @override
  String get awards_allYours => 'Chaque réalisation est à vous';

  @override
  String get awards_dayStreak => 'séquence d\'une journée';

  @override
  String get awards_fasts => 'jeûnes';

  @override
  String get awards_total => 'total';

  @override
  String get awards_stageStart => 'Commencer';

  @override
  String get awards_stageRhythm => 'Rythme';

  @override
  String get awards_stageEndurance => 'Endurance';

  @override
  String get awards_stageMastery => 'Maîtrise';

  @override
  String get awards_completed => 'Complété';

  @override
  String awards_fastsRemaining(int count) {
    return '$count jeûne à emporter';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count jours restants';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count heures restantes';
  }

  @override
  String get common_retry => 'Essayer à nouveau';

  @override
  String get game_title => 'Centre de progrès';

  @override
  String get game_quests => 'Les quêtes du jour';

  @override
  String get game_questsDesc => 'Petits pas, rythme durable.';

  @override
  String get game_season => 'Saison en 30 étapes';

  @override
  String get game_seasonDesc => 'Un sceau de collection toutes les cinq étapes.';

  @override
  String get game_badges => 'Collection de badges';

  @override
  String game_shields(int count) {
    return 'Boucliers de rythme $count';
  }

  @override
  String get game_shieldsDesc => 'Obtenu toutes les sept réussites. Une journée manquée n’efface jamais vos progrès.';

  @override
  String get game_league => 'Ligue hebdomadaire privée';

  @override
  String game_leagueDesc(int percent) {
    return 'Votre score rythmique se situe dans le centile $percent d’un modèle local privé. Le poids et le jeûne extrême ne sont jamais classés.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Points d\'expérience de niveau $level, $xp';
  }

  @override
  String get game_explorer => 'Explorateur de rythme';

  @override
  String get game_streak => 'Traînée';

  @override
  String get game_targets => 'Cibles';

  @override
  String get game_best => 'Meilleur';

  @override
  String get quest_rhythm => 'Construisez le rythme d’aujourd’hui';

  @override
  String get quest_hydrate => 'Atteignez la moitié de votre objectif en eau';

  @override
  String get quest_steady => 'Protégez votre séquence';

  @override
  String get badge_first_title => 'Premier pas';

  @override
  String get badge_first_desc => 'Enregistrez votre premier jeûne';

  @override
  String get badge_rhythm7_title => 'Gardien du rythme';

  @override
  String get badge_rhythm7_desc => 'Atteignez une séquence de 7 jours';

  @override
  String get badge_rhythm3_title => 'Rythme de trois jours';

  @override
  String get badge_rhythm3_desc => 'Atteignez une séquence de 3 jours';

  @override
  String get badge_target1_title => 'Première cible';

  @override
  String get badge_target1_desc => 'Complétez rapidement votre premier objectif';

  @override
  String get badge_target3_title => 'Trois étapes';

  @override
  String get badge_target3_desc => 'Complétez 3 cibles';

  @override
  String get badge_water_title => 'Équilibré';

  @override
  String get badge_water_desc => 'Complétez l\'objectif quotidien en eau';

  @override
  String get badge_support_title => 'Conscience de soi';

  @override
  String get badge_support_desc => 'Utiliser le mode assistance';

  @override
  String get badge_hours10_title => '10 heures';

  @override
  String get badge_hours10_desc => 'Enregistrez 10 heures au total';

  @override
  String get badge_target10_title => 'Dix forts';

  @override
  String get badge_target10_desc => 'Complétez 10 cibles';

  @override
  String get badge_target20_title => 'Vingt cibles';

  @override
  String get badge_target20_desc => 'Complétez 20 cibles';

  @override
  String get badge_fast16_title => '16 heures';

  @override
  String get badge_fast16_desc => 'Atteignez 16 heures en un seul jeûne';

  @override
  String get badge_hours50_title => '50 heures';

  @override
  String get badge_hours50_desc => 'Enregistrez 50 heures au total';

  @override
  String get badge_hours100_title => 'Cent heures';

  @override
  String get badge_hours100_desc => 'Enregistrez 100 heures au total';

  @override
  String get badge_target30_title => 'Trente cibles';

  @override
  String get badge_target30_desc => 'Complétez 30 cibles';

  @override
  String get badge_rhythm30_title => 'Rythme de 30 jours';

  @override
  String get badge_rhythm30_desc => 'Atteignez une séquence de 30 jours';

  @override
  String get paywall_restoreSuccess => 'Achats restaurés !';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Progrès à jeun $percent pourcentage';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}h';
  }

  @override
  String get paywall_lifetime => 'À vie';

  @override
  String get paywall_once => 'paiement unique';

  @override
  String get paywall_processing => 'Traitement…';

  @override
  String get paywall_continue => 'Continuer';

  @override
  String get paywall_productsUnavailable => 'Les achats sont indisponibles pour le moment. Réessayez plus tard.';

  @override
  String get paywall_purchaseFailed => 'L’achat n’a pas pu être finalisé.';

  @override
  String get paywall_nothingToRestore => 'Aucun achat antérieur n’a été trouvé.';

  @override
  String get paywall_restoreFailed => 'Les achats n’ont pas pu être restaurés.';

  @override
  String get paywall_terms => 'Conditions d’utilisation';

  @override
  String get permission_notificationDesc => 'Rappels de jeûne, changements de phase et notifications de fin';

  @override
  String get permission_healthTitle => 'Health Connect / HealthKit';

  @override
  String get permission_healthDesc => 'Synchronisez les pas, calories actives et le poids avec votre autorisation';

  @override
  String get profile_privacyChoices => 'Choix de confidentialité';

  @override
  String get paywall_autoRenewInfo => 'Les abonnements se renouvellent automatiquement sauf résiliation au moins 24 heures avant la fin de la période. Gérez-les dans les réglages de l\'App Store.';
}
