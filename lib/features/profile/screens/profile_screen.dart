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
import '../../../services/notification_service.dart';
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
        SnackBar(content: Text(AppLocalizations.of(context)!.profile_share)),
      );
    }
  }

  Future<void> _privacyChoices(BuildContext context) async {
    final success = await AdmobService().showPrivacyOptions();
    if (!success && context.mounted) {
      await _openUrl(context, BuildConfig.privacyPolicyUrl);
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
              InkWell(
                borderRadius: BorderRadius.circular(26),
                onTap: () => _showNameDialog(context, ref, settings.userName),
                child: EditorialScreenHero(
                  assetPath: 'assets/images/editorial/profile-progress.webp',
                  title: settings.userName.isNotEmpty ? settings.userName : l10n.profile_user,
                  subtitle: l10n.profile_planActive(plan.name),
                  height: 156,
                  textWidth: 220,
                ),
              ),
              const SizedBox(height: 16),

              // Premium card
              InkWell(
                onTap: () => context.push('/paywall'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.16),
                        AppColors.secondary.withValues(alpha: 0.10),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withValues(alpha: .22)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(9),
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
                        onChanged: (v) async {
                          if (v) {
                            final granted = await NotificationService()
                                .requestPermission();
                            if (!granted) return;
                          }
                          ref
                              .read(settingsProvider.notifier)
                              .setNotifications(v);
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [Icon(PhosphorIcons.moon(), size: 20, color: AppColors.primary), const SizedBox(width: 12), Text(l10n.profile_theme, style: theme.textTheme.bodyMedium)]),
                        const SizedBox(height: 10),
                        SizedBox(width: double.infinity, child: SegmentedButton<ThemeMode>(
                          showSelectedIcon: false,
                          segments: ThemeMode.values.map((mode) => ButtonSegment(value: mode, label: Text(_themeLabel(l10n, mode)))).toList(),
                          selected: {settings.themeMode},
                          onSelectionChanged: (selection) => ref.read(settingsProvider.notifier).setThemeMode(selection.first),
                        )),
                      ]),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.drop(),
                      title: l10n.profile_waterReminder,
                      trailing: Switch(
                        value: settings.waterReminders,
                        onChanged: settings.notificationsEnabled ? (v) {
                          ref
                              .read(settingsProvider.notifier)
                              .setWaterReminders(v);
                        } : null,
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.lightning(),
                      title: l10n.profile_phaseNotifications,
                      trailing: Switch(
                        value: settings.phaseNotifications,
                        onChanged: settings.notificationsEnabled ? (v) {
                          ref
                              .read(settingsProvider.notifier)
                              .setPhaseNotifications(v);
                        } : null,
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
                            ref
                                .read(settingsProvider.notifier)
                                .setSoundEnabled,
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
                      onTap: () => _showLanguageScreen(context, ref),
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
                      subtitle: '1.2.6 (18)',
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
    ('en', 'English'), ('ar', 'العربية'), ('cs', 'Čeština'), ('da', 'Dansk'),
    ('de', 'Deutsch'), ('es_ES', 'Español (España)'), ('es_419', 'Español (Latinoamérica)'),
    ('fi', 'Suomi'), ('fr', 'Français'), ('hi', 'हिन्दी'), ('hu', 'Magyar'),
    ('id', 'Bahasa Indonesia'), ('it', 'Italiano'), ('he', 'עברית'), ('ja', '日本語'),
    ('ko', '한국어'), ('nl', 'Nederlands'), ('no', 'Norsk'), ('pl', 'Polski'),
    ('pt_BR', 'Português (Brasil)'), ('ro', 'Română'), ('ru', 'Русский'),
    ('sk', 'Slovenčina'), ('sv', 'Svenska'), ('th', 'ไทย'), ('tr', 'Türkçe'),
    ('uk', 'Українська'), ('vi', 'Tiếng Việt'), ('zh_CN', '简体中文'),
  ];

  void _showLanguageScreen(BuildContext context, WidgetRef ref) => Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => _LanguagePickerPage(current: ref.read(settingsProvider).locale, onSelected: ref.read(settingsProvider.notifier).setLocale)),
  );

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

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      showDragHandle: false,
      builder:
          (sheetContext) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetContext).bottom),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: Text(l10n.profile_editName, style: Theme.of(sheetContext).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900))),
                      IconButton(onPressed: () => Navigator.pop(sheetContext), icon: const Icon(Icons.close_rounded)),
                    ]),
                    const SizedBox(height: 12),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      maxLength: 32,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: l10n.profile_name, hintText: l10n.profile_user),
                      onSubmitted: (value) {
                        final name = value.trim();
                        if (name.isEmpty) return;
                        ref.read(settingsProvider.notifier).setUserName(name);
                        Navigator.pop(sheetContext);
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          final name = controller.text.trim();
                          if (name.isEmpty) return;
                          ref.read(settingsProvider.notifier).setUserName(name);
                          Navigator.pop(sheetContext);
                        },
                        icon: const Icon(Icons.check_rounded),
                        label: Text(l10n.common_save),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
    controller.dispose();
  }
}

class _LanguagePickerPage extends StatefulWidget {
  const _LanguagePickerPage({required this.current, required this.onSelected});
  final String? current;
  final ValueChanged<String?> onSelected;

  @override
  State<_LanguagePickerPage> createState() => _LanguagePickerPageState();
}

class _LanguagePickerPageState extends State<_LanguagePickerPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final options = <(String?, String)>[(null, l10n.language_system), ...ProfileScreen._languageOptions]
        .where((item) => item.$2.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.languageSelect)),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: SearchBar(leading: const Icon(Icons.search), hintText: l10n.profile_language, onChanged: (value) => setState(() => _query = value)),
        ),
        Expanded(child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          itemCount: options.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final option = options[index];
            final selected = widget.current == option.$1;
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              title: Text(option.$2),
              subtitle: option.$1 == null ? Text(l10n.language_system) : Text(option.$1!),
              trailing: selected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : null,
              onTap: () { widget.onSelected(option.$1); Navigator.pop(context); },
            );
          },
        )),
      ]),
    );
  }
}
