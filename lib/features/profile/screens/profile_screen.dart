import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/utils/calculations.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../../services/admob_service.dart';
import '../../../core/config/build_config.dart';
import '../providers/settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _openUrl(BuildContext context, String value) async {
    final uri = Uri.tryParse(value);
    if (uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.explore_sourceError),
        ),
      );
    }
  }

  Future<void> _rate(BuildContext context) =>
      _openUrl(context, BuildConfig.storeUrl);

  Future<void> _share(BuildContext context) async {
    final url = BuildConfig.storeUrl;
    if (url.isEmpty) return _openUrl(context, url);
    await Clipboard.setData(ClipboardData(text: url));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.replay_copied)),
      );
    }
  }

  Future<void> _privacyChoices(BuildContext context) async {
    final success = await AdmobService().showPrivacyOptions();
    if (!success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.explore_sourceError),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final plan = FastingPlans.getById(settings.selectedPlanId);

    final bmi =
        (settings.weight != null && settings.height != null)
            ? Calculations.calculateBMI(settings.weight!, settings.height!)
            : null;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Header
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.profile_title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              EditorialScreenHero(
                assetPath: 'assets/images/editorial/profile-progress.webp',
                title: settings.userName.isNotEmpty
                    ? settings.userName
                    : l10n.profile_user,
                subtitle: l10n.profile_planActive(plan.name),
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),

              // Profile card
              GlassCard(
                onTap: () => _showNameDialog(context, ref, settings.userName),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.person,
                        size: 32,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            settings.userName.isNotEmpty
                                ? settings.userName
                                : l10n.profile_user,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            l10n.profile_planActive(plan.name),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIcons.pencilSimple(),
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Premium card
              GlassCard(
                onTap: () => context.push('/paywall'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.05),
                        AppColors.secondary.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: AppSpacing.borderRadiusLg,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          PhosphorIconsRegular.crown,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.profile_upgradePremium,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              l10n.profile_premiumDesc,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        PhosphorIcons.caretRight(),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Body metrics
              _buildSectionTitle(context, l10n.profile_bodyMetrics),
              const SizedBox(height: 8),
              GlassCard(
                onTap: () => context.push('/body-metrics'),
                child: Column(
                  children: [
                    _buildMetricRow(
                      context,
                      l10n.profile_height,
                      settings.height != null
                          ? '${settings.height!.toStringAsFixed(0)} cm'
                          : '—',
                      PhosphorIcons.ruler(),
                    ),
                    const Divider(height: 1),
                    _buildMetricRow(
                      context,
                      l10n.profile_weight,
                      settings.weight != null
                          ? '${settings.weight!.toStringAsFixed(1)} kg'
                          : '—',
                      PhosphorIcons.scales(),
                    ),
                    const Divider(height: 1),
                    _buildMetricRow(
                      context,
                      l10n.profile_targetWeight,
                      settings.targetWeight != null
                          ? '${settings.targetWeight!.toStringAsFixed(1)} kg'
                          : '—',
                      PhosphorIcons.target(),
                    ),
                    const Divider(height: 1),
                    _buildMetricRow(
                      context,
                      l10n.profile_bmi,
                      bmi != null
                          ? '${bmi.toStringAsFixed(1)} (${Calculations.getBMICategory(bmi, l10n)})'
                          : '—',
                      PhosphorIcons.heartbeat(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Settings
              _buildSectionTitle(context, l10n.profile_settings),
              const SizedBox(height: 8),
              GlassCard(
                child: Column(
                  children: [
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.bell(),
                      title: l10n.profile_notifications,
                      trailing: Switch(
                        value: settings.notificationsEnabled,
                        onChanged: (v) {
                          ref
                              .read(settingsProvider.notifier)
                              .setNotifications(v);
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.moon(),
                      title: l10n.profile_theme,
                      subtitle: _themeLabel(l10n, settings.themeMode),
                      trailing: Icon(
                        PhosphorIcons.caretRight(),
                        size: 20,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      onTap: () => _showThemeDialog(context, ref),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.drop(),
                      title: l10n.profile_waterReminder,
                      trailing: Switch(
                        value: settings.waterReminders,
                        onChanged: (v) {
                          ref
                              .read(settingsProvider.notifier)
                              .setWaterReminders(v);
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.lightning(),
                      title: l10n.profile_phaseNotifications,
                      trailing: Switch(
                        value: settings.phaseNotifications,
                        onChanged: (v) {
                          ref
                              .read(settingsProvider.notifier)
                              .setPhaseNotifications(v);
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.speakerHigh(),
                      title: l10n.profile_completionSound,
                      trailing: Switch(
                        value: settings.soundEnabled,
                        onChanged:
                            ref.read(settingsProvider.notifier).setSoundEnabled,
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.leaf(),
                      title: l10n.profile_calmGamification,
                      subtitle: l10n.profile_calmGamificationDesc,
                      trailing: Switch(
                        value: settings.calmGamification,
                        onChanged:
                            ref
                                .read(settingsProvider.notifier)
                                .setCalmGamification,
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.translate(),
                      title: l10n.profile_language,
                      subtitle: _localeLabel(l10n, settings.locale),
                      trailing: Icon(
                        PhosphorIcons.caretRight(),
                        size: 20,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      onTap: () => _showLanguageDialog(context, ref),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // About
              _buildSectionTitle(context, l10n.profile_about),
              const SizedBox(height: 8),
              GlassCard(
                child: Column(
                  children: [
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.star(),
                      title: l10n.profile_rateApp,
                      onTap: () => _rate(context),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.share(),
                      title: l10n.profile_share,
                      onTap: () => _share(context),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.shieldCheck(),
                      title: l10n.profile_privacyPolicy,
                      onTap:
                          () => _openUrl(context, BuildConfig.privacyPolicyUrl),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.slidersHorizontal(),
                      title: l10n.profile_privacyChoices,
                      onTap: () => _privacyChoices(context),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.info(),
                      title: l10n.profile_version,
                      subtitle: '1.0.0',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(label, style: theme.textTheme.bodyMedium),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.bodyMedium),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  static const _languageOptions = <(String, String)>[
    ('en', '🇬🇧 English'),
    ('ar', '🇸🇦 العربية'),
    ('cs', '🇨🇿 Čeština'),
    ('da', '🇩🇰 Dansk'),
    ('de', '🇩🇪 Deutsch'),
    ('es_ES', '🇪🇸 Español (España)'),
    ('es_419', '🌎 Español (Latinoamérica)'),
    ('fi', '🇫🇮 Suomi'),
    ('fr', '🇫🇷 Français'),
    ('hi', '🇮🇳 हिन्दी'),
    ('hu', '🇭🇺 Magyar'),
    ('id', '🇮🇩 Bahasa Indonesia'),
    ('it', '🇮🇹 Italiano'),
    ('he', '🇮🇱 עברית'),
    ('ja', '🇯🇵 日本語'),
    ('ko', '🇰🇷 한국어'),
    ('nl', '🇳🇱 Nederlands'),
    ('no', '🇳🇴 Norsk'),
    ('pl', '🇵🇱 Polski'),
    ('pt_BR', '🇧🇷 Português (Brasil)'),
    ('ro', '🇷🇴 Română'),
    ('ru', '🇷🇺 Русский'),
    ('sk', '🇸🇰 Slovenčina'),
    ('sv', '🇸🇪 Svenska'),
    ('th', '🇹🇭 ไทย'),
    ('tr', '🇹🇷 Türkçe'),
    ('uk', '🇺🇦 Українська'),
    ('vi', '🇻🇳 Tiếng Việt'),
    ('zh_CN', '🇨🇳 简体中文'),
  ];

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.read(settingsProvider);

    final options = <(String?, String)>[
      (null, l10n.language_system),
      ..._languageOptions,
    ];

    showDialog<void>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.languageSelect),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return RadioListTile<String?>(
                    title: Text(option.$2),
                    value: option.$1,
                    groupValue: settings.locale,
                    onChanged: (value) {
                      ref.read(settingsProvider.notifier).setLocale(value);
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.read(settingsProvider);
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => SimpleDialog(
            title: Text(l10n.theme_select),
            children:
                ThemeMode.values.map((mode) {
                  return RadioListTile<ThemeMode>(
                    title: Text(_themeLabel(l10n, mode)),
                    value: mode,
                    groupValue: settings.themeMode,
                    onChanged: (value) {
                      if (value == null) return;
                      ref.read(settingsProvider.notifier).setThemeMode(value);
                      Navigator.pop(dialogContext);
                    },
                  );
                }).toList(),
          ),
    );
  }

  String _themeLabel(AppLocalizations l10n, ThemeMode mode) => switch (mode) {
    ThemeMode.system => l10n.theme_system,
    ThemeMode.light => l10n.theme_light,
    ThemeMode.dark => l10n.theme_dark,
  };

  String _localeLabel(AppLocalizations l10n, String? locale) {
    if (locale == null) return l10n.language_system;
    return _languageOptions
        .where((option) => option.$1 == locale)
        .map((option) => option.$2)
        .firstOrNull ??
        l10n.languageEnglish;
  }

  Future<void> _showNameDialog(
    BuildContext context,
    WidgetRef ref,
    String currentName,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: currentName);
    controller.selection = TextSelection.collapsed(
      offset: controller.text.length,
    );

    await showDialog<void>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.profile_editName),
            content: TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: l10n.profile_name,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              onSubmitted: (value) {
                final name = value.trim();
                if (name.isEmpty) return;
                ref.read(settingsProvider.notifier).setUserName(name);
                Navigator.pop(dialogContext);
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.common_cancel),
              ),
              FilledButton(
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isEmpty) return;
                  ref.read(settingsProvider.notifier).setUserName(name);
                  Navigator.pop(dialogContext);
                },
                child: Text(l10n.common_save),
              ),
            ],
          ),
    );
    controller.dispose();
  }
}
