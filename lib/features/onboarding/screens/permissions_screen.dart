import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../services/notification_service.dart';
import '../../../services/health_service.dart';
import '../../profile/providers/settings_provider.dart';
import '../widgets/onboarding_progress.dart';

class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen> {
  bool _notificationGranted = false;
  bool _healthGranted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgress(currentStep: 4),
              const SizedBox(height: 24),

              Text(
                l10n.onboarding_permissions,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboarding_permissionsDesc,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 40),

              _buildPermissionCard(
                context,
                icon: PhosphorIcons.bell(PhosphorIconsStyle.fill),
                title: l10n.profile_notifications,
                description: l10n.permission_notificationDesc,
                color: AppColors.primary,
                granted: _notificationGranted,
                onEnable: () async {
                  final granted =
                      await NotificationService().requestPermission();
                  setState(() => _notificationGranted = granted);
                  if (granted) {
                    ref.read(settingsProvider.notifier).setNotifications(true);
                  }
                },
              ),
              const SizedBox(height: 16),

              _buildPermissionCard(
                context,
                icon: PhosphorIcons.heartbeat(PhosphorIconsStyle.fill),
                title: l10n.permission_healthTitle,
                description: l10n.permission_healthDesc,
                color: AppColors.success,
                granted: _healthGranted,
                onEnable: () async {
                  final granted = await HealthService().requestAuthorization();
                  setState(() => _healthGranted = granted);
                },
              ),

              const Spacer(),

              GradientButton(
                text: l10n.onboarding_start,
                onPressed: () {
                  ref.read(settingsProvider.notifier).completeOnboarding();
                  context.go('/timer');
                },
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {
                    ref.read(settingsProvider.notifier).completeOnboarding();
                    context.go('/timer');
                  },
                  child: Text(
                    l10n.onboarding_skipForNow,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required bool granted,
    required VoidCallback onEnable,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            granted
                ? color.withValues(alpha: 0.05)
                : theme.colorScheme.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              granted
                  ? color.withValues(alpha: 0.3)
                  : theme.colorScheme.onSurface.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (granted)
            Icon(Icons.check_circle, color: color, size: 28)
          else
            OutlinedButton(
              onPressed: onEnable,
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(color: color),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: Text(AppLocalizations.of(context)!.common_enable),
            ),
        ],
      ),
    );
  }
}
