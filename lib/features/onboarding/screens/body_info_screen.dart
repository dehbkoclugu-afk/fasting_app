import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/utils/fasting_safety.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../profile/providers/settings_provider.dart';
import '../widgets/onboarding_progress.dart';
import 'safety_screen.dart';

class BodyInfoScreen extends ConsumerStatefulWidget {
  const BodyInfoScreen({super.key});

  @override
  ConsumerState<BodyInfoScreen> createState() => _BodyInfoScreenState();
}

class _BodyInfoScreenState extends ConsumerState<BodyInfoScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _ageController = TextEditingController();
  String _gender = 'male';

  double? _number(TextEditingController controller) =>
      double.tryParse(controller.text.trim().replaceAll(',', '.'));

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final height = _number(_heightController);
    final weight = _number(_weightController);
    final target = _number(_targetWeightController);
    final age = int.tryParse(_ageController.text.trim());
    if (height == null || height < 100 || height > 250 ||
        weight == null || weight < 20 || weight > 500 ||
        target == null || target < 20 || target > 500 ||
        age == null || age < 1 || age > 120) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.onboarding_invalidBody)),
      );
      return;
    }
    if (age < FastingSafety.minAge ||
        FastingSafety.isUnderweight(weight, height)) {
      unawaited(blockFasting(ref));
      context.go('/safety', extra: true);
      return;
    }
    if (FastingSafety.isUnderweight(target, height)) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.safety_targetTooLow)),
      );
      return;
    }
    ref
        .read(settingsProvider.notifier)
        .setBodyInfo(
          height: height,
          weight: weight,
          targetWeight: target,
          age: age,
          isMale: _gender == 'male',
        );
    context.go('/onboarding/permissions');
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingProgress(
                currentStep: 3,
                onBack: () => context.go('/onboarding/plan'),
              ),
              const SizedBox(height: 24),

              EditorialScreenHero(
                assetPath: 'assets/images/editorial/profile-progress.webp',
                title: l10n.onboarding_bodyInfo,
                subtitle: l10n.onboarding_bodyInfoDesc,
                icon: Icons.person_outline,
                height: 148,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(height: 18),

              // Gender
              Text(l10n.onboarding_gender, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  segments: [
                    ButtonSegment(
                      value: 'male',
                      icon: const Icon(Icons.male),
                      label: Text(l10n.onboarding_male),
                    ),
                    ButtonSegment(
                      value: 'female',
                      icon: const Icon(Icons.female),
                      label: Text(l10n.onboarding_female),
                    ),
                  ],
                  selected: {_gender},
                  showSelectedIcon: false,
                  onSelectionChanged:
                      (selection) => setState(() => _gender = selection.first),
                ),
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

              // Target weight
              _buildInputField(
                context,
                label: l10n.profile_targetWeight,
                controller: _targetWeightController,
                suffix: 'kg',
                icon: Icons.flag_outlined,
              ),
              const SizedBox(height: 16),

              // Age
              _buildInputField(
                context,
                label: l10n.onboarding_age,
                controller: _ageController,
                icon: Icons.cake_outlined,
              ),

              const SizedBox(height: 24),

              Text(
                l10n.onboarding_bodyInfoDisclaimer,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(height: 16),

              GradientButton(
                text: l10n.onboarding_next,
                onPressed: _submit,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    String? suffix,
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
          ),
        ),
      ],
    );
  }
}
