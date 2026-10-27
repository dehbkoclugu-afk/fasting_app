// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => '早上好';

  @override
  String get greeting_afternoon => '下午好';

  @override
  String get greeting_evening => '晚上好';

  @override
  String get tab_timer => '首页';

  @override
  String get tab_explore => '探索';

  @override
  String get tab_stats => '报告';

  @override
  String get tab_meals => '膳食';

  @override
  String get tab_achievements => '成就';

  @override
  String get tab_profile => '账户';

  @override
  String get timer_fasting => '禁食时间';

  @override
  String get timer_remaining => '剩余时间';

  @override
  String get timer_elapsed => '已用时间';

  @override
  String get timer_start => '开始';

  @override
  String get timer_stop => '停止';

  @override
  String get timer_completed => '恭喜！';

  @override
  String get timer_completedMessage => '您已成功完成禁食！';

  @override
  String get timer_selectPlan => '选择禁食计划';

  @override
  String get timer_stopConfirm => '确定要提前结束禁食吗？';

  @override
  String get timer_stopTitle => '结束禁食';

  @override
  String get timer_cancel => '取消';

  @override
  String get timer_confirmStop => '是，结束';

  @override
  String get phase_anabolic => '合成代谢期';

  @override
  String get phase_anabolicDesc => '正在消化';

  @override
  String get phase_catabolic => '分解代谢期';

  @override
  String get phase_catabolicDesc => '能量转换中';

  @override
  String get phase_fatBurning => '脂肪燃烧';

  @override
  String get phase_fatBurningDesc => '脂肪燃烧已开始';

  @override
  String get phase_ketosis => '酮症';

  @override
  String get phase_ketosisDesc => '酮体生成活跃';

  @override
  String get phase_autophagy => '自噬';

  @override
  String get phase_autophagyDesc => '细胞更新';

  @override
  String get stats_title => '统计';

  @override
  String get stats_week => '周';

  @override
  String get stats_month => '月';

  @override
  String get stats_year => '年';

  @override
  String get stats_totalFasts => '禁食总次数';

  @override
  String get stats_average => '平均';

  @override
  String get stats_fastDuration => '禁食时长';

  @override
  String get stats_streak => '连续记录';

  @override
  String get stats_daysConsecutive => '连续天数';

  @override
  String get stats_success => '成功';

  @override
  String get stats_completion => '完成率';

  @override
  String get stats_weeklyFasting => '每周禁食';

  @override
  String get stats_monthlyView => '月度视图';

  @override
  String get stats_weightChange => '体重变化';

  @override
  String get heatmap_none => '无';

  @override
  String get heatmap_low => '较少';

  @override
  String get heatmap_good => '良好';

  @override
  String get heatmap_full => '充足';

  @override
  String get meals_title => '膳食计划';

  @override
  String get meals_eatingWindow => '进食窗口';

  @override
  String get meals_windowOpen => '已开放';

  @override
  String get meals_windowFasting => '禁食中';

  @override
  String get meals_calories => '卡路里';

  @override
  String get meals_protein => '蛋白质';

  @override
  String get meals_carbs => '碳水化合物';

  @override
  String get meals_fat => '脂肪';

  @override
  String get meals_todayMeals => '今日膳食';

  @override
  String get meals_noMeals => '尚未添加膳食';

  @override
  String get meals_breakfastSuggestions => '开斋餐建议';

  @override
  String get meals_addMeal => '添加膳食';

  @override
  String get profile_title => '个人资料';

  @override
  String get profile_user => '用户';

  @override
  String profile_planActive(String plan) {
    return '$plan计划已启用';
  }

  @override
  String get profile_upgradePremium => '升级到高级版';

  @override
  String get profile_premiumDesc => '所有禁食计划，无广告';

  @override
  String get profile_bodyMetrics => '身体指标';

  @override
  String get profile_height => '身高';

  @override
  String get profile_weight => '体重';

  @override
  String get profile_targetWeight => '目标体重';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => '设置';

  @override
  String get profile_notifications => '通知';

  @override
  String get profile_darkTheme => '深色主题';

  @override
  String get profile_waterReminder => '饮水提醒';

  @override
  String get profile_phaseNotifications => '阶段通知';

  @override
  String get profile_language => '语言';

  @override
  String get profile_about => '关于';

  @override
  String get profile_rateApp => '评价应用';

  @override
  String get profile_share => '分享';

  @override
  String get profile_privacyPolicy => '隐私政策';

  @override
  String get profile_version => '版本';

  @override
  String get onboarding_welcome => '欢迎';

  @override
  String get onboarding_welcomeDesc => '掌控您的\n间歇性禁食之旅';

  @override
  String get onboarding_featureTimer => '智能禁食计时器';

  @override
  String get onboarding_featureStats => '详细统计和图表';

  @override
  String get onboarding_featureMeals => '膳食计划和食谱建议';

  @override
  String get onboarding_getStarted => '开始使用';

  @override
  String get onboarding_selectGoal => '您的目标是什么？';

  @override
  String get onboarding_selectGoalDesc => '可以多选';

  @override
  String get onboarding_goalWeight => '减重';

  @override
  String get onboarding_goalWeightDesc => '健康减重';

  @override
  String get onboarding_goalHealth => '改善健康';

  @override
  String get onboarding_goalHealthDesc => '整体健康和免疫力';

  @override
  String get onboarding_goalEnergy => '更有活力';

  @override
  String get onboarding_goalEnergyDesc => '全天保持精力';

  @override
  String get onboarding_goalMental => '思维清晰';

  @override
  String get onboarding_goalMentalDesc => '专注与清晰';

  @override
  String get onboarding_goalLongevity => '长寿';

  @override
  String get onboarding_goalLongevityDesc => '细胞更新与健康衰老';

  @override
  String get onboarding_goalDiscipline => '自律';

  @override
  String get onboarding_goalDisciplineDesc => '培养自律能力';

  @override
  String get onboarding_selectPlan => '选择您的计划';

  @override
  String get onboarding_selectPlanDesc => '选择最适合您的禁食计划';

  @override
  String get onboarding_bodyInfo => '输入您的信息';

  @override
  String get onboarding_bodyInfoDesc => '用于个性化建议';

  @override
  String get onboarding_gender => '性别';

  @override
  String get onboarding_male => '男';

  @override
  String get onboarding_female => '女';

  @override
  String get onboarding_age => '年龄';

  @override
  String get onboarding_bodyInfoDisclaimer => '此信息仅保存在您的设备上，并用于计算卡路里。';

  @override
  String get onboarding_permissions => '最后一步';

  @override
  String get onboarding_permissionsDesc => '启用权限以获得最佳体验';

  @override
  String get onboarding_next => '继续';

  @override
  String get onboarding_start => '开始吧！';

  @override
  String get onboarding_skipForNow => '稍后设置';

  @override
  String get waterAdded => '已添加250毫升水';

  @override
  String get languageSelect => '选择语言';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => '升级到高级版';

  @override
  String get paywall_subtitle => '解锁所有禁食计划并移除广告';

  @override
  String get paywall_allPlans => '所有禁食计划';

  @override
  String get paywall_advancedStats => '高级统计';

  @override
  String get paywall_mealPlanner => '膳食计划';

  @override
  String get paywall_themes => '主题自定义';

  @override
  String get paywall_noAds => '无广告';

  @override
  String get paywall_weekly => '每周';

  @override
  String get paywall_monthly => '每月';

  @override
  String get paywall_yearly => '每年';

  @override
  String get paywall_bestValue => '最划算';

  @override
  String get paywall_freeTrial => '免费试用（3天）';

  @override
  String get paywall_restore => '恢复购买';

  @override
  String get paywall_premiumActive => '高级版已启用！';

  @override
  String get paywall_premiumActiveDesc => '所有禁食计划均已解锁，广告已关闭';

  @override
  String get water_title => '饮水量';

  @override
  String get water_addWater => '添加饮水';

  @override
  String get water_goal => '目标';

  @override
  String get water_ml => '毫升';

  @override
  String get common_ok => '确定';

  @override
  String get common_cancel => '取消';

  @override
  String get common_save => '保存';

  @override
  String get common_delete => '删除';

  @override
  String get common_hours => '小时';

  @override
  String get common_minutes => '分钟';

  @override
  String get common_days => '天';

  @override
  String get common_enable => '启用';

  @override
  String get streakCard_currentStreak => '当前连续记录';

  @override
  String get streakCard_longestStreak => '最长连续记录';

  @override
  String get streakCard_totalSessions => '禁食总次数';

  @override
  String get meals_mealType => '膳食类型';

  @override
  String get meals_breakfast => '早餐';

  @override
  String get meals_lunch => '午餐';

  @override
  String get meals_dinner => '晚餐';

  @override
  String get meals_snack => '加餐';

  @override
  String get meals_carbohydrate => '碳水化合物';

  @override
  String get meals_add => '添加';

  @override
  String get meals_mealName => '膳食名称';

  @override
  String get bodyMetrics_title => '身体指标';

  @override
  String get bodyMetrics_weight => '体重';

  @override
  String get bodyMetrics_target => '目标';

  @override
  String get bodyMetrics_save => '保存';

  @override
  String get bodyMetrics_history => '历史';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI：$value';
  }

  @override
  String get bodyMetrics_noData => '暂无数据';

  @override
  String get meals_quickAdd => '快速添加';

  @override
  String get meals_manualEntry => '手动输入';

  @override
  String meals_added(String name) {
    return '已添加$name';
  }

  @override
  String get meals_nameCalorieRequired => '名称和卡路里为必填项';

  @override
  String get bodyMetrics_addWeight => '添加体重';

  @override
  String get bodyMetrics_hintWeight => '例如74.5';

  @override
  String get bodyMetrics_invalidWeight => '请输入有效体重';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '已保存$value公斤';
  }

  @override
  String get completion_duration => '时长';

  @override
  String get completion_plan => '计划';

  @override
  String get completion_lastPhase => '最后阶段';

  @override
  String get completion_earlyTitle => '禁食已结束';

  @override
  String get completion_earlyMessage => '今天的时长已保存。由于未完成目标，连续记录和成就进度没有变化。';

  @override
  String get timer_remainingTime => '剩余时间';

  @override
  String get timer_ready => '准备开始';

  @override
  String get streak_status => '状态';

  @override
  String get streak_startToday => '今天开始！';

  @override
  String get streak_goodStart => '开局不错！';

  @override
  String get streak_goingGreat => '进展顺利！';

  @override
  String get streak_superb => '太棒了！';

  @override
  String get streak_legendary => '传奇！';

  @override
  String get streak_incredible => '不可思议！';

  @override
  String get weight_noRecord => '尚无体重记录\n请从个人资料 > 身体指标添加';

  @override
  String get day_mon => '周一';

  @override
  String get day_tue => '周二';

  @override
  String get day_wed => '周三';

  @override
  String get day_thu => '周四';

  @override
  String get day_fri => '周五';

  @override
  String get day_sat => '周六';

  @override
  String get day_sun => '周日';

  @override
  String get day_short_mon => '一';

  @override
  String get day_short_tue => '二';

  @override
  String get day_short_wed => '三';

  @override
  String get day_short_thu => '四';

  @override
  String get day_short_fri => '五';

  @override
  String get day_short_sat => '六';

  @override
  String get day_short_sun => '日';

  @override
  String get month_jan => '一月';

  @override
  String get month_feb => '二月';

  @override
  String get month_mar => '三月';

  @override
  String get month_apr => '四月';

  @override
  String get month_may => '五月';

  @override
  String get month_jun => '六月';

  @override
  String get month_jul => '七月';

  @override
  String get month_aug => '八月';

  @override
  String get month_sep => '九月';

  @override
  String get month_oct => '十月';

  @override
  String get month_nov => '十一月';

  @override
  String get month_dec => '十二月';

  @override
  String meals_fastingWindow(String hours) {
    return '禁食（$hours小时）';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return '进食（$hours小时）';
  }

  @override
  String get recipe_oatSmoothie => '燕麦奶昔';

  @override
  String get recipe_avocadoToast => '牛油果吐司';

  @override
  String get recipe_yogurtBowl => '酸奶碗';

  @override
  String get elapsed_time => '已用时间';

  @override
  String get fast_ends_on => '您的禁食结束于';

  @override
  String get end_fasting => '结束禁食';

  @override
  String get start_fasting => '开始禁食';

  @override
  String get water_tracker => '饮水追踪';

  @override
  String get weight_tracker => '体重追踪';

  @override
  String get drink => '饮水';

  @override
  String get log_weight => '记录体重';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => '已减体重';

  @override
  String get current_weight => '当前体重';

  @override
  String get goal_weight => '目标体重';

  @override
  String get daily_goal => '每日目标';

  @override
  String completed_percent(String percent) {
    return '已完成$percent%';
  }

  @override
  String get explore => '探索';

  @override
  String get achievements => '成就';

  @override
  String get profile_theme => '外观';

  @override
  String get theme_select => '选择外观';

  @override
  String get theme_system => '跟随系统';

  @override
  String get theme_light => '浅色';

  @override
  String get theme_dark => '深色';

  @override
  String get language_system => '系统语言';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => '完成提示音';

  @override
  String get profile_calmGamification => '轻松游戏化';

  @override
  String get profile_calmGamificationDesc => '减轻联赛和赛季压力';

  @override
  String get profile_editName => '编辑您的姓名';

  @override
  String get profile_name => '姓名';

  @override
  String get circle_title => '禁食圈';

  @override
  String get circle_you => '您';

  @override
  String get circle_tagline => '一起坚持，毫无压力。';

  @override
  String get circle_privacy => '体重和私人指标保持隐藏，仅显示进度和支持。';

  @override
  String circle_sendSupport(int count) {
    return '发送支持 · $count';
  }

  @override
  String get circle_inviteCopied => '邀请码已复制';

  @override
  String get circle_createInvite => '创建私人邀请';

  @override
  String get crisis_nameTitle => '首先，说出正在发生什么';

  @override
  String get crisis_nameDesc => '这可能是饥饿、习惯或情绪。';

  @override
  String get crisis_waterTitle => '喝一杯水';

  @override
  String get crisis_waterDesc => '然后缓慢深呼吸三次。';

  @override
  String get crisis_delayTitle => '将决定推迟10分钟';

  @override
  String get crisis_delayDesc => '如果感觉不适，结束禁食并不意味着失败。';

  @override
  String get crisis_hunger => '饥饿';

  @override
  String get crisis_habit => '习惯';

  @override
  String get crisis_stress => '压力';

  @override
  String get crisis_tenMore => '再给自己10分钟';

  @override
  String get stats_storyEmpty => '第一次禁食将开启您的个人故事。';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return '本阶段您禁食了$sessions次，保持节奏$hours小时，完成率达到$rate%。';
  }

  @override
  String get stats_storyTitle => '您的节奏故事';

  @override
  String get home_todayRhythm => '今日节奏';

  @override
  String get home_finalHourSupport => '最后一小时支持';

  @override
  String get home_needSupport => '我需要一点支持';

  @override
  String get home_todaySummary => '今日概览';

  @override
  String get home_dayStreak => '天连续';

  @override
  String home_weightGoal(String weight) {
    return '目标$weight公斤';
  }

  @override
  String get weather_steady => '您的节奏很稳定';

  @override
  String get weather_gentle => '轻松的一天';

  @override
  String get weather_water => '一杯水可能会有帮助。';

  @override
  String get weather_listen => '您已经走了很远，请倾听身体的声音。';

  @override
  String get weather_onPlan => '今天的节奏符合您的计划。';

  @override
  String get weather_challenging => '过去这个小时比较难熬，支持模式已准备好。';

  @override
  String get replay_copied => '禁食回顾已复制';

  @override
  String get replay_button => '回顾';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return '我用$hours小时$minutes分钟完成了$plan禁食 · $phase';
  }

  @override
  String get journey_label => '代谢之旅';

  @override
  String get journey_now => '现在';

  @override
  String journey_next(String time, String phase) {
    return '距离$phase还有$time';
  }

  @override
  String get phase_estimateShort => '阶段时间仅为一般估计，并非医学测量。';

  @override
  String phase_hours(int start, int end) {
    return '第$start–$end小时';
  }

  @override
  String get phase_estimateLong => '此时间仅为一般估计，不同人的代谢反应可能有所不同。';

  @override
  String get bmi_underweight => '体重过轻';

  @override
  String get bmi_normal => '正常';

  @override
  String get bmi_overweight => '超重';

  @override
  String get bmi_obese => '肥胖';

  @override
  String get notification_halfwayTitle => '已完成一半！ 💪';

  @override
  String notification_halfwayBody(String plan) {
    return '您已完成$plan禁食的一半，继续加油！';
  }

  @override
  String get notification_phaseCatabolic => '已进入分解代谢期 📉';

  @override
  String get notification_phaseFatBurning => '脂肪燃烧已开始！ 🔥';

  @override
  String get notification_phaseKetosis => '您正处于酮症状态 ⚡';

  @override
  String get notification_phaseAutophagy => '自噬已激活！ 🔄';

  @override
  String notification_completedBody(String plan) {
    return '您已完成$plan禁食！进食窗口已开放。';
  }

  @override
  String get notification_waterTitle => '喝水 💧';

  @override
  String get notification_waterBody => '禁食期间别忘了补充充足水分！';

  @override
  String get notification_windowTitle => '进食窗口即将关闭 ⏰';

  @override
  String get notification_windowBody => '您的进食窗口将在30分钟后关闭。';

  @override
  String notification_streakTitle(int days) {
    return '连续$days天！ 🔥';
  }

  @override
  String get notification_streakBody => '您做得很棒！今天继续保持。';

  @override
  String notification_ongoingTitle(String phase) {
    return '禁食进行中 - $phase';
  }

  @override
  String notification_remaining(String time) {
    return '剩余：$time';
  }

  @override
  String notification_started(String plan) {
    return '禁食已开始 - $plan';
  }

  @override
  String notification_target(int hours) {
    return '目标：$hours小时';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours小时$minutes分钟';
  }

  @override
  String get explore_guide => '禁食指南';

  @override
  String get explore_guideDesc => '您需要了解的间歇性禁食知识';

  @override
  String get explore_circleDesc => '与您的私人小组安静地互相支持。';

  @override
  String get explore_faq => '常见问题';

  @override
  String get explore_education => '此内容仅用于一般教育，不构成医学诊断或治疗建议。';

  @override
  String get explore_safety => '健康与安全';

  @override
  String get explore_safetyDesc =>
      '如果您有疾病、长期服药、出现令人担忧的症状、正在怀孕或哺乳，请在禁食前咨询合格的医疗专业人员。如感觉不适，请停止禁食。';

  @override
  String get explore_sources => '资料来源';

  @override
  String get explore_sourcesDesc => '内容根据下方公共卫生资料进行了简化。';

  @override
  String get explore_sourceError => '无法打开资料来源';

  @override
  String get explore_rules => '重要规则';

  @override
  String get explore_rule1 => '禁食期间不要摄入含热量的食物';

  @override
  String get explore_rule2 => '饮用充足的水和液体';

  @override
  String get explore_rule3 => '在进食窗口内均衡饮食';

  @override
  String get explore_rule4 => '如感觉不适，请停止禁食';

  @override
  String get explore_rule5 => '孕妇或哺乳期女性不应禁食';

  @override
  String get explore_rule6 => '如有慢性疾病，请咨询医生';

  @override
  String get tip_water => '保持水分充足';

  @override
  String get tip_waterDesc => '口渴时喝水，并随餐补充液体。需求会因健康状况、天气和活动量而异。';

  @override
  String get tip_food => '合理饮食';

  @override
  String get tip_foodDesc => '进食期间请选择富含蛋白质、纤维和健康脂肪的食物，避免加工食品。';

  @override
  String get tip_sleep => '保证睡眠';

  @override
  String get tip_sleepDesc => '规律且充足的睡眠有益于整体健康。请安排好禁食，避免影响睡眠。';

  @override
  String get tip_exercise => '轻度运动';

  @override
  String get tip_exerciseDesc => '禁食期间可以轻松散步或练习瑜伽。避免剧烈运动，尤其是在身体适应前的最初几周。';

  @override
  String get tip_drinks => '允许的饮品';

  @override
  String get tip_drinksDesc => '禁食期间可以饮用水、纯茶和黑咖啡（不加糖、不加奶），这些饮品不会中断禁食。';

  @override
  String get faq_drinks => '禁食期间可以喝什么？';

  @override
  String get faq_drinksAnswer => '可以饮用水、纯茶和黑咖啡（不加糖/奶）。含热量的饮品会中断禁食。';

  @override
  String get faq_plan => '我该选择哪种禁食计划？';

  @override
  String get faq_planAnswer =>
      '新手可从12:12或14:10开始。有经验者可尝试16:8或18:6。20:4和OMAD适合高级禁食者。';

  @override
  String get faq_exercise => '禁食期间可以运动吗？';

  @override
  String get faq_exerciseAnswer =>
      '可以，但请避免高强度训练。轻度有氧、散步和瑜伽较为理想。力量训练请安排在进食窗口附近。';

  @override
  String get faq_weight => '禁食有助于减重吗？';

  @override
  String get faq_weightAnswer => '对一些人来说，限制进食时间可能减少总能量摄入。效果因人而异，长期影响仍在研究中。';

  @override
  String get plan_12_desc => '初级';

  @override
  String get plan_12_detail => '适合新手。包括睡眠时间在内禁食12小时。';

  @override
  String get plan_16_desc => '最受欢迎的计划';

  @override
  String get plan_16_detail => '最常见的间歇性禁食计划。禁食16小时，进食8小时，通常从午餐到晚餐。';

  @override
  String get plan_18_desc => '中级';

  @override
  String get plan_18_detail => '禁食18小时，进食6小时，脂肪燃烧持续更久。';

  @override
  String get plan_20_desc => '高级';

  @override
  String get plan_20_detail => '禁食20小时，进食4小时，适合进入酮症和自噬。';

  @override
  String get plan_omad_desc => '一天一餐';

  @override
  String get plan_omad_detail => '一天一餐。禁食23小时，进食1小时，适合专业级用户。';

  @override
  String get plan_52_desc => '每周2天';

  @override
  String get plan_52_detail => '5天正常饮食，另外2天仅摄入约500卡路里，是一种替代方案。';

  @override
  String get plan_ese_desc => '24小时禁食';

  @override
  String get plan_ese_detail => '每周进行1–2次24小时禁食，适合高级用户。';

  @override
  String get plan_warrior_desc => '勇士饮食法';

  @override
  String get plan_warrior_detail => '白天少量进食（水果、蔬菜），在晚间4小时窗口内吃主餐。';

  @override
  String get award_first_title => '第一步';

  @override
  String get award_first_desc => '完成第一次禁食';

  @override
  String get award_rhythm3_title => '3天节奏';

  @override
  String get award_rhythm3_desc => '保持三天节奏';

  @override
  String get award_hours24_title => '24小时';

  @override
  String get award_hours24_desc => '累计禁食24小时';

  @override
  String get award_week_title => '一周节奏';

  @override
  String get award_week_desc => '建立连续七天记录';

  @override
  String get award_fasts10_title => '禁食10次';

  @override
  String get award_fasts10_desc => '完成十次禁食';

  @override
  String get award_hours100_title => '100小时';

  @override
  String get award_hours100_desc => '累计达到100小时';

  @override
  String get award_rhythm30_title => '30天节奏';

  @override
  String get award_rhythm30_desc => '建立连续三十天记录';

  @override
  String get award_fasts50_title => '禁食50次';

  @override
  String get award_fasts50_desc => '完成五十次禁食';

  @override
  String get award_hours500_title => '500小时';

  @override
  String get award_hours500_desc => '累计达到500小时';

  @override
  String get award_fasts100_title => '禁食100次';

  @override
  String get award_fasts100_desc => '完成一百次禁食';

  @override
  String get award_rhythm90_title => '90天节奏';

  @override
  String get award_rhythm90_desc => '建立连续九十天记录';

  @override
  String get award_year_title => '一年之旅';

  @override
  String get award_year_desc => '达到365天节奏';

  @override
  String get awards_loadError => '无法加载进度';

  @override
  String get awards_journeyComplete => '旅程完成';

  @override
  String get awards_nextGoal => '下一个目标';

  @override
  String get awards_allYours => '所有成就都属于您';

  @override
  String get awards_dayStreak => '天连续';

  @override
  String get awards_fasts => '次禁食';

  @override
  String get awards_total => '总计';

  @override
  String get awards_stageStart => '开始';

  @override
  String get awards_stageRhythm => '节奏';

  @override
  String get awards_stageEndurance => '耐力';

  @override
  String get awards_stageMastery => '精通';

  @override
  String get awards_completed => '已完成';

  @override
  String awards_fastsRemaining(int count) {
    return '还需$count次禁食';
  }

  @override
  String awards_daysRemaining(int count) {
    return '还需$count天';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '还需$count小时';
  }

  @override
  String get common_retry => '重试';

  @override
  String get game_title => '进度中心';

  @override
  String get game_quests => '今日任务';

  @override
  String get game_questsDesc => '小步前进，保持可持续节奏。';

  @override
  String get game_season => '30步赛季';

  @override
  String get game_seasonDesc => '每五步获得一枚收藏印章。';

  @override
  String get game_badges => '徽章收藏';

  @override
  String game_shields(int count) {
    return '$count枚节奏护盾';
  }

  @override
  String get game_shieldsDesc => '每完成七次即可获得。错过一天也不会抹去您的进度。';

  @override
  String get game_league => '私人周联赛';

  @override
  String game_leagueDesc(int percent) {
    return '您的节奏得分在私人本地模型中位于第$percent百分位。体重和极端禁食永远不会参与排名。';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return '等级$level，$xp经验值';
  }

  @override
  String get game_explorer => '节奏探索者';

  @override
  String get game_streak => '连续记录';

  @override
  String get game_targets => '目标';

  @override
  String get game_best => '最佳';

  @override
  String get quest_rhythm => '建立今日节奏';

  @override
  String get quest_hydrate => '达到饮水目标的一半';

  @override
  String get quest_steady => '守住您的连续记录';

  @override
  String get badge_first_title => '第一步';

  @override
  String get badge_first_desc => '记录第一次禁食';

  @override
  String get badge_rhythm7_title => '节奏守护者';

  @override
  String get badge_rhythm7_desc => '连续达到7天';

  @override
  String get badge_rhythm3_title => '三天节奏';

  @override
  String get badge_rhythm3_desc => '连续达到3天';

  @override
  String get badge_target1_title => '第一个目标';

  @override
  String get badge_target1_desc => '完成第一次目标禁食';

  @override
  String get badge_target3_title => '三步';

  @override
  String get badge_target3_desc => '完成3个目标';

  @override
  String get badge_water_title => '平衡';

  @override
  String get badge_water_desc => '完成每日饮水目标';

  @override
  String get badge_support_title => '自我觉察';

  @override
  String get badge_support_desc => '使用支持模式';

  @override
  String get badge_hours10_title => '10小时';

  @override
  String get badge_hours10_desc => '累计记录10小时';

  @override
  String get badge_target10_title => '坚实十次';

  @override
  String get badge_target10_desc => '完成10个目标';

  @override
  String get badge_target20_title => '二十个目标';

  @override
  String get badge_target20_desc => '完成20个目标';

  @override
  String get badge_fast16_title => '16小时';

  @override
  String get badge_fast16_desc => '单次禁食达到16小时';

  @override
  String get badge_hours50_title => '50小时';

  @override
  String get badge_hours50_desc => '累计记录50小时';

  @override
  String get badge_hours100_title => '一百小时';

  @override
  String get badge_hours100_desc => '累计记录100小时';

  @override
  String get badge_target30_title => '三十个目标';

  @override
  String get badge_target30_desc => '完成30个目标';

  @override
  String get badge_rhythm30_title => '30天节奏';

  @override
  String get badge_rhythm30_desc => '连续达到30天';

  @override
  String get paywall_restoreSuccess => '购买已恢复！';

  @override
  String fasting_progressSemantics(int percent) {
    return '禁食进度$percent%';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour小时';
  }

  @override
  String get paywall_lifetime => '终身';

  @override
  String get paywall_once => '一次性';

  @override
  String get paywall_processing => '处理中…';

  @override
  String get paywall_continue => '继续';

  @override
  String get paywall_productsUnavailable => '目前无法购买，请稍后重试。';

  @override
  String get paywall_purchaseFailed => '无法完成购买。';

  @override
  String get paywall_nothingToRestore => '未找到之前的购买。';

  @override
  String get paywall_restoreFailed => '无法恢复购买。';

  @override
  String get paywall_terms => '使用条款';

  @override
  String get permission_notificationDesc => '禁食提醒、阶段更新和完成通知';

  @override
  String get profile_privacyChoices => '隐私选项';

  @override
  String get paywall_autoRenewInfo =>
      '除非在周期结束前至少24小时取消，否则订阅会自动续订。您可以随时在App Store设置中管理或取消。';

  @override
  String paywall_perMonth(String price) {
    return '$price / 月';
  }

  @override
  String paywall_savePercent(int percent) {
    return '节省$percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days天免费试用';
  }

  @override
  String get paywall_startFreeTrial => '开始免费试用';

  @override
  String get paywall_retry => '重试';

  @override
  String get paywall_alreadyOwned => '您已拥有此订阅。请点按“恢复购买”。';

  @override
  String get paywall_storeUnavailable => '目前无法连接商店。请检查网络连接后重试。';

  @override
  String get paywall_secureNote => '可随时取消。费用将从您的商店账户扣除。';

  @override
  String get paywall_autoRenewInfoPlay =>
      '除非在周期结束前至少24小时取消，否则订阅会自动续订。您可以随时在Google Play > 订阅中管理或取消。';

  @override
  String get paywall_allPlansDesc =>
      '解锁18:6、20:4、OMAD、5:2、Eat-Stop-Eat和Warrior';

  @override
  String get paywall_noAdsDesc => '横幅广告和插页广告将完全关闭';

  @override
  String get foodScan_title => 'AI食物扫描';

  @override
  String get foodScan_scanCta => '扫描膳食';

  @override
  String get foodScan_scanCtaDesc => '拍摄餐盘，获取卡路里和宏量营养素';

  @override
  String get foodScan_introTitle => '拍摄您的餐盘';

  @override
  String get foodScan_introDesc => 'AI读取照片并估算卡路里、蛋白质、碳水化合物和脂肪。';

  @override
  String get foodScan_tipLight => '均匀充足的光线可提高估算准确度';

  @override
  String get foodScan_tipFrame => '将整个餐盘放入画面';

  @override
  String get foodScan_tipScale => '加入餐具或手，以便估算份量';

  @override
  String get foodScan_takePhoto => '拍照';

  @override
  String get foodScan_chooseFromGallery => '从相册选择';

  @override
  String foodScan_scansLeft(int count) {
    return '今天还剩$count次扫描';
  }

  @override
  String get foodScan_quotaReached => '您已用完今天的扫描次数，请明天再试。';

  @override
  String get foodScan_privacyNote =>
      '照片会发送至Google的Gemini API进行分析，不会存储在我们的服务器上。';

  @override
  String get foodScan_consentTitle => '要将照片发送给 Google Gemini 吗？';

  @override
  String get foodScan_consentBody =>
      '为估算卡路里和宏量营养素，你拍摄或选择的每张餐食照片都会发送到 Google 的 Gemini AI 服务。照片仅用于此次分析，不会存储在我们的服务器上。';

  @override
  String get foodScan_consentAgree => '同意并继续';

  @override
  String get foodScan_analyzing => '正在分析您的膳食…';

  @override
  String get foodScan_analyzingHint => '通常只需几秒钟';

  @override
  String get foodScan_detectedItems => '检测到的食物';

  @override
  String get foodScan_disclaimer => 'AI估算仅供参考。点按项目可进行修正。';

  @override
  String get foodScan_lowConfidence => '模型无法确定这张照片的内容。保存前请检查数值。';

  @override
  String get foodScan_save => '添加到膳食';

  @override
  String get foodScan_retake => '新照片';

  @override
  String get foodScan_retry => '重试';

  @override
  String get foodScan_editItem => '编辑项目';

  @override
  String get foodScan_portion => '份量';

  @override
  String get foodScan_saveEdit => '保存';

  @override
  String get foodScan_premiumTitle => '高级版功能';

  @override
  String get foodScan_premiumDesc => '高级版包含照片卡路里分析。';

  @override
  String get foodScan_upgrade => '查看高级版';

  @override
  String get foodScan_errorNetwork => '无网络连接。请检查网络后重试。';

  @override
  String get foodScan_errorRateLimited => '当前扫描请求过多，请几分钟后重试。';

  @override
  String get foodScan_errorUnavailable => '目前无法使用照片分析。';

  @override
  String get foodScan_errorServer => '分析服务遇到问题，请稍后重试。';

  @override
  String get foodScan_errorNoFood => '照片中未发现食物，请更清晰地拍摄餐盘。';

  @override
  String get foodScan_errorUnreadable => '无法分析这张照片，请尝试另一张。';

  @override
  String get paywall_aiFoodScan => 'AI食物扫描';

  @override
  String get paywall_aiFoodScanDesc => '拍摄膳食，数秒内记录卡路里和宏量营养素';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appTitle => 'FastTrack';

  @override
  String get greeting_morning => '早上好';

  @override
  String get greeting_afternoon => '下午好';

  @override
  String get greeting_evening => '晚上好';

  @override
  String get tab_timer => '首页';

  @override
  String get tab_explore => '探索';

  @override
  String get tab_stats => '报告';

  @override
  String get tab_meals => '膳食';

  @override
  String get tab_achievements => '成就';

  @override
  String get tab_profile => '账户';

  @override
  String get timer_fasting => '禁食时间';

  @override
  String get timer_remaining => '剩余时间';

  @override
  String get timer_elapsed => '已用时间';

  @override
  String get timer_start => '开始';

  @override
  String get timer_stop => '停止';

  @override
  String get timer_completed => '恭喜！';

  @override
  String get timer_completedMessage => '您已成功完成禁食！';

  @override
  String get timer_selectPlan => '选择禁食计划';

  @override
  String get timer_stopConfirm => '确定要提前结束禁食吗？';

  @override
  String get timer_stopTitle => '结束禁食';

  @override
  String get timer_cancel => '取消';

  @override
  String get timer_confirmStop => '是，结束';

  @override
  String get phase_anabolic => '合成代谢期';

  @override
  String get phase_anabolicDesc => '正在消化';

  @override
  String get phase_catabolic => '分解代谢期';

  @override
  String get phase_catabolicDesc => '能量转换中';

  @override
  String get phase_fatBurning => '脂肪燃烧';

  @override
  String get phase_fatBurningDesc => '脂肪燃烧已开始';

  @override
  String get phase_ketosis => '酮症';

  @override
  String get phase_ketosisDesc => '酮体生成活跃';

  @override
  String get phase_autophagy => '自噬';

  @override
  String get phase_autophagyDesc => '细胞更新';

  @override
  String get stats_title => '统计';

  @override
  String get stats_week => '周';

  @override
  String get stats_month => '月';

  @override
  String get stats_year => '年';

  @override
  String get stats_totalFasts => '禁食总次数';

  @override
  String get stats_average => '平均';

  @override
  String get stats_fastDuration => '禁食时长';

  @override
  String get stats_streak => '连续记录';

  @override
  String get stats_daysConsecutive => '连续天数';

  @override
  String get stats_success => '成功';

  @override
  String get stats_completion => '完成率';

  @override
  String get stats_weeklyFasting => '每周禁食';

  @override
  String get stats_monthlyView => '月度视图';

  @override
  String get stats_weightChange => '体重变化';

  @override
  String get heatmap_none => '无';

  @override
  String get heatmap_low => '较少';

  @override
  String get heatmap_good => '良好';

  @override
  String get heatmap_full => '充足';

  @override
  String get meals_title => '膳食计划';

  @override
  String get meals_eatingWindow => '进食窗口';

  @override
  String get meals_windowOpen => '已开放';

  @override
  String get meals_windowFasting => '禁食中';

  @override
  String get meals_calories => '卡路里';

  @override
  String get meals_protein => '蛋白质';

  @override
  String get meals_carbs => '碳水化合物';

  @override
  String get meals_fat => '脂肪';

  @override
  String get meals_todayMeals => '今日膳食';

  @override
  String get meals_noMeals => '尚未添加膳食';

  @override
  String get meals_breakfastSuggestions => '开斋餐建议';

  @override
  String get meals_addMeal => '添加膳食';

  @override
  String get profile_title => '个人资料';

  @override
  String get profile_user => '用户';

  @override
  String profile_planActive(String plan) {
    return '$plan计划已启用';
  }

  @override
  String get profile_upgradePremium => '升级到高级版';

  @override
  String get profile_premiumDesc => '所有禁食计划，无广告';

  @override
  String get profile_bodyMetrics => '身体指标';

  @override
  String get profile_height => '身高';

  @override
  String get profile_weight => '体重';

  @override
  String get profile_targetWeight => '目标体重';

  @override
  String get profile_bmi => 'BMI';

  @override
  String get profile_settings => '设置';

  @override
  String get profile_notifications => '通知';

  @override
  String get profile_darkTheme => '深色主题';

  @override
  String get profile_waterReminder => '饮水提醒';

  @override
  String get profile_phaseNotifications => '阶段通知';

  @override
  String get profile_language => '语言';

  @override
  String get profile_about => '关于';

  @override
  String get profile_rateApp => '评价应用';

  @override
  String get profile_share => '分享';

  @override
  String get profile_privacyPolicy => '隐私政策';

  @override
  String get profile_version => '版本';

  @override
  String get onboarding_welcome => '欢迎';

  @override
  String get onboarding_welcomeDesc => '掌控您的\n间歇性禁食之旅';

  @override
  String get onboarding_featureTimer => '智能禁食计时器';

  @override
  String get onboarding_featureStats => '详细统计和图表';

  @override
  String get onboarding_featureMeals => '膳食计划和食谱建议';

  @override
  String get onboarding_getStarted => '开始使用';

  @override
  String get onboarding_selectGoal => '您的目标是什么？';

  @override
  String get onboarding_selectGoalDesc => '可以多选';

  @override
  String get onboarding_goalWeight => '减重';

  @override
  String get onboarding_goalWeightDesc => '健康减重';

  @override
  String get onboarding_goalHealth => '改善健康';

  @override
  String get onboarding_goalHealthDesc => '整体健康和免疫力';

  @override
  String get onboarding_goalEnergy => '更有活力';

  @override
  String get onboarding_goalEnergyDesc => '全天保持精力';

  @override
  String get onboarding_goalMental => '思维清晰';

  @override
  String get onboarding_goalMentalDesc => '专注与清晰';

  @override
  String get onboarding_goalLongevity => '长寿';

  @override
  String get onboarding_goalLongevityDesc => '细胞更新与健康衰老';

  @override
  String get onboarding_goalDiscipline => '自律';

  @override
  String get onboarding_goalDisciplineDesc => '培养自律能力';

  @override
  String get onboarding_selectPlan => '选择您的计划';

  @override
  String get onboarding_selectPlanDesc => '选择最适合您的禁食计划';

  @override
  String get onboarding_bodyInfo => '输入您的信息';

  @override
  String get onboarding_bodyInfoDesc => '用于个性化建议';

  @override
  String get onboarding_gender => '性别';

  @override
  String get onboarding_male => '男';

  @override
  String get onboarding_female => '女';

  @override
  String get onboarding_age => '年龄';

  @override
  String get onboarding_bodyInfoDisclaimer => '此信息仅保存在您的设备上，并用于计算卡路里。';

  @override
  String get onboarding_permissions => '最后一步';

  @override
  String get onboarding_permissionsDesc => '启用权限以获得最佳体验';

  @override
  String get onboarding_next => '继续';

  @override
  String get onboarding_start => '开始吧！';

  @override
  String get onboarding_skipForNow => '稍后设置';

  @override
  String get waterAdded => '已添加250毫升水';

  @override
  String get languageSelect => '选择语言';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get paywall_title => '升级到高级版';

  @override
  String get paywall_subtitle => '解锁所有禁食计划并移除广告';

  @override
  String get paywall_allPlans => '所有禁食计划';

  @override
  String get paywall_advancedStats => '高级统计';

  @override
  String get paywall_mealPlanner => '膳食计划';

  @override
  String get paywall_themes => '主题自定义';

  @override
  String get paywall_noAds => '无广告';

  @override
  String get paywall_weekly => '每周';

  @override
  String get paywall_monthly => '每月';

  @override
  String get paywall_yearly => '每年';

  @override
  String get paywall_bestValue => '最划算';

  @override
  String get paywall_freeTrial => '免费试用（3天）';

  @override
  String get paywall_restore => '恢复购买';

  @override
  String get paywall_premiumActive => '高级版已启用！';

  @override
  String get paywall_premiumActiveDesc => '所有禁食计划均已解锁，广告已关闭';

  @override
  String get water_title => '饮水量';

  @override
  String get water_addWater => '添加饮水';

  @override
  String get water_goal => '目标';

  @override
  String get water_ml => '毫升';

  @override
  String get common_ok => '确定';

  @override
  String get common_cancel => '取消';

  @override
  String get common_save => '保存';

  @override
  String get common_delete => '删除';

  @override
  String get common_hours => '小时';

  @override
  String get common_minutes => '分钟';

  @override
  String get common_days => '天';

  @override
  String get common_enable => '启用';

  @override
  String get streakCard_currentStreak => '当前连续记录';

  @override
  String get streakCard_longestStreak => '最长连续记录';

  @override
  String get streakCard_totalSessions => '禁食总次数';

  @override
  String get meals_mealType => '膳食类型';

  @override
  String get meals_breakfast => '早餐';

  @override
  String get meals_lunch => '午餐';

  @override
  String get meals_dinner => '晚餐';

  @override
  String get meals_snack => '加餐';

  @override
  String get meals_carbohydrate => '碳水化合物';

  @override
  String get meals_add => '添加';

  @override
  String get meals_mealName => '膳食名称';

  @override
  String get bodyMetrics_title => '身体指标';

  @override
  String get bodyMetrics_weight => '体重';

  @override
  String get bodyMetrics_target => '目标';

  @override
  String get bodyMetrics_save => '保存';

  @override
  String get bodyMetrics_history => '历史';

  @override
  String bodyMetrics_bmiValue(String value) {
    return 'BMI：$value';
  }

  @override
  String get bodyMetrics_noData => '暂无数据';

  @override
  String get meals_quickAdd => '快速添加';

  @override
  String get meals_manualEntry => '手动输入';

  @override
  String meals_added(String name) {
    return '已添加$name';
  }

  @override
  String get meals_nameCalorieRequired => '名称和卡路里为必填项';

  @override
  String get bodyMetrics_addWeight => '添加体重';

  @override
  String get bodyMetrics_hintWeight => '例如74.5';

  @override
  String get bodyMetrics_invalidWeight => '请输入有效体重';

  @override
  String bodyMetrics_weightSaved(String value) {
    return '已保存$value公斤';
  }

  @override
  String get completion_duration => '时长';

  @override
  String get completion_plan => '计划';

  @override
  String get completion_lastPhase => '最后阶段';

  @override
  String get completion_earlyTitle => '禁食已结束';

  @override
  String get completion_earlyMessage => '今天的时长已保存。由于未完成目标，连续记录和成就进度没有变化。';

  @override
  String get timer_remainingTime => '剩余时间';

  @override
  String get timer_ready => '准备开始';

  @override
  String get streak_status => '状态';

  @override
  String get streak_startToday => '今天开始！';

  @override
  String get streak_goodStart => '开局不错！';

  @override
  String get streak_goingGreat => '进展顺利！';

  @override
  String get streak_superb => '太棒了！';

  @override
  String get streak_legendary => '传奇！';

  @override
  String get streak_incredible => '不可思议！';

  @override
  String get weight_noRecord => '尚无体重记录\n请从个人资料 > 身体指标添加';

  @override
  String get day_mon => '周一';

  @override
  String get day_tue => '周二';

  @override
  String get day_wed => '周三';

  @override
  String get day_thu => '周四';

  @override
  String get day_fri => '周五';

  @override
  String get day_sat => '周六';

  @override
  String get day_sun => '周日';

  @override
  String get day_short_mon => '一';

  @override
  String get day_short_tue => '二';

  @override
  String get day_short_wed => '三';

  @override
  String get day_short_thu => '四';

  @override
  String get day_short_fri => '五';

  @override
  String get day_short_sat => '六';

  @override
  String get day_short_sun => '日';

  @override
  String get month_jan => '一月';

  @override
  String get month_feb => '二月';

  @override
  String get month_mar => '三月';

  @override
  String get month_apr => '四月';

  @override
  String get month_may => '五月';

  @override
  String get month_jun => '六月';

  @override
  String get month_jul => '七月';

  @override
  String get month_aug => '八月';

  @override
  String get month_sep => '九月';

  @override
  String get month_oct => '十月';

  @override
  String get month_nov => '十一月';

  @override
  String get month_dec => '十二月';

  @override
  String meals_fastingWindow(String hours) {
    return '禁食（$hours小时）';
  }

  @override
  String meals_eatingWindowHours(String hours) {
    return '进食（$hours小时）';
  }

  @override
  String get recipe_oatSmoothie => '燕麦奶昔';

  @override
  String get recipe_avocadoToast => '牛油果吐司';

  @override
  String get recipe_yogurtBowl => '酸奶碗';

  @override
  String get elapsed_time => '已用时间';

  @override
  String get fast_ends_on => '您的禁食结束于';

  @override
  String get end_fasting => '结束禁食';

  @override
  String get start_fasting => '开始禁食';

  @override
  String get water_tracker => '饮水追踪';

  @override
  String get weight_tracker => '体重追踪';

  @override
  String get drink => '饮水';

  @override
  String get log_weight => '记录体重';

  @override
  String get bmi => 'BMI';

  @override
  String get weight_lost => '已减体重';

  @override
  String get current_weight => '当前体重';

  @override
  String get goal_weight => '目标体重';

  @override
  String get daily_goal => '每日目标';

  @override
  String completed_percent(String percent) {
    return '已完成$percent%';
  }

  @override
  String get explore => '探索';

  @override
  String get achievements => '成就';

  @override
  String get profile_theme => '外观';

  @override
  String get theme_select => '选择外观';

  @override
  String get theme_system => '跟随系统';

  @override
  String get theme_light => '浅色';

  @override
  String get theme_dark => '深色';

  @override
  String get language_system => '系统语言';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Français';

  @override
  String get profile_completionSound => '完成提示音';

  @override
  String get profile_calmGamification => '轻松游戏化';

  @override
  String get profile_calmGamificationDesc => '减轻联赛和赛季压力';

  @override
  String get profile_editName => '编辑您的姓名';

  @override
  String get profile_name => '姓名';

  @override
  String get circle_title => '禁食圈';

  @override
  String get circle_you => '您';

  @override
  String get circle_tagline => '一起坚持，毫无压力。';

  @override
  String get circle_privacy => '体重和私人指标保持隐藏，仅显示进度和支持。';

  @override
  String circle_sendSupport(int count) {
    return '发送支持 · $count';
  }

  @override
  String get circle_inviteCopied => '邀请码已复制';

  @override
  String get circle_createInvite => '创建私人邀请';

  @override
  String get crisis_nameTitle => '首先，说出正在发生什么';

  @override
  String get crisis_nameDesc => '这可能是饥饿、习惯或情绪。';

  @override
  String get crisis_waterTitle => '喝一杯水';

  @override
  String get crisis_waterDesc => '然后缓慢深呼吸三次。';

  @override
  String get crisis_delayTitle => '将决定推迟10分钟';

  @override
  String get crisis_delayDesc => '如果感觉不适，结束禁食并不意味着失败。';

  @override
  String get crisis_hunger => '饥饿';

  @override
  String get crisis_habit => '习惯';

  @override
  String get crisis_stress => '压力';

  @override
  String get crisis_tenMore => '再给自己10分钟';

  @override
  String get stats_storyEmpty => '第一次禁食将开启您的个人故事。';

  @override
  String stats_story(int sessions, int hours, int rate) {
    return '本阶段您禁食了$sessions次，保持节奏$hours小时，完成率达到$rate%。';
  }

  @override
  String get stats_storyTitle => '您的节奏故事';

  @override
  String get home_todayRhythm => '今日节奏';

  @override
  String get home_finalHourSupport => '最后一小时支持';

  @override
  String get home_needSupport => '我需要一点支持';

  @override
  String get home_todaySummary => '今日概览';

  @override
  String get home_dayStreak => '天连续';

  @override
  String home_weightGoal(String weight) {
    return '目标$weight公斤';
  }

  @override
  String get weather_steady => '您的节奏很稳定';

  @override
  String get weather_gentle => '轻松的一天';

  @override
  String get weather_water => '一杯水可能会有帮助。';

  @override
  String get weather_listen => '您已经走了很远，请倾听身体的声音。';

  @override
  String get weather_onPlan => '今天的节奏符合您的计划。';

  @override
  String get weather_challenging => '过去这个小时比较难熬，支持模式已准备好。';

  @override
  String get replay_copied => '禁食回顾已复制';

  @override
  String get replay_button => '回顾';

  @override
  String replay_text(String plan, int hours, int minutes, String phase) {
    return '我用$hours小时$minutes分钟完成了$plan禁食 · $phase';
  }

  @override
  String get journey_label => '代谢之旅';

  @override
  String get journey_now => '现在';

  @override
  String journey_next(String time, String phase) {
    return '距离$phase还有$time';
  }

  @override
  String get phase_estimateShort => '阶段时间仅为一般估计，并非医学测量。';

  @override
  String phase_hours(int start, int end) {
    return '第$start–$end小时';
  }

  @override
  String get phase_estimateLong => '此时间仅为一般估计，不同人的代谢反应可能有所不同。';

  @override
  String get bmi_underweight => '体重过轻';

  @override
  String get bmi_normal => '正常';

  @override
  String get bmi_overweight => '超重';

  @override
  String get bmi_obese => '肥胖';

  @override
  String get notification_halfwayTitle => '已完成一半！ 💪';

  @override
  String notification_halfwayBody(String plan) {
    return '您已完成$plan禁食的一半，继续加油！';
  }

  @override
  String get notification_phaseCatabolic => '已进入分解代谢期 📉';

  @override
  String get notification_phaseFatBurning => '脂肪燃烧已开始！ 🔥';

  @override
  String get notification_phaseKetosis => '您正处于酮症状态 ⚡';

  @override
  String get notification_phaseAutophagy => '自噬已激活！ 🔄';

  @override
  String notification_completedBody(String plan) {
    return '您已完成$plan禁食！进食窗口已开放。';
  }

  @override
  String get notification_waterTitle => '喝水 💧';

  @override
  String get notification_waterBody => '禁食期间别忘了补充充足水分！';

  @override
  String get notification_windowTitle => '进食窗口即将关闭 ⏰';

  @override
  String get notification_windowBody => '您的进食窗口将在30分钟后关闭。';

  @override
  String notification_streakTitle(int days) {
    return '连续$days天！ 🔥';
  }

  @override
  String get notification_streakBody => '您做得很棒！今天继续保持。';

  @override
  String notification_ongoingTitle(String phase) {
    return '禁食进行中 - $phase';
  }

  @override
  String notification_remaining(String time) {
    return '剩余：$time';
  }

  @override
  String notification_started(String plan) {
    return '禁食已开始 - $plan';
  }

  @override
  String notification_target(int hours) {
    return '目标：$hours小时';
  }

  @override
  String notification_time(int hours, int minutes) {
    return '$hours小时$minutes分钟';
  }

  @override
  String get explore_guide => '禁食指南';

  @override
  String get explore_guideDesc => '您需要了解的间歇性禁食知识';

  @override
  String get explore_circleDesc => '与您的私人小组安静地互相支持。';

  @override
  String get explore_faq => '常见问题';

  @override
  String get explore_education => '此内容仅用于一般教育，不构成医学诊断或治疗建议。';

  @override
  String get explore_safety => '健康与安全';

  @override
  String get explore_safetyDesc =>
      '如果您有疾病、长期服药、出现令人担忧的症状、正在怀孕或哺乳，请在禁食前咨询合格的医疗专业人员。如感觉不适，请停止禁食。';

  @override
  String get explore_sources => '资料来源';

  @override
  String get explore_sourcesDesc => '内容根据下方公共卫生资料进行了简化。';

  @override
  String get explore_sourceError => '无法打开资料来源';

  @override
  String get explore_rules => '重要规则';

  @override
  String get explore_rule1 => '禁食期间不要摄入含热量的食物';

  @override
  String get explore_rule2 => '饮用充足的水和液体';

  @override
  String get explore_rule3 => '在进食窗口内均衡饮食';

  @override
  String get explore_rule4 => '如感觉不适，请停止禁食';

  @override
  String get explore_rule5 => '孕妇或哺乳期女性不应禁食';

  @override
  String get explore_rule6 => '如有慢性疾病，请咨询医生';

  @override
  String get tip_water => '保持水分充足';

  @override
  String get tip_waterDesc => '口渴时喝水，并随餐补充液体。需求会因健康状况、天气和活动量而异。';

  @override
  String get tip_food => '合理饮食';

  @override
  String get tip_foodDesc => '进食期间请选择富含蛋白质、纤维和健康脂肪的食物，避免加工食品。';

  @override
  String get tip_sleep => '保证睡眠';

  @override
  String get tip_sleepDesc => '规律且充足的睡眠有益于整体健康。请安排好禁食，避免影响睡眠。';

  @override
  String get tip_exercise => '轻度运动';

  @override
  String get tip_exerciseDesc => '禁食期间可以轻松散步或练习瑜伽。避免剧烈运动，尤其是在身体适应前的最初几周。';

  @override
  String get tip_drinks => '允许的饮品';

  @override
  String get tip_drinksDesc => '禁食期间可以饮用水、纯茶和黑咖啡（不加糖、不加奶），这些饮品不会中断禁食。';

  @override
  String get faq_drinks => '禁食期间可以喝什么？';

  @override
  String get faq_drinksAnswer => '可以饮用水、纯茶和黑咖啡（不加糖/奶）。含热量的饮品会中断禁食。';

  @override
  String get faq_plan => '我该选择哪种禁食计划？';

  @override
  String get faq_planAnswer =>
      '新手可从12:12或14:10开始。有经验者可尝试16:8或18:6。20:4和OMAD适合高级禁食者。';

  @override
  String get faq_exercise => '禁食期间可以运动吗？';

  @override
  String get faq_exerciseAnswer =>
      '可以，但请避免高强度训练。轻度有氧、散步和瑜伽较为理想。力量训练请安排在进食窗口附近。';

  @override
  String get faq_weight => '禁食有助于减重吗？';

  @override
  String get faq_weightAnswer => '对一些人来说，限制进食时间可能减少总能量摄入。效果因人而异，长期影响仍在研究中。';

  @override
  String get plan_12_desc => '初级';

  @override
  String get plan_12_detail => '适合新手。包括睡眠时间在内禁食12小时。';

  @override
  String get plan_16_desc => '最受欢迎的计划';

  @override
  String get plan_16_detail => '最常见的间歇性禁食计划。禁食16小时，进食8小时，通常从午餐到晚餐。';

  @override
  String get plan_18_desc => '中级';

  @override
  String get plan_18_detail => '禁食18小时，进食6小时，脂肪燃烧持续更久。';

  @override
  String get plan_20_desc => '高级';

  @override
  String get plan_20_detail => '禁食20小时，进食4小时，适合进入酮症和自噬。';

  @override
  String get plan_omad_desc => '一天一餐';

  @override
  String get plan_omad_detail => '一天一餐。禁食23小时，进食1小时，适合专业级用户。';

  @override
  String get plan_52_desc => '每周2天';

  @override
  String get plan_52_detail => '5天正常饮食，另外2天仅摄入约500卡路里，是一种替代方案。';

  @override
  String get plan_ese_desc => '24小时禁食';

  @override
  String get plan_ese_detail => '每周进行1–2次24小时禁食，适合高级用户。';

  @override
  String get plan_warrior_desc => '勇士饮食法';

  @override
  String get plan_warrior_detail => '白天少量进食（水果、蔬菜），在晚间4小时窗口内吃主餐。';

  @override
  String get award_first_title => '第一步';

  @override
  String get award_first_desc => '完成第一次禁食';

  @override
  String get award_rhythm3_title => '3天节奏';

  @override
  String get award_rhythm3_desc => '保持三天节奏';

  @override
  String get award_hours24_title => '24小时';

  @override
  String get award_hours24_desc => '累计禁食24小时';

  @override
  String get award_week_title => '一周节奏';

  @override
  String get award_week_desc => '建立连续七天记录';

  @override
  String get award_fasts10_title => '禁食10次';

  @override
  String get award_fasts10_desc => '完成十次禁食';

  @override
  String get award_hours100_title => '100小时';

  @override
  String get award_hours100_desc => '累计达到100小时';

  @override
  String get award_rhythm30_title => '30天节奏';

  @override
  String get award_rhythm30_desc => '建立连续三十天记录';

  @override
  String get award_fasts50_title => '禁食50次';

  @override
  String get award_fasts50_desc => '完成五十次禁食';

  @override
  String get award_hours500_title => '500小时';

  @override
  String get award_hours500_desc => '累计达到500小时';

  @override
  String get award_fasts100_title => '禁食100次';

  @override
  String get award_fasts100_desc => '完成一百次禁食';

  @override
  String get award_rhythm90_title => '90天节奏';

  @override
  String get award_rhythm90_desc => '建立连续九十天记录';

  @override
  String get award_year_title => '一年之旅';

  @override
  String get award_year_desc => '达到365天节奏';

  @override
  String get awards_loadError => '无法加载进度';

  @override
  String get awards_journeyComplete => '旅程完成';

  @override
  String get awards_nextGoal => '下一个目标';

  @override
  String get awards_allYours => '所有成就都属于您';

  @override
  String get awards_dayStreak => '天连续';

  @override
  String get awards_fasts => '次禁食';

  @override
  String get awards_total => '总计';

  @override
  String get awards_stageStart => '开始';

  @override
  String get awards_stageRhythm => '节奏';

  @override
  String get awards_stageEndurance => '耐力';

  @override
  String get awards_stageMastery => '精通';

  @override
  String get awards_completed => '已完成';

  @override
  String awards_fastsRemaining(int count) {
    return '还需$count次禁食';
  }

  @override
  String awards_daysRemaining(int count) {
    return '还需$count天';
  }

  @override
  String awards_hoursRemaining(int count) {
    return '还需$count小时';
  }

  @override
  String get common_retry => '重试';

  @override
  String get game_title => '进度中心';

  @override
  String get game_quests => '今日任务';

  @override
  String get game_questsDesc => '小步前进，保持可持续节奏。';

  @override
  String get game_season => '30步赛季';

  @override
  String get game_seasonDesc => '每五步获得一枚收藏印章。';

  @override
  String get game_badges => '徽章收藏';

  @override
  String game_shields(int count) {
    return '$count枚节奏护盾';
  }

  @override
  String get game_shieldsDesc => '每完成七次即可获得。错过一天也不会抹去您的进度。';

  @override
  String get game_league => '私人周联赛';

  @override
  String game_leagueDesc(int percent) {
    return '您的节奏得分在私人本地模型中位于第$percent百分位。体重和极端禁食永远不会参与排名。';
  }

  @override
  String game_levelSemantics(int level, int xp) {
    return '等级$level，$xp经验值';
  }

  @override
  String get game_explorer => '节奏探索者';

  @override
  String get game_streak => '连续记录';

  @override
  String get game_targets => '目标';

  @override
  String get game_best => '最佳';

  @override
  String get quest_rhythm => '建立今日节奏';

  @override
  String get quest_hydrate => '达到饮水目标的一半';

  @override
  String get quest_steady => '守住您的连续记录';

  @override
  String get badge_first_title => '第一步';

  @override
  String get badge_first_desc => '记录第一次禁食';

  @override
  String get badge_rhythm7_title => '节奏守护者';

  @override
  String get badge_rhythm7_desc => '连续达到7天';

  @override
  String get badge_rhythm3_title => '三天节奏';

  @override
  String get badge_rhythm3_desc => '连续达到3天';

  @override
  String get badge_target1_title => '第一个目标';

  @override
  String get badge_target1_desc => '完成第一次目标禁食';

  @override
  String get badge_target3_title => '三步';

  @override
  String get badge_target3_desc => '完成3个目标';

  @override
  String get badge_water_title => '平衡';

  @override
  String get badge_water_desc => '完成每日饮水目标';

  @override
  String get badge_support_title => '自我觉察';

  @override
  String get badge_support_desc => '使用支持模式';

  @override
  String get badge_hours10_title => '10小时';

  @override
  String get badge_hours10_desc => '累计记录10小时';

  @override
  String get badge_target10_title => '坚实十次';

  @override
  String get badge_target10_desc => '完成10个目标';

  @override
  String get badge_target20_title => '二十个目标';

  @override
  String get badge_target20_desc => '完成20个目标';

  @override
  String get badge_fast16_title => '16小时';

  @override
  String get badge_fast16_desc => '单次禁食达到16小时';

  @override
  String get badge_hours50_title => '50小时';

  @override
  String get badge_hours50_desc => '累计记录50小时';

  @override
  String get badge_hours100_title => '一百小时';

  @override
  String get badge_hours100_desc => '累计记录100小时';

  @override
  String get badge_target30_title => '三十个目标';

  @override
  String get badge_target30_desc => '完成30个目标';

  @override
  String get badge_rhythm30_title => '30天节奏';

  @override
  String get badge_rhythm30_desc => '连续达到30天';

  @override
  String get paywall_restoreSuccess => '购买已恢复！';

  @override
  String fasting_progressSemantics(int percent) {
    return '禁食进度$percent%';
  }

  @override
  String phase_hourMarker(int hour) {
    return '$hour小时';
  }

  @override
  String get paywall_lifetime => '终身';

  @override
  String get paywall_once => '一次性';

  @override
  String get paywall_processing => '处理中…';

  @override
  String get paywall_continue => '继续';

  @override
  String get paywall_productsUnavailable => '目前无法购买，请稍后重试。';

  @override
  String get paywall_purchaseFailed => '无法完成购买。';

  @override
  String get paywall_nothingToRestore => '未找到之前的购买。';

  @override
  String get paywall_restoreFailed => '无法恢复购买。';

  @override
  String get paywall_terms => '使用条款';

  @override
  String get permission_notificationDesc => '禁食提醒、阶段更新和完成通知';

  @override
  String get profile_privacyChoices => '隐私选项';

  @override
  String get paywall_autoRenewInfo =>
      '除非在周期结束前至少24小时取消，否则订阅会自动续订。您可以随时在App Store设置中管理或取消。';

  @override
  String paywall_perMonth(String price) {
    return '$price / 月';
  }

  @override
  String paywall_savePercent(int percent) {
    return '节省$percent%';
  }

  @override
  String paywall_freeTrialDays(int days) {
    return '$days天免费试用';
  }

  @override
  String get paywall_startFreeTrial => '开始免费试用';

  @override
  String get paywall_retry => '重试';

  @override
  String get paywall_alreadyOwned => '您已拥有此订阅。请点按“恢复购买”。';

  @override
  String get paywall_storeUnavailable => '目前无法连接商店。请检查网络连接后重试。';

  @override
  String get paywall_secureNote => '可随时取消。费用将从您的商店账户扣除。';

  @override
  String get paywall_autoRenewInfoPlay =>
      '除非在周期结束前至少24小时取消，否则订阅会自动续订。您可以随时在Google Play > 订阅中管理或取消。';

  @override
  String get paywall_allPlansDesc =>
      '解锁18:6、20:4、OMAD、5:2、Eat-Stop-Eat和Warrior';

  @override
  String get paywall_noAdsDesc => '横幅广告和插页广告将完全关闭';

  @override
  String get foodScan_title => 'AI食物扫描';

  @override
  String get foodScan_scanCta => '扫描膳食';

  @override
  String get foodScan_scanCtaDesc => '拍摄餐盘，获取卡路里和宏量营养素';

  @override
  String get foodScan_introTitle => '拍摄您的餐盘';

  @override
  String get foodScan_introDesc => 'AI读取照片并估算卡路里、蛋白质、碳水化合物和脂肪。';

  @override
  String get foodScan_tipLight => '均匀充足的光线可提高估算准确度';

  @override
  String get foodScan_tipFrame => '将整个餐盘放入画面';

  @override
  String get foodScan_tipScale => '加入餐具或手，以便估算份量';

  @override
  String get foodScan_takePhoto => '拍照';

  @override
  String get foodScan_chooseFromGallery => '从相册选择';

  @override
  String foodScan_scansLeft(int count) {
    return '今天还剩$count次扫描';
  }

  @override
  String get foodScan_quotaReached => '您已用完今天的扫描次数，请明天再试。';

  @override
  String get foodScan_privacyNote =>
      '照片会发送至Google的Gemini API进行分析，不会存储在我们的服务器上。';

  @override
  String get foodScan_consentTitle => '要将照片发送给 Google Gemini 吗？';

  @override
  String get foodScan_consentBody =>
      '为估算卡路里和宏量营养素，你拍摄或选择的每张餐食照片都会发送到 Google 的 Gemini AI 服务。照片仅用于此次分析，不会存储在我们的服务器上。';

  @override
  String get foodScan_consentAgree => '同意并继续';

  @override
  String get foodScan_analyzing => '正在分析您的膳食…';

  @override
  String get foodScan_analyzingHint => '通常只需几秒钟';

  @override
  String get foodScan_detectedItems => '检测到的食物';

  @override
  String get foodScan_disclaimer => 'AI估算仅供参考。点按项目可进行修正。';

  @override
  String get foodScan_lowConfidence => '模型无法确定这张照片的内容。保存前请检查数值。';

  @override
  String get foodScan_save => '添加到膳食';

  @override
  String get foodScan_retake => '新照片';

  @override
  String get foodScan_retry => '重试';

  @override
  String get foodScan_editItem => '编辑项目';

  @override
  String get foodScan_portion => '份量';

  @override
  String get foodScan_saveEdit => '保存';

  @override
  String get foodScan_premiumTitle => '高级版功能';

  @override
  String get foodScan_premiumDesc => '高级版包含照片卡路里分析。';

  @override
  String get foodScan_upgrade => '查看高级版';

  @override
  String get foodScan_errorNetwork => '无网络连接。请检查网络后重试。';

  @override
  String get foodScan_errorRateLimited => '当前扫描请求过多，请几分钟后重试。';

  @override
  String get foodScan_errorUnavailable => '目前无法使用照片分析。';

  @override
  String get foodScan_errorServer => '分析服务遇到问题，请稍后重试。';

  @override
  String get foodScan_errorNoFood => '照片中未发现食物，请更清晰地拍摄餐盘。';

  @override
  String get foodScan_errorUnreadable => '无法分析这张照片，请尝试另一张。';

  @override
  String get paywall_aiFoodScan => 'AI食物扫描';

  @override
  String get paywall_aiFoodScanDesc => '拍摄膳食，数秒内记录卡路里和宏量营养素';
}
