// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Доброго ранку';

  @override
  String get greeting_afternoon => 'Добрий день';

  @override
  String get greeting_evening => 'Добрий вечір';

  @override
  String get tab_timer => 'Головна';

  @override
  String get tab_explore => 'Огляд';

  @override
  String get tab_stats => 'Звіт';

  @override
  String get tab_meals => 'Харчування';

  @override
  String get tab_achievements => 'Нагороди';

  @override
  String get tab_profile => 'Обліковий запис';

  @override
  String get timer_fasting => 'Час голодування';

  @override
  String get timer_remaining => 'Залишилося';

  @override
  String get timer_elapsed => 'Минуло';

  @override
  String get timer_start => 'Почати';

  @override
  String get timer_stop => 'Зупинити';

  @override
  String get timer_completed => 'Вітаємо!';

  @override
  String get timer_completedMessage => 'Ви успішно завершили голодування!';

  @override
  String get timer_selectPlan => 'Виберіть план голодування';

  @override
  String get timer_stopConfirm =>
      'Ви впевнені, що хочете завершити голодування раніше?';

  @override
  String get timer_stopTitle => 'Завершити голодування';

  @override
  String get timer_cancel => 'Скасувати';

  @override
  String get timer_confirmStop => 'Так, завершити';

  @override
  String get phase_anabolic => 'Анаболічна';

  @override
  String get phase_anabolicDesc => 'Триває травлення';

  @override
  String get phase_catabolic => 'Катаболічна';

  @override
  String get phase_catabolicDesc => 'Перехід джерела енергії';

  @override
  String get phase_fatBurning => 'Спалювання жиру';

  @override
  String get phase_fatBurningDesc => 'Спалювання жиру розпочалося';

  @override
  String get phase_ketosis => 'Кетоз';

  @override
  String get phase_ketosisDesc => 'Вироблення кетонів активне';

  @override
  String get phase_autophagy => 'Аутофагія';

  @override
  String get phase_autophagyDesc => 'Оновлення клітин';

  @override
  String get stats_title => 'Статистика';

  @override
  String get stats_week => 'Тиждень';

  @override
  String get stats_month => 'Місяць';

  @override
  String get stats_year => 'Рік';

  @override
  String get stats_totalFasts => 'Усього голодувань';

  @override
  String get stats_average => 'Середнє';

  @override
  String get stats_fastDuration => 'тривалість голодування';

  @override
  String get stats_streak => 'Серія';

  @override
  String get stats_daysConsecutive => 'днів поспіль';

  @override
  String get stats_success => 'Успіх';

  @override
  String get stats_completion => 'завершено';

  @override
  String get stats_weeklyFasting => 'Голодування за тиждень';

  @override
  String get stats_monthlyView => 'Місячний огляд';

  @override
  String get stats_weightChange => 'Зміна ваги';

  @override
  String get heatmap_none => 'Немає';

  @override
  String get heatmap_low => 'Низько';

  @override
  String get heatmap_good => 'Добре';

  @override
  String get heatmap_full => 'Повністю';

  @override
  String get meals_title => 'Планувальник харчування';

  @override
  String get meals_eatingWindow => 'Вікно харчування';

  @override
  String get meals_windowOpen => 'Відкрите';

  @override
  String get meals_windowFasting => 'Голодування';

  @override
  String get meals_calories => 'Калорії';

  @override
  String get meals_protein => 'Білки';

  @override
  String get meals_carbs => 'Вуглеводи';

  @override
  String get meals_fat => 'Жири';

  @override
  String get meals_todayMeals => 'Сьогоднішні прийоми їжі';

  @override
  String get meals_noMeals => 'Прийоми їжі ще не додано';

  @override
  String get meals_breakfastSuggestions => 'Поради щодо виходу з голодування';

  @override
  String get meals_addMeal => 'Додати прийом їжі';

  @override
  String get profile_title => 'Профіль';

  @override
  String get profile_user => 'Користувач';

  @override
  String profile_planActive(String plan) {
    return 'План $plan активний';
  }

  @override
  String get profile_upgradePremium => 'Перейти на Premium';

  @override
  String get profile_premiumDesc => 'Усі плани голодування без реклами';

  @override
  String get profile_bodyMetrics => 'Параметри тіла';

  @override
  String get profile_height => 'Зріст';

  @override
  String get profile_weight => 'Вага';

  @override
  String get profile_targetWeight => 'Цільова вага';

  @override
  String get profile_bmi => 'ІМТ';

  @override
  String get profile_settings => 'Налаштування';

  @override
  String get profile_notifications => 'Сповіщення';

  @override
  String get profile_darkTheme => 'Темна тема';

  @override
  String get profile_waterReminder => 'Нагадування про воду';

  @override
  String get profile_phaseNotifications => 'Сповіщення про фази';

  @override
  String get profile_language => 'Мова';

  @override
  String get profile_about => 'Про застосунок';

  @override
  String get profile_rateApp => 'Оцінити застосунок';

  @override
  String get profile_share => 'Поділитися';

  @override
  String get profile_privacyPolicy => 'Політика конфіденційності';

  @override
  String get profile_version => 'Версія';

  @override
  String get onboarding_welcome => 'Ласкаво просимо';

  @override
  String get onboarding_welcomeDesc =>
      'Керуйте своєю подорожжю\nз інтервальним голодуванням';

  @override
  String get onboarding_featureTimer => 'Розумний таймер голодування';

  @override
  String get onboarding_featureStats => 'Докладна статистика та графіки';

  @override
  String get onboarding_featureMeals =>
      'Планувальник харчування та поради щодо рецептів';

  @override
  String get onboarding_getStarted => 'Розпочати';

  @override
  String get onboarding_selectGoal => 'Яка ваша мета?';

  @override
  String get onboarding_selectGoalDesc => 'Можна вибрати кілька';

  @override
  String get onboarding_goalWeight => 'Знизити вагу';

  @override
  String get onboarding_goalWeightDesc => 'Здорове зниження ваги';

  @override
  String get onboarding_goalHealth => 'Поліпшити здоров’я';

  @override
  String get onboarding_goalHealthDesc => 'Загальне здоров’я та імунітет';

  @override
  String get onboarding_goalEnergy => 'Більше енергії';

  @override
  String get onboarding_goalEnergyDesc => 'Енергія протягом усього дня';

  @override
  String get onboarding_goalMental => 'Ясність розуму';

  @override
  String get onboarding_goalMentalDesc => 'Зосередженість і ясність';

  @override
  String get onboarding_goalLongevity => 'Довголіття';

  @override
  String get onboarding_goalLongevityDesc =>
      'Оновлення клітин і здорове старіння';

  @override
  String get onboarding_goalDiscipline => 'Дисципліна';

  @override
  String get onboarding_goalDisciplineDesc => 'Розвивайте самодисципліну';

  @override
  String get onboarding_selectPlan => 'Виберіть свій план';

  @override
  String get onboarding_selectPlanDesc =>
      'Виберіть найкращий для себе план голодування';

  @override
  String get onboarding_bodyInfo => 'Введіть свої дані';

  @override
  String get onboarding_bodyInfoDesc => 'Для персональних рекомендацій';

  @override
  String get onboarding_gender => 'Стать';

  @override
  String get onboarding_male => 'Чоловіча';

  @override
  String get onboarding_female => 'Жіноча';

  @override
  String get onboarding_age => 'Вік';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Ці дані зберігаються лише на вашому пристрої та використовуються для розрахунку калорій.';

  @override
  String get onboarding_permissions => 'Останній крок';

  @override
  String get onboarding_permissionsDesc =>
      'Увімкніть дозволи для найкращої роботи';

  @override
  String get onboarding_next => 'Продовжити';

  @override
  String get onboarding_start => 'Почнімо!';

  @override
  String get onboarding_skipForNow => 'Налаштувати пізніше';

  @override
  String get waterAdded => 'Додано 250 мл води';

  @override
  String get languageSelect => 'Виберіть мову';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Перейти на Premium';

  @override
  String get paywall_subtitle =>
      'Відкрийте всі плани голодування та приберіть рекламу';

  @override
  String get paywall_allPlans => 'Усі плани голодування';

  @override
  String get paywall_advancedStats => 'Розширена статистика';

  @override
  String get paywall_mealPlanner => 'Планувальник харчування';

  @override
  String get paywall_themes => 'Налаштування теми';

  @override
  String get paywall_noAds => 'Без реклами';

  @override
  String get paywall_weekly => 'Щотижня';

  @override
  String get paywall_monthly => 'Щомісяця';

  @override
  String get paywall_yearly => 'Щороку';

  @override
  String get paywall_bestValue => 'Найкраща пропозиція';

  @override
  String get paywall_freeTrial => 'Безкоштовний період (3 дні)';

  @override
  String get paywall_restore => 'Відновити покупки';

  @override
  String get paywall_premiumActive => 'Premium активний!';

  @override
  String get paywall_premiumActiveDesc =>
      'Усі плани голодування відкрито, рекламу вимкнено';

  @override
  String get water_title => 'Споживання води';

  @override
  String get water_addWater => 'Додати воду';

  @override
  String get water_goal => 'Мета';

  @override
  String get water_ml => 'мл';

  @override
  String get common_ok => 'ОК';

  @override
  String get common_cancel => 'Скасувати';

  @override
  String get common_save => 'Зберегти';

  @override
  String get common_delete => 'Видалити';

  @override
  String get common_hours => 'годин';

  @override
  String get common_minutes => 'хвилин';

  @override
  String get common_days => 'днів';

  @override
  String get common_enable => 'Увімкнути';

  @override
  String get streakCard_currentStreak => 'Поточна серія';

  @override
  String get streakCard_longestStreak => 'Найдовша серія';

  @override
  String get streakCard_totalSessions => 'Усього голодувань';

  @override
  String get meals_mealType => 'Тип прийому їжі';

  @override
  String get meals_breakfast => 'Сніданок';

  @override
  String get meals_lunch => 'Обід';

  @override
  String get meals_dinner => 'Вечеря';

  @override
  String get meals_snack => 'Перекус';

  @override
  String get meals_carbohydrate => 'Вуглеводи';

  @override
  String get meals_add => 'Додати';

  @override
  String get meals_mealName => 'Назва страви';

  @override
  String get bodyMetrics_title => 'Параметри тіла';

  @override
  String get bodyMetrics_weight => 'Вага';

  @override
  String get bodyMetrics_target => 'Мета';

  @override
  String get bodyMetrics_save => 'Зберегти';

  @override
  String get bodyMetrics_history => 'Історія';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'ІМТ: $value';
  }

  @override
  String get bodyMetrics_noData => 'Даних поки немає';

  @override
  String get meals_quickAdd => 'Швидке додавання';

  @override
  String get meals_manualEntry => 'Ручне введення';

  @override
  String meals_added(String name) {
    return 'Додано: $name';
  }

  @override
  String get meals_nameCalorieRequired => 'Потрібно вказати назву та калорії';

  @override
  String get bodyMetrics_addWeight => 'Додати вагу';

  @override
  String get bodyMetrics_hintWeight => 'наприклад, 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Введіть коректну вагу';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'Збережено: $value кг';
  }

  @override
  String get completion_duration => 'Тривалість';

  @override
  String get completion_plan => 'План';

  @override
  String get completion_lastPhase => 'Остання фаза';

  @override
  String get completion_earlyTitle => 'Піст завершено';

  @override
  String get completion_earlyMessage =>
      'Сьогоднішній час збережено. Серія та прогрес досягнень не змінилися, оскільки ціль не була виконана.';

  @override
  String get timer_remainingTime => 'Час, що залишився';

  @override
  String get timer_ready => 'Готово до початку';

  @override
  String get streak_status => 'Статус';

  @override
  String get streak_startToday => 'Почніть сьогодні!';

  @override
  String get streak_goodStart => 'Гарний початок!';

  @override
  String get streak_goingGreat => 'Чудово виходить!';

  @override
  String get streak_superb => 'Неперевершено!';

  @override
  String get streak_legendary => 'Легендарно!';

  @override
  String get streak_incredible => 'Неймовірно!';

  @override
  String get weight_noRecord =>
      'Записів ваги поки немає\nДодайте їх у Профіль > Параметри тіла';

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
  String get day_sun => 'Нд';

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
  String get day_short_sun => 'Н';

  @override
  String get month_jan => 'Січень';

  @override
  String get month_feb => 'Лютий';

  @override
  String get month_mar => 'Березень';

  @override
  String get month_apr => 'Квітень';

  @override
  String get month_may => 'Травень';

  @override
  String get month_jun => 'Червень';

  @override
  String get month_jul => 'Липень';

  @override
  String get month_aug => 'Серпень';

  @override
  String get month_sep => 'Вересень';

  @override
  String get month_oct => 'Жовтень';

  @override
  String get month_nov => 'Листопад';

  @override
  String get month_dec => 'Грудень';

  @override
  String meals_fastingWindow(String hours) {
    return 'Голодування ($hours год)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Харчування ($hours год)';
  }

  @override
  String get recipe_oatSmoothie => 'Вівсяний смузі';

  @override
  String get recipe_avocadoToast => 'Тост з авокадо';

  @override
  String get recipe_yogurtBowl => 'Йогуртова миска';

  @override
  String get elapsed_time => 'Минулий час';

  @override
  String get fast_ends_on => 'Ваше голодування завершиться о';

  @override
  String get end_fasting => 'Завершити голодування';

  @override
  String get start_fasting => 'Почати голодування';

  @override
  String get water_tracker => 'Облік води';

  @override
  String get weight_tracker => 'Облік ваги';

  @override
  String get drink => 'Випити';

  @override
  String get log_weight => 'Записати вагу';

  @override
  String get bmi => 'ІМТ';

  @override
  String get weight_lost => 'Зниження ваги';

  @override
  String get current_weight => 'Поточна вага';

  @override
  String get goal_weight => 'Цільова вага';

  @override
  String get daily_goal => 'Денна мета';

  @override
  String completed_percent(String percent) {
    return 'Виконано на $percent%';
  }

  @override
  String get explore => 'Огляд';

  @override
  String get achievements => 'Досягнення';

  @override
  String get profile_theme => 'Оформлення';

  @override
  String get theme_select => 'Виберіть оформлення';

  @override
  String get theme_system => 'Системна тема';

  @override
  String get theme_light => 'Світла';

  @override
  String get theme_dark => 'Темна';

  @override
  String get language_system => 'Мова системи';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Звук завершення';

  @override
  String get profile_calmGamification => 'Спокійна ігрова механіка';

  @override
  String get profile_calmGamificationDesc => 'Зменшує тиск ліги та сезону';

  @override
  String get profile_editName => 'Змінити ім’я';

  @override
  String get profile_name => 'Ім’я';

  @override
  String get circle_title => 'Коло голодування';

  @override
  String get circle_you => 'Ви';

  @override
  String get circle_tagline => 'Разом, без тиску.';

  @override
  String get circle_privacy =>
      'Вага та приватні показники залишаються прихованими. Видно лише прогрес і підтримку.';

  @override
  String circle_sendSupport(int count) {
    return 'Надіслати підтримку · $count';
  }

  @override
  String get circle_inviteCopied => 'Код запрошення скопійовано';

  @override
  String get circle_createInvite => 'Створити приватне запрошення';

  @override
  String get crisis_nameTitle => 'Спочатку визначте, що відбувається';

  @override
  String get crisis_nameDesc => 'Це може бути голод, звичка або емоція.';

  @override
  String get crisis_waterTitle => 'Випийте склянку води';

  @override
  String get crisis_waterDesc => 'Потім зробіть три повільні вдихи.';

  @override
  String get crisis_delayTitle => 'Відкладіть рішення на 10 хвилин';

  @override
  String get crisis_delayDesc =>
      'Якщо вам зле, завершити голодування — не поразка.';

  @override
  String get crisis_hunger => 'Голод';

  @override
  String get crisis_habit => 'Звичка';

  @override
  String get crisis_stress => 'Стрес';

  @override
  String get crisis_tenMore => 'Дайте собі 10 хвилин';

  @override
  String get stats_storyEmpty =>
      'Перше голодування стане початком вашої особистої історії.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'За цей період ви голодували $sessions разів, зберігали ритм $hours годин і досягли $rate% завершення.';
  }

  @override
  String get stats_storyTitle => 'Історія вашого ритму';

  @override
  String get home_todayRhythm => 'Сьогоднішній ритм';

  @override
  String get home_finalHourSupport => 'Підтримка в останню годину';

  @override
  String get home_needSupport => 'Мені потрібна невелика підтримка';

  @override
  String get home_todaySummary => 'Сьогодні одним поглядом';

  @override
  String get home_dayStreak => 'днів поспіль';

  @override
  String home_weightGoal(String weight) {
    return 'мета: $weight кг';
  }

  @override
  String get weather_steady => 'Ваш ритм стабільний';

  @override
  String get weather_gentle => 'Спокійний день';

  @override
  String get weather_water => 'Склянка води може допомогти.';

  @override
  String get weather_listen => 'Ви пройшли довгий шлях; прислухайтеся до тіла.';

  @override
  String get weather_onPlan => 'Сьогоднішній темп відповідає вашому плану.';

  @override
  String get weather_challenging =>
      'Раніше ця година була складною; режим підтримки готовий.';

  @override
  String get replay_copied => 'Підсумок голодування скопійовано';

  @override
  String get replay_button => 'Підсумок';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Я завершив(-ла) голодування $plan за $hours год $minutes хв · $phase';
  }

  @override
  String get journey_label => 'Метаболічний шлях';

  @override
  String get journey_now => 'Зараз';

  @override
  String journey_next(String time, String phase) {
    return '$time до фази $phase';
  }

  @override
  String get phase_estimateShort =>
      'Час фаз — загальна оцінка, а не медичне вимірювання.';

  @override
  String phase_hours(int start, int end) {
    return 'Години $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Це загальна оцінка часу. Метаболічні реакції можуть відрізнятися в різних людей.';

  @override
  String get bmi_underweight => 'Недостатня вага';

  @override
  String get bmi_normal => 'Нормальна вага';

  @override
  String get bmi_overweight => 'Надмірна вага';

  @override
  String get bmi_obese => 'Ожиріння';

  @override
  String get notification_halfwayTitle => 'Половина позаду! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Ви завершили половину голодування $plan. Продовжуйте!';
  }

  @override
  String get notification_phaseCatabolic => 'Почалася катаболічна фаза 📉';

  @override
  String get notification_phaseFatBurning => 'Почалося спалювання жиру! 🔥';

  @override
  String get notification_phaseKetosis => 'Ви в кетозі ⚡';

  @override
  String get notification_phaseAutophagy => 'Аутофагія активна! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Ви завершили голодування $plan! Вікно харчування відкрите.';
  }

  @override
  String get notification_waterTitle => 'Випийте води 💧';

  @override
  String get notification_waterBody =>
      'Не забувайте пити достатньо води під час голодування!';

  @override
  String get notification_windowTitle => 'Вікно харчування зачиняється ⏰';

  @override
  String get notification_windowBody =>
      'Вікно харчування зачиниться через 30 хвилин.';

  @override
  String notification_streakTitle(int days) {
    return '$days днів поспіль! 🔥';
  }

  @override
  String get notification_streakBody =>
      'Ви чудово справляєтеся! Продовжуйте сьогодні.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Голодування триває — $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Залишилося: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Голодування розпочато — $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Мета: $hours годин';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours год $minutes хв';
  }

  @override
  String get explore_guide => 'Посібник із голодування';

  @override
  String get explore_guideDesc =>
      'Усе, що потрібно знати про інтервальне голодування';

  @override
  String get explore_circleDesc =>
      'Діліться спокійною підтримкою у своїй приватній групі.';

  @override
  String get explore_faq => 'Поширені запитання';

  @override
  String get explore_education =>
      'Цей матеріал призначений лише для загальної освіти й не є медичним діагнозом або порадою щодо лікування.';

  @override
  String get explore_safety => 'Здоров’я та безпека';

  @override
  String get explore_safetyDesc =>
      'Якщо у вас є захворювання, ви регулярно приймаєте ліки, маєте тривожні симптоми, вагітні або годуєте грудьми, проконсультуйтеся з кваліфікованим медичним працівником перед голодуванням. Припиніть, якщо вам зле.';

  @override
  String get explore_sources => 'Джерела';

  @override
  String get explore_sourcesDesc =>
      'Матеріал спрощено на основі наведених нижче загальнодоступних джерел про здоров’я.';

  @override
  String get explore_sourceError => 'Не вдалося відкрити джерело';

  @override
  String get explore_rules => 'Важливі правила';

  @override
  String get explore_rule1 => 'Не вживайте калорійну їжу під час голодування';

  @override
  String get explore_rule2 => 'Пийте достатньо води та інших рідин';

  @override
  String get explore_rule3 => 'Харчуйтеся збалансовано у вікно харчування';

  @override
  String get explore_rule4 => 'Припиніть голодування, якщо вам зле';

  @override
  String get explore_rule5 =>
      'Вагітним і жінкам, які годують грудьми, не слід голодувати';

  @override
  String get explore_rule6 =>
      'За хронічних захворювань проконсультуйтеся з лікарем';

  @override
  String get tip_water => 'Підтримуйте водний баланс';

  @override
  String get tip_waterDesc =>
      'Пийте воду, коли відчуваєте спрагу, та вживайте рідину під час їжі. Потреба залежить від здоров’я, погоди й активності.';

  @override
  String get tip_food => 'Харчуйтеся правильно';

  @override
  String get tip_foodDesc =>
      'У вікно харчування обирайте продукти, багаті на білок і клітковину, а також корисні жири. Уникайте оброблених продуктів.';

  @override
  String get tip_sleep => 'Добре висипайтеся';

  @override
  String get tip_sleepDesc =>
      'Регулярний і достатній сон підтримує загальне самопочуття. Плануйте голодування так, щоб воно не заважало сну.';

  @override
  String get tip_exercise => 'Легка активність';

  @override
  String get tip_exerciseDesc =>
      'Під час голодування можна спокійно ходити або займатися йогою. Уникайте важких тренувань, особливо в перші тижні, поки організм адаптується.';

  @override
  String get tip_drinks => 'Дозволені напої';

  @override
  String get tip_drinksDesc =>
      'Під час голодування можна пити воду, несолодкий чай і чорну каву без цукру та молока. Ці напої не переривають голодування.';

  @override
  String get faq_drinks => 'Що можна пити під час голодування?';

  @override
  String get faq_drinksAnswer =>
      'Можна пити воду, несолодкий чай і чорну каву без цукру та молока. Калорійні напої переривають голодування.';

  @override
  String get faq_plan => 'Який план голодування вибрати?';

  @override
  String get faq_planAnswer =>
      'Якщо ви новачок, почніть із 12:12 або 14:10. Якщо маєте досвід, спробуйте 16:8 або 18:6. 20:4 і OMAD призначені для досвідчених.';

  @override
  String get faq_exercise => 'Чи можна тренуватися під час голодування?';

  @override
  String get faq_exerciseAnswer =>
      'Так, але уникайте інтенсивних тренувань. Легке кардіо, ходьба та йога підійдуть найкраще. Силові тренування плануйте ближче до вікна харчування.';

  @override
  String get faq_weight => 'Чи допомагає голодування знизити вагу?';

  @override
  String get faq_weightAnswer =>
      'У деяких людей обмеження часу прийому їжі може зменшити загальне споживання енергії. Результати різняться, а довгострокові наслідки ще вивчаються.';

  @override
  String get plan_12_desc => 'Для початківців';

  @override
  String get plan_12_detail =>
      'Ідеально для початківців. Голодуйте 12 годин, включно з часом сну.';

  @override
  String get plan_16_desc => 'Найпопулярніший план';

  @override
  String get plan_16_detail =>
      'Найпоширеніший план інтервального голодування: 16 годин голодування та 8-годинне вікно харчування, зазвичай від обіду до вечері.';

  @override
  String get plan_18_desc => 'Середній рівень';

  @override
  String get plan_18_detail =>
      '18 годин голодування та 6-годинне вікно харчування. Триваліше спалювання жиру.';

  @override
  String get plan_20_desc => 'Просунутий рівень';

  @override
  String get plan_20_detail =>
      '20 годин голодування та 4-годинне вікно харчування. Підходить для досягнення кетозу й аутофагії.';

  @override
  String get plan_omad_desc => 'Один прийом їжі на день';

  @override
  String get plan_omad_detail =>
      'Один прийом їжі на день: 23 години голодування та 1-годинне вікно харчування. Експертний рівень.';

  @override
  String get plan_52_desc => '2 дні на тиждень';

  @override
  String get plan_52_detail =>
      'Харчуйтеся звичайно 5 днів, а протягом 2 днів обмежте раціон приблизно 500 калоріями. Альтернативний підхід.';

  @override
  String get plan_ese_desc => '24-годинне голодування';

  @override
  String get plan_ese_detail =>
      'Голодуйте 24 години 1–2 рази на тиждень. Для досвідчених.';

  @override
  String get plan_warrior_desc => 'Дієта воїна';

  @override
  String get plan_warrior_detail =>
      'Удень їжте легко, а основний прийом їжі влаштуйте в чотиригодинне вечірнє вікно.';

  @override
  String get award_first_title => 'Перший крок';

  @override
  String get award_first_desc => 'Завершіть перше голодування';

  @override
  String get award_rhythm3_title => 'Триденний ритм';

  @override
  String get award_rhythm3_desc => 'Зберігайте ритм три дні';

  @override
  String get award_hours24_title => '24 години';

  @override
  String get award_hours24_desc => 'Голодуйте загалом 24 години';

  @override
  String get award_week_title => 'Тижневий ритм';

  @override
  String get award_week_desc => 'Створіть серію із семи днів';

  @override
  String get award_fasts10_title => '10 голодувань';

  @override
  String get award_fasts10_desc => 'Завершіть десять голодувань';

  @override
  String get award_hours100_title => '100 годин';

  @override
  String get award_hours100_desc => 'Досягніть 100 годин загалом';

  @override
  String get award_rhythm30_title => '30-денний ритм';

  @override
  String get award_rhythm30_desc => 'Створіть серію з тридцяти днів';

  @override
  String get award_fasts50_title => '50 голодувань';

  @override
  String get award_fasts50_desc => 'Завершіть п’ятдесят голодувань';

  @override
  String get award_hours500_title => '500 годин';

  @override
  String get award_hours500_desc => 'Досягніть 500 годин загалом';

  @override
  String get award_fasts100_title => '100 голодувань';

  @override
  String get award_fasts100_desc => 'Завершіть сто голодувань';

  @override
  String get award_rhythm90_title => '90-денний ритм';

  @override
  String get award_rhythm90_desc => 'Створіть серію з дев’яноста днів';

  @override
  String get award_year_title => 'Річний шлях';

  @override
  String get award_year_desc => 'Досягніть ритму в 365 днів';

  @override
  String get awards_loadError => 'Не вдалося завантажити прогрес';

  @override
  String get awards_journeyComplete => 'Шлях завершено';

  @override
  String get awards_nextGoal => 'Наступна мета';

  @override
  String get awards_allYours => 'Усі досягнення ваші';

  @override
  String get awards_dayStreak => 'днів поспіль';

  @override
  String get awards_fasts => 'голодувань';

  @override
  String get awards_total => 'усього';

  @override
  String get awards_stageStart => 'Початок';

  @override
  String get awards_stageRhythm => 'Ритм';

  @override
  String get awards_stageEndurance => 'Витривалість';

  @override
  String get awards_stageMastery => 'Майстерність';

  @override
  String get awards_completed => 'Завершено';

  @override
  String awards_fastsRemaining(int count) {
    return 'Залишилося голодувань: $count';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Залишилося днів: $count';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Залишилося годин: $count';
  }

  @override
  String get common_retry => 'Повторити';

  @override
  String get game_title => 'Центр прогресу';

  @override
  String get game_quests => 'Завдання на сьогодні';

  @override
  String get game_questsDesc => 'Невеликі кроки, сталий ритм.';

  @override
  String get game_season => 'Сезон із 30 кроків';

  @override
  String get game_seasonDesc => 'Колекційна печатка за кожен п’ятий крок.';

  @override
  String get game_badges => 'Колекція значків';

  @override
  String game_shields(int count) {
    return 'Щити ритму: $count';
  }

  @override
  String get game_shieldsDesc =>
      'Один щит за кожні сім завершень. Пропущений день ніколи не стирає прогрес.';

  @override
  String get game_league => 'Приватна тижнева ліга';

  @override
  String game_leagueDesc(int percent) {
    return 'Ваш показник ритму перебуває в $percent-му процентилі приватної локальної моделі. Вага та екстремальне голодування ніколи не ранжуються.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Рівень $level, очки досвіду: $xp';
  }

  @override
  String get game_explorer => 'Дослідник ритму';

  @override
  String get game_streak => 'Серія';

  @override
  String get game_targets => 'Цілі';

  @override
  String get game_best => 'Найкраще';

  @override
  String get quest_rhythm => 'Створіть сьогоднішній ритм';

  @override
  String get quest_hydrate => 'Досягніть половини цілі щодо води';

  @override
  String get quest_steady => 'Захистіть свою серію';

  @override
  String get badge_first_title => 'Перший крок';

  @override
  String get badge_first_desc => 'Запишіть перше голодування';

  @override
  String get badge_rhythm7_title => 'Охоронець ритму';

  @override
  String get badge_rhythm7_desc => 'Досягніть серії в 7 днів';

  @override
  String get badge_rhythm3_title => 'Триденний ритм';

  @override
  String get badge_rhythm3_desc => 'Досягніть серії в 3 дні';

  @override
  String get badge_target1_title => 'Перша ціль';

  @override
  String get badge_target1_desc => 'Завершіть перше цільове голодування';

  @override
  String get badge_target3_title => 'Три кроки';

  @override
  String get badge_target3_desc => 'Виконайте 3 цілі';

  @override
  String get badge_water_title => 'Баланс';

  @override
  String get badge_water_desc => 'Виконайте денну ціль щодо води';

  @override
  String get badge_support_title => 'Самоусвідомлення';

  @override
  String get badge_support_desc => 'Скористайтеся режимом підтримки';

  @override
  String get badge_hours10_title => '10 годин';

  @override
  String get badge_hours10_desc => 'Запишіть загалом 10 годин';

  @override
  String get badge_target10_title => 'Сильна десятка';

  @override
  String get badge_target10_desc => 'Виконайте 10 цілей';

  @override
  String get badge_target20_title => 'Двадцять цілей';

  @override
  String get badge_target20_desc => 'Виконайте 20 цілей';

  @override
  String get badge_fast16_title => '16 годин';

  @override
  String get badge_fast16_desc => 'Досягніть 16 годин за одне голодування';

  @override
  String get badge_hours50_title => '50 годин';

  @override
  String get badge_hours50_desc => 'Запишіть загалом 50 годин';

  @override
  String get badge_hours100_title => 'Сто годин';

  @override
  String get badge_hours100_desc => 'Запишіть загалом 100 годин';

  @override
  String get badge_target30_title => 'Тридцять цілей';

  @override
  String get badge_target30_desc => 'Виконайте 30 цілей';

  @override
  String get badge_rhythm30_title => '30-денний ритм';

  @override
  String get badge_rhythm30_desc => 'Досягніть серії в 30 днів';

  @override
  String get paywall_restoreSuccess => 'Покупки відновлено!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Прогрес голодування: $percent відсотків';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour год';
  }

  @override
  String get paywall_lifetime => 'Назавжди';

  @override
  String get paywall_once => 'одноразова оплата';

  @override
  String get paywall_processing => 'Обробка…';

  @override
  String get paywall_continue => 'Продовжити';

  @override
  String get paywall_productsUnavailable =>
      'Покупки зараз недоступні. Повторіть спробу пізніше.';

  @override
  String get paywall_purchaseFailed => 'Не вдалося завершити покупку.';

  @override
  String get paywall_nothingToRestore => 'Попередніх покупок не знайдено.';

  @override
  String get paywall_restoreFailed => 'Не вдалося відновити покупки.';

  @override
  String get paywall_terms => 'Умови використання';

  @override
  String get permission_notificationDesc =>
      'Нагадування про голодування, оновлення фаз і сповіщення про завершення';

  @override
  String get profile_privacyChoices => 'Налаштування конфіденційності';

  @override
  String get paywall_autoRenewInfo =>
      'Підписки поновлюються автоматично, якщо їх не скасувати щонайменше за 24 години до завершення періоду. Керувати ними або скасувати їх можна в налаштуваннях App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / місяць';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Економія $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return 'Безкоштовний період: $days днів';
  }

  @override
  String get paywall_startFreeTrial => 'Почати безкоштовний період';

  @override
  String get paywall_retry => 'Повторити';

  @override
  String get paywall_alreadyOwned =>
      'У вас уже є ця підписка. Натисніть «Відновити покупки».';

  @override
  String get paywall_storeUnavailable =>
      'Зараз не вдається підключитися до магазину. Перевірте з’єднання та повторіть спробу.';

  @override
  String get paywall_secureNote =>
      'Скасування будь-коли. Плата стягується з облікового запису магазину.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Підписки поновлюються автоматично, якщо їх не скасувати щонайменше за 24 години до завершення періоду. Керування та скасування: Google Play > Підписки.';

  @override
  String get paywall_allPlansDesc =>
      'Відкриває 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat і Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Банерну та повноекранну рекламу повністю вимкнено';

  @override
  String get foodScan_title => 'ШІ-сканування їжі';

  @override
  String get foodScan_scanCta => 'Сканувати страву';

  @override
  String get foodScan_scanCtaDesc =>
      'Сфотографуйте тарілку й дізнайтеся калорії та макронутрієнти';

  @override
  String get foodScan_introTitle => 'Сфотографуйте тарілку';

  @override
  String get foodScan_introDesc =>
      'ШІ аналізує фото й оцінює калорії, білки, вуглеводи та жири.';

  @override
  String get foodScan_tipLight =>
      'Гарне рівномірне освітлення підвищує точність';

  @override
  String get foodScan_tipFrame => 'Уся тарілка має бути в кадрі';

  @override
  String get foodScan_tipScale =>
      'Додайте в кадр прибори або руку для оцінки розміру порції';

  @override
  String get foodScan_takePhoto => 'Зробити фото';

  @override
  String get foodScan_chooseFromGallery => 'Вибрати з галереї';

  @override
  String foodScan_scansLeft(int count) {
    return 'Сьогодні залишилося сканувань: $count';
  }

  @override
  String get foodScan_quotaReached =>
      'Сьогоднішні сканування вичерпано. Спробуйте завтра.';

  @override
  String get foodScan_privacyNote =>
      'Фото надсилається до Google Gemini API для аналізу й не зберігається на наших серверах.';

  @override
  String get foodScan_consentTitle => 'Надсилати фото в Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Щоб оцінити калорії та БЖВ, кожне зняте або вибране фото страви надсилається до ШІ-сервісу Google Gemini. Фото використовується лише для цього аналізу й не зберігається на наших серверах.';

  @override
  String get foodScan_consentAgree => 'Погодитися й продовжити';

  @override
  String get foodScan_analyzing => 'Аналізуємо вашу страву…';

  @override
  String get foodScan_analyzingHint => 'Зазвичай це займає кілька секунд';

  @override
  String get foodScan_detectedItems => 'Розпізнані продукти';

  @override
  String get foodScan_disclaimer =>
      'Оцінки ШІ приблизні. Натисніть на продукт, щоб виправити його.';

  @override
  String get foodScan_lowConfidence =>
      'Модель не впевнена в цьому фото. Перевірте значення перед збереженням.';

  @override
  String get foodScan_save => 'Додати до харчування';

  @override
  String get foodScan_retake => 'Нове фото';

  @override
  String get foodScan_retry => 'Повторити';

  @override
  String get foodScan_editItem => 'Змінити продукт';

  @override
  String get foodScan_portion => 'Порція';

  @override
  String get foodScan_saveEdit => 'Зберегти';

  @override
  String get foodScan_premiumTitle => 'Функція Premium';

  @override
  String get foodScan_premiumDesc =>
      'Аналіз калорій за фото входить до Premium.';

  @override
  String get foodScan_upgrade => 'Переглянути Premium';

  @override
  String get foodScan_errorNetwork =>
      'Немає з’єднання. Перевірте інтернет і повторіть спробу.';

  @override
  String get foodScan_errorRateLimited =>
      'Зараз надто багато сканувань. Повторіть спробу через кілька хвилин.';

  @override
  String get foodScan_errorUnavailable => 'Аналіз фото зараз недоступний.';

  @override
  String get foodScan_errorServer =>
      'Виникла проблема зі службою аналізу. Повторіть спробу трохи пізніше.';

  @override
  String get foodScan_errorNoFood =>
      'На фото не знайдено їжі. Зробіть чіткіший знімок тарілки.';

  @override
  String get foodScan_errorUnreadable =>
      'Не вдалося проаналізувати це фото. Спробуйте інше.';

  @override
  String get paywall_aiFoodScan => 'ШІ-сканування їжі';

  @override
  String get paywall_aiFoodScanDesc =>
      'Сфотографуйте страву та запишіть калорії й макронутрієнти за кілька секунд';
}
