// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => 'おはようございます';

  @override
  String get greeting_afternoon => 'こんにちは';

  @override
  String get greeting_evening => 'こんばんは';

  @override
  String get tab_timer => 'ホーム';

  @override
  String get tab_explore => '見つける';

  @override
  String get tab_stats => 'レポート';

  @override
  String get tab_meals => '食事';

  @override
  String get tab_achievements => '実績';

  @override
  String get tab_profile => 'アカウント';

  @override
  String get timer_fasting => '断食時間';

  @override
  String get timer_remaining => '残り時間';

  @override
  String get timer_elapsed => '経過時間';

  @override
  String get timer_start => '開始';

  @override
  String get timer_stop => '停止';

  @override
  String get timer_completed => 'おめでとうございます！';

  @override
  String get timer_completedMessage => '断食を無事に完了しました！';

  @override
  String get timer_selectPlan => '断食プランを選択';

  @override
  String get timer_stopConfirm => '断食を早めに終了してもよろしいですか？';

  @override
  String get timer_stopTitle => '断食を終了';

  @override
  String get timer_cancel => 'キャンセル';

  @override
  String get timer_confirmStop => 'はい、終了します';

  @override
  String get phase_anabolic => '同化期';

  @override
  String get phase_anabolicDesc => '消化が進行中';

  @override
  String get phase_catabolic => '異化期';

  @override
  String get phase_catabolicDesc => 'エネルギー移行中';

  @override
  String get phase_fatBurning => '脂肪燃焼';

  @override
  String get phase_fatBurningDesc => '脂肪燃焼が始まりました';

  @override
  String get phase_ketosis => 'ケトーシス';

  @override
  String get phase_ketosisDesc => 'ケトン体の生成が活発です';

  @override
  String get phase_autophagy => 'オートファジー';

  @override
  String get phase_autophagyDesc => '細胞の更新';

  @override
  String get stats_title => '統計';

  @override
  String get stats_week => '週';

  @override
  String get stats_month => '月';

  @override
  String get stats_year => '年';

  @override
  String get stats_totalFasts => '断食の合計';

  @override
  String get stats_average => '平均';

  @override
  String get stats_fastDuration => '断食時間';

  @override
  String get stats_streak => '連続記録';

  @override
  String get stats_daysConsecutive => '連続日数';

  @override
  String get stats_success => '成功';

  @override
  String get stats_completion => '完了率';

  @override
  String get stats_weeklyFasting => '週間断食';

  @override
  String get stats_monthlyView => '月間表示';

  @override
  String get stats_weightChange => '体重の変化';

  @override
  String get heatmap_none => 'なし';

  @override
  String get heatmap_low => '少ない';

  @override
  String get heatmap_good => '良好';

  @override
  String get heatmap_full => '十分';

  @override
  String get meals_title => '食事プランナー';

  @override
  String get meals_eatingWindow => '食事時間';

  @override
  String get meals_windowOpen => '食事可能';

  @override
  String get meals_windowFasting => '断食中';

  @override
  String get meals_calories => 'カロリー';

  @override
  String get meals_protein => 'たんぱく質';

  @override
  String get meals_carbs => '炭水化物';

  @override
  String get meals_fat => '脂質';

  @override
  String get meals_todayMeals => '今日の食事';

  @override
  String get meals_noMeals => 'まだ食事が追加されていません';

  @override
  String get meals_breakfastSuggestions => '断食明けの食事候補';

  @override
  String get meals_addMeal => '食事を追加';

  @override
  String get profile_title => 'プロフィール';

  @override
  String get profile_user => 'ユーザー';

  @override
  String profile_planActive(String plan) {
    return '$planプランが有効です';
  }

  @override
  String get profile_upgradePremium => 'Premiumにアップグレード';

  @override
  String get profile_premiumDesc => 'すべての断食プランを広告なしで利用';

  @override
  String get profile_bodyMetrics => '身体測定値';

  @override
  String get profile_height => '身長';

  @override
  String get profile_weight => '体重';

  @override
  String get profile_targetWeight => '目標体重';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => '設定';

  @override
  String get profile_notifications => '通知';

  @override
  String get profile_darkTheme => 'ダークテーマ';

  @override
  String get profile_waterReminder => '水分補給リマインダー';

  @override
  String get profile_phaseNotifications => 'フェーズ通知';

  @override
  String get profile_language => '言語';

  @override
  String get profile_about => 'アプリについて';

  @override
  String get profile_rateApp => 'アプリを評価';

  @override
  String get profile_share => '共有';

  @override
  String get profile_privacyPolicy => 'プライバシーポリシー';

  @override
  String get profile_version => 'バージョン';

  @override
  String get onboarding_welcome => 'ようこそ';

  @override
  String get onboarding_welcomeDesc => '間欠的断食の旅を\n自分の手で管理しましょう';

  @override
  String get onboarding_featureTimer => 'スマート断食タイマー';

  @override
  String get onboarding_featureStats => '詳細な統計とグラフ';

  @override
  String get onboarding_featureMeals => '食事プランナーとレシピ提案';

  @override
  String get onboarding_getStarted => '始める';

  @override
  String get onboarding_selectGoal => '目標は何ですか？';

  @override
  String get onboarding_selectGoalDesc => '複数選択できます';

  @override
  String get onboarding_goalWeight => '減量';

  @override
  String get onboarding_goalWeightDesc => '健康的に体重を減らす';

  @override
  String get onboarding_goalHealth => '健康改善';

  @override
  String get onboarding_goalHealthDesc => '全身の健康と免疫';

  @override
  String get onboarding_goalEnergy => '活力を高める';

  @override
  String get onboarding_goalEnergyDesc => '一日を通して元気に';

  @override
  String get onboarding_goalMental => '頭をすっきりさせる';

  @override
  String get onboarding_goalMentalDesc => '集中力と思考の明瞭さ';

  @override
  String get onboarding_goalLongevity => '長寿';

  @override
  String get onboarding_goalLongevityDesc => '細胞の更新と健やかな老化';

  @override
  String get onboarding_goalDiscipline => '自律';

  @override
  String get onboarding_goalDisciplineDesc => '自己管理力を養う';

  @override
  String get onboarding_selectPlan => 'プランを選択';

  @override
  String get onboarding_selectPlanDesc => 'あなたに最適な断食プランを選びましょう';

  @override
  String get onboarding_bodyInfo => '情報を入力';

  @override
  String get onboarding_bodyInfoDesc => '個別のおすすめを提供するために使用します';

  @override
  String get onboarding_gender => '性別';

  @override
  String get onboarding_male => '男性';

  @override
  String get onboarding_female => '女性';

  @override
  String get onboarding_age => '年齢';

  @override
  String get onboarding_bodyInfoDisclaimer => 'この情報は端末内にのみ保存され、カロリー計算に使用されます。';

  @override
  String get onboarding_permissions => '最後のステップ';

  @override
  String get onboarding_permissionsDesc => '快適に利用するために権限を有効にしてください';

  @override
  String get onboarding_next => '続ける';

  @override
  String get onboarding_start => '始めましょう！';

  @override
  String get onboarding_skipForNow => 'あとで設定';

  @override
  String get waterAdded => '水を250ml追加しました';

  @override
  String get languageSelect => '言語を選択';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => 'Premiumにアップグレード';

  @override
  String get paywall_subtitle => 'すべての断食プランを利用し、広告を非表示にします';

  @override
  String get paywall_allPlans => 'すべての断食プラン';

  @override
  String get paywall_advancedStats => '高度な統計';

  @override
  String get paywall_mealPlanner => '食事プランナー';

  @override
  String get paywall_themes => 'テーマのカスタマイズ';

  @override
  String get paywall_noAds => '広告なし';

  @override
  String get paywall_weekly => '週間';

  @override
  String get paywall_monthly => '月間';

  @override
  String get paywall_yearly => '年間';

  @override
  String get paywall_bestValue => 'おすすめ';

  @override
  String get paywall_freeTrial => '無料トライアル（3日間）';

  @override
  String get paywall_restore => '購入を復元';

  @override
  String get paywall_premiumActive => 'Premiumが有効です！';

  @override
  String get paywall_premiumActiveDesc => 'すべての断食プランが利用でき、広告は表示されません';

  @override
  String get water_title => '水分摂取量';

  @override
  String get water_addWater => '水を追加';

  @override
  String get water_goal => '目標';

  @override
  String get water_ml => 'ml';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'キャンセル';

  @override
  String get common_save => '保存';

  @override
  String get common_delete => '削除';

  @override
  String get common_hours => '時間';

  @override
  String get common_minutes => '分';

  @override
  String get common_days => '日';

  @override
  String get common_enable => '有効にする';

  @override
  String get streakCard_currentStreak => '現在の連続記録';

  @override
  String get streakCard_longestStreak => '最長連続記録';

  @override
  String get streakCard_totalSessions => '断食の合計';

  @override
  String get meals_mealType => '食事の種類';

  @override
  String get meals_breakfast => '朝食';

  @override
  String get meals_lunch => '昼食';

  @override
  String get meals_dinner => '夕食';

  @override
  String get meals_snack => '間食';

  @override
  String get meals_carbohydrate => '炭水化物';

  @override
  String get meals_add => '追加';

  @override
  String get meals_mealName => '食事名';

  @override
  String get bodyMetrics_title => '身体測定値';

  @override
  String get bodyMetrics_weight => '体重';

  @override
  String get bodyMetrics_target => '目標';

  @override
  String get bodyMetrics_save => '保存';

  @override
  String get bodyMetrics_history => '履歴';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI：$value';
  }

  @override
  String get bodyMetrics_noData => 'まだデータがありません';

  @override
  String get meals_quickAdd => 'クイック追加';

  @override
  String get meals_manualEntry => '手動入力';

  @override
  String meals_added(String name) {
    return '$nameを追加しました';
  }

  @override
  String get meals_nameCalorieRequired => '名前とカロリーを入力してください';

  @override
  String get bodyMetrics_addWeight => '体重を追加';

  @override
  String get bodyMetrics_hintWeight => '例：74.5';

  @override
  String get bodyMetrics_invalidWeight => '有効な体重を入力してください';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '$value kgを保存しました';
  }

  @override
  String get completion_duration => '時間';

  @override
  String get completion_plan => 'プラン';

  @override
  String get completion_lastPhase => '最終フェーズ';

  @override
  String get completion_earlyTitle => '断食を終了しました';

  @override
  String get completion_earlyMessage =>
      '今日の時間を保存しました。目標を達成していないため、連続記録と実績の進行状況は変わりません。';

  @override
  String get timer_remainingTime => '残り時間';

  @override
  String get timer_ready => '開始できます';

  @override
  String get streak_status => 'ステータス';

  @override
  String get streak_startToday => '今日から始めましょう！';

  @override
  String get streak_goodStart => '良いスタート！';

  @override
  String get streak_goingGreat => '順調です！';

  @override
  String get streak_superb => 'すばらしい！';

  @override
  String get streak_legendary => '伝説的！';

  @override
  String get streak_incredible => '驚異的！';

  @override
  String get weight_noRecord => '体重記録がまだありません\nプロフィール > 身体測定値から追加してください';

  @override
  String get day_mon => '月';

  @override
  String get day_tue => '火';

  @override
  String get day_wed => '水';

  @override
  String get day_thu => '木';

  @override
  String get day_fri => '金';

  @override
  String get day_sat => '土';

  @override
  String get day_sun => '日';

  @override
  String get day_short_mon => '月';

  @override
  String get day_short_tue => '火';

  @override
  String get day_short_wed => '水';

  @override
  String get day_short_thu => '木';

  @override
  String get day_short_fri => '金';

  @override
  String get day_short_sat => '土';

  @override
  String get day_short_sun => '日';

  @override
  String get month_jan => '1月';

  @override
  String get month_feb => '2月';

  @override
  String get month_mar => '3月';

  @override
  String get month_apr => '4月';

  @override
  String get month_may => '5月';

  @override
  String get month_jun => '6月';

  @override
  String get month_jul => '7月';

  @override
  String get month_aug => '8月';

  @override
  String get month_sep => '9月';

  @override
  String get month_oct => '10月';

  @override
  String get month_nov => '11月';

  @override
  String get month_dec => '12月';

  @override
  String meals_fastingWindow(String hours) {
    return '断食（$hours時間）';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return '食事（$hours時間）';
  }

  @override
  String get recipe_oatSmoothie => 'オートミールスムージー';

  @override
  String get recipe_avocadoToast => 'アボカドトースト';

  @override
  String get recipe_yogurtBowl => 'ヨーグルトボウル';

  @override
  String get elapsed_time => '経過時間';

  @override
  String get fast_ends_on => '断食終了時刻';

  @override
  String get end_fasting => '断食を終了';

  @override
  String get start_fasting => '断食を開始';

  @override
  String get water_tracker => '水分トラッカー';

  @override
  String get weight_tracker => '体重トラッカー';

  @override
  String get drink => '飲む';

  @override
  String get log_weight => '体重を記録';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => '減量した体重';

  @override
  String get current_weight => '現在の体重';

  @override
  String get goal_weight => '目標体重';

  @override
  String get daily_goal => '1日の目標';

  @override
  String completed_percent(String percent) {
    return '$percent%完了';
  }

  @override
  String get explore => '見つける';

  @override
  String get achievements => '実績';

  @override
  String get profile_theme => '外観';

  @override
  String get theme_select => '外観を選択';

  @override
  String get theme_system => 'システム設定';

  @override
  String get theme_light => 'ライト';

  @override
  String get theme_dark => 'ダーク';

  @override
  String get language_system => 'システム言語';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => '完了音';

  @override
  String get profile_calmGamification => '穏やかなゲーム要素';

  @override
  String get profile_calmGamificationDesc => 'リーグやシーズンのプレッシャーを軽減します';

  @override
  String get profile_editName => '名前を編集';

  @override
  String get profile_name => '名前';

  @override
  String get circle_title => '断食サークル';

  @override
  String get circle_you => 'あなた';

  @override
  String get circle_tagline => 'プレッシャーなく、一緒に。';

  @override
  String get circle_privacy => '体重と個人指標は非公開です。進捗と応援だけが表示されます。';

  @override
  String circle_sendSupport(int count) {
    return '応援を送る · $count';
  }

  @override
  String get circle_inviteCopied => '招待コードをコピーしました';

  @override
  String get circle_createInvite => '非公開の招待を作成';

  @override
  String get crisis_nameTitle => 'まず、今起きていることを言葉にしましょう';

  @override
  String get crisis_nameDesc => '空腹、習慣、または感情かもしれません。';

  @override
  String get crisis_waterTitle => 'コップ一杯の水を飲む';

  @override
  String get crisis_waterDesc => 'そのあと、ゆっくり3回呼吸しましょう。';

  @override
  String get crisis_delayTitle => '決断を10分先延ばしにする';

  @override
  String get crisis_delayDesc => '気分が悪いときに断食を終えることは失敗ではありません。';

  @override
  String get crisis_hunger => '空腹';

  @override
  String get crisis_habit => '習慣';

  @override
  String get crisis_stress => 'ストレス';

  @override
  String get crisis_tenMore => 'あと10分待つ';

  @override
  String get stats_storyEmpty => '最初の断食から、あなた自身の物語が始まります。';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return 'この期間に$sessions回断食し、$hours時間リズムを保ち、完了率$rate%を達成しました。';
  }

  @override
  String get stats_storyTitle => 'あなたのリズムの物語';

  @override
  String get home_todayRhythm => '今日のリズム';

  @override
  String get home_finalHourSupport => '最後の1時間のサポート';

  @override
  String get home_needSupport => '少し応援がほしい';

  @override
  String get home_todaySummary => '今日の概要';

  @override
  String get home_dayStreak => '日連続';

  @override
  String home_weightGoal(String weight) {
    return '目標 $weight kg';
  }

  @override
  String get weather_steady => 'リズムは安定しています';

  @override
  String get weather_gentle => '穏やかな一日';

  @override
  String get weather_water => 'コップ一杯の水が助けになるかもしれません。';

  @override
  String get weather_listen => 'ここまでよく進みました。身体の声に耳を傾けましょう。';

  @override
  String get weather_onPlan => '今日のペースはプランどおりです。';

  @override
  String get weather_challenging => '以前はこの時間が難所でした。サポートモードを利用できます。';

  @override
  String get replay_copied => '断食リプレイをコピーしました';

  @override
  String get replay_button => 'リプレイ';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return '$plan断食を$hours時間$minutes分で完了しました · $phase';
  }

  @override
  String get journey_label => '代謝の旅';

  @override
  String get journey_now => '現在';

  @override
  String journey_next(String time, String phase) {
    return '$phaseまで$time';
  }

  @override
  String get phase_estimateShort => 'フェーズの時間は一般的な目安であり、医学的な測定値ではありません。';

  @override
  String phase_hours(int start, int end) {
    return '$start～$end時間';
  }

  @override
  String get phase_estimateLong => 'この時間は一般的な目安です。代謝反応には個人差があります。';

  @override
  String get bmi_underweight => '低体重';

  @override
  String get bmi_normal => '標準';

  @override
  String get bmi_overweight => '過体重';

  @override
  String get bmi_obese => '肥満';

  @override
  String get notification_halfwayTitle => '半分まで来ました！ 💪';

  @override
  String notification_halfwayBody(String plan) {
    return '$plan断食の半分を完了しました。その調子です！';
  }

  @override
  String get notification_phaseCatabolic => '異化期に入りました 📉';

  @override
  String get notification_phaseFatBurning => '脂肪燃焼が始まりました！ 🔥';

  @override
  String get notification_phaseKetosis => 'ケトーシス状態です ⚡';

  @override
  String get notification_phaseAutophagy => 'オートファジーが活発です！ 🔄';

  @override
  String notification_completedBody(String plan) {
    return '$plan断食を完了しました！食事時間が始まりました。';
  }

  @override
  String get notification_waterTitle => '水を飲みましょう 💧';

  @override
  String get notification_waterBody => '断食中は十分な水分補給を忘れずに！';

  @override
  String get notification_windowTitle => '食事時間がまもなく終了します ⏰';

  @override
  String get notification_windowBody => '食事時間は30分後に終了します。';

  @override
  String notification_streakTitle(int days) {
    return '$days日連続！ 🔥';
  }

  @override
  String get notification_streakBody => '順調です！今日も続けましょう。';

  @override
  String notification_ongoingTitle(String phase) {
    return '断食中 - $phase';
  }

  @override
  String notification_remaining(String time) {
    return '残り：$time';
  }

  @override
  String notification_started(String plan) {
    return '断食開始 - $plan';
  }

  @override
  String notification_target(int hours) {
    return '目標：$hours時間';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours時間$minutes分';
  }

  @override
  String get explore_guide => '断食ガイド';

  @override
  String get explore_guideDesc => '間欠的断食について知っておきたいすべてのこと';

  @override
  String get explore_circleDesc => '非公開グループで穏やかに応援し合いましょう。';

  @override
  String get explore_faq => 'よくある質問';

  @override
  String get explore_education => 'この内容は一般的な教育のみを目的としており、医学的診断や治療の助言ではありません。';

  @override
  String get explore_safety => '健康と安全';

  @override
  String get explore_safetyDesc =>
      '持病がある、常用薬を服用している、気になる症状がある、妊娠中または授乳中の場合は、断食を始める前に資格を持つ医療専門家に相談してください。気分が悪くなったら中止してください。';

  @override
  String get explore_sources => '出典';

  @override
  String get explore_sourcesDesc => '内容は以下の公衆衛生資料をもとに簡略化しています。';

  @override
  String get explore_sourceError => '出典を開けませんでした';

  @override
  String get explore_rules => '重要なルール';

  @override
  String get explore_rule1 => '断食中はカロリーのある食品を摂らない';

  @override
  String get explore_rule2 => '水や水分を十分に摂る';

  @override
  String get explore_rule3 => '食事時間にはバランスよく食べる';

  @override
  String get explore_rule4 => '気分が悪くなったら断食を中止する';

  @override
  String get explore_rule5 => '妊娠中または授乳中の方は断食しない';

  @override
  String get explore_rule6 => '慢性疾患がある場合は医師に相談する';

  @override
  String get tip_water => '水分を保つ';

  @override
  String get tip_waterDesc =>
      '喉が渇いたら水を飲み、食事にも水分を取り入れましょう。必要量は健康状態、天候、活動量によって異なります。';

  @override
  String get tip_food => '正しく食べる';

  @override
  String get tip_foodDesc => '食事時間には、食物繊維と良質な脂質を含む高たんぱく食品を選び、加工食品を避けましょう。';

  @override
  String get tip_sleep => 'よく眠る';

  @override
  String get tip_sleepDesc => '規則正しく十分な睡眠は健康全般を支えます。睡眠を妨げないよう断食時間を調整してください。';

  @override
  String get tip_exercise => '軽い運動';

  @override
  String get tip_exerciseDesc =>
      '断食中も軽い散歩やヨガはできます。特に身体が慣れるまでの最初の数週間は激しい運動を避けてください。';

  @override
  String get tip_drinks => '飲めるもの';

  @override
  String get tip_drinksDesc =>
      '断食中は水、無糖のお茶、ブラックコーヒー（砂糖・ミルクなし）を飲めます。これらは断食を中断しません。';

  @override
  String get faq_drinks => '断食中に何を飲めますか？';

  @override
  String get faq_drinksAnswer =>
      '水、無糖のお茶、ブラックコーヒー（砂糖・ミルクなし）を飲めます。カロリーのある飲み物は断食を中断します。';

  @override
  String get faq_plan => 'どの断食プランを選べばよいですか？';

  @override
  String get faq_planAnswer =>
      '初心者は12:12または14:10から始めましょう。経験者は16:8または18:6を試せます。20:4とOMADは上級者向けです。';

  @override
  String get faq_exercise => '断食中に運動できますか？';

  @override
  String get faq_exerciseAnswer =>
      'はい。ただし激しい運動は避けてください。軽い有酸素運動、散歩、ヨガが適しています。筋力トレーニングは食事時間の近くに行いましょう。';

  @override
  String get faq_weight => '断食は減量に役立ちますか？';

  @override
  String get faq_weightAnswer =>
      '食事時間を制限すると総摂取エネルギーが減る人もいます。結果には個人差があり、長期的な影響は現在も研究中です。';

  @override
  String get plan_12_desc => '初心者向け';

  @override
  String get plan_12_detail => '初心者に最適。睡眠時間を含めて12時間断食します。';

  @override
  String get plan_16_desc => '最も人気のプラン';

  @override
  String get plan_16_detail => '最も一般的な間欠的断食。16時間断食し、8時間食事します。通常は昼食から夕食までです。';

  @override
  String get plan_18_desc => '中級者向け';

  @override
  String get plan_18_detail => '18時間断食し、6時間食事します。脂肪燃焼時間が長くなります。';

  @override
  String get plan_20_desc => '上級者向け';

  @override
  String get plan_20_detail => '20時間断食し、4時間食事します。ケトーシスとオートファジーを目指す上級プランです。';

  @override
  String get plan_omad_desc => '1日1食';

  @override
  String get plan_omad_detail => '1日1食。23時間断食し、1時間食事します。熟練者向けです。';

  @override
  String get plan_52_desc => '週2日';

  @override
  String get plan_52_detail => '5日は通常どおり食べ、2日は約500カロリーだけ摂ります。別の選択肢となる方法です。';

  @override
  String get plan_ese_desc => '24時間断食';

  @override
  String get plan_ese_detail => '週に1～2回、24時間断食します。上級者向けです。';

  @override
  String get plan_warrior_desc => 'ウォリアーダイエット';

  @override
  String get plan_warrior_detail => '日中は果物や野菜などを軽く食べ、夜の4時間枠で主な食事を摂ります。';

  @override
  String get award_first_title => '最初の一歩';

  @override
  String get award_first_desc => '最初の断食を完了する';

  @override
  String get award_rhythm3_title => '3日間のリズム';

  @override
  String get award_rhythm3_desc => '3日間リズムを保つ';

  @override
  String get award_hours24_title => '24時間';

  @override
  String get award_hours24_desc => '合計24時間断食する';

  @override
  String get award_week_title => '1週間のリズム';

  @override
  String get award_week_desc => '7日間の連続記録を作る';

  @override
  String get award_fasts10_title => '断食10回';

  @override
  String get award_fasts10_desc => '断食を10回完了する';

  @override
  String get award_hours100_title => '100時間';

  @override
  String get award_hours100_desc => '合計100時間に達する';

  @override
  String get award_rhythm30_title => '30日間のリズム';

  @override
  String get award_rhythm30_desc => '30日間の連続記録を作る';

  @override
  String get award_fasts50_title => '断食50回';

  @override
  String get award_fasts50_desc => '断食を50回完了する';

  @override
  String get award_hours500_title => '500時間';

  @override
  String get award_hours500_desc => '合計500時間に達する';

  @override
  String get award_fasts100_title => '断食100回';

  @override
  String get award_fasts100_desc => '断食を100回完了する';

  @override
  String get award_rhythm90_title => '90日間のリズム';

  @override
  String get award_rhythm90_desc => '90日間の連続記録を作る';

  @override
  String get award_year_title => '1年間の旅';

  @override
  String get award_year_desc => '365日間のリズムに達する';

  @override
  String get awards_loadError => '進捗を読み込めませんでした';

  @override
  String get awards_journeyComplete => '旅を完了';

  @override
  String get awards_nextGoal => '次の目標';

  @override
  String get awards_allYours => 'すべての実績を獲得しました';

  @override
  String get awards_dayStreak => '日連続';

  @override
  String get awards_fasts => '回の断食';

  @override
  String get awards_total => '合計';

  @override
  String get awards_stageStart => '開始';

  @override
  String get awards_stageRhythm => 'リズム';

  @override
  String get awards_stageEndurance => '持久力';

  @override
  String get awards_stageMastery => '熟練';

  @override
  String get awards_completed => '完了';

  @override
  String awards_fastsRemaining(int count) {
    return 'あと$count回の断食';
  }

  @override
  String awards_daysRemaining(int count) {
    return 'あと$count日';
  }

  @override
  String awards_hoursRemaining(int count) {
    return 'あと$count時間';
  }

  @override
  String get common_retry => '再試行';

  @override
  String get game_title => '進捗ハブ';

  @override
  String get game_quests => '今日のクエスト';

  @override
  String get game_questsDesc => '小さな一歩で、持続できるリズムを。';

  @override
  String get game_season => '30ステップシーズン';

  @override
  String get game_seasonDesc => '5ステップごとにコレクション用のシールを獲得。';

  @override
  String get game_badges => 'バッジコレクション';

  @override
  String game_shields(int count) {
    return 'リズムシールド $count個';
  }

  @override
  String get game_shieldsDesc => '7回完了するごとに獲得できます。1日休んでも進捗が消えることはありません。';

  @override
  String get game_league => '非公開の週間リーグ';

  @override
  String game_leagueDesc(int percent) {
    return 'あなたのリズムスコアは非公開のローカルモデルで$percentパーセンタイルです。体重や極端な断食を順位付けすることはありません。';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return 'レベル$level、経験値$xp';
  }

  @override
  String get game_explorer => 'リズム探検家';

  @override
  String get game_streak => '連続記録';

  @override
  String get game_targets => '目標';

  @override
  String get game_best => 'ベスト';

  @override
  String get quest_rhythm => '今日のリズムを作る';

  @override
  String get quest_hydrate => '水分目標の半分に達する';

  @override
  String get quest_steady => '連続記録を守る';

  @override
  String get badge_first_title => '最初の一歩';

  @override
  String get badge_first_desc => '最初の断食を記録する';

  @override
  String get badge_rhythm7_title => 'リズムキーパー';

  @override
  String get badge_rhythm7_desc => '7日連続を達成する';

  @override
  String get badge_rhythm3_title => '3日間のリズム';

  @override
  String get badge_rhythm3_desc => '3日連続を達成する';

  @override
  String get badge_target1_title => '最初の目標';

  @override
  String get badge_target1_desc => '最初の目標断食を完了する';

  @override
  String get badge_target3_title => '3つのステップ';

  @override
  String get badge_target3_desc => '目標を3つ完了する';

  @override
  String get badge_water_title => 'バランス';

  @override
  String get badge_water_desc => '1日の水分目標を達成する';

  @override
  String get badge_support_title => '自己理解';

  @override
  String get badge_support_desc => 'サポートモードを使う';

  @override
  String get badge_hours10_title => '10時間';

  @override
  String get badge_hours10_desc => '合計10時間を記録する';

  @override
  String get badge_target10_title => '力強い10回';

  @override
  String get badge_target10_desc => '目標を10回完了する';

  @override
  String get badge_target20_title => '20の目標';

  @override
  String get badge_target20_desc => '目標を20回完了する';

  @override
  String get badge_fast16_title => '16時間';

  @override
  String get badge_fast16_desc => '1回の断食で16時間に達する';

  @override
  String get badge_hours50_title => '50時間';

  @override
  String get badge_hours50_desc => '合計50時間を記録する';

  @override
  String get badge_hours100_title => '100時間';

  @override
  String get badge_hours100_desc => '合計100時間を記録する';

  @override
  String get badge_target30_title => '30の目標';

  @override
  String get badge_target30_desc => '目標を30回完了する';

  @override
  String get badge_rhythm30_title => '30日間のリズム';

  @override
  String get badge_rhythm30_desc => '30日連続を達成する';

  @override
  String get paywall_restoreSuccess => '購入を復元しました！';

  @override
  String fasting_progressSemantics(int percent) {
    return '断食の進捗$percentパーセント';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour時間';
  }

  @override
  String get paywall_lifetime => '買い切り';

  @override
  String get paywall_once => '1回限り';

  @override
  String get paywall_processing => '処理中…';

  @override
  String get paywall_continue => '続ける';

  @override
  String get paywall_productsUnavailable => '現在購入できません。しばらくしてからもう一度お試しください。';

  @override
  String get paywall_purchaseFailed => '購入を完了できませんでした。';

  @override
  String get paywall_nothingToRestore => '以前の購入が見つかりませんでした。';

  @override
  String get paywall_restoreFailed => '購入を復元できませんでした。';

  @override
  String get paywall_terms => '利用規約';

  @override
  String get permission_notificationDesc => '断食リマインダー、フェーズ更新、完了通知';

  @override
  String get profile_privacyChoices => 'プライバシーの選択';

  @override
  String get paywall_autoRenewInfo =>
      '期間終了の24時間以上前に解約しない限り、サブスクリプションは自動更新されます。App Storeの設定からいつでも管理または解約できます。';

  @override
  String paywall_perMonth(String price) {
    return '月額 $price';
  }

  @override
  String paywall_savePercent(int percent) {
    return '$percent%お得';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days日間無料トライアル';
  }

  @override
  String get paywall_startFreeTrial => '無料トライアルを開始';

  @override
  String get paywall_retry => '再試行';

  @override
  String get paywall_alreadyOwned => 'このサブスクリプションはすでに購入済みです。「購入を復元」をタップしてください。';

  @override
  String get paywall_storeUnavailable => '現在ストアに接続できません。接続を確認して再試行してください。';

  @override
  String get paywall_secureNote => 'いつでも解約できます。料金はストアアカウントに請求されます。';

  @override
  String get paywall_autoRenewInfoPlay =>
      '期間終了の24時間以上前に解約しない限り、サブスクリプションは自動更新されます。Google Play > 定期購入からいつでも管理または解約できます。';

  @override
  String get paywall_allPlansDesc =>
      '18:6、20:4、OMAD、5:2、Eat-Stop-Eat、Warriorを利用可能';

  @override
  String get paywall_noAdsDesc => 'バナー広告と全画面広告を完全に非表示にします';

  @override
  String get foodScan_title => 'AI食事スキャン';

  @override
  String get foodScan_scanCta => '食事をスキャン';

  @override
  String get foodScan_scanCtaDesc => '料理を撮影してカロリーと主要栄養素を確認';

  @override
  String get foodScan_introTitle => '料理を撮影';

  @override
  String get foodScan_introDesc => 'AIが写真を読み取り、カロリー、たんぱく質、炭水化物、脂質を推定します。';

  @override
  String get foodScan_tipLight => '均一で明るい照明ほど推定精度が上がります';

  @override
  String get foodScan_tipFrame => '皿全体をフレームに収めてください';

  @override
  String get foodScan_tipScale => '量を推定できるよう、カトラリーや手も写してください';

  @override
  String get foodScan_takePhoto => '写真を撮る';

  @override
  String get foodScan_chooseFromGallery => 'ギャラリーから選択';

  @override
  String foodScan_scansLeft(int count) {
    return '今日の残りスキャン回数：$count';
  }

  @override
  String get foodScan_quotaReached => '今日のスキャン回数を使い切りました。明日もう一度お試しください。';

  @override
  String get foodScan_privacyNote =>
      '写真は分析のためGoogleのGemini APIに送信され、当社のサーバーには保存されません。';

  @override
  String get foodScan_consentTitle => '写真を Google Gemini に送信しますか？';

  @override
  String get foodScan_consentBody =>
      'カロリーと栄養素を推定するため、撮影または選択した食事の写真は Google の AI サービス Gemini に送信されます。写真はこの分析にのみ使用され、当社のサーバーには保存されません。';

  @override
  String get foodScan_consentAgree => '同意して続ける';

  @override
  String get foodScan_analyzing => '食事を分析中…';

  @override
  String get foodScan_analyzingHint => '通常は数秒で完了します';

  @override
  String get foodScan_detectedItems => '検出された食品';

  @override
  String get foodScan_disclaimer => 'AIの推定値は概算です。項目をタップして修正できます。';

  @override
  String get foodScan_lowConfidence => 'この写真についてモデルの確信度が低いです。保存前に数値を確認してください。';

  @override
  String get foodScan_save => '食事に追加';

  @override
  String get foodScan_retake => '新しい写真';

  @override
  String get foodScan_retry => '再試行';

  @override
  String get foodScan_editItem => '項目を編集';

  @override
  String get foodScan_portion => '分量';

  @override
  String get foodScan_saveEdit => '保存';

  @override
  String get foodScan_premiumTitle => 'Premium機能';

  @override
  String get foodScan_premiumDesc => '写真によるカロリー分析はPremiumに含まれます。';

  @override
  String get foodScan_upgrade => 'Premiumを見る';

  @override
  String get foodScan_errorNetwork => '接続がありません。インターネット接続を確認して再試行してください。';

  @override
  String get foodScan_errorRateLimited => '現在スキャンが集中しています。数分後にもう一度お試しください。';

  @override
  String get foodScan_errorUnavailable => '現在、写真分析を利用できません。';

  @override
  String get foodScan_errorServer => '分析サービスに問題が発生しています。しばらくしてから再試行してください。';

  @override
  String get foodScan_errorNoFood => '写真に食べ物が見つかりませんでした。皿をより鮮明に撮影してください。';

  @override
  String get foodScan_errorUnreadable => 'この写真を分析できませんでした。別の写真をお試しください。';

  @override
  String get paywall_aiFoodScan => 'AI食事スキャン';

  @override
  String get paywall_aiFoodScanDesc => '食事を撮影し、カロリーと主要栄養素を数秒で記録します';
}
