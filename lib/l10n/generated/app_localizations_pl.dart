// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'Dzień dobry';

  @override
  String get greeting_afternoon => 'Dzień dobry';

  @override
  String get greeting_evening => 'Dobry wieczór';

  @override
  String get tab_timer => 'Start';

  @override
  String get tab_explore => 'Odkrywaj';

  @override
  String get tab_stats => 'Raport';

  @override
  String get tab_meals => 'Posiłki';

  @override
  String get tab_achievements => 'Nagrody';

  @override
  String get tab_profile => 'Konto';

  @override
  String get timer_fasting => 'Czas postu';

  @override
  String get timer_remaining => 'Pozostało';

  @override
  String get timer_elapsed => 'Minęło';

  @override
  String get timer_start => 'Rozpocznij';

  @override
  String get timer_stop => 'Zatrzymaj';

  @override
  String get timer_completed => 'Gratulacje!';

  @override
  String get timer_completedMessage => 'Udało Ci się ukończyć post!';

  @override
  String get timer_selectPlan => 'Wybierz plan postu';

  @override
  String get timer_stopConfirm =>
      'Czy na pewno chcesz zakończyć post wcześniej?';

  @override
  String get timer_stopTitle => 'Zakończ post';

  @override
  String get timer_cancel => 'Anuluj';

  @override
  String get timer_confirmStop => 'Tak, zakończ';

  @override
  String get phase_anabolic => 'Anaboliczna';

  @override
  String get phase_anabolicDesc => 'Trwa trawienie';

  @override
  String get phase_catabolic => 'Kataboliczna';

  @override
  String get phase_catabolicDesc => 'Zmiana źródła energii';

  @override
  String get phase_fatBurning => 'Spalanie tłuszczu';

  @override
  String get phase_fatBurningDesc => 'Rozpoczęło się spalanie tłuszczu';

  @override
  String get phase_ketosis => 'Ketoza';

  @override
  String get phase_ketosisDesc => 'Produkcja ketonów jest aktywna';

  @override
  String get phase_autophagy => 'Autofagia';

  @override
  String get phase_autophagyDesc => 'Odnowa komórkowa';

  @override
  String get stats_title => 'Statystyki';

  @override
  String get stats_week => 'Tydzień';

  @override
  String get stats_month => 'Miesiąc';

  @override
  String get stats_year => 'Rok';

  @override
  String get stats_totalFasts => 'Łączna liczba postów';

  @override
  String get stats_average => 'Średnia';

  @override
  String get stats_fastDuration => 'czas trwania postu';

  @override
  String get stats_streak => 'Seria';

  @override
  String get stats_daysConsecutive => 'dni z rzędu';

  @override
  String get stats_success => 'Sukces';

  @override
  String get stats_completion => 'ukończenie';

  @override
  String get stats_weeklyFasting => 'Post tygodniowy';

  @override
  String get stats_monthlyView => 'Widok miesiąca';

  @override
  String get stats_weightChange => 'Zmiana masy ciała';

  @override
  String get heatmap_none => 'Brak';

  @override
  String get heatmap_low => 'Niska';

  @override
  String get heatmap_good => 'Dobra';

  @override
  String get heatmap_full => 'Pełna';

  @override
  String get meals_title => 'Planer posiłków';

  @override
  String get meals_eatingWindow => 'Okno żywieniowe';

  @override
  String get meals_windowOpen => 'Otwarte';

  @override
  String get meals_windowFasting => 'Post';

  @override
  String get meals_calories => 'Kalorie';

  @override
  String get meals_protein => 'Białko';

  @override
  String get meals_carbs => 'Węglowodany';

  @override
  String get meals_fat => 'Tłuszcz';

  @override
  String get meals_todayMeals => 'Dzisiejsze posiłki';

  @override
  String get meals_noMeals => 'Nie dodano jeszcze posiłków';

  @override
  String get meals_breakfastSuggestions => 'Propozycje przerwania postu';

  @override
  String get meals_addMeal => 'Dodaj posiłek';

  @override
  String get profile_title => 'Profil';

  @override
  String get profile_user => 'Użytkownik';

  @override
  String profile_planActive(String plan) {
    return 'Plan $plan jest aktywny';
  }

  @override
  String get profile_upgradePremium => 'Przejdź na Premium';

  @override
  String get profile_premiumDesc => 'Wszystkie plany postu bez reklam';

  @override
  String get profile_bodyMetrics => 'Pomiary ciała';

  @override
  String get profile_height => 'Wzrost';

  @override
  String get profile_weight => 'Masa ciała';

  @override
  String get profile_targetWeight => 'Docelowa masa ciała';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => 'Ustawienia';

  @override
  String get profile_notifications => 'Powiadomienia';

  @override
  String get profile_darkTheme => 'Ciemny motyw';

  @override
  String get profile_waterReminder => 'Przypomnienie o wodzie';

  @override
  String get profile_phaseNotifications => 'Powiadomienia o fazach';

  @override
  String get profile_language => 'Język';

  @override
  String get profile_about => 'Informacje';

  @override
  String get profile_rateApp => 'Oceń aplikację';

  @override
  String get profile_share => 'Udostępnij';

  @override
  String get profile_privacyPolicy => 'Polityka prywatności';

  @override
  String get profile_version => 'Wersja';

  @override
  String get onboarding_welcome => 'Witaj';

  @override
  String get onboarding_welcomeDesc =>
      'Przejmij kontrolę nad swoją drogą\nz postem przerywanym';

  @override
  String get onboarding_featureTimer => 'Inteligentny minutnik postu';

  @override
  String get onboarding_featureStats => 'Szczegółowe statystyki i wykresy';

  @override
  String get onboarding_featureMeals =>
      'Planer posiłków i propozycje przepisów';

  @override
  String get onboarding_getStarted => 'Zaczynamy';

  @override
  String get onboarding_selectGoal => 'Jaki jest Twój cel?';

  @override
  String get onboarding_selectGoalDesc => 'Możesz wybrać kilka';

  @override
  String get onboarding_goalWeight => 'Schudnij';

  @override
  String get onboarding_goalWeightDesc => 'Zdrowa utrata masy ciała';

  @override
  String get onboarding_goalHealth => 'Popraw zdrowie';

  @override
  String get onboarding_goalHealthDesc => 'Ogólne zdrowie i odporność';

  @override
  String get onboarding_goalEnergy => 'Więcej energii';

  @override
  String get onboarding_goalEnergyDesc => 'Energia przez cały dzień';

  @override
  String get onboarding_goalMental => 'Jasność umysłu';

  @override
  String get onboarding_goalMentalDesc => 'Skupienie i jasność';

  @override
  String get onboarding_goalLongevity => 'Długowieczność';

  @override
  String get onboarding_goalLongevityDesc =>
      'Odnowa komórkowa i zdrowe starzenie';

  @override
  String get onboarding_goalDiscipline => 'Dyscyplina';

  @override
  String get onboarding_goalDisciplineDesc => 'Buduj samodyscyplinę';

  @override
  String get onboarding_selectPlan => 'Wybierz swój plan';

  @override
  String get onboarding_selectPlanDesc =>
      'Wybierz najlepszy dla siebie plan postu';

  @override
  String get onboarding_bodyInfo => 'Wprowadź swoje dane';

  @override
  String get onboarding_bodyInfoDesc =>
      'Aby otrzymywać spersonalizowane zalecenia';

  @override
  String get onboarding_gender => 'Płeć';

  @override
  String get onboarding_male => 'Mężczyzna';

  @override
  String get onboarding_female => 'Kobieta';

  @override
  String get onboarding_age => 'Wiek';

  @override
  String get onboarding_bodyInfoDisclaimer =>
      'Te informacje są przechowywane wyłącznie na Twoim urządzeniu i służą do obliczeń kalorii.';

  @override
  String get onboarding_permissions => 'Ostatni krok';

  @override
  String get onboarding_permissionsDesc =>
      'Włącz uprawnienia, aby uzyskać najlepsze wrażenia';

  @override
  String get onboarding_next => 'Kontynuuj';

  @override
  String get onboarding_start => 'Zaczynamy!';

  @override
  String get onboarding_skipForNow => 'Skonfiguruj później';

  @override
  String get waterAdded => 'Dodano 250 ml wody';

  @override
  String get languageSelect => 'Wybierz język';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Przejdź na Premium';

  @override
  String get paywall_subtitle =>
      'Odblokuj wszystkie plany postu i usuń reklamy';

  @override
  String get paywall_allPlans => 'Wszystkie plany postu';

  @override
  String get paywall_advancedStats => 'Zaawansowane statystyki';

  @override
  String get paywall_mealPlanner => 'Planer posiłków';

  @override
  String get paywall_themes => 'Dostosowanie motywu';

  @override
  String get paywall_noAds => 'Bez reklam';

  @override
  String get paywall_weekly => 'Tygodniowo';

  @override
  String get paywall_monthly => 'Miesięcznie';

  @override
  String get paywall_yearly => 'Rocznie';

  @override
  String get paywall_bestValue => 'Najlepsza oferta';

  @override
  String get paywall_freeTrial => 'Bezpłatny okres próbny (3 dni)';

  @override
  String get paywall_restore => 'Przywróć zakupy';

  @override
  String get paywall_premiumActive => 'Premium jest aktywne!';

  @override
  String get paywall_premiumActiveDesc =>
      'Wszystkie plany postu są odblokowane, a reklamy wyłączone';

  @override
  String get water_title => 'Spożycie wody';

  @override
  String get water_addWater => 'Dodaj wodę';

  @override
  String get water_goal => 'Cel';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Anuluj';

  @override
  String get common_save => 'Zapisz';

  @override
  String get common_delete => 'Usuń';

  @override
  String get common_hours => 'godzin';

  @override
  String get common_minutes => 'minut';

  @override
  String get common_days => 'dni';

  @override
  String get common_enable => 'Włącz';

  @override
  String get streakCard_currentStreak => 'Obecna seria';

  @override
  String get streakCard_longestStreak => 'Najdłuższa seria';

  @override
  String get streakCard_totalSessions => 'Łączna liczba postów';

  @override
  String get meals_mealType => 'Rodzaj posiłku';

  @override
  String get meals_breakfast => 'Śniadanie';

  @override
  String get meals_lunch => 'Obiad';

  @override
  String get meals_dinner => 'Kolacja';

  @override
  String get meals_snack => 'Przekąska';

  @override
  String get meals_carbohydrate => 'Węglowodany';

  @override
  String get meals_add => 'Dodaj';

  @override
  String get meals_mealName => 'Nazwa posiłku';

  @override
  String get bodyMetrics_title => 'Pomiary ciała';

  @override
  String get bodyMetrics_weight => 'Masa ciała';

  @override
  String get bodyMetrics_target => 'Cel';

  @override
  String get bodyMetrics_save => 'Zapisz';

  @override
  String get bodyMetrics_history => 'Historia';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI: $value';
  }

  @override
  String get bodyMetrics_noData => 'Brak danych';

  @override
  String get meals_quickAdd => 'Szybkie dodawanie';

  @override
  String get meals_manualEntry => 'Wprowadzanie ręczne';

  @override
  String meals_added(String name) {
    return 'Dodano: $name';
  }

  @override
  String get meals_nameCalorieRequired => 'Nazwa i liczba kalorii są wymagane';

  @override
  String get bodyMetrics_addWeight => 'Dodaj masę ciała';

  @override
  String get bodyMetrics_hintWeight => 'np. 74,5';

  @override
  String get bodyMetrics_invalidWeight => 'Wprowadź prawidłową masę ciała';

  @override
  String bodyMetrics_weightSaved(String value) {
    return 'Zapisano $value kg';
  }

  @override
  String get completion_duration => 'Czas trwania';

  @override
  String get completion_plan => 'Plan';

  @override
  String get completion_lastPhase => 'Ostatnia faza';

  @override
  String get completion_earlyTitle => 'Post zakończony';

  @override
  String get completion_earlyMessage =>
      'Dzisiejszy czas został zapisany. Seria i postęp osiągnięć nie zmieniły się, ponieważ cel nie został ukończony.';

  @override
  String get timer_remainingTime => 'Pozostały czas';

  @override
  String get timer_ready => 'Gotowe do rozpoczęcia';

  @override
  String get streak_status => 'Stan';

  @override
  String get streak_startToday => 'Zacznij dziś!';

  @override
  String get streak_goodStart => 'Dobry początek!';

  @override
  String get streak_goingGreat => 'Świetnie Ci idzie!';

  @override
  String get streak_superb => 'Wspaniale!';

  @override
  String get streak_legendary => 'Legendarnie!';

  @override
  String get streak_incredible => 'Niesamowicie!';

  @override
  String get weight_noRecord =>
      'Brak zapisów masy ciała\nDodaj je w Profil > Pomiary ciała';

  @override
  String get day_mon => 'Pon';

  @override
  String get day_tue => 'Wt';

  @override
  String get day_wed => 'Śr';

  @override
  String get day_thu => 'Czw';

  @override
  String get day_fri => 'Pt';

  @override
  String get day_sat => 'Sob';

  @override
  String get day_sun => 'Niedz';

  @override
  String get day_short_mon => 'P';

  @override
  String get day_short_tue => 'W';

  @override
  String get day_short_wed => 'Ś';

  @override
  String get day_short_thu => 'C';

  @override
  String get day_short_fri => 'P';

  @override
  String get day_short_sat => 'S';

  @override
  String get day_short_sun => 'N';

  @override
  String get month_jan => 'Styczeń';

  @override
  String get month_feb => 'Luty';

  @override
  String get month_mar => 'Marzec';

  @override
  String get month_apr => 'Kwiecień';

  @override
  String get month_may => 'Maj';

  @override
  String get month_jun => 'Czerwiec';

  @override
  String get month_jul => 'Lipiec';

  @override
  String get month_aug => 'Sierpień';

  @override
  String get month_sep => 'Wrzesień';

  @override
  String get month_oct => 'Październik';

  @override
  String get month_nov => 'Listopad';

  @override
  String get month_dec => 'Grudzień';

  @override
  String meals_fastingWindow(String hours) {
    return 'Post ($hours godz.)';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return 'Jedzenie ($hours godz.)';
  }

  @override
  String get recipe_oatSmoothie => 'Koktajl owsiany';

  @override
  String get recipe_avocadoToast => 'Tost z awokado';

  @override
  String get recipe_yogurtBowl => 'Miska jogurtu';

  @override
  String get elapsed_time => 'Czas, który upłynął';

  @override
  String get fast_ends_on => 'Twój post kończy się o';

  @override
  String get end_fasting => 'Zakończ post';

  @override
  String get start_fasting => 'Rozpocznij post';

  @override
  String get water_tracker => 'Monitor wody';

  @override
  String get weight_tracker => 'Monitor masy ciała';

  @override
  String get drink => 'Pij';

  @override
  String get log_weight => 'Zapisz masę ciała';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => 'Utrata masy ciała';

  @override
  String get current_weight => 'Obecna masa ciała';

  @override
  String get goal_weight => 'Docelowa masa ciała';

  @override
  String get daily_goal => 'Cel dzienny';

  @override
  String completed_percent(String percent) {
    return 'Ukończono $percent%';
  }

  @override
  String get explore => 'Odkrywaj';

  @override
  String get achievements => 'Osiągnięcia';

  @override
  String get profile_theme => 'Wygląd';

  @override
  String get theme_select => 'Wybierz wygląd';

  @override
  String get theme_system => 'Ustawienie systemowe';

  @override
  String get theme_light => 'Jasny';

  @override
  String get theme_dark => 'Ciemny';

  @override
  String get language_system => 'Język systemu';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => 'Dźwięk ukończenia';

  @override
  String get profile_calmGamification => 'Spokojna grywalizacja';

  @override
  String get profile_calmGamificationDesc => 'Zmniejsza presję ligi i sezonu';

  @override
  String get profile_editName => 'Edytuj swoje imię';

  @override
  String get profile_name => 'Imię';

  @override
  String get circle_title => 'Krąg postu';

  @override
  String get circle_you => 'Ty';

  @override
  String get circle_tagline => 'Razem, bez presji.';

  @override
  String get circle_privacy =>
      'Masa ciała i prywatne pomiary pozostają ukryte. Widoczne są tylko postępy i wsparcie.';

  @override
  String circle_sendSupport(int count) {
    return 'Wyślij wsparcie · $count';
  }

  @override
  String get circle_inviteCopied => 'Kod zaproszenia skopiowany';

  @override
  String get circle_createInvite => 'Utwórz prywatne zaproszenie';

  @override
  String get crisis_nameTitle => 'Najpierw nazwij to, co się dzieje';

  @override
  String get crisis_nameDesc => 'To może być głód, nawyk lub emocja.';

  @override
  String get crisis_waterTitle => 'Wypij szklankę wody';

  @override
  String get crisis_waterDesc => 'Następnie weź trzy powolne oddechy.';

  @override
  String get crisis_delayTitle => 'Odłóż decyzję o 10 minut';

  @override
  String get crisis_delayDesc =>
      'Jeśli źle się czujesz, zakończenie postu nie jest porażką.';

  @override
  String get crisis_hunger => 'Głód';

  @override
  String get crisis_habit => 'Nawyk';

  @override
  String get crisis_stress => 'Stres';

  @override
  String get crisis_tenMore => 'Daj sobie 10 minut';

  @override
  String get stats_storyEmpty =>
      'Twój pierwszy post rozpocznie Twoją osobistą historię.';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'W tym okresie pościłeś(-aś) $sessions razy, utrzymałeś(-aś) rytm przez $hours godzin i osiągnąłeś(-aś) $rate% ukończenia.';
  }

  @override
  String get stats_storyTitle => 'Historia Twojego rytmu';

  @override
  String get home_todayRhythm => 'Dzisiejszy rytm';

  @override
  String get home_finalHourSupport => 'Wsparcie w ostatniej godzinie';

  @override
  String get home_needSupport => 'Potrzebuję trochę wsparcia';

  @override
  String get home_todaySummary => 'Dzisiejszy dzień w skrócie';

  @override
  String get home_dayStreak => 'dni z rzędu';

  @override
  String home_weightGoal(String weight) {
    return 'cel $weight kg';
  }

  @override
  String get weather_steady => 'Twój rytm jest stabilny';

  @override
  String get weather_gentle => 'Spokojny dzień';

  @override
  String get weather_water => 'Szklanka wody może pomóc.';

  @override
  String get weather_listen => 'Daleko zaszedłeś(-aś); słuchaj swojego ciała.';

  @override
  String get weather_onPlan => 'Dzisiejsze tempo odpowiada Twojemu planowi.';

  @override
  String get weather_challenging =>
      'Ta godzina była wcześniej trudna; tryb wsparcia jest gotowy.';

  @override
  String get replay_copied => 'Podsumowanie postu skopiowane';

  @override
  String get replay_button => 'Podsumowanie';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return 'Ukończyłem(-am) post $plan w $hours godz. $minutes min · $phase';
  }

  @override
  String get journey_label => 'Podróż metaboliczna';

  @override
  String get journey_now => 'Teraz';

  @override
  String journey_next(String time, String phase) {
    return '$time do fazy $phase';
  }

  @override
  String get phase_estimateShort =>
      'Czasy faz są ogólnymi szacunkami, a nie pomiarami medycznymi.';

  @override
  String phase_hours(int start, int end) {
    return 'Godziny $start–$end';
  }

  @override
  String get phase_estimateLong =>
      'Ten czas jest ogólnym szacunkiem. Reakcje metaboliczne mogą się różnić między osobami.';

  @override
  String get bmi_underweight => 'Niedowaga';

  @override
  String get bmi_normal => 'Prawidłowa masa ciała';

  @override
  String get bmi_overweight => 'Nadwaga';

  @override
  String get bmi_obese => 'Otyłość';

  @override
  String get notification_halfwayTitle => 'Połowa za Tobą! 💪';

  @override
  String notification_halfwayBody(String plan) {
    return 'Ukończyłeś(-aś) połowę postu $plan. Tak trzymaj!';
  }

  @override
  String get notification_phaseCatabolic =>
      'Rozpoczęła się faza kataboliczna 📉';

  @override
  String get notification_phaseFatBurning =>
      'Rozpoczęło się spalanie tłuszczu! 🔥';

  @override
  String get notification_phaseKetosis => 'Jesteś w ketozie ⚡';

  @override
  String get notification_phaseAutophagy => 'Autofagia jest aktywna! 🔄';

  @override
  String notification_completedBody(String plan) {
    return 'Ukończyłeś(-aś) post $plan! Twoje okno żywieniowe jest otwarte.';
  }

  @override
  String get notification_waterTitle => 'Napij się wody 💧';

  @override
  String get notification_waterBody =>
      'Pamiętaj o piciu wystarczającej ilości wody podczas postu!';

  @override
  String get notification_windowTitle => 'Okno żywieniowe się zamyka ⏰';

  @override
  String get notification_windowBody =>
      'Twoje okno żywieniowe zamknie się za 30 minut.';

  @override
  String notification_streakTitle(int days) {
    return '$days dni z rzędu! 🔥';
  }

  @override
  String get notification_streakBody => 'Świetnie Ci idzie! Kontynuuj dzisiaj.';

  @override
  String notification_ongoingTitle(String phase) {
    return 'Post trwa – $phase';
  }

  @override
  String notification_remaining(String time) {
    return 'Pozostało: $time';
  }

  @override
  String notification_started(String plan) {
    return 'Post rozpoczęty – $plan';
  }

  @override
  String notification_target(int hours) {
    return 'Cel: $hours godzin';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours godz. $minutes min';
  }

  @override
  String get explore_guide => 'Przewodnik po poście';

  @override
  String get explore_guideDesc =>
      'Wszystko, co musisz wiedzieć o poście przerywanym';

  @override
  String get explore_circleDesc =>
      'Dziel się spokojnym wsparciem ze swoją prywatną grupą.';

  @override
  String get explore_faq => 'Często zadawane pytania';

  @override
  String get explore_education =>
      'Te treści służą wyłącznie ogólnej edukacji i nie stanowią diagnozy medycznej ani porady dotyczącej leczenia.';

  @override
  String get explore_safety => 'Zdrowie i bezpieczeństwo';

  @override
  String get explore_safetyDesc =>
      'Jeśli masz chorobę, regularnie przyjmujesz leki, masz niepokojące objawy, jesteś w ciąży lub karmisz piersią, skonsultuj się z wykwalifikowanym pracownikiem ochrony zdrowia przed rozpoczęciem postu. Przerwij, jeśli źle się czujesz.';

  @override
  String get explore_sources => 'Źródła';

  @override
  String get explore_sourcesDesc =>
      'Treść została uproszczona na podstawie poniższych publicznych źródeł zdrowotnych.';

  @override
  String get explore_sourceError => 'Nie udało się otworzyć źródła';

  @override
  String get explore_rules => 'Ważne zasady';

  @override
  String get explore_rule1 =>
      'Nie spożywaj kalorycznych produktów podczas postu';

  @override
  String get explore_rule2 => 'Pij dużo wody i płynów';

  @override
  String get explore_rule3 => 'Jedz zbilansowane posiłki w oknie żywieniowym';

  @override
  String get explore_rule4 => 'Przerwij post, jeśli źle się czujesz';

  @override
  String get explore_rule5 =>
      'Kobiety w ciąży lub karmiące piersią nie powinny pościć';

  @override
  String get explore_rule6 =>
      'Skonsultuj się z lekarzem, jeśli masz chorobę przewlekłą';

  @override
  String get tip_water => 'Dbaj o nawodnienie';

  @override
  String get tip_waterDesc =>
      'Pij wodę, gdy odczuwasz pragnienie, i przyjmuj płyny z posiłkami. Zapotrzebowanie może zależeć od zdrowia, pogody i aktywności.';

  @override
  String get tip_food => 'Odżywiaj się zdrowo';

  @override
  String get tip_foodDesc =>
      'W oknie żywieniowym wybieraj produkty bogate w białko i błonnik oraz zdrowe tłuszcze. Unikaj żywności przetworzonej.';

  @override
  String get tip_sleep => 'Wysypiaj się';

  @override
  String get tip_sleepDesc =>
      'Regularny i wystarczający sen wspiera ogólne samopoczucie. Zaplanuj post tak, aby nie zakłócał snu.';

  @override
  String get tip_exercise => 'Lekka aktywność';

  @override
  String get tip_exerciseDesc =>
      'Podczas postu możesz spacerować lub ćwiczyć jogę. Unikaj ciężkich treningów, zwłaszcza w pierwszych tygodniach, zanim organizm się przystosuje.';

  @override
  String get tip_drinks => 'Dozwolone napoje';

  @override
  String get tip_drinksDesc =>
      'Podczas postu możesz pić wodę, czystą herbatę i czarną kawę bez cukru i mleka. Te napoje nie przerywają postu.';

  @override
  String get faq_drinks => 'Co mogę pić podczas postu?';

  @override
  String get faq_drinksAnswer =>
      'Możesz pić wodę, czystą herbatę i czarną kawę bez cukru i mleka. Kaloryczne napoje przerywają post.';

  @override
  String get faq_plan => 'Który plan postu wybrać?';

  @override
  String get faq_planAnswer =>
      'Jeśli zaczynasz, wybierz 12:12 lub 14:10. Jeśli masz doświadczenie, spróbuj 16:8 lub 18:6. 20:4 i OMAD są dla zaawansowanych.';

  @override
  String get faq_exercise => 'Czy mogę ćwiczyć podczas postu?';

  @override
  String get faq_exerciseAnswer =>
      'Tak, ale unikaj intensywnych treningów. Lekkie kardio, spacery i joga są idealne. Trening siłowy zaplanuj blisko okna żywieniowego.';

  @override
  String get faq_weight => 'Czy post pomaga schudnąć?';

  @override
  String get faq_weightAnswer =>
      'U niektórych osób ograniczenie czasu jedzenia może zmniejszyć całkowite spożycie energii. Wyniki są różne, a długofalowe skutki nadal są badane.';

  @override
  String get plan_12_desc => 'Poziom początkujący';

  @override
  String get plan_12_detail =>
      'Idealny dla początkujących. Pość przez 12 godzin, wliczając sen.';

  @override
  String get plan_16_desc => 'Najpopularniejszy plan';

  @override
  String get plan_16_detail =>
      'Najczęstszy plan postu przerywanego: 16 godzin postu i 8-godzinne okno żywieniowe, zwykle od obiadu do kolacji.';

  @override
  String get plan_18_desc => 'Poziom średniozaawansowany';

  @override
  String get plan_18_detail =>
      '18 godzin postu i 6-godzinne okno żywieniowe. Dłuższe spalanie tłuszczu.';

  @override
  String get plan_20_desc => 'Poziom zaawansowany';

  @override
  String get plan_20_detail =>
      '20 godzin postu i 4-godzinne okno żywieniowe. Idealny do osiągnięcia ketozy i autofagii.';

  @override
  String get plan_omad_desc => 'Jeden posiłek dziennie';

  @override
  String get plan_omad_detail =>
      'Jeden posiłek dziennie: 23 godziny postu i 1-godzinne okno żywieniowe. Poziom ekspercki.';

  @override
  String get plan_52_desc => '2 dni w tygodniu';

  @override
  String get plan_52_detail =>
      'Jedz normalnie przez 5 dni, a przez 2 dni ogranicz się do około 500 kalorii. Alternatywne podejście.';

  @override
  String get plan_ese_desc => '24-godzinny post';

  @override
  String get plan_ese_detail =>
      'Pość przez 24 godziny 1–2 razy w tygodniu. Dla zaawansowanych.';

  @override
  String get plan_warrior_desc => 'Dieta wojownika';

  @override
  String get plan_warrior_detail =>
      'W ciągu dnia jedz lekko, a główny posiłek zjedz w czterogodzinnym oknie wieczorem.';

  @override
  String get award_first_title => 'Pierwszy krok';

  @override
  String get award_first_desc => 'Ukończ swój pierwszy post';

  @override
  String get award_rhythm3_title => 'Trzydniowy rytm';

  @override
  String get award_rhythm3_desc => 'Utrzymaj rytm przez trzy dni';

  @override
  String get award_hours24_title => '24 godziny';

  @override
  String get award_hours24_desc => 'Pość łącznie przez 24 godziny';

  @override
  String get award_week_title => 'Tygodniowy rytm';

  @override
  String get award_week_desc => 'Zbuduj serię siedmiu dni';

  @override
  String get award_fasts10_title => '10 postów';

  @override
  String get award_fasts10_desc => 'Ukończ dziesięć postów';

  @override
  String get award_hours100_title => '100 godzin';

  @override
  String get award_hours100_desc => 'Osiągnij łącznie 100 godzin';

  @override
  String get award_rhythm30_title => '30-dniowy rytm';

  @override
  String get award_rhythm30_desc => 'Zbuduj serię trzydziestu dni';

  @override
  String get award_fasts50_title => '50 postów';

  @override
  String get award_fasts50_desc => 'Ukończ pięćdziesiąt postów';

  @override
  String get award_hours500_title => '500 godzin';

  @override
  String get award_hours500_desc => 'Osiągnij łącznie 500 godzin';

  @override
  String get award_fasts100_title => '100 postów';

  @override
  String get award_fasts100_desc => 'Ukończ sto postów';

  @override
  String get award_rhythm90_title => '90-dniowy rytm';

  @override
  String get award_rhythm90_desc => 'Zbuduj serię dziewięćdziesięciu dni';

  @override
  String get award_year_title => 'Roczna podróż';

  @override
  String get award_year_desc => 'Osiągnij rytm 365 dni';

  @override
  String get awards_loadError => 'Nie udało się wczytać postępów';

  @override
  String get awards_journeyComplete => 'Podróż ukończona';

  @override
  String get awards_nextGoal => 'Następny cel';

  @override
  String get awards_allYours => 'Wszystkie osiągnięcia należą do Ciebie';

  @override
  String get awards_dayStreak => 'dni z rzędu';

  @override
  String get awards_fasts => 'postów';

  @override
  String get awards_total => 'łącznie';

  @override
  String get awards_stageStart => 'Początek';

  @override
  String get awards_stageRhythm => 'Rytm';

  @override
  String get awards_stageEndurance => 'Wytrzymałość';

  @override
  String get awards_stageMastery => 'Mistrzostwo';

  @override
  String get awards_completed => 'Ukończono';

  @override
  String awards_fastsRemaining(int count) {
    return 'Pozostało $count postów';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'Pozostało $count dni';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'Pozostało $count godzin';
  }

  @override
  String get common_retry => 'Spróbuj ponownie';

  @override
  String get game_title => 'Centrum postępów';

  @override
  String get game_quests => 'Dzisiejsze zadania';

  @override
  String get game_questsDesc => 'Małe kroki, trwały rytm.';

  @override
  String get game_season => 'Sezon 30 kroków';

  @override
  String get game_seasonDesc => 'Odznaka kolekcjonerska za każdy piąty krok.';

  @override
  String get game_badges => 'Kolekcja odznak';

  @override
  String game_shields(int count) {
    return '$count tarcz rytmu';
  }

  @override
  String get game_shieldsDesc =>
      'Otrzymujesz jedną za każde siedem ukończeń. Pominięty dzień nigdy nie usuwa postępów.';

  @override
  String get game_league => 'Prywatna liga tygodniowa';

  @override
  String game_leagueDesc(int percent) {
    return 'Twój wynik rytmu znajduje się w $percent. percentylu prywatnego modelu lokalnego. Masa ciała i skrajny post nigdy nie są klasyfikowane.';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'Poziom $level, $xp punktów doświadczenia';
  }

  @override
  String get game_explorer => 'Odkrywca rytmu';

  @override
  String get game_streak => 'Seria';

  @override
  String get game_targets => 'Cele';

  @override
  String get game_best => 'Najlepszy wynik';

  @override
  String get quest_rhythm => 'Buduj dzisiejszy rytm';

  @override
  String get quest_hydrate => 'Osiągnij połowę celu nawodnienia';

  @override
  String get quest_steady => 'Chroń swoją serię';

  @override
  String get badge_first_title => 'Pierwszy krok';

  @override
  String get badge_first_desc => 'Zapisz swój pierwszy post';

  @override
  String get badge_rhythm7_title => 'Strażnik rytmu';

  @override
  String get badge_rhythm7_desc => 'Osiągnij serię 7 dni';

  @override
  String get badge_rhythm3_title => 'Trzydniowy rytm';

  @override
  String get badge_rhythm3_desc => 'Osiągnij serię 3 dni';

  @override
  String get badge_target1_title => 'Pierwszy cel';

  @override
  String get badge_target1_desc => 'Ukończ pierwszy post docelowy';

  @override
  String get badge_target3_title => 'Trzy kroki';

  @override
  String get badge_target3_desc => 'Ukończ 3 cele';

  @override
  String get badge_water_title => 'Równowaga';

  @override
  String get badge_water_desc => 'Osiągnij dzienny cel nawodnienia';

  @override
  String get badge_support_title => 'Samoświadomość';

  @override
  String get badge_support_desc => 'Użyj trybu wsparcia';

  @override
  String get badge_hours10_title => '10 godzin';

  @override
  String get badge_hours10_desc => 'Zapisz łącznie 10 godzin';

  @override
  String get badge_target10_title => 'Mocna dziesiątka';

  @override
  String get badge_target10_desc => 'Ukończ 10 celów';

  @override
  String get badge_target20_title => 'Dwadzieścia celów';

  @override
  String get badge_target20_desc => 'Ukończ 20 celów';

  @override
  String get badge_fast16_title => '16 godzin';

  @override
  String get badge_fast16_desc => 'Osiągnij 16 godzin w jednym poście';

  @override
  String get badge_hours50_title => '50 godzin';

  @override
  String get badge_hours50_desc => 'Zapisz łącznie 50 godzin';

  @override
  String get badge_hours100_title => 'Sto godzin';

  @override
  String get badge_hours100_desc => 'Zapisz łącznie 100 godzin';

  @override
  String get badge_target30_title => 'Trzydzieści celów';

  @override
  String get badge_target30_desc => 'Ukończ 30 celów';

  @override
  String get badge_rhythm30_title => '30-dniowy rytm';

  @override
  String get badge_rhythm30_desc => 'Osiągnij serię 30 dni';

  @override
  String get paywall_restoreSuccess => 'Zakupy zostały przywrócone!';

  @override
  String fasting_progressSemantics(int percent) {
    return 'Post ukończony w $percent procentach';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour godz.';
  }

  @override
  String get paywall_lifetime => 'Dożywotnio';

  @override
  String get paywall_once => 'jednorazowo';

  @override
  String get paywall_processing => 'Przetwarzanie…';

  @override
  String get paywall_continue => 'Kontynuuj';

  @override
  String get paywall_productsUnavailable =>
      'Zakupy są obecnie niedostępne. Spróbuj ponownie później.';

  @override
  String get paywall_purchaseFailed => 'Nie udało się zrealizować zakupu.';

  @override
  String get paywall_nothingToRestore =>
      'Nie znaleziono wcześniejszego zakupu.';

  @override
  String get paywall_restoreFailed => 'Nie udało się przywrócić zakupów.';

  @override
  String get paywall_terms => 'Warunki użytkowania';

  @override
  String get permission_notificationDesc =>
      'Przypomnienia o poście, aktualizacje faz i powiadomienia o ukończeniu';

  @override
  String get profile_privacyChoices => 'Opcje prywatności';

  @override
  String get paywall_autoRenewInfo =>
      'Subskrypcje odnawiają się automatycznie, chyba że anulujesz je co najmniej 24 godziny przed końcem okresu. Możesz nimi zarządzać lub anulować je w ustawieniach App Store.';

  @override
  String paywall_perMonth(String price) {
    return '$price / miesiąc';
  }

  @override
  String paywall_savePercent(int percent) {
    return 'Oszczędź $percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days-dniowy bezpłatny okres próbny';
  }

  @override
  String get paywall_startFreeTrial => 'Rozpocznij bezpłatny okres próbny';

  @override
  String get paywall_retry => 'Spróbuj ponownie';

  @override
  String get paywall_alreadyOwned =>
      'Masz już tę subskrypcję. Dotknij Przywróć zakupy.';

  @override
  String get paywall_storeUnavailable =>
      'Nie można teraz połączyć się ze sklepem. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get paywall_secureNote =>
      'Anuluj w dowolnym momencie. Płatność zostanie pobrana z konta sklepu.';

  @override
  String get paywall_autoRenewInfoPlay =>
      'Subskrypcje odnawiają się automatycznie, chyba że anulujesz je co najmniej 24 godziny przed końcem okresu. Zarządzaj lub anuluj w Google Play > Subskrypcje.';

  @override
  String get paywall_allPlansDesc =>
      'Odblokowuje 18:6, 20:4, OMAD, 5:2, Eat-Stop-Eat i Warrior';

  @override
  String get paywall_noAdsDesc =>
      'Reklamy banerowe i pełnoekranowe są całkowicie wyłączone';

  @override
  String get foodScan_title => 'Skanowanie jedzenia przez AI';

  @override
  String get foodScan_scanCta => 'Zeskanuj posiłek';

  @override
  String get foodScan_scanCtaDesc =>
      'Zrób zdjęcie talerza i poznaj kalorie oraz makroskładniki';

  @override
  String get foodScan_introTitle => 'Zrób zdjęcie talerza';

  @override
  String get foodScan_introDesc =>
      'AI analizuje zdjęcie i szacuje kalorie, białko, węglowodany i tłuszcz.';

  @override
  String get foodScan_tipLight =>
      'Dobre, równomierne światło daje dokładniejsze oszacowanie';

  @override
  String get foodScan_tipFrame => 'Umieść cały talerz w kadrze';

  @override
  String get foodScan_tipScale =>
      'Umieść w kadrze sztućce lub dłoń, aby można było oszacować porcję';

  @override
  String get foodScan_takePhoto => 'Zrób zdjęcie';

  @override
  String get foodScan_chooseFromGallery => 'Wybierz z galerii';

  @override
  String foodScan_scansLeft(int count) {
    return 'Pozostało dziś $count skanów';
  }

  @override
  String get foodScan_quotaReached =>
      'Wykorzystano dzisiejsze skany. Spróbuj ponownie jutro.';

  @override
  String get foodScan_privacyNote =>
      'Zdjęcie jest wysyłane do interfejsu Gemini API firmy Google w celu analizy i nie jest przechowywane na naszych serwerach.';

  @override
  String get foodScan_consentTitle => 'Wysłać zdjęcia do Google Gemini?';

  @override
  String get foodScan_consentBody =>
      'Aby oszacować kalorie i makroskładniki, każde zrobione lub wybrane zdjęcie posiłku jest wysyłane do usługi AI Gemini firmy Google. Zdjęcie jest używane tylko do tej analizy i nie jest przechowywane na naszych serwerach.';

  @override
  String get foodScan_consentAgree => 'Akceptuję i kontynuuję';

  @override
  String get foodScan_analyzing => 'Analizujemy Twój posiłek…';

  @override
  String get foodScan_analyzingHint => 'Zwykle zajmuje to kilka sekund';

  @override
  String get foodScan_detectedItems => 'Wykryte produkty';

  @override
  String get foodScan_disclaimer =>
      'Szacunki AI są przybliżone. Dotknij produktu, aby go poprawić.';

  @override
  String get foodScan_lowConfidence =>
      'Model nie jest pewien tego zdjęcia. Sprawdź wartości przed zapisaniem.';

  @override
  String get foodScan_save => 'Dodaj do posiłków';

  @override
  String get foodScan_retake => 'Nowe zdjęcie';

  @override
  String get foodScan_retry => 'Spróbuj ponownie';

  @override
  String get foodScan_editItem => 'Edytuj produkt';

  @override
  String get foodScan_portion => 'Porcja';

  @override
  String get foodScan_saveEdit => 'Zapisz';

  @override
  String get foodScan_premiumTitle => 'Funkcja Premium';

  @override
  String get foodScan_premiumDesc =>
      'Analiza kalorii ze zdjęcia jest dostępna w Premium.';

  @override
  String get foodScan_upgrade => 'Zobacz Premium';

  @override
  String get foodScan_errorNetwork =>
      'Brak połączenia. Sprawdź internet i spróbuj ponownie.';

  @override
  String get foodScan_errorRateLimited =>
      'Trwa teraz zbyt wiele skanowań. Spróbuj ponownie za kilka minut.';

  @override
  String get foodScan_errorUnavailable =>
      'Analiza zdjęć jest obecnie niedostępna.';

  @override
  String get foodScan_errorServer =>
      'Usługa analizy ma problemy. Spróbuj ponownie za chwilę.';

  @override
  String get foodScan_errorNoFood =>
      'Na zdjęciu nie znaleziono jedzenia. Zrób wyraźniejsze zdjęcie talerza.';

  @override
  String get foodScan_errorUnreadable =>
      'Nie udało się przeanalizować tego zdjęcia. Spróbuj innego.';

  @override
  String get paywall_aiFoodScan => 'Skanowanie jedzenia przez AI';

  @override
  String get paywall_aiFoodScanDesc =>
      'Zrób zdjęcie posiłku i zapisz kalorie oraz makroskładniki w kilka sekund';
}
