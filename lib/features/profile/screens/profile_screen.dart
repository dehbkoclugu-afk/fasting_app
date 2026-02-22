import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/utils/calculations.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);
    final plan = FastingPlans.getById(settings.selectedPlanId);

    final bmi = (settings.weight != null && settings.height != null)
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
              const SizedBox(height: 24),

              // Profile card
              GlassCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary.withValues(alpha:0.1),
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
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha:0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIcons.pencilSimple(),
                      color: theme.colorScheme.onSurface.withValues(alpha:0.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Premium card
              GlassCard(
                onTap: () => context.push('/paywall'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha:0.05),
                        AppColors.secondary.withValues(alpha:0.05),
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
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha:0.5),
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
                          ? '${bmi.toStringAsFixed(1)} (${Calculations.getBMICategory(bmi, Localizations.localeOf(context).languageCode)})'
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
                        activeColor: AppColors.primary,
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.moon(),
                      title: l10n.profile_darkTheme,
                      trailing: Switch(
                        value: settings.themeMode == ThemeMode.dark,
                        onChanged: (v) {
                          ref.read(settingsProvider.notifier).setThemeMode(
                                v ? ThemeMode.dark : ThemeMode.light,
                              );
                        },
                        activeColor: AppColors.primary,
                      ),
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
                        activeColor: AppColors.primary,
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
                        activeColor: AppColors.primary,
                      ),
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.translate(),
                      title: l10n.profile_language,
                      subtitle: settings.locale == 'tr' ? 'Türkçe' : 'English',
                      trailing: Icon(
                        PhosphorIcons.caretRight(),
                        size: 20,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha:0.3),
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
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.share(),
                      title: l10n.profile_share,
                    ),
                    const Divider(height: 1),
                    _buildSettingsTile(
                      context,
                      icon: PhosphorIcons.shieldCheck(),
                      title: l10n.profile_privacyPolicy,
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
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha:0.5),
            ),
      ),
    );
  }

  Widget _buildMetricRow(
      BuildContext context, String label, String value, IconData icon) {
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
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
                      color: theme.colorScheme.onSurface.withValues(alpha:0.4),
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

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.read(settingsProvider);

    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(l10n.languageSelect),
        children: [
          RadioListTile<String>(
            title: Text(l10n.languageTurkish),
            value: 'tr',
            groupValue: settings.locale,
            activeColor: AppColors.primary,
            onChanged: (v) {
              ref.read(settingsProvider.notifier).setLocale(v!);
              Navigator.pop(ctx);
            },
          ),
          RadioListTile<String>(
            title: Text(l10n.languageEnglish),
            value: 'en',
            groupValue: settings.locale,
            activeColor: AppColors.primary,
            onChanged: (v) {
              ref.read(settingsProvider.notifier).setLocale(v!);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}
