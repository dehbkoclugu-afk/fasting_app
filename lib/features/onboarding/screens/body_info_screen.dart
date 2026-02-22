import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../profile/providers/settings_provider.dart';
import '../widgets/onboarding_progress.dart';

class BodyInfoScreen extends ConsumerStatefulWidget {
  const BodyInfoScreen({super.key});

  @override
  ConsumerState<BodyInfoScreen> createState() => _BodyInfoScreenState();
}

class _BodyInfoScreenState extends ConsumerState<BodyInfoScreen> {
  final _heightController = TextEditingController(text: '175');
  final _weightController = TextEditingController(text: '75');
  final _ageController = TextEditingController(text: '30');
  String _gender = 'male';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgress(currentStep: 3),
              const SizedBox(height: 24),

              Text(
                l10n.onboarding_bodyInfo,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboarding_bodyInfoDesc,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.5),
                ),
              ),
              const SizedBox(height: 32),

              // Gender
              Text(l10n.onboarding_gender, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildGenderOption(
                      context, 'male', l10n.onboarding_male, Icons.male,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGenderOption(
                      context, 'female', l10n.onboarding_female, Icons.female,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Height
              _buildInputField(
                context,
                label: l10n.profile_height,
                controller: _heightController,
                suffix: 'cm',
                icon: Icons.height,
              ),
              const SizedBox(height: 16),

              // Weight
              _buildInputField(
                context,
                label: l10n.profile_weight,
                controller: _weightController,
                suffix: 'kg',
                icon: Icons.monitor_weight_outlined,
              ),
              const SizedBox(height: 16),

              // Age
              _buildInputField(
                context,
                label: l10n.onboarding_age,
                controller: _ageController,
                suffix: 'yaş',
                icon: Icons.cake_outlined,
              ),

              const Spacer(),

              Text(
                l10n.onboarding_bodyInfoDisclaimer,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.4),
                ),
              ),
              const SizedBox(height: 16),

              GradientButton(
                text: l10n.onboarding_next,
                onPressed: () {
                  ref.read(settingsProvider.notifier).setBodyInfo(
                        height: double.tryParse(_heightController.text),
                        weight: double.tryParse(_weightController.text),
                        age: int.tryParse(_ageController.text),
                        isMale: _gender == 'male',
                      );
                  context.go('/onboarding/permissions');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final isSelected = _gender == value;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => setState(() => _gender = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha:0.1)
              : theme.colorScheme.onSurface.withValues(alpha:0.03),
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : theme.colorScheme.onSurface.withValues(alpha:0.08),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String suffix,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20),
            suffixText: suffix,
            filled: true,
            fillColor: theme.colorScheme.onSurface.withValues(alpha:0.03),
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha:0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha:0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
