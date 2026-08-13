// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Buen día';

  @override
  String get greeting_afternoon => 'Buenas tardes';

  @override
  String get greeting_evening => 'Buenas noches';

  @override
  String get tab_timer => 'Hogar';

  @override
  String get tab_explore => 'Explorar';

  @override
  String get tab_stats => 'Informe';

  @override
  String get tab_meals => 'Comidas';

  @override
  String get tab_achievements => 'Premios';

  @override
  String get tab_profile => 'Cuenta';

  @override
  String get timer_fasting => 'Tiempo de ayuno';

  @override
  String get timer_remaining => 'Restante';

  @override
  String get timer_elapsed => 'Transcurrido';

  @override
  String get timer_start => 'Comenzar';

  @override
  String get timer_stop => 'Detener';

  @override
  String get timer_completed => '¡Felicidades!';

  @override
  String get timer_completedMessage => '¡Completaste tu ayuno con éxito!';

  @override
  String get timer_selectPlan => 'Seleccionar plan de ayuno';

  @override
  String get timer_stopConfirm =>
      '¿Estás seguro de que quieres terminar el ayuno antes de tiempo?';

  @override
  String get timer_stopTitle => 'Terminar rápido';

  @override
  String get timer_cancel => 'Cancelar';

  @override
  String get timer_confirmStop => 'Si, fin';

  @override
  String get phase_anabolic => 'Anabólico';

  @override
  String get phase_anabolicDesc => 'Digestión en progreso';

  @override
  String get phase_catabolic => 'catabólico';

  @override
  String get phase_catabolicDesc => 'Transición energética';

  @override
  String get phase_fatBurning => 'Quema Grasa';

  @override
  String get phase_fatBurningDesc => 'Comenzó la quema de grasa';

  @override
  String get phase_ketosis => 'cetosis';

  @override
  String get phase_ketosisDesc => 'Producción de cetonas activa.';

  @override
  String get phase_autophagy => 'Autofagia';

  @override
  String get phase_autophagyDesc => 'Renovación celular';

  @override
  String get stats_title => 'Estadística';

  @override
  String get stats_week => 'Semana';

  @override
  String get stats_month => 'Mes';

  @override
  String get stats_year => 'Año';

  @override
  String get stats_totalFasts => 'Ayunos totales';

  @override
  String get stats_average => 'Promedio';

  @override
  String get stats_fastDuration => 'duración rápida';

  @override
  String get stats_streak => 'Racha';

  @override
  String get stats_daysConsecutive => 'dias consecutivos';

  @override
  String get stats_success => 'Éxito';

  @override
  String get stats_completion => 'terminación';

  @override
  String get stats_weeklyFasting => 'Ayuno Semanal';

  @override
  String get stats_monthlyView => 'Vista mensual';

  @override
  String get stats_weightChange => 'Cambio de peso';

  @override
  String get heatmap_none => 'Ninguno';

  @override
  String get heatmap_low => 'Bajo';

  @override
  String get heatmap_good => 'Bien';

  @override
  String get heatmap_full => 'Lleno';

  @override
  String get meals_title => 'Planificador de comidas';

  @override
  String get meals_eatingWindow => 'ventana para comer';

  @override
  String get meals_windowOpen => 'Abierto';

  @override
  String get meals_windowFasting => 'Ayuno';

  @override
  String get meals_calories => 'calorías';

  @override
  String get meals_protein => 'Proteína';

  @override
  String get meals_carbs => 'carbohidratos';

  @override
  String get meals_fat => 'Gordo';

  @override
  String get meals_todayMeals => 'Las comidas de hoy';

  @override
  String get meals_noMeals => 'Aún no se han agregado comidas';

  @override
  String get meals_breakfastSuggestions => 'Sugerencias para el desayuno';

  @override
  String get meals_addMeal => 'Agregar comida';

  @override
  String get profile_title => 'Perfil';

  @override
  String get profile_user => 'Usuario';

  @override
  String profile_planActive(String plan) {
    return '$plan Plan activo';
  }

  @override
  String get profile_upgradePremium => 'Actualizar a Premium';

  @override
  String get profile_premiumDesc =>
      'Todos los planes, estadísticas avanzadas y más';

  @override
  String get profile_bodyMetrics => 'Métricas corporales';

  @override
  String get profile_height => 'Altura';

  @override
  String get profile_weight => 'Peso';

  @override
  String get profile_targetWeight => 'Peso objetivo';

  @override
  String get profile_bmi => 'IMC';

  @override
  String get profile_settings => 'Ajustes';

  @override
  String get profile_notifications => 'Notificaciones';

  @override
  String get profile_darkTheme => 'Tema oscuro';

  @override
  String get profile_waterReminder => 'Recordatorio de agua';

  @override
  String get profile_phaseNotifications => 'Notificaciones de fase';

  @override
  String get profile_language => 'Idioma';

  @override
  String get profile_about => 'Acerca de';

  @override
  String get profile_rateApp => 'Calificar aplicación';

  @override
  String get profile_share => 'Compartir';

  @override
  String get profile_privacyPolicy => 'política de privacidad';

  @override
  String get profile_version => 'Versión';

  @override
  String get onboarding_welcome => 'Bienvenido';

  @override
  String get onboarding_welcomeDesc =>
      'Toma el control de tu\nviaje de ayuno intermitente';

  @override
  String get onboarding_featureTimer => 'Temporizador de ayuno inteligente';

  @override
  String get onboarding_featureStats => 'Estadísticas y gráficos detallados';

  @override
  String get onboarding_featureMeals =>
      'Planificador de comidas y sugerencias de recetas.';

  @override
  String get onboarding_getStarted => 'Empezar';

  @override
  String get onboarding_selectGoal => '¿Cuál es tu objetivo?';

  @override
  String get onboarding_selectGoalDesc => 'Puedes seleccionar varios';

  @override
  String get onboarding_goalWeight => 'Perder peso';

  @override
  String get onboarding_goalWeightDesc => 'Pérdida de peso saludable';

  @override
  String get onboarding_goalHealth => 'Mejorar la salud';

  @override
  String get onboarding_goalHealthDesc => 'Salud general e inmunidad.';

  @override
  String get onboarding_goalEnergy => 'Más energía';

  @override
  String get onboarding_goalEnergyDesc => 'Energía durante todo el día';

  @override
  String get onboarding_goalMental => 'Claridad mental';

  @override
  String get onboarding_goalMentalDesc => 'Enfoque y claridad';

  @override
  String get onboarding_goalLongevity => 'Longevidad';

  @override
  String get onboarding_goalLongevityDesc =>
      'Renovación celular y antienvejecimiento';

  @override
  String get onboarding_goalDiscipline => 'Disciplina';

  @override
  String get onboarding_goalDisciplineDesc => 'Desarrollar la autodisciplina';

  @override
  String get onboarding_selectPlan => 'Elige tu plan';

  @override
  String get onboarding_selectPlanDesc =>
      'Selecciona el mejor plan de ayuno para ti';

  @override
  String get onboarding_bodyInfo => 'Ingrese su información';

  @override
  String get onboarding_bodyInfoDesc => 'Para recomendaciones personalizadas';

  @override
  String get onboarding_gender => 'Género';

  @override
  String get onboarding_male => 'Masculino';

  @override
  String get onboarding_female => 'Femenino';

  @override
  String get onboarding_age => 'Edad';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Esta información se almacena únicamente en su dispositivo y se utiliza para cálculos de calorías.';

  @override
  String get onboarding_permissions => 'Paso final';

  @override
  String get onboarding_permissionsDesc =>
      'Habilite permisos para la mejor experiencia';

  @override
  String get onboarding_next => 'Continuar';

  @override
  String get onboarding_start => '¡Vamos!';

  @override
  String get onboarding_skipForNow => 'Configurar más tarde';

  @override
  String get waterAdded => '+250ml de agua añadidos';

  @override
  String get languageSelect => 'Seleccionar idioma';

  @override
  String get languageTurkish => 'turco';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get paywall_title => 'Actualizar a Premium';

  @override
  String get paywall_subtitle => 'Desbloquea todas las funciones';

  @override
  String get paywall_allPlans => 'Todos los planes de ayuno';

  @override
  String get paywall_advancedStats => 'Estadísticas avanzadas';

  @override
  String get paywall_mealPlanner => 'Planificador de comidas';

  @override
  String get paywall_healthKit => 'Integración de HealthKit';

  @override
  String get paywall_themes => 'Personalización del tema';

  @override
  String get paywall_noAds => 'Sin anuncios';

  @override
  String get paywall_weekly => 'Semanalmente';

  @override
  String get paywall_monthly => 'Mensual';

  @override
  String get paywall_yearly => 'Anual';

  @override
  String get paywall_bestValue => 'Mejor';

  @override
  String get paywall_freeTrial => 'Prueba gratuita (3 días)';

  @override
  String get paywall_restore => 'Restaurar compras';

  @override
  String get paywall_premiumActive => 'Premium Activo!';

  @override
  String get paywall_premiumActiveDesc => 'Desbloqueaste todas las funciones.';

  @override
  String get water_title => 'Ingesta de agua';

  @override
  String get water_addWater => 'agregar agua';

  @override
  String get water_goal => 'Meta';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'DE ACUERDO';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_save => 'Ahorrar';

  @override
  String get common_delete => 'Borrar';

  @override
  String get common_hours => 'horas';

  @override
  String get common_minutes => 'minutos';

  @override
  String get common_days => 'días';

  @override
  String get common_enable => 'Permitir';

  @override
  String get streakCard_currentStreak => 'Racha actual';

  @override
  String get streakCard_longestStreak => 'Racha más larga';

  @override
  String get streakCard_totalSessions => 'Ayunos totales';

  @override
  String get meals_mealType => 'Tipo de comida';

  @override
  String get meals_breakfast => 'Desayuno';

  @override
  String get meals_lunch => 'Almuerzo';

  @override
  String get meals_dinner => 'Cena';

  @override
  String get meals_snack => 'Bocadillo';

  @override
  String get meals_carbohydrate => 'Carbohidrato';

  @override
  String get meals_add => 'Agregar';

  @override
  String get meals_mealName => 'Nombre de la comida';

  @override
  String get bodyMetrics_title => 'Métricas corporales';

  @override
  String get bodyMetrics_weight => 'Peso';

  @override
  String get bodyMetrics_target => 'Objetivo';

  @override
  String get bodyMetrics_save => 'Ahorrar';

  @override
  String get bodyMetrics_history => 'Historia';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'IMC: $value';
  }

  @override
  String get bodyMetrics_noData => 'Aún no hay datos';

  @override
  String get meals_quickAdd => 'Agregar rápido';

  @override
  String get meals_manualEntry => 'Entrada manual';

  @override
  String meals_added(String name) {
    return '$name añadido';
  }

  @override
  String get meals_nameCalorieRequired => 'Se requieren nombre y calorías.';

  @override
  String get bodyMetrics_addWeight => 'Agregar peso';

  @override
  String get bodyMetrics_hintWeight => 'p.ej. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Introduzca un peso válido';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg ahorrados';
  }

  @override
  String get completion_duration => 'Duración';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Última Fase';

  @override
  String get timer_remainingTime => 'Tiempo restante';

  @override
  String get timer_ready => 'Listo para comenzar';

  @override
  String get streak_status => 'Estado';

  @override
  String get streak_startToday => '¡Empieza hoy!';

  @override
  String get streak_goodStart => '¡Buen comienzo!';

  @override
  String get streak_goingGreat => '¡Va genial!';

  @override
  String get streak_superb => '¡Magnífico!';

  @override
  String get streak_legendary => '¡Legendario!';

  @override
  String get streak_incredible => '¡Increíble!';

  @override
  String get weight_noRecord =>
      'Aún no hay registros de peso\nAgregar desde perfil > Métricas corporales';

  @override
  String get day_mon => 'Lun';

  @override
  String get day_tue => 'Mar';

  @override
  String get day_wed => 'Casarse';

  @override
  String get day_thu => 'Jue';

  @override
  String get day_fri => 'Vie';

  @override
  String get day_sat => 'Se sentó';

  @override
  String get day_sun => 'Sol';

  @override
  String get day_short_mon => 'METRO';

  @override
  String get day_short_tue => 't';

  @override
  String get day_short_wed => 'W.';

  @override
  String get day_short_thu => 't';

  @override
  String get day_short_fri => 'F';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'S';

  @override
  String get month_jan => 'Enero';

  @override
  String get month_feb => 'Febrero';

  @override
  String get month_mar => 'Marzo';

  @override
  String get month_apr => 'Abril';

  @override
  String get month_may => 'Puede';

  @override
  String get month_jun => 'Junio';

  @override
  String get month_jul => 'Julio';

  @override
  String get month_aug => 'Agosto';

  @override
  String get month_sep => 'Septiembre';

  @override
  String get month_oct => 'Octubre';

  @override
  String get month_nov => 'Noviembre';

  @override
  String get month_dec => 'Diciembre';

  @override
  String meals_fastingWindow(String hours) {
    return 'Ayuno (${hours}h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Comer (${hours}h)';
  }

  @override
  String get recipe_oatSmoothie => 'Batido de avena';

  @override
  String get recipe_avocadoToast => 'Tostada De Aguacate';

  @override
  String get recipe_yogurtBowl => 'Tazón de yogur';

  @override
  String get elapsed_time => 'Tiempo transcurrido';

  @override
  String get fast_ends_on => 'Tu ayuno termina en';

  @override
  String get end_fasting => 'Terminar el ayuno';

  @override
  String get start_fasting => 'Empezar a ayunar';

  @override
  String get water_tracker => 'Rastreador de agua';

  @override
  String get weight_tracker => 'Rastreador de peso';

  @override
  String get drink => 'Beber';

  @override
  String get log_weight => 'Peso del tronco';

  @override
  String get bmi => 'IMC';

  @override
  String get weight_lost => 'Peso perdido';

  @override
  String get current_weight => 'Peso actual';

  @override
  String get goal_weight => 'Peso objetivo';

  @override
  String get daily_goal => 'Objetivo diario';

  @override
  String completed_percent(String percent) {
    return '$percent% completado';
  }

  @override
  String get explore => 'Explorar';

  @override
  String get achievements => 'Logros';

  @override
  String get profile_theme => 'Apariencia';

  @override
  String get theme_select => 'Elige apariencia';

  @override
  String get theme_system => 'Valor predeterminado del sistema';

  @override
  String get theme_light => 'Luz';

  @override
  String get theme_dark => 'Oscuro';

  @override
  String get language_system => 'Idioma del sistema';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'alemán';

  @override
  String get languageFrench => 'francés';

  @override
  String get profile_completionSound => 'Sonido de finalización';

  @override
  String get profile_calmGamification => 'Gamificación tranquila';

  @override
  String get profile_calmGamificationDesc =>
      'Reduce la presión de la liga y la temporada.';

  @override
  String get profile_editName => 'Edita tu nombre';

  @override
  String get profile_name => 'Nombre';

  @override
  String get circle_title => 'Círculo de ayuno';

  @override
  String get circle_you => 'Tú';

  @override
  String get circle_tagline => 'Juntos, sin presiones.';

  @override
  String get circle_privacy =>
      'El peso y las métricas privadas permanecen ocultas. Sólo el progreso y el apoyo son visibles.';

  @override
  String circle_sendSupport(int count) {
    return 'Enviar soporte · $count';
  }

  @override
  String get circle_inviteCopied => 'Código de invitación copiado';

  @override
  String get circle_createInvite => 'Crear invitación privada';

  @override
  String get crisis_nameTitle => 'Primero, nombra lo que está sucediendo.';

  @override
  String get crisis_nameDesc => 'Puede ser hambre, hábito o emoción.';

  @override
  String get crisis_waterTitle => 'Bebe un vaso de agua';

  @override
  String get crisis_waterDesc => 'Luego haz tres respiraciones lentas.';

  @override
  String get crisis_delayTitle => 'Retrasar la decisión durante 10 minutos.';

  @override
  String get crisis_delayDesc =>
      'Si no se siente bien, poner fin al ayuno no es un fracaso.';

  @override
  String get crisis_hunger => 'Hambre';

  @override
  String get crisis_habit => 'Hábito';

  @override
  String get crisis_stress => 'Estrés';

  @override
  String get crisis_tenMore => 'Dale 10 minutos';

  @override
  String get stats_storyEmpty =>
      'Tu primer ayuno comenzará tu historia personal.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Ayunaste $sessions veces durante este período, mantuviste tu ritmo durante $hours horas y alcanzaste una tasa de finalización de $rate%.';
  }

  @override
  String get stats_storyTitle => 'La historia de tu ritmo.';

  @override
  String get home_todayRhythm => 'El ritmo de hoy';

  @override
  String get home_finalHourSupport => 'Soporte de última hora';

  @override
  String get home_needSupport => 'necesito un poco de apoyo';

  @override
  String get home_todaySummary => 'Hoy de un vistazo';

  @override
  String get home_dayStreak => 'racha de dias';

  @override
  String home_weightGoal(String weight) {
    return 'objetivo $weight kg';
  }

  @override
  String get weather_steady => 'Tu ritmo es constante';

  @override
  String get weather_gentle => 'un dia suave';

  @override
  String get weather_water => 'Un vaso de agua puede ayudar.';

  @override
  String get weather_listen => 'Has llegado lejos; escucha tu cuerpo.';

  @override
  String get weather_onPlan => 'El ritmo de hoy coincide con su plan.';

  @override
  String get weather_challenging =>
      'Esta hora antes era desafiante; El modo de soporte está listo.';

  @override
  String get replay_copied => 'Repetición del ayuno copiada';

  @override
  String get replay_button => 'Repetición';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Completé mi $plan rápido en ${hours}h ${minutes}m · $phase';
  }

  @override
  String get journey_label => 'Viaje metabólico';

  @override
  String get journey_now => 'Ahora';

  @override
  String journey_next(String time, String phase) {
    return '$time hasta $phase';
  }

  @override
  String get phase_estimateShort =>
      'El tiempo de fase es una estimación general, no una medición médica.';

  @override
  String phase_hours(int start, int end) {
    return 'Horas $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Este momento es una estimación general. Las respuestas metabólicas pueden variar entre personas.';

  @override
  String get bmi_underweight => 'Bajo peso';

  @override
  String get bmi_normal => 'Normal';

  @override
  String get bmi_overweight => 'Sobrepeso';

  @override
  String get bmi_obese => 'Obeso';

  @override
  String get notification_halfwayTitle => '¡A mitad de camino! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Completaste la mitad de tu $plan rápidamente. ¡Sigue adelante!';
  }

  @override
  String get notification_phaseCatabolic => 'Entró en fase catabólica 📉';

  @override
  String get notification_phaseFatBurning => '¡Comenzó la quema de grasa! 🔥';

  @override
  String get notification_phaseKetosis => 'Estás en cetosis ⚡';

  @override
  String get notification_phaseAutophagy => '¡Autofagia activa! 🔄';

  @override
  String notification_completedBody(String plan) {
    return '¡Completaste tu $plan rápidamente! Tu ventana para comer está abierta.';
  }

  @override
  String get notification_waterTitle => 'Bebe agua 💧';

  @override
  String get notification_waterBody =>
      '¡No olvides beber mucha agua mientras ayunas!';

  @override
  String get notification_windowTitle => 'Comer Ventana Cerrándose ⏰';

  @override
  String get notification_windowBody =>
      'Su ventana para comer se cerrará en 30 minutos.';

  @override
  String notification_streakTitle(int days) {
    return '$days ¡Racha de días! 🔥';
  }

  @override
  String get notification_streakBody =>
      '¡Lo estás haciendo genial! Sigue así hoy.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Ayuno en progreso - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Restante: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Ayuno iniciado - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Objetivo: horas $hours';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get explore_guide => 'Guía de ayuno';

  @override
  String get explore_guideDesc =>
      'Todo lo que necesitas saber sobre el ayuno intermitente';

  @override
  String get explore_circleDesc =>
      'Comparte apoyo silencioso con tu grupo privado.';

  @override
  String get explore_faq => 'Preguntas frecuentes';

  @override
  String get explore_education =>
      'Este contenido es solo para educación general y no es un diagnóstico médico ni un consejo de tratamiento.';

  @override
  String get explore_safety => 'Salud y seguridad';

  @override
  String get explore_safetyDesc =>
      'Si tiene una condición médica, toma medicamentos regularmente, tiene síntomas preocupantes, está embarazada o amamantando, consulte a un profesional de la salud calificado antes de ayunar. Deténgase si no se siente bien.';

  @override
  String get explore_sources => 'Fuentes';

  @override
  String get explore_sourcesDesc =>
      'El contenido se simplifica a partir de las referencias de salud pública que aparecen a continuación.';

  @override
  String get explore_sourceError => 'No se pudo abrir la fuente.';

  @override
  String get explore_rules => 'Reglas importantes';

  @override
  String get explore_rule1 =>
      'No consumir alimentos calóricos durante el ayuno';

  @override
  String get explore_rule2 => 'Beba mucha agua y líquidos.';

  @override
  String get explore_rule3 =>
      'Coma equilibrado durante su período de alimentación';

  @override
  String get explore_rule4 => 'Deja de ayunar si no te sientes bien';

  @override
  String get explore_rule5 =>
      'Las mujeres embarazadas o en período de lactancia no deben ayunar';

  @override
  String get explore_rule6 =>
      'Consulta a tu médico si tienes enfermedades crónicas.';

  @override
  String get tip_water => 'Mantente hidratado';

  @override
  String get tip_waterDesc =>
      'Beba agua cuando tenga sed e incluya líquidos con las comidas. Las necesidades pueden variar según la salud, el clima y la actividad.';

  @override
  String get tip_food => 'comer bien';

  @override
  String get tip_foodDesc =>
      'Durante las ventanas para comer, elija alimentos ricos en proteínas, con fibra y grasas saludables. Evite los alimentos procesados.';

  @override
  String get tip_sleep => 'Dormir bien';

  @override
  String get tip_sleepDesc =>
      'Dormir lo suficiente y con regularidad contribuye al bienestar general. Programe el ayuno para que no interrumpa su sueño.';

  @override
  String get tip_exercise => 'Ejercicio ligero';

  @override
  String get tip_exerciseDesc =>
      'Puedes hacer caminatas ligeras o yoga en ayunas. Evite el ejercicio intenso, especialmente durante las primeras semanas hasta que su cuerpo se adapte.';

  @override
  String get tip_drinks => 'Bebidas permitidas';

  @override
  String get tip_drinksDesc =>
      'Durante el ayuno, puedes consumir agua, té natural y café negro (sin azúcar ni leche). Estas bebidas no romperán tu ayuno.';

  @override
  String get faq_drinks => '¿Qué puedo beber durante el ayuno?';

  @override
  String get faq_drinksAnswer =>
      'Puede beber agua, té simple y café negro (sin azúcar ni leche). Las bebidas calóricas rompen el ayuno.';

  @override
  String get faq_plan => '¿Qué plan de ayuno debo elegir?';

  @override
  String get faq_planAnswer =>
      'Si eres nuevo, comienza con las 12:12 o 14:10. Si tiene experiencia, pruebe con 16:8 o 18:6. 20:4 y OMAD son para ayunadores avanzados.';

  @override
  String get faq_exercise => '¿Puedo hacer ejercicio en ayunas?';

  @override
  String get faq_exerciseAnswer =>
      'Sí, pero evita los entrenamientos intensos. Lo ideal son ejercicios cardiovasculares ligeros, caminar y yoga. Si levanta pesas, programe un horario cerca de su ventana para comer.';

  @override
  String get faq_weight => '¿El ayuno ayuda a perder peso?';

  @override
  String get faq_weightAnswer =>
      'Para algunas personas, limitar el tiempo para comer puede reducir la ingesta total de energía. Los resultados varían y todavía se están estudiando los efectos a largo plazo.';

  @override
  String get plan_12_desc => 'Nivel principiante';

  @override
  String get plan_12_detail =>
      'Ideal para principiantes. Ayuno 12 horas incluyendo tu tiempo de sueño.';

  @override
  String get plan_16_desc => 'plan más popular';

  @override
  String get plan_16_detail =>
      'El plan IF más común. 16 horas de ayuno, 8 horas de ventana para comer. Generalmente desde el almuerzo hasta la cena.';

  @override
  String get plan_18_desc => 'nivel intermedio';

  @override
  String get plan_18_detail =>
      '18 horas de ayuno, 6 horas de ventana para comer. Mayor duración de la quema de grasas.';

  @override
  String get plan_20_desc => 'nivel avanzado';

  @override
  String get plan_20_detail =>
      '20 horas de ayuno, 4 horas de ventana para comer. Ideal para alcanzar cetosis y autofagia.';

  @override
  String get plan_omad_desc => 'Una comida al dia';

  @override
  String get plan_omad_detail =>
      'Una comida al día. 23 horas de ayuno, 1 hora de ventana para comer. Nivel experto.';

  @override
  String get plan_52_desc => '2 días por semana';

  @override
  String get plan_52_detail =>
      'Coma normalmente durante 5 días, sólo ~500 calorías en 2 días. Un enfoque alternativo.';

  @override
  String get plan_ese_desc => 'ayuno de 24 horas';

  @override
  String get plan_ese_detail =>
      'Ayune durante 24 horas 1 o 2 veces por semana. Para usuarios avanzados.';

  @override
  String get plan_warrior_desc => 'Dieta del guerrero';

  @override
  String get plan_warrior_detail =>
      'Coma ligero durante el día (frutas, verduras), tome su comida principal en un período de 4 horas por la noche.';

  @override
  String get award_first_title => 'Primer paso';

  @override
  String get award_first_desc => 'Completa tu primer ayuno';

  @override
  String get award_rhythm3_title => 'Ritmo de 3 días';

  @override
  String get award_rhythm3_desc => 'Mantén tu ritmo durante tres días';

  @override
  String get award_hours24_title => '24 Horas';

  @override
  String get award_hours24_desc => 'Ayuno durante 24 horas en total.';

  @override
  String get award_week_title => 'Ritmo de una semana';

  @override
  String get award_week_desc => 'Crea una racha de siete días';

  @override
  String get award_fasts10_title => '10 ayunos';

  @override
  String get award_fasts10_desc => 'Completa diez ayunos';

  @override
  String get award_hours100_title => '100 horas';

  @override
  String get award_hours100_desc => 'Llegar a 100 horas totales';

  @override
  String get award_rhythm30_title => 'Ritmo de 30 días';

  @override
  String get award_rhythm30_desc => 'Construya una racha de treinta días';

  @override
  String get award_fasts50_title => '50 ayunos';

  @override
  String get award_fasts50_desc => 'Completa cincuenta ayunos';

  @override
  String get award_hours500_title => '500 horas';

  @override
  String get award_hours500_desc => 'Llegar a 500 horas totales';

  @override
  String get award_fasts100_title => '100 ayunos';

  @override
  String get award_fasts100_desc => 'Completa cien ayunos';

  @override
  String get award_rhythm90_title => 'Ritmo de 90 días';

  @override
  String get award_rhythm90_desc => 'Construya una racha de noventa días';

  @override
  String get award_year_title => 'Viaje de un año';

  @override
  String get award_year_desc => 'Alcanza un ritmo de 365 días';

  @override
  String get awards_loadError => 'El progreso no se pudo cargar';

  @override
  String get awards_journeyComplete => 'Viaje completo';

  @override
  String get awards_nextGoal => 'Próximo objetivo';

  @override
  String get awards_allYours => 'Cada logro es tuyo';

  @override
  String get awards_dayStreak => 'racha de dias';

  @override
  String get awards_fasts => 'ayunos';

  @override
  String get awards_total => 'total';

  @override
  String get awards_stageStart => 'Comenzar';

  @override
  String get awards_stageRhythm => 'Ritmo';

  @override
  String get awards_stageEndurance => 'Resistencia';

  @override
  String get awards_stageMastery => 'Maestría';

  @override
  String get awards_completed => 'Terminado';

  @override
  String awards_fastsRemaining(int count) {
    return '$count ayuna para llevar';
  }

  @override
  String awards_daysRemaining(int count) {
    return '$count quedan días';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count horas restantes';
  }

  @override
  String get common_retry => 'Intentar otra vez';

  @override
  String get game_title => 'Centro de progreso';

  @override
  String get game_quests => 'Las misiones de hoy';

  @override
  String get game_questsDesc => 'Pequeños pasos, ritmo sostenible.';

  @override
  String get game_season => 'temporada de 30 pasos';

  @override
  String get game_seasonDesc => 'Un sello coleccionable cada cinco pasos.';

  @override
  String get game_badges => 'Colección de insignias';

  @override
  String game_shields(int count) {
    return 'Escudos de ritmo $count';
  }

  @override
  String get game_shieldsDesc =>
      'Obtenido cada siete completaciones. Un día perdido nunca borra tu progreso.';

  @override
  String get game_league => 'Liga semanal privada';

  @override
  String game_leagueDesc(int percent) {
    return 'Su puntuación de ritmo está en el percentil $percent de un modelo local privado. El peso y el ayuno extremo nunca se clasifican.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Nivel $level, puntos de experiencia $xp';
  }

  @override
  String get game_explorer => 'Explorador de ritmo';

  @override
  String get game_streak => 'Racha';

  @override
  String get game_targets => 'Objetivos';

  @override
  String get game_best => 'Mejor';

  @override
  String get quest_rhythm => 'Construye el ritmo de hoy';

  @override
  String get quest_hydrate => 'Alcanza la mitad de tu objetivo de agua';

  @override
  String get quest_steady => 'Protege tu racha';

  @override
  String get badge_first_title => 'Primer paso';

  @override
  String get badge_first_desc => 'Registra tu primer ayuno';

  @override
  String get badge_rhythm7_title => 'Guardián del ritmo';

  @override
  String get badge_rhythm7_desc => 'Alcanza una racha de 7 días';

  @override
  String get badge_rhythm3_title => 'Ritmo de tres días';

  @override
  String get badge_rhythm3_desc => 'Alcanza una racha de 3 días';

  @override
  String get badge_target1_title => 'Primer objetivo';

  @override
  String get badge_target1_desc => 'Completa tu primer objetivo rápidamente';

  @override
  String get badge_target3_title => 'Tres pasos';

  @override
  String get badge_target3_desc => 'Completa 3 objetivos';

  @override
  String get badge_water_title => 'Equilibrado';

  @override
  String get badge_water_desc => 'Completa el objetivo diario de agua.';

  @override
  String get badge_support_title => 'Autoconsciente';

  @override
  String get badge_support_desc => 'Usar el modo de soporte';

  @override
  String get badge_hours10_title => '10 horas';

  @override
  String get badge_hours10_desc => 'Registra 10 horas en total';

  @override
  String get badge_target10_title => 'Diez fuertes';

  @override
  String get badge_target10_desc => 'Completa 10 objetivos';

  @override
  String get badge_target20_title => 'Veinte objetivos';

  @override
  String get badge_target20_desc => 'Completa 20 objetivos';

  @override
  String get badge_fast16_title => '16 horas';

  @override
  String get badge_fast16_desc => 'Llega a las 16 horas en un ayuno';

  @override
  String get badge_hours50_title => '50 horas';

  @override
  String get badge_hours50_desc => 'Registra 50 horas en total';

  @override
  String get badge_hours100_title => 'cien horas';

  @override
  String get badge_hours100_desc => 'Registrar 100 horas totales';

  @override
  String get badge_target30_title => 'Treinta objetivos';

  @override
  String get badge_target30_desc => 'Completa 30 objetivos';

  @override
  String get badge_rhythm30_title => 'Ritmo de 30 días';

  @override
  String get badge_rhythm30_desc => 'Alcanza una racha de 30 días';

  @override
  String get paywall_restoreSuccess => '¡Compras restauradas!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Progreso en ayunas $percent por ciento';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}h';
  }

  @override
  String get paywall_lifetime => 'De por vida';

  @override
  String get paywall_once => 'pago único';

  @override
  String get paywall_processing => 'Procesando…';

  @override
  String get paywall_continue => 'Continuar';

  @override
  String get paywall_productsUnavailable =>
      'Las compras no están disponibles ahora. Inténtalo de nuevo más tarde.';

  @override
  String get paywall_purchaseFailed => 'No se pudo completar la compra.';

  @override
  String get paywall_nothingToRestore =>
      'No se encontró ninguna compra anterior.';

  @override
  String get paywall_restoreFailed => 'No se pudieron restaurar las compras.';

  @override
  String get paywall_terms => 'Términos de uso';

  @override
  String get permission_notificationDesc =>
      'Recordatorios de ayuno, cambios de fase y avisos de finalización';

  @override
  String get permission_healthTitle => 'Health Connect / HealthKit';

  @override
  String get permission_healthDesc =>
      'Sincroniza pasos, calorías activas y peso con tu permiso';

  @override
  String get profile_privacyChoices => 'Opciones de privacidad';

  @override
  String get paywall_autoRenewInfo =>
      'Las suscripciones se renuevan automáticamente salvo que se cancelen al menos 24 horas antes del fin del periodo. Gestiónalas en los ajustes de la App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / mes';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Ahorra $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days días de prueba gratis';
  }

  @override
  String get paywall_startFreeTrial => 'Iniciar prueba gratis';

  @override
  String get paywall_retry => 'Reintentar';

  @override
  String get paywall_alreadyOwned =>
      'Ya tienes esta suscripción. Toca «Restaurar compras».';

  @override
  String get paywall_storeUnavailable =>
      'No se puede conectar con la tienda. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get paywall_secureNote =>
      'Cancela cuando quieras. El pago se carga a tu cuenta de la tienda.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Las suscripciones se renuevan automáticamente salvo que se cancelen al menos 24 horas antes del final del periodo. Gestiónalas o cancélalas cuando quieras en Google Play > Suscripciones.';

  @override
  String get paywall_healthConnect => 'Integración con Health Connect';
}
