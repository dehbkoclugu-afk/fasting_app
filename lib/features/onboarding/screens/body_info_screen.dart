import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
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
  final _targetWeightController = TextEditingController(text: '70');
  final _ageController = TextEditingController(text: '30');
  String _gender = 'male';

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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgress(currentStep: 3),
              const SizedBox(height: 24),

              EditorialScreenHero(
                assetPath: 'assets/images/editorial/profile-progress.webp',
                title: l10n.onboarding_bodyInfo,
                subtitle: l10n.onboarding_bodyInfoDesc,
                icon: Icons.person_outline,
                height: 118,
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
                suffix: 'yaş',
                icon: Icons.cake_outlined,
              ),

              const Spacer(),

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
                onPressed: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setBodyInfo(
                        height: double.tryParse(_heightController.text),
                        weight: double.tryParse(_weightController.text),
                        targetWeight: double.tryParse(
                          _targetWeightController.text,
                        ),
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
          ),
        ),
      ],
    );
  }
}
