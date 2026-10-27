// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Доброе утро';

  @override
  String get greeting_afternoon => 'Добрый день';

  @override
  String get greeting_evening => 'Добрый вечер';

  @override
  String get tab_timer => 'Главная';

  @override
  String get tab_explore => 'Обзор';

  @override
  String get tab_stats => 'Отчёт';

  @override
  String get tab_meals => 'Питание';

  @override
  String get tab_achievements => 'Награды';

  @override
  String get tab_profile => 'Аккаунт';

  @override
  String get timer_fasting => 'Время голодания';

  @override
  String get timer_remaining => 'Осталось';

  @override
  String get timer_elapsed => 'Прошло';

  @override
  String get timer_start => 'Начать';

  @override
  String get timer_stop => 'Остановить';

  @override
  String get timer_completed => 'Поздравляем!';

  @override
  String get timer_completedMessage => 'Вы успешно завершили голодание!';

  @override
  String get timer_selectPlan => 'Выберите план голодания';

  @override
  String get timer_stopConfirm =>
      'Вы уверены, что хотите завершить голодание раньше?';

  @override
  String get timer_stopTitle => 'Завершить голодание';

  @override
  String get timer_cancel => 'Отмена';

  @override
  String get timer_confirmStop => 'Да, завершить';

  @override
  String get phase_anabolic => 'Анаболическая';

  @override
  String get phase_anabolicDesc => 'Идёт пищеварение';

  @override
  String get phase_catabolic => 'Катаболическая';

  @override
  String get phase_catabolicDesc => 'Переход источника энергии';

  @override
  String get phase_fatBurning => 'Сжигание жира';

  @override
  String get phase_fatBurningDesc => 'Началось сжигание жира';

  @override
  String get phase_ketosis => 'Кетоз';

  @override
  String get phase_ketosisDesc => 'Выработка кетонов активна';

  @override
  String get phase_autophagy => 'Аутофагия';

  @override
  String get phase_autophagyDesc => 'Обновление клеток';

  @override
  String get stats_title => 'Статистика';

  @override
  String get stats_week => 'Неделя';

  @override
  String get stats_month => 'Месяц';

  @override
  String get stats_year => 'Год';

  @override
  String get stats_totalFasts => 'Всего голоданий';

  @override
  String get stats_average => 'Среднее';

  @override
  String get stats_fastDuration => 'длительность голодания';

  @override
  String get stats_streak => 'Серия';

  @override
  String get stats_daysConsecutive => 'дней подряд';

  @override
  String get stats_success => 'Успех';

  @override
  String get stats_completion => 'завершено';

  @override
  String get stats_weeklyFasting => 'Голодание за неделю';

  @override
  String get stats_monthlyView => 'Месячный обзор';

  @override
  String get stats_weightChange => 'Изменение веса';

  @override
  String get heatmap_none => 'Нет';

  @override
  String get heatmap_low => 'Низко';

  @override
  String get heatmap_good => 'Хорошо';

  @override
  String get heatmap_full => 'Полностью';

  @override
  String get meals_title => 'Планировщик питания';

  @override
  String get meals_eatingWindow => 'Окно питания';

  @override
  String get meals_windowOpen => 'Открыто';

  @override
  String get meals_windowFasting => 'Голодание';

  @override
  String get meals_calories => 'Калории';

  @override
  String get meals_protein => 'Белки';

  @override
  String get meals_carbs => 'Углеводы';

  @override
  String get meals_fat => 'Жиры';

  @override
  String get meals_todayMeals => 'Сегодняшние приёмы пищи';

  @override
  String get meals_noMeals => 'Приёмы пищи ещё не добавлены';

  @override
  String get meals_breakfastSuggestions => 'Советы по выходу из голодания';

  @override
  String get meals_addMeal => 'Добавить приём пищи';

  @override
  String get profile_title => 'Профиль';

  @override
  String get profile_user => 'Пользователь';

  @override
  String profile_planActive(String plan) {
    return 'План $plan активен';
  }

  @override
  String get profile_upgradePremium => 'Перейти на Premium';

  @override
  String get profile_premiumDesc => 'Все планы голодания без рекламы';

  @override
  String get profile_bodyMetrics => 'Параметры тела';

  @override
  String get profile_height => 'Рост';

  @override
  String get profile_weight => 'Вес';

  @override
  String get profile_targetWeight => 'Целевой вес';

  @override
  String get profile_bmi => 'ИМТ';

  @override
  String get profile_settings => 'Настройки';

  @override
  String get profile_notifications => 'Уведомления';

  @override
  String get profile_darkTheme => 'Тёмная тема';

  @override
  String get profile_waterReminder => 'Напоминание о воде';

  @override
  String get profile_phaseNotifications => 'Уведомления о фазах';

  @override
  String get profile_language => 'Язык';

  @override
  String get profile_about => 'О приложении';

  @override
  String get profile_rateApp => 'Оценить приложение';

  @override
  String get profile_share => 'Поделиться';

  @override
  String get profile_privacyPolicy => 'Политика конфиденциальности';

  @override
  String get profile_version => 'Версия';

  @override
  String get onboarding_welcome => 'Добро пожаловать';

  @override
  String get onboarding_welcomeDesc =>
      'Управляйте своим путём\nинтервального голодания';

  @override
  String get onboarding_featureTimer => 'Умный таймер голодания';

  @override
  String get onboarding_featureStats => 'Подробная статистика и графики';

  @override
  String get onboarding_featureMeals =>
      'Планировщик питания и рекомендации рецептов';

  @override
  String get onboarding_getStarted => 'Начать';

  @override
  String get onboarding_selectGoal => 'Какова ваша цель?';

  @override
  String get onboarding_selectGoalDesc => 'Можно выбрать несколько';

  @override
  String get onboarding_goalWeight => 'Снизить вес';

  @override
  String get onboarding_goalWeightDesc => 'Здоровое снижение веса';

  @override
  String get onboarding_goalHealth => 'Улучшить здоровье';

  @override
  String get onboarding_goalHealthDesc => 'Общее здоровье и иммунитет';

  @override
  String get onboarding_goalEnergy => 'Больше энергии';

  @override
  String get onboarding_goalEnergyDesc => 'Энергия на весь день';

  @override
  String get onboarding_goalMental => 'Ясность ума';

  @override
  String get onboarding_goalMentalDesc => 'Сосредоточенность и ясность';

  @override
  String get onboarding_goalLongevity => 'Долголетие';

  @override
  String get onboarding_goalLongevityDesc =>
      'Обновление клеток и здоровое старение';

  @override
  String get onboarding_goalDiscipline => 'Дисциплина';

  @override
  String get onboarding_goalDisciplineDesc => 'Развивайте самодисциплину';

  @override
  String get onboarding_selectPlan => 'Выберите свой план';

  @override
  String get onboarding_selectPlanDesc =>
      'Выберите наиболее подходящий план голодания';

  @override
  String get onboarding_bodyInfo => 'Введите свои данные';

  @override
  String get onboarding_bodyInfoDesc => 'Для персональных рекомендаций';

  @override
  String get onboarding_gender => 'Пол';

  @override
  String get onboarding_male => 'Мужской';

  @override
  String get onboarding_female => 'Женский';

  @override
  String get onboarding_age => 'Возраст';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Эти данные хранятся только на вашем устройстве и используются для расчёта калорий.';

  @override
  String get onboarding_permissions => 'Последний шаг';

  @override
  String get onboarding_permissionsDesc =>
      'Включите разрешения для максимально удобной работы';

  @override
  String get onboarding_next => 'Продолжить';

  @override
  String get onboarding_start => 'Начнём!';

  @override
  String get onboarding_skipForNow => 'Настроить позже';

  @override
  String get waterAdded => 'Добавлено 250 мл воды';

  @override
  String get languageSelect => 'Выберите язык';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Перейти на Premium';

  @override
  String get paywall_subtitle =>
      'Откройте все планы голодания и уберите рекламу';

  @override
  String get paywall_allPlans => 'Все планы голодания';

  @override
  String get paywall_advancedStats => 'Расширенная статистика';

  @override
  String get paywall_mealPlanner => 'Планировщик питания';

  @override
  String get paywall_themes => 'Настройка темы';

  @override
  String get paywall_noAds => 'Без рекламы';

  @override
  String get paywall_weekly => 'Еженедельно';

  @override
  String get paywall_monthly => 'Ежемесячно';

  @override
  String get paywall_yearly => 'Ежегодно';

  @override
  String get paywall_bestValue => 'Лучшее предложение';

  @override
  String get paywall_freeTrial => 'Бесплатный период (3 дня)';

  @override
  String get paywall_restore => 'Восстановить покупки';

  @override
  String get paywall_premiumActive => 'Premium активен!';

  @override
  String get paywall_premiumActiveDesc =>
      'Все планы голодания открыты, реклама отключена';

  @override
  String get water_title => 'Потребление воды';

  @override
  String get water_addWater => 'Добавить воду';

  @override
  String get water_goal => 'Цель';

  @override
  String get water_ml => 'мл';

  @override
  String get common_ok => 'ОК';

  @override
  String get common_cancel => 'Отмена';

  @override
  String get common_save => 'Сохранить';

  @override
  String get common_delete => 'Удалить';

  @override
  String get common_hours => 'часов';

  @override
  String get common_minutes => 'минут';

  @override
  String get common_days => 'дней';

  @override
  String get common_enable => 'Включить';

  @override
  String get streakCard_currentStreak => 'Текущая серия';

  @override
  String get streakCard_longestStreak => 'Самая длинная серия';

  @override
  String get streakCard_totalSessions => 'Всего голоданий';

  @override
  String get meals_mealType => 'Тип приёма пищи';

  @override
  String get meals_breakfast => 'Завтрак';

  @override
  String get meals_lunch => 'Обед';

  @override
  String get meals_dinner => 'Ужин';

  @override
  String get meals_snack => 'Перекус';

  @override
  String get meals_carbohydrate => 'Углеводы';

  @override
  String get meals_add => 'Добавить';

  @override
  String get meals_mealName => 'Название блюда';

  @override
  String get bodyMetrics_title => 'Параметры тела';

  @override
  String get bodyMetrics_weight => 'Вес';

  @override
  String get bodyMetrics_target => 'Цель';

  @override
  String get bodyMetrics_save => 'Сохранить';

  @override
  String get bodyMetrics_history => 'История';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'ИМТ: $value';
  }

  @override
  String get bodyMetrics_noData => 'Данных пока нет';

  @override
  String get meals_quickAdd => 'Быстрое добавление';

  @override
  String get meals_manualEntry => 'Ручной ввод';

  @override
  String meals_added(String name) {
    return 'Добавлено: $name';
  }

  @override
  String get meals_nameCalorieRequired =>
      'Необходимо указать название и калории';

  @override
  String get bodyMetrics_addWeight => 'Добавить вес';

  @override
  String get bodyMetrics_hintWeight => 'например, 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Введите допустимый вес';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'Сохранено: $value кг';
  }

  @override
  String get completion_duration => 'Длительность';

  @override
  String get completion_plan => 'План';

  @override
  String get completion_lastPhase => 'Последняя фаза';

  @override
  String get completion_earlyTitle => 'Пост завершён';

  @override
  String get completion_earlyMessage =>
      'Сегодняшнее время сохранено. Серия и прогресс достижений не изменились, потому что цель не была выполнена.';

  @override
  String get timer_remainingTime => 'Оставшееся время';

  @override
  String get timer_ready => 'Готово к началу';

  @override
  String get streak_status => 'Статус';

  @override
  String get streak_startToday => 'Начните сегодня!';

  @override
  String get streak_goodStart => 'Хорошее начало!';

  @override
  String get streak_goingGreat => 'Отлично идёт!';

  @override
  String get streak_superb => 'Превосходно!';

  @override
  String get streak_legendary => 'Легендарно!';

  @override
  String get streak_incredible => 'Невероятно!';

  @override
  String get weight_noRecord =>
      'Записей веса пока нет\nДобавьте их в Профиль > Параметры тела';

  @override
  String get day_mon => 'Пн';

  @override
  String get day_tue => 'Вт';

  @override
  String get day_wed => 'Ср';

  @override
  String get day_thu => 'Чт';

  @override
  String get day_fri => 'Пт';

  @override
  String get day_sat => 'Сб';

  @override
  String get day_sun => 'Вс';

  @override
  String get day_short_mon => 'П';

  @override
  String get day_short_tue => 'В';

  @override
  String get day_short_wed => 'С';

  @override
  String get day_short_thu => 'Ч';

  @override
  String get day_short_fri => 'П';

  @override
  String get day_short_sat => 'С';

  @override
  String get day_short_sun => 'В';

  @override
  String get month_jan => 'Январь';

  @override
  String get month_feb => 'Февраль';

  @override
  String get month_mar => 'Март';

  @override
  String get month_apr => 'Апрель';

  @override
  String get month_may => 'Май';

  @override
  String get month_jun => 'Июнь';

  @override
  String get month_jul => 'Июль';

  @override
  String get month_aug => 'Август';

  @override
  String get month_sep => 'Сентябрь';

  @override
  String get month_oct => 'Октябрь';

  @override
  String get month_nov => 'Ноябрь';

  @override
  String get month_dec => 'Декабрь';

  @override
  String meals_fastingWindow(String hours) {
    return 'Голодание ($hours ч)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Питание ($hours ч)';
  }

  @override
  String get recipe_oatSmoothie => 'Овсяный смузи';

  @override
  String get recipe_avocadoToast => 'Тост с авокадо';

  @override
  String get recipe_yogurtBowl => 'Йогурт в миске';

  @override
  String get elapsed_time => 'Прошедшее время';

  @override
  String get fast_ends_on => 'Ваше голодание завершится в';

  @override
  String get end_fasting => 'Завершить голодание';

  @override
  String get start_fasting => 'Начать голодание';

  @override
  String get water_tracker => 'Учёт воды';

  @override
  String get weight_tracker => 'Учёт веса';

  @override
  String get drink => 'Выпить';

  @override
  String get log_weight => 'Записать вес';

  @override
  String get bmi => 'ИМТ';

  @override
  String get weight_lost => 'Снижение веса';

  @override
  String get current_weight => 'Текущий вес';

  @override
  String get goal_weight => 'Целевой вес';

  @override
  String get daily_goal => 'Дневная цель';

  @override
  String completed_percent(String percent) {
    return 'Выполнено на $percent%';
  }

  @override
  String get explore => 'Обзор';

  @override
  String get achievements => 'Достижения';

  @override
  String get profile_theme => 'Оформление';

  @override
  String get theme_select => 'Выберите оформление';

  @override
  String get theme_system => 'Системная тема';

  @override
  String get theme_light => 'Светлая';

  @override
  String get theme_dark => 'Тёмная';

  @override
  String get language_system => 'Язык системы';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Звук завершения';

  @override
  String get profile_calmGamification => 'Спокойная игровая механика';

  @override
  String get profile_calmGamificationDesc => 'Снижает давление лиги и сезона';

  @override
  String get profile_editName => 'Изменить имя';

  @override
  String get profile_name => 'Имя';

  @override
  String get circle_title => 'Круг голодания';

  @override
  String get circle_you => 'Вы';

  @override
  String get circle_tagline => 'Вместе, без давления.';

  @override
  String get circle_privacy =>
      'Вес и личные показатели остаются скрытыми. Видны только прогресс и поддержка.';

  @override
  String circle_sendSupport(int count) {
    return 'Отправить поддержку · $count';
  }

  @override
  String get circle_inviteCopied => 'Код приглашения скопирован';

  @override
  String get circle_createInvite => 'Создать личное приглашение';

  @override
  String get crisis_nameTitle => 'Сначала определите, что происходит';

  @override
  String get crisis_nameDesc => 'Это может быть голод, привычка или эмоция.';

  @override
  String get crisis_waterTitle => 'Выпейте стакан воды';

  @override
  String get crisis_waterDesc => 'Затем сделайте три медленных вдоха.';

  @override
  String get crisis_delayTitle => 'Отложите решение на 10 минут';

  @override
  String get crisis_delayDesc =>
      'Если вы плохо себя чувствуете, завершить голодание — не поражение.';

  @override
  String get crisis_hunger => 'Голод';

  @override
  String get crisis_habit => 'Привычка';

  @override
  String get crisis_stress => 'Стресс';

  @override
  String get crisis_tenMore => 'Дайте себе 10 минут';

  @override
  String get stats_storyEmpty =>
      'Первое голодание станет началом вашей личной истории.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'За этот период вы голодали $sessions раз, сохраняли ритм $hours часов и достигли $rate% завершения.';
  }

  @override
  String get stats_storyTitle => 'История вашего ритма';

  @override
  String get home_todayRhythm => 'Сегодняшний ритм';

  @override
  String get home_finalHourSupport => 'Поддержка в последний час';

  @override
  String get home_needSupport => 'Мне нужна небольшая поддержка';

  @override
  String get home_todaySummary => 'Сегодня одним взглядом';

  @override
  String get home_dayStreak => 'дней подряд';

  @override
  String home_weightGoal(String weight) {
    return 'цель: $weight кг';
  }

  @override
  String get weather_steady => 'Ваш ритм стабилен';

  @override
  String get weather_gentle => 'Спокойный день';

  @override
  String get weather_water => 'Стакан воды может помочь.';

  @override
  String get weather_listen => 'Вы прошли большой путь; прислушайтесь к телу.';

  @override
  String get weather_onPlan => 'Сегодняшний темп соответствует вашему плану.';

  @override
  String get weather_challenging =>
      'Раньше этот час был сложным; режим поддержки готов.';

  @override
  String get replay_copied => 'Сводка голодания скопирована';

  @override
  String get replay_button => 'Сводка';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Я завершил(а) голодание $plan за $hours ч $minutes мин · $phase';
  }

  @override
  String get journey_label => 'Метаболический путь';

  @override
  String get journey_now => 'Сейчас';

  @override
  String journey_next(String time, String phase) {
    return '$time до фазы $phase';
  }

  @override
  String get phase_estimateShort =>
      'Время фаз — общая оценка, а не медицинское измерение.';

  @override
  String phase_hours(int start, int end) {
    return 'Часы $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Это общая оценка времени. Метаболические реакции могут различаться у разных людей.';

  @override
  String get bmi_underweight => 'Недостаточный вес';

  @override
  String get bmi_normal => 'Нормальный вес';

  @override
  String get bmi_overweight => 'Избыточный вес';

  @override
  String get bmi_obese => 'Ожирение';

  @override
  String get notification_halfwayTitle => 'Половина позади! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Вы завершили половину голодания $plan. Продолжайте!';
  }

  @override
  String get notification_phaseCatabolic => 'Началась катаболическая фаза 📉';

  @override
  String get notification_phaseFatBurning => 'Началось сжигание жира! 🔥';

  @override
  String get notification_phaseKetosis => 'Вы в кетозе ⚡';

  @override
  String get notification_phaseAutophagy => 'Аутофагия активна! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Вы завершили голодание $plan! Окно питания открыто.';
  }

  @override
  String get notification_waterTitle => 'Выпейте воды 💧';

  @override
  String get notification_waterBody =>
      'Не забывайте пить достаточно воды во время голодания!';

  @override
  String get notification_windowTitle => 'Окно питания закрывается ⏰';

  @override
  String get notification_windowBody =>
      'Окно питания закроется через 30 минут.';

  @override
  String notification_streakTitle(int days) {
    return '$days дней подряд! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Вы отлично справляетесь! Продолжайте сегодня.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Голодание идёт — $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Осталось: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Голодание начато — $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Цель: $hours часов';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get explore_guide => 'Руководство по голоданию';

  @override
  String get explore_guideDesc =>
      'Всё, что нужно знать об интервальном голодании';

  @override
  String get explore_circleDesc =>
      'Делитесь спокойной поддержкой в своей закрытой группе.';

  @override
  String get explore_faq => 'Частые вопросы';

  @override
  String get explore_education =>
      'Этот материал предназначен только для общего ознакомления и не является медицинским диагнозом или советом по лечению.';

  @override
  String get explore_safety => 'Здоровье и безопасность';

  @override
  String get explore_safetyDesc =>
      'Если у вас есть заболевание, вы регулярно принимаете лекарства, испытываете тревожные симптомы, беременны или кормите грудью, проконсультируйтесь с квалифицированным медицинским специалистом перед голоданием. Прекратите голодание при плохом самочувствии.';

  @override
  String get explore_sources => 'Источники';

  @override
  String get explore_sourcesDesc =>
      'Материал упрощён на основе приведённых ниже общедоступных источников о здоровье.';

  @override
  String get explore_sourceError => 'Не удалось открыть источник';

  @override
  String get explore_rules => 'Важные правила';

  @override
  String get explore_rule1 =>
      'Не употребляйте калорийную пищу во время голодания';

  @override
  String get explore_rule2 => 'Пейте достаточно воды и других жидкостей';

  @override
  String get explore_rule3 => 'Питайтесь сбалансированно в окно питания';

  @override
  String get explore_rule4 => 'Прекратите голодание при плохом самочувствии';

  @override
  String get explore_rule5 =>
      'Беременным и кормящим женщинам не следует голодать';

  @override
  String get explore_rule6 =>
      'При хронических заболеваниях проконсультируйтесь с врачом';

  @override
  String get tip_water => 'Поддерживайте водный баланс';

  @override
  String get tip_waterDesc =>
      'Пейте воду при жажде и употребляйте жидкости во время еды. Потребность зависит от здоровья, погоды и активности.';

  @override
  String get tip_food => 'Питайтесь правильно';

  @override
  String get tip_foodDesc =>
      'В окно питания выбирайте продукты, богатые белком и клетчаткой, а также полезные жиры. Избегайте переработанных продуктов.';

  @override
  String get tip_sleep => 'Хорошо высыпайтесь';

  @override
  String get tip_sleepDesc =>
      'Регулярный и достаточный сон поддерживает общее самочувствие. Планируйте голодание так, чтобы оно не мешало сну.';

  @override
  String get tip_exercise => 'Лёгкая активность';

  @override
  String get tip_exerciseDesc =>
      'Во время голодания можно спокойно ходить или заниматься йогой. Избегайте тяжёлых тренировок, особенно в первые недели, пока организм адаптируется.';

  @override
  String get tip_drinks => 'Разрешённые напитки';

  @override
  String get tip_drinksDesc =>
      'Во время голодания можно пить воду, несладкий чай и чёрный кофе без сахара и молока. Эти напитки не прерывают голодание.';

  @override
  String get faq_drinks => 'Что можно пить во время голодания?';

  @override
  String get faq_drinksAnswer =>
      'Можно пить воду, несладкий чай и чёрный кофе без сахара и молока. Калорийные напитки прерывают голодание.';

  @override
  String get faq_plan => 'Какой план голодания выбрать?';

  @override
  String get faq_planAnswer =>
      'Если вы новичок, начните с 12:12 или 14:10. Если есть опыт, попробуйте 16:8 или 18:6. 20:4 и OMAD предназначены для опытных.';

  @override
  String get faq_exercise => 'Можно ли тренироваться во время голодания?';

  @override
  String get faq_exerciseAnswer =>
      'Да, но избегайте интенсивных тренировок. Лёгкое кардио, ходьба и йога подойдут лучше всего. Силовые тренировки планируйте ближе к окну питания.';

  @override
  String get faq_weight => 'Помогает ли голодание снизить вес?';

  @override
  String get faq_weightAnswer =>
      'У некоторых людей ограничение времени приёма пищи может снизить общее потребление энергии. Результаты различаются, а долгосрочные эффекты всё ещё изучаются.';

  @override
  String get plan_12_desc => 'Для начинающих';

  @override
  String get plan_12_detail =>
      'Идеально для начинающих. Голодайте 12 часов, включая время сна.';

  @override
  String get plan_16_desc => 'Самый популярный план';

  @override
  String get plan_16_detail =>
      'Самый распространённый план интервального голодания: 16 часов голодания и 8-часовое окно питания, обычно от обеда до ужина.';

  @override
  String get plan_18_desc => 'Средний уровень';

  @override
  String get plan_18_detail =>
      '18 часов голодания и 6-часовое окно питания. Более длительное сжигание жира.';

  @override
  String get plan_20_desc => 'Продвинутый уровень';

  @override
  String get plan_20_detail =>
      '20 часов голодания и 4-часовое окно питания. Подходит для достижения кетоза и аутофагии.';

  @override
  String get plan_omad_desc => 'Один приём пищи в день';

  @override
  String get plan_omad_detail =>
      'Один приём пищи в день: 23 часа голодания и 1-часовое окно питания. Экспертный уровень.';

  @override
  String get plan_52_desc => '2 дня в неделю';

  @override
  String get plan_52_detail =>
      'Питайтесь обычно 5 дней, а в течение 2 дней ограничьте рацион примерно 500 калориями. Альтернативный подход.';

  @override
  String get plan_ese_desc => '24-часовое голодание';

  @override
  String get plan_ese_detail =>
      'Голодайте 24 часа 1–2 раза в неделю. Для опытных.';

  @override
  String get plan_warrior_desc => 'Диета воина';

  @override
  String get plan_warrior_detail =>
      'Днём ешьте легко, а основной приём пищи устройте в четырёхчасовое вечернее окно.';

  @override
  String get award_first_title => 'Первый шаг';

  @override
  String get award_first_desc => 'Завершите первое голодание';

  @override
  String get award_rhythm3_title => 'Трёхдневный ритм';

  @override
  String get award_rhythm3_desc => 'Сохраняйте ритм три дня';

  @override
  String get award_hours24_title => '24 часа';

  @override
  String get award_hours24_desc => 'Голодайте в общей сложности 24 часа';

  @override
  String get award_week_title => 'Недельный ритм';

  @override
  String get award_week_desc => 'Создайте серию из семи дней';

  @override
  String get award_fasts10_title => '10 голоданий';

  @override
  String get award_fasts10_desc => 'Завершите десять голоданий';

  @override
  String get award_hours100_title => '100 часов';

  @override
  String get award_hours100_desc => 'Достигните 100 часов в сумме';

  @override
  String get award_rhythm30_title => '30-дневный ритм';

  @override
  String get award_rhythm30_desc => 'Создайте серию из тридцати дней';

  @override
  String get award_fasts50_title => '50 голоданий';

  @override
  String get award_fasts50_desc => 'Завершите пятьдесят голоданий';

  @override
  String get award_hours500_title => '500 часов';

  @override
  String get award_hours500_desc => 'Достигните 500 часов в сумме';

  @override
  String get award_fasts100_title => '100 голоданий';

  @override
  String get award_fasts100_desc => 'Завершите сто голоданий';

  @override
  String get award_rhythm90_title => '90-дневный ритм';

  @override
  String get award_rhythm90_desc => 'Создайте серию из девяноста дней';

  @override
  String get award_year_title => 'Годовой путь';

  @override
  String get award_year_desc => 'Достигните ритма в 365 дней';

  @override
  String get awards_loadError => 'Не удалось загрузить прогресс';

  @override
  String get awards_journeyComplete => 'Путь завершён';

  @override
  String get awards_nextGoal => 'Следующая цель';

  @override
  String get awards_allYours => 'Все достижения ваши';

  @override
  String get awards_dayStreak => 'дней подряд';

  @override
  String get awards_fasts => 'голоданий';

  @override
  String get awards_total => 'всего';

  @override
  String get awards_stageStart => 'Начало';

  @override
  String get awards_stageRhythm => 'Ритм';

  @override
  String get awards_stageEndurance => 'Выносливость';

  @override
  String get awards_stageMastery => 'Мастерство';

  @override
  String get awards_completed => 'Завершено';

  @override
  String awards_fastsRemaining(int count) {
    return 'Осталось голоданий: $count';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Осталось дней: $count';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Осталось часов: $count';
  }

  @override
  String get common_retry => 'Повторить';

  @override
  String get game_title => 'Центр прогресса';

  @override
  String get game_quests => 'Задания на сегодня';

  @override
  String get game_questsDesc => 'Небольшие шаги, устойчивый ритм.';

  @override
  String get game_season => 'Сезон из 30 шагов';

  @override
  String get game_seasonDesc => 'Коллекционная печать за каждый пятый шаг.';

  @override
  String get game_badges => 'Коллекция значков';

  @override
  String game_shields(int count) {
    return 'Щиты ритма: $count';
  }

  @override
  String get game_shieldsDesc =>
      'Один щит за каждые семь завершений. Пропущенный день никогда не стирает прогресс.';

  @override
  String get game_league => 'Закрытая недельная лига';

  @override
  String game_leagueDesc(int percent) {
    return 'Ваш показатель ритма находится в $percent-м процентиле частной локальной модели. Вес и экстремальное голодание никогда не ранжируются.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Уровень $level, очки опыта: $xp';
  }

  @override
  String get game_explorer => 'Исследователь ритма';

  @override
  String get game_streak => 'Серия';

  @override
  String get game_targets => 'Цели';

  @override
  String get game_best => 'Лучшее';

  @override
  String get quest_rhythm => 'Создайте сегодняшний ритм';

  @override
  String get quest_hydrate => 'Достигните половины цели по воде';

  @override
  String get quest_steady => 'Защитите свою серию';

  @override
  String get badge_first_title => 'Первый шаг';

  @override
  String get badge_first_desc => 'Запишите первое голодание';

  @override
  String get badge_rhythm7_title => 'Хранитель ритма';

  @override
  String get badge_rhythm7_desc => 'Достигните серии в 7 дней';

  @override
  String get badge_rhythm3_title => 'Трёхдневный ритм';

  @override
  String get badge_rhythm3_desc => 'Достигните серии в 3 дня';

  @override
  String get badge_target1_title => 'Первая цель';

  @override
  String get badge_target1_desc => 'Завершите первое целевое голодание';

  @override
  String get badge_target3_title => 'Три шага';

  @override
  String get badge_target3_desc => 'Выполните 3 цели';

  @override
  String get badge_water_title => 'Баланс';

  @override
  String get badge_water_desc => 'Выполните дневную цель по воде';

  @override
  String get badge_support_title => 'Самоосознанность';

  @override
  String get badge_support_desc => 'Используйте режим поддержки';

  @override
  String get badge_hours10_title => '10 часов';

  @override
  String get badge_hours10_desc => 'Запишите в сумме 10 часов';

  @override
  String get badge_target10_title => 'Сильная десятка';

  @override
  String get badge_target10_desc => 'Выполните 10 целей';

  @override
  String get badge_target20_title => 'Двадцать целей';

  @override
  String get badge_target20_desc => 'Выполните 20 целей';

  @override
  String get badge_fast16_title => '16 часов';

  @override
  String get badge_fast16_desc => 'Достигните 16 часов за одно голодание';

  @override
  String get badge_hours50_title => '50 часов';

  @override
  String get badge_hours50_desc => 'Запишите в сумме 50 часов';

  @override
  String get badge_hours100_title => 'Сто часов';

  @override
  String get badge_hours100_desc => 'Запишите в сумме 100 часов';

  @override
  String get badge_target30_title => 'Тридцать целей';

  @override
  String get badge_target30_desc => 'Выполните 30 целей';

  @override
  String get badge_rhythm30_title => '30-дневный ритм';

  @override
  String get badge_rhythm30_desc => 'Достигните серии в 30 дней';

  @override
  String get paywall_restoreSuccess => 'Покупки восстановлены!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Прогресс голодания: $percent процентов';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour ч';
  }

  @override
  String get paywall_lifetime => 'Навсегда';

  @override
  String get paywall_once => 'разовый платёж';

  @override
  String get paywall_processing => 'Обработка…';

  @override
  String get paywall_continue => 'Продолжить';

  @override
  String get paywall_productsUnavailable =>
      'Покупки сейчас недоступны. Повторите попытку позже.';

  @override
  String get paywall_purchaseFailed => 'Не удалось завершить покупку.';

  @override
  String get paywall_nothingToRestore => 'Предыдущие покупки не найдены.';

  @override
  String get paywall_restoreFailed => 'Не удалось восстановить покупки.';

  @override
  String get paywall_terms => 'Условия использования';

  @override
  String get permission_notificationDesc =>
      'Напоминания о голодании, обновления фаз и уведомления о завершении';

  @override
  String get profile_privacyChoices => 'Настройки конфиденциальности';

  @override
  String get paywall_autoRenewInfo =>
      'Подписки продлеваются автоматически, если не отменить их минимум за 24 часа до конца периода. Управлять ими или отменить их можно в настройках App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / месяц';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Экономия $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Бесплатный период: $days дней';
  }

  @override
  String get paywall_startFreeTrial => 'Начать бесплатный период';

  @override
  String get paywall_retry => 'Повторить';

  @override
  String get paywall_alreadyOwned =>
      'У вас уже есть эта подписка. Нажмите «Восстановить покупки».';

  @override
  String get paywall_storeUnavailable =>
      'Сейчас не удаётся подключиться к магазину. Проверьте соединение и повторите попытку.';

  @override
  String get paywall_secureNote =>
      'Отмена в любое время. Плата списывается с аккаунта магазина.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Подписки продлеваются автоматически, если не отменить их минимум за 24 часа до конца периода. Управление и отмена: Google Play > Подписки.';

  @override
  String get paywall_allPlansDesc =>
      'Открывает 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat и Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Баннерная и полноэкранная реклама полностью отключаются';

  @override
  String get foodScan_title => 'ИИ-сканирование еды';

  @override
  String get foodScan_scanCta => 'Сканировать блюдо';

  @override
  String get foodScan_scanCtaDesc =>
      'Сфотографируйте тарелку и узнайте калории и макронутриенты';

  @override
  String get foodScan_introTitle => 'Сфотографируйте тарелку';

  @override
  String get foodScan_introDesc =>
      'ИИ анализирует фото и оценивает калории, белки, углеводы и жиры.';

  @override
  String get foodScan_tipLight =>
      'Хорошее равномерное освещение повышает точность';

  @override
  String get foodScan_tipFrame => 'Вся тарелка должна быть в кадре';

  @override
  String get foodScan_tipScale =>
      'Добавьте в кадр приборы или руку для оценки размера порции';

  @override
  String get foodScan_takePhoto => 'Сделать фото';

  @override
  String get foodScan_chooseFromGallery => 'Выбрать из галереи';

  @override
  String foodScan_scansLeft(int count) {
    return 'Сегодня осталось сканирований: $count';
  }

  @override
  String get foodScan_quotaReached =>
      'Сегодняшние сканирования израсходованы. Попробуйте завтра.';

  @override
  String get foodScan_privacyNote =>
      'Фото отправляется в Google Gemini API для анализа и не хранится на наших серверах.';

  @override
  String get foodScan_consentTitle => 'Отправлять фото в Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Чтобы оценить калории и БЖУ, каждое снятое или выбранное фото блюда отправляется в ИИ-сервис Google Gemini. Фото используется только для этого анализа и не хранится на наших серверах.';

  @override
  String get foodScan_consentAgree => 'Принять и продолжить';

  @override
  String get foodScan_analyzing => 'Анализируем ваше блюдо…';

  @override
  String get foodScan_analyzingHint => 'Обычно это занимает несколько секунд';

  @override
  String get foodScan_detectedItems => 'Распознанные продукты';

  @override
  String get foodScan_disclaimer =>
      'Оценки ИИ приблизительны. Нажмите на продукт, чтобы исправить его.';

  @override
  String get foodScan_lowConfidence =>
      'Модель не уверена в этом фото. Проверьте значения перед сохранением.';

  @override
  String get foodScan_save => 'Добавить к питанию';

  @override
  String get foodScan_retake => 'Новое фото';

  @override
  String get foodScan_retry => 'Повторить';

  @override
  String get foodScan_editItem => 'Изменить продукт';

  @override
  String get foodScan_portion => 'Порция';

  @override
  String get foodScan_saveEdit => 'Сохранить';

  @override
  String get foodScan_premiumTitle => 'Функция Premium';

  @override
  String get foodScan_premiumDesc => 'Анализ калорий по фото входит в Premium.';

  @override
  String get foodScan_upgrade => 'Посмотреть Premium';

  @override
  String get foodScan_errorNetwork =>
      'Нет соединения. Проверьте интернет и повторите попытку.';

  @override
  String get foodScan_errorRateLimited =>
      'Сейчас слишком много сканирований. Повторите попытку через несколько минут.';

  @override
  String get foodScan_errorUnavailable => 'Анализ фото сейчас недоступен.';

  @override
  String get foodScan_errorServer =>
      'Возникла проблема со службой анализа. Повторите попытку чуть позже.';

  @override
  String get foodScan_errorNoFood =>
      'На фото не найдена еда. Сделайте более чёткий снимок тарелки.';

  @override
  String get foodScan_errorUnreadable =>
      'Не удалось проанализировать это фото. Попробуйте другое.';

  @override
  String get paywall_aiFoodScan => 'ИИ-сканирование еды';

  @override
  String get paywall_aiFoodScanDesc =>
      'Сфотографируйте блюдо и запишите калории и макронутриенты за несколько секунд';
}
