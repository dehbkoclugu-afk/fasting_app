// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Bom dia';

  @override
  String get greeting_afternoon => 'Boa tarde';

  @override
  String get greeting_evening => 'Boa noite';

  @override
  String get tab_timer => 'Lar';

  @override
  String get tab_explore => 'Explorar';

  @override
  String get tab_stats => 'Relatório';

  @override
  String get tab_meals => 'Refeições';

  @override
  String get tab_achievements => 'Prêmios';

  @override
  String get tab_profile => 'Conta';

  @override
  String get timer_fasting => 'Tempo de jejum';

  @override
  String get timer_remaining => 'Restante';

  @override
  String get timer_elapsed => 'Decorrido';

  @override
  String get timer_start => 'Começar';

  @override
  String get timer_stop => 'Parar';

  @override
  String get timer_completed => 'Parabéns!';

  @override
  String get timer_completedMessage => 'Você completou seu jejum com sucesso!';

  @override
  String get timer_selectPlan => 'Selecione o plano de jejum';

  @override
  String get timer_stopConfirm =>
      'Tem certeza de que deseja encerrar o jejum mais cedo?';

  @override
  String get timer_stopTitle => 'Fim rápido';

  @override
  String get timer_cancel => 'Cancelar';

  @override
  String get timer_confirmStop => 'Sim, fim';

  @override
  String get phase_anabolic => 'Anabólico';

  @override
  String get phase_anabolicDesc => 'Digestão em andamento';

  @override
  String get phase_catabolic => 'Catabólico';

  @override
  String get phase_catabolicDesc => 'Transição energética';

  @override
  String get phase_fatBurning => 'Queima de gordura';

  @override
  String get phase_fatBurningDesc => 'Começou a queima de gordura';

  @override
  String get phase_ketosis => 'Cetose';

  @override
  String get phase_ketosisDesc => 'Produção de cetona ativa';

  @override
  String get phase_autophagy => 'Autofagia';

  @override
  String get phase_autophagyDesc => 'Renovação celular';

  @override
  String get stats_title => 'Estatísticas';

  @override
  String get stats_week => 'Semana';

  @override
  String get stats_month => 'Mês';

  @override
  String get stats_year => 'Ano';

  @override
  String get stats_totalFasts => 'Jejuns totais';

  @override
  String get stats_average => 'Média';

  @override
  String get stats_fastDuration => 'duração rápida';

  @override
  String get stats_streak => 'Onda';

  @override
  String get stats_daysConsecutive => 'dias consecutivos';

  @override
  String get stats_success => 'Sucesso';

  @override
  String get stats_completion => 'conclusão';

  @override
  String get stats_weeklyFasting => 'Jejum Semanal';

  @override
  String get stats_monthlyView => 'Visualização Mensal';

  @override
  String get stats_weightChange => 'Mudança de peso';

  @override
  String get heatmap_none => 'Nenhum';

  @override
  String get heatmap_low => 'Baixo';

  @override
  String get heatmap_good => 'Bom';

  @override
  String get heatmap_full => 'Completo';

  @override
  String get meals_title => 'Planejador de refeições';

  @override
  String get meals_eatingWindow => 'Janela de comer';

  @override
  String get meals_windowOpen => 'Abrir';

  @override
  String get meals_windowFasting => 'Jejum';

  @override
  String get meals_calories => 'Calorias';

  @override
  String get meals_protein => 'Proteína';

  @override
  String get meals_carbs => 'Carboidratos';

  @override
  String get meals_fat => 'Gordo';

  @override
  String get meals_todayMeals => 'Refeições de hoje';

  @override
  String get meals_noMeals => 'Nenhuma refeição adicionada ainda';

  @override
  String get meals_breakfastSuggestions => 'Sugestões para o café da manhã';

  @override
  String get meals_addMeal => 'Adicionar refeição';

  @override
  String get profile_title => 'Perfil';

  @override
  String get profile_user => 'Usuário';

  @override
  String profile_planActive(String plan) {
    return 'Plano $plan ativo';
  }

  @override
  String get profile_upgradePremium => 'Atualizar para Premium';

  @override
  String get profile_premiumDesc => 'Todos os planos de jejum, sem anúncios';

  @override
  String get profile_bodyMetrics => 'Métricas Corporais';

  @override
  String get profile_height => 'Altura';

  @override
  String get profile_weight => 'Peso';

  @override
  String get profile_targetWeight => 'Peso Alvo';

  @override
  String get profile_bmi => 'IMC';

  @override
  String get profile_settings => 'Configurações';

  @override
  String get profile_notifications => 'Notificações';

  @override
  String get profile_darkTheme => 'Tema escuro';

  @override
  String get profile_waterReminder => 'Lembrete de água';

  @override
  String get profile_phaseNotifications => 'Notificações de Fase';

  @override
  String get profile_language => 'Linguagem';

  @override
  String get profile_about => 'Sobre';

  @override
  String get profile_rateApp => 'Avaliar aplicativo';

  @override
  String get profile_share => 'Compartilhar';

  @override
  String get profile_privacyPolicy => 'política de Privacidade';

  @override
  String get profile_version => 'Versão';

  @override
  String get onboarding_welcome => 'Bem-vindo';

  @override
  String get onboarding_welcomeDesc =>
      'Assuma o controle do seu\njornada de jejum intermitente';

  @override
  String get onboarding_featureTimer => 'Temporizador de jejum inteligente';

  @override
  String get onboarding_featureStats => 'Estatísticas e gráficos detalhados';

  @override
  String get onboarding_featureMeals =>
      'Planejador de refeições e sugestões de receitas';

  @override
  String get onboarding_getStarted => 'Comece';

  @override
  String get onboarding_selectGoal => 'Qual é o seu objetivo?';

  @override
  String get onboarding_selectGoalDesc => 'Você pode selecionar vários';

  @override
  String get onboarding_goalWeight => 'Perder peso';

  @override
  String get onboarding_goalWeightDesc => 'Perda de peso saudável';

  @override
  String get onboarding_goalHealth => 'Melhorar a saúde';

  @override
  String get onboarding_goalHealthDesc => 'Saúde geral e imunidade';

  @override
  String get onboarding_goalEnergy => 'Mais energia';

  @override
  String get onboarding_goalEnergyDesc => 'Energia ao longo do dia';

  @override
  String get onboarding_goalMental => 'Clareza Mental';

  @override
  String get onboarding_goalMentalDesc => 'Foco e clareza';

  @override
  String get onboarding_goalLongevity => 'Longevidade';

  @override
  String get onboarding_goalLongevityDesc =>
      'Renovação celular e antienvelhecimento';

  @override
  String get onboarding_goalDiscipline => 'Disciplina';

  @override
  String get onboarding_goalDisciplineDesc => 'Desenvolva autodisciplina';

  @override
  String get onboarding_selectPlan => 'Escolha o seu plano';

  @override
  String get onboarding_selectPlanDesc =>
      'Selecione o melhor plano de jejum para você';

  @override
  String get onboarding_bodyInfo => 'Insira suas informações';

  @override
  String get onboarding_bodyInfoDesc => 'Para recomendações personalizadas';

  @override
  String get onboarding_gender => 'Gênero';

  @override
  String get onboarding_male => 'Macho';

  @override
  String get onboarding_female => 'Fêmea';

  @override
  String get onboarding_age => 'Idade';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Essas informações são armazenadas apenas no seu dispositivo e usadas para cálculos de calorias.';

  @override
  String get onboarding_permissions => 'Etapa final';

  @override
  String get onboarding_permissionsDesc =>
      'Habilite permissões para a melhor experiência';

  @override
  String get onboarding_next => 'Continuar';

  @override
  String get onboarding_start => 'Vamos!';

  @override
  String get onboarding_skipForNow => 'Configurar mais tarde';

  @override
  String get waterAdded => '+250ml de água adicionada';

  @override
  String get languageSelect => 'Selecione o idioma';

  @override
  String get languageTurkish => 'Turquia';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get paywall_title => 'Atualizar para Premium';

  @override
  String get paywall_subtitle =>
      'Desbloqueia todos os planos de jejum e remove os anúncios';

  @override
  String get paywall_allPlans => 'Todos os planos de jejum';

  @override
  String get paywall_advancedStats => 'Estatísticas avançadas';

  @override
  String get paywall_mealPlanner => 'Planejador de refeições';

  @override
  String get paywall_themes => 'Personalização do tema';

  @override
  String get paywall_noAds => 'Sem anúncios';

  @override
  String get paywall_weekly => 'Semanalmente';

  @override
  String get paywall_monthly => 'Mensal';

  @override
  String get paywall_yearly => 'Anual';

  @override
  String get paywall_bestValue => 'Melhor';

  @override
  String get paywall_freeTrial => 'Avaliação gratuita (3 dias)';

  @override
  String get paywall_restore => 'Restaurar compras';

  @override
  String get paywall_premiumActive => 'Ativo Premium!';

  @override
  String get paywall_premiumActiveDesc =>
      'Todos os planos de jejum estão desbloqueados e os anúncios desativados';

  @override
  String get water_title => 'Ingestão de água';

  @override
  String get water_addWater => 'Adicionar água';

  @override
  String get water_goal => 'Meta';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_save => 'Salvar';

  @override
  String get common_delete => 'Excluir';

  @override
  String get common_hours => 'horas';

  @override
  String get common_minutes => 'minutos';

  @override
  String get common_days => 'dias';

  @override
  String get common_enable => 'Habilitar';

  @override
  String get streakCard_currentStreak => 'Sequência Atual';

  @override
  String get streakCard_longestStreak => 'Sequência mais longa';

  @override
  String get streakCard_totalSessions => 'Jejuns totais';

  @override
  String get meals_mealType => 'Tipo de refeição';

  @override
  String get meals_breakfast => 'Café da manhã';

  @override
  String get meals_lunch => 'Almoço';

  @override
  String get meals_dinner => 'Jantar';

  @override
  String get meals_snack => 'Lanche';

  @override
  String get meals_carbohydrate => 'Carboidrato';

  @override
  String get meals_add => 'Adicionar';

  @override
  String get meals_mealName => 'Nome da refeição';

  @override
  String get bodyMetrics_title => 'Métricas Corporais';

  @override
  String get bodyMetrics_weight => 'Peso';

  @override
  String get bodyMetrics_target => 'Alvo';

  @override
  String get bodyMetrics_save => 'Salvar';

  @override
  String get bodyMetrics_history => 'História';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'IMC: $value';
  }

  @override
  String get bodyMetrics_noData => 'Ainda não há dados';

  @override
  String get meals_quickAdd => 'Adição rápida';

  @override
  String get meals_manualEntry => 'Entrada manual';

  @override
  String meals_added(String name) {
    return '$name adicionado';
  }

  @override
  String get meals_nameCalorieRequired => 'Nome e calorias são obrigatórios';

  @override
  String get bodyMetrics_addWeight => 'Adicionar peso';

  @override
  String get bodyMetrics_hintWeight => 'por exemplo 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Insira um peso válido';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kg economizados';
  }

  @override
  String get completion_duration => 'Duração';

  @override
  String get completion_plan => 'Plano';

  @override
  String get completion_lastPhase => 'Última Fase';

  @override
  String get timer_remainingTime => 'Tempo restante';

  @override
  String get timer_ready => 'Pronto para começar';

  @override
  String get streak_status => 'Status';

  @override
  String get streak_startToday => 'Comece hoje!';

  @override
  String get streak_goodStart => 'Bom começo!';

  @override
  String get streak_goingGreat => 'Está indo muito bem!';

  @override
  String get streak_superb => 'Excelente!';

  @override
  String get streak_legendary => 'Lendário!';

  @override
  String get streak_incredible => 'Incrível!';

  @override
  String get weight_noRecord =>
      'Ainda não há registros de peso\nAdicionar em Perfil> Métricas Corporais';

  @override
  String get day_mon => 'seg';

  @override
  String get day_tue => 'ter';

  @override
  String get day_wed => 'qua';

  @override
  String get day_thu => 'qui';

  @override
  String get day_fri => 'sex';

  @override
  String get day_sat => 'Sentado';

  @override
  String get day_sun => 'Sol';

  @override
  String get day_short_mon => 'M';

  @override
  String get day_short_tue => 'T';

  @override
  String get day_short_wed => 'C';

  @override
  String get day_short_thu => 'T';

  @override
  String get day_short_fri => 'F';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'S';

  @override
  String get month_jan => 'Janeiro';

  @override
  String get month_feb => 'Fevereiro';

  @override
  String get month_mar => 'Marchar';

  @override
  String get month_apr => 'abril';

  @override
  String get month_may => 'Poderia';

  @override
  String get month_jun => 'Junho';

  @override
  String get month_jul => 'Julho';

  @override
  String get month_aug => 'Agosto';

  @override
  String get month_sep => 'Setembro';

  @override
  String get month_oct => 'outubro';

  @override
  String get month_nov => 'novembro';

  @override
  String get month_dec => 'dezembro';

  @override
  String meals_fastingWindow(String hours) {
    return 'Jejum (${hours}h)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Comer (${hours}h)';
  }

  @override
  String get recipe_oatSmoothie => 'Batido de aveia';

  @override
  String get recipe_avocadoToast => 'Torrada de Abacate';

  @override
  String get recipe_yogurtBowl => 'Tigela de iogurte';

  @override
  String get elapsed_time => 'Tempo decorrido';

  @override
  String get fast_ends_on => 'Seu jejum termina em';

  @override
  String get end_fasting => 'Fim do jejum';

  @override
  String get start_fasting => 'Comece a jejuar';

  @override
  String get water_tracker => 'Rastreador de água';

  @override
  String get weight_tracker => 'Rastreador de peso';

  @override
  String get drink => 'Bebida';

  @override
  String get log_weight => 'Peso do registro';

  @override
  String get bmi => 'IMC';

  @override
  String get weight_lost => 'Peso perdido';

  @override
  String get current_weight => 'Peso atual';

  @override
  String get goal_weight => 'Meta de peso';

  @override
  String get daily_goal => 'Meta diária';

  @override
  String completed_percent(String percent) {
    return '$percent% Concluído';
  }

  @override
  String get explore => 'Explorar';

  @override
  String get achievements => 'Conquistas';

  @override
  String get profile_theme => 'Aparência';

  @override
  String get theme_select => 'Escolha a aparência';

  @override
  String get theme_system => 'Padrão do sistema';

  @override
  String get theme_light => 'Luz';

  @override
  String get theme_dark => 'Escuro';

  @override
  String get language_system => 'Idioma do sistema';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Alemão';

  @override
  String get languageFrench => 'Francês';

  @override
  String get profile_completionSound => 'Som de conclusão';

  @override
  String get profile_calmGamification => 'Gamificação calma';

  @override
  String get profile_calmGamificationDesc =>
      'Reduz a pressão da liga e da temporada';

  @override
  String get profile_editName => 'Edite seu nome';

  @override
  String get profile_name => 'Nome';

  @override
  String get circle_title => 'Círculo de Jejum';

  @override
  String get circle_you => 'Você';

  @override
  String get circle_tagline => 'Juntos, sem pressão.';

  @override
  String get circle_privacy =>
      'O peso e as métricas privadas permanecem ocultas. Apenas o progresso e o apoio são visíveis.';

  @override
  String circle_sendSupport(int count) {
    return 'Enviar suporte · $count';
  }

  @override
  String get circle_inviteCopied => 'Código de convite copiado';

  @override
  String get circle_createInvite => 'Criar convite privado';

  @override
  String get crisis_nameTitle => 'Primeiro, diga o que está acontecendo';

  @override
  String get crisis_nameDesc => 'Pode ser fome, hábito ou emoção.';

  @override
  String get crisis_waterTitle => 'Beba um copo de água';

  @override
  String get crisis_waterDesc => 'Em seguida, faça três respirações lentas.';

  @override
  String get crisis_delayTitle => 'Adie a decisão por 10 minutos';

  @override
  String get crisis_delayDesc =>
      'Se você não se sentir bem, terminar o jejum não é um fracasso.';

  @override
  String get crisis_hunger => 'Fome';

  @override
  String get crisis_habit => 'Hábito';

  @override
  String get crisis_stress => 'Estresse';

  @override
  String get crisis_tenMore => 'Dê 10 minutos';

  @override
  String get stats_storyEmpty =>
      'Seu primeiro jejum dará início à sua história pessoal.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'Você jejuou $sessions vezes neste período, manteve seu ritmo por $hours horas e atingiu uma taxa de conclusão de $rate%.';
  }

  @override
  String get stats_storyTitle => 'A história do seu ritmo';

  @override
  String get home_todayRhythm => 'O ritmo de hoje';

  @override
  String get home_finalHourSupport => 'Suporte de última hora';

  @override
  String get home_needSupport => 'Eu preciso de um pouco de apoio';

  @override
  String get home_todaySummary => 'Hoje em resumo';

  @override
  String get home_dayStreak => 'sequência do dia';

  @override
  String home_weightGoal(String weight) {
    return 'meta $weight kg';
  }

  @override
  String get weather_steady => 'Seu ritmo é constante';

  @override
  String get weather_gentle => 'Um dia gentil';

  @override
  String get weather_water => 'Um copo de água pode ajudar.';

  @override
  String get weather_listen => 'Você chegou longe; ouça seu corpo.';

  @override
  String get weather_onPlan => 'O ritmo de hoje corresponde ao seu plano.';

  @override
  String get weather_challenging =>
      'Esta hora foi desafiadora antes; o modo de suporte está pronto.';

  @override
  String get replay_copied => 'Repetição de jejum copiada';

  @override
  String get replay_button => 'Repetir';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Concluí meu $plan rápido em ${hours}h ${minutes}m · $phase';
  }

  @override
  String get journey_label => 'Jornada metabólica';

  @override
  String get journey_now => 'Agora';

  @override
  String journey_next(String time, String phase) {
    return '$time até $phase';
  }

  @override
  String get phase_estimateShort =>
      'O tempo da fase é uma estimativa geral, não uma medida médica.';

  @override
  String phase_hours(int start, int end) {
    return 'Horas $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Este momento é uma estimativa geral. As respostas metabólicas podem variar entre as pessoas.';

  @override
  String get bmi_underweight => 'Abaixo do peso';

  @override
  String get bmi_normal => 'Normal';

  @override
  String get bmi_overweight => 'Sobrepeso';

  @override
  String get bmi_obese => 'Obeso';

  @override
  String get notification_halfwayTitle => 'No meio do caminho! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Você completou metade do seu $plan rapidamente. Continue!';
  }

  @override
  String get notification_phaseCatabolic => 'Entrou na fase catabólica 📉';

  @override
  String get notification_phaseFatBurning => 'Começou a queima de gordura! 🔥';

  @override
  String get notification_phaseKetosis => 'Você está em cetose ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagia ativa! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Você completou seu $plan rapidamente! Sua janela de alimentação está aberta.';
  }

  @override
  String get notification_waterTitle => 'Beba Água 💧';

  @override
  String get notification_waterBody =>
      'Não se esqueça de beber bastante água durante o jejum!';

  @override
  String get notification_windowTitle => 'Comendo Janela Fechando ⏰';

  @override
  String get notification_windowBody =>
      'Sua janela de alimentação fechará em 30 minutos.';

  @override
  String notification_streakTitle(int days) {
    return 'Série de dias $days! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Você está indo muito bem! Continue assim hoje.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Jejum em andamento - $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Restante: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Jejum iniciado - $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Meta: horas $hours';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get explore_guide => 'Guia de jejum';

  @override
  String get explore_guideDesc =>
      'Tudo o que você precisa saber sobre jejum intermitente';

  @override
  String get explore_circleDesc =>
      'Compartilhe suporte silencioso com seu grupo privado.';

  @override
  String get explore_faq => 'Perguntas frequentes';

  @override
  String get explore_education =>
      'Este conteúdo é apenas para educação geral e não constitui diagnóstico médico ou conselho de tratamento.';

  @override
  String get explore_safety => 'Saúde e segurança';

  @override
  String get explore_safetyDesc =>
      'Se você tem algum problema de saúde, toma medicamentos regularmente, apresenta sintomas preocupantes, está grávida ou amamentando, consulte um profissional de saúde qualificado antes de jejuar. Pare se você não se sentir bem.';

  @override
  String get explore_sources => 'Fontes';

  @override
  String get explore_sourcesDesc =>
      'O conteúdo é simplificado a partir das referências de saúde pública abaixo.';

  @override
  String get explore_sourceError => 'A fonte não pôde ser aberta';

  @override
  String get explore_rules => 'Regras importantes';

  @override
  String get explore_rule1 => 'Não consuma alimentos calóricos durante o jejum';

  @override
  String get explore_rule2 => 'Beba bastante água e líquidos';

  @override
  String get explore_rule3 =>
      'Coma de forma equilibrada durante sua janela de alimentação';

  @override
  String get explore_rule4 => 'Pare de jejuar se não se sentir bem';

  @override
  String get explore_rule5 =>
      'Mulheres grávidas ou amamentando não devem jejuar';

  @override
  String get explore_rule6 =>
      'Consulte seu médico se você tiver doenças crônicas';

  @override
  String get tip_water => 'Mantenha-se hidratado';

  @override
  String get tip_waterDesc =>
      'Beba água quando estiver com sede e inclua líquidos nas refeições. As necessidades podem variar de acordo com a saúde, o clima e a atividade.';

  @override
  String get tip_food => 'Coma bem';

  @override
  String get tip_foodDesc =>
      'Durante as janelas de alimentação, escolha alimentos ricos em proteínas, com fibras e gorduras saudáveis. Evite alimentos processados.';

  @override
  String get tip_sleep => 'Durma bem';

  @override
  String get tip_sleepDesc =>
      'O sono regular e suficiente apoia o bem-estar geral. Programe o jejum para não atrapalhar seu sono.';

  @override
  String get tip_exercise => 'Exercício leve';

  @override
  String get tip_exerciseDesc =>
      'Você pode fazer caminhadas leves ou ioga em jejum. Evite exercícios pesados, especialmente durante as primeiras semanas, até que seu corpo se adapte.';

  @override
  String get tip_drinks => 'Bebidas permitidas';

  @override
  String get tip_drinksDesc =>
      'Durante o jejum, você pode consumir água, chá puro e café preto (sem açúcar, sem leite). Essas bebidas não vão quebrar o seu jejum.';

  @override
  String get faq_drinks => 'O que posso beber durante o jejum?';

  @override
  String get faq_drinksAnswer =>
      'Você pode beber água, chá puro e café preto (sem açúcar/leite). Bebidas calóricas quebram o jejum.';

  @override
  String get faq_plan => 'Qual plano de jejum devo escolher?';

  @override
  String get faq_planAnswer =>
      'Se você é novo, comece com 12h12 ou 14h10. Se tiver experiência, tente 16:8 ou 18:6. 20:4 e OMAD são para jejuadores avançados.';

  @override
  String get faq_exercise => 'Posso fazer exercícios em jejum?';

  @override
  String get faq_exerciseAnswer =>
      'Sim, mas evite treinos intensos. Cardio leve, caminhada e ioga são ideais. Se estiver levantando pesos, agende próximo à janela de alimentação.';

  @override
  String get faq_weight => 'O jejum ajuda na perda de peso?';

  @override
  String get faq_weightAnswer =>
      'Para algumas pessoas, limitar o tempo de alimentação pode reduzir a ingestão total de energia. Os resultados variam e os efeitos a longo prazo ainda estão sendo estudados.';

  @override
  String get plan_12_desc => 'Nível iniciante';

  @override
  String get plan_12_detail =>
      'Ideal para iniciantes. Jejue 12 horas incluindo o tempo de sono.';

  @override
  String get plan_16_desc => 'Plano mais popular';

  @override
  String get plan_16_detail =>
      'O plano IF mais comum. 16 horas de jejum, 8 horas de janela para comer. Geralmente do almoço ao jantar.';

  @override
  String get plan_18_desc => 'Nível intermediário';

  @override
  String get plan_18_detail =>
      '18 horas de jejum, 6 horas de janela para comer. Maior duração da queima de gordura.';

  @override
  String get plan_20_desc => 'Nível avançado';

  @override
  String get plan_20_detail =>
      '20 horas de jejum, 4 horas de janela para comer. Ideal para atingir cetose e autofagia.';

  @override
  String get plan_omad_desc => 'Uma refeição por dia';

  @override
  String get plan_omad_detail =>
      'Uma refeição por dia. 23 horas de jejum, 1 hora de janela para comer. Nível de especialista.';

  @override
  String get plan_52_desc => '2 dias por semana';

  @override
  String get plan_52_detail =>
      'Coma normalmente 5 dias, apenas cerca de 500 calorias em 2 dias. Uma abordagem alternativa.';

  @override
  String get plan_ese_desc => '24 horas rápido';

  @override
  String get plan_ese_detail =>
      'Jejue por 24 horas, 1–2 vezes por semana. Para usuários avançados.';

  @override
  String get plan_warrior_desc => 'Dieta do guerreiro';

  @override
  String get plan_warrior_detail =>
      'Coma alimentos leves durante o dia (frutas, vegetais), faça sua refeição principal em uma janela noturna de 4 horas.';

  @override
  String get award_first_title => 'Primeiro passo';

  @override
  String get award_first_desc => 'Complete seu primeiro jejum';

  @override
  String get award_rhythm3_title => 'Ritmo de 3 dias';

  @override
  String get award_rhythm3_desc => 'Mantenha seu ritmo por três dias';

  @override
  String get award_hours24_title => '24 horas';

  @override
  String get award_hours24_desc => 'Rápido por 24 horas no total';

  @override
  String get award_week_title => 'Ritmo de uma semana';

  @override
  String get award_week_desc => 'Construa uma sequência de sete dias';

  @override
  String get award_fasts10_title => '10 jejuns';

  @override
  String get award_fasts10_desc => 'Complete dez jejuns';

  @override
  String get award_hours100_title => '100 horas';

  @override
  String get award_hours100_desc => 'Alcance 100 horas totais';

  @override
  String get award_rhythm30_title => 'Ritmo de 30 dias';

  @override
  String get award_rhythm30_desc => 'Construa uma sequência de trinta dias';

  @override
  String get award_fasts50_title => '50 jejuns';

  @override
  String get award_fasts50_desc => 'Complete cinquenta jejuns';

  @override
  String get award_hours500_title => '500 horas';

  @override
  String get award_hours500_desc => 'Alcance 500 horas totais';

  @override
  String get award_fasts100_title => '100 jejuns';

  @override
  String get award_fasts100_desc => 'Complete cem jejuns';

  @override
  String get award_rhythm90_title => 'Ritmo de 90 dias';

  @override
  String get award_rhythm90_desc => 'Construa uma sequência de noventa dias';

  @override
  String get award_year_title => 'Jornada de um ano';

  @override
  String get award_year_desc => 'Alcance um ritmo de 365 dias';

  @override
  String get awards_loadError => 'Não foi possível carregar o progresso';

  @override
  String get awards_journeyComplete => 'Jornada concluída';

  @override
  String get awards_nextGoal => 'Próximo objetivo';

  @override
  String get awards_allYours => 'Cada conquista é sua';

  @override
  String get awards_dayStreak => 'sequência do dia';

  @override
  String get awards_fasts => 'jejuns';

  @override
  String get awards_total => 'total';

  @override
  String get awards_stageStart => 'Começar';

  @override
  String get awards_stageRhythm => 'Ritmo';

  @override
  String get awards_stageEndurance => 'Resistência';

  @override
  String get awards_stageMastery => 'Domínio';

  @override
  String get awards_completed => 'Concluído';

  @override
  String awards_fastsRemaining(int count) {
    return '$count jejua para ir';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Faltam $count dias';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '$count horas restantes';
  }

  @override
  String get common_retry => 'Tente novamente';

  @override
  String get game_title => 'Centro de Progresso';

  @override
  String get game_quests => 'Missões de hoje';

  @override
  String get game_questsDesc => 'Pequenos passos, ritmo sustentável.';

  @override
  String get game_season => 'Temporada de 30 etapas';

  @override
  String get game_seasonDesc => 'Um selo colecionável a cada cinco etapas.';

  @override
  String get game_badges => 'Coleção de emblemas';

  @override
  String game_shields(int count) {
    return 'Escudos de ritmo $count';
  }

  @override
  String get game_shieldsDesc =>
      'Ganhou a cada sete conclusões. Um dia perdido nunca apaga seu progresso.';

  @override
  String get game_league => 'Liga semanal privada';

  @override
  String game_leagueDesc(int percent) {
    return 'Sua pontuação de ritmo está no percentil $percent de um modelo local privado. Peso e jejum extremo nunca são classificados.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Nível $level, pontos de experiência $xp';
  }

  @override
  String get game_explorer => 'Explorador de Ritmo';

  @override
  String get game_streak => 'Onda';

  @override
  String get game_targets => 'Alvos';

  @override
  String get game_best => 'Melhor';

  @override
  String get quest_rhythm => 'Construa o ritmo de hoje';

  @override
  String get quest_hydrate =>
      'Alcance metade do seu objetivo de consumo de água';

  @override
  String get quest_steady => 'Proteja sua sequência';

  @override
  String get badge_first_title => 'Primeiro passo';

  @override
  String get badge_first_desc => 'Registre seu primeiro jejum';

  @override
  String get badge_rhythm7_title => 'Guardião do Ritmo';

  @override
  String get badge_rhythm7_desc => 'Alcance uma sequência de 7 dias';

  @override
  String get badge_rhythm3_title => 'Ritmo de três dias';

  @override
  String get badge_rhythm3_desc => 'Alcance uma sequência de 3 dias';

  @override
  String get badge_target1_title => 'Primeiro alvo';

  @override
  String get badge_target1_desc => 'Complete seu primeiro alvo rapidamente';

  @override
  String get badge_target3_title => 'Três etapas';

  @override
  String get badge_target3_desc => 'Complete 3 alvos';

  @override
  String get badge_water_title => 'Equilibrado';

  @override
  String get badge_water_desc => 'Complete a meta diária de água';

  @override
  String get badge_support_title => 'Autoconsciente';

  @override
  String get badge_support_desc => 'Usar o modo de suporte';

  @override
  String get badge_hours10_title => '10 horas';

  @override
  String get badge_hours10_desc => 'Registrar 10 horas totais';

  @override
  String get badge_target10_title => 'Dez fortes';

  @override
  String get badge_target10_desc => 'Complete 10 alvos';

  @override
  String get badge_target20_title => 'Vinte alvos';

  @override
  String get badge_target20_desc => 'Complete 20 alvos';

  @override
  String get badge_fast16_title => '16 horas';

  @override
  String get badge_fast16_desc => 'Alcance 16 horas em um jejum';

  @override
  String get badge_hours50_title => '50 horas';

  @override
  String get badge_hours50_desc => 'Registrar 50 horas no total';

  @override
  String get badge_hours100_title => 'Cem Horas';

  @override
  String get badge_hours100_desc => 'Registrar 100 horas totais';

  @override
  String get badge_target30_title => 'Trinta Alvos';

  @override
  String get badge_target30_desc => 'Complete 30 alvos';

  @override
  String get badge_rhythm30_title => 'Ritmo de 30 dias';

  @override
  String get badge_rhythm30_desc => 'Alcance uma sequência de 30 dias';

  @override
  String get paywall_restoreSuccess => 'Compras restauradas!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Progresso em jejum $percent por cento';
  }

  @override
  String phase_hourMarker(int hour) {
    return '${hour}h';
  }

  @override
  String get paywall_lifetime => 'Vitalício';

  @override
  String get paywall_once => 'pagamento único';

  @override
  String get paywall_processing => 'Processando…';

  @override
  String get paywall_continue => 'Continuar';

  @override
  String get paywall_productsUnavailable =>
      'As compras não estão disponíveis agora. Tente novamente mais tarde.';

  @override
  String get paywall_purchaseFailed => 'Não foi possível concluir a compra.';

  @override
  String get paywall_nothingToRestore =>
      'Nenhuma compra anterior foi encontrada.';

  @override
  String get paywall_restoreFailed => 'Não foi possível restaurar as compras.';

  @override
  String get paywall_terms => 'Termos de uso';

  @override
  String get permission_notificationDesc =>
      'Lembretes de jejum, mudanças de fase e avisos de conclusão';

  @override
  String get profile_privacyChoices => 'Opções de privacidade';

  @override
  String get paywall_autoRenewInfo =>
      'As assinaturas renovam automaticamente, a menos que sejam canceladas pelo menos 24 horas antes do fim do período. Gerencie nas configurações da App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / mês';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Poupe $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days dias de teste grátis';
  }

  @override
  String get paywall_startFreeTrial => 'Iniciar teste grátis';

  @override
  String get paywall_retry => 'Tentar novamente';

  @override
  String get paywall_alreadyOwned =>
      'Já tens esta subscrição. Toca em “Restaurar compras”.';

  @override
  String get paywall_storeUnavailable =>
      'Não é possível contactar a loja. Verifica a ligação e tenta de novo.';

  @override
  String get paywall_secureNote =>
      'Cancela quando quiseres. O pagamento é cobrado na tua conta da loja.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'As subscrições renovam-se automaticamente, exceto se forem canceladas pelo menos 24 horas antes do fim do período. Gere ou cancela quando quiseres em Google Play > Subscrições.';

  @override
  String get paywall_allPlansDesc =>
      'Desbloqueia 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat e Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Os anúncios de banner e intersticiais são totalmente desativados';
}
