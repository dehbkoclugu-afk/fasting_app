import 'dart:async';

import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/fasting_safety.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../timer/providers/timer_provider.dart';

/// Marks the device as blocked and ends any running fast, so its notifications
/// do not keep encouraging someone the app has just told not to fast.
///
/// Callers show the block first and do not wait: a stuck plugin must never keep
/// the warning off the screen. So [ref] is only read before the first await.
Future<void> blockFasting(WidgetRef ref) async {
  final timer = ref.read(timerProvider.notifier);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(FastingSafety.statusKey, FastingSafety.blocked);
  await timer.endFastQuietly();
}

class SafetyScreen extends ConsumerStatefulWidget {
  final bool startBlocked;

  const SafetyScreen({super.key, this.startBlocked = false});

  @override
  ConsumerState<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends ConsumerState<SafetyScreen> {
  final _answers = <SafetyAnswer>{};
  bool _none = false;
  bool _doctorAcknowledged = false;
  late bool _blocked = widget.startBlocked;

  bool get _canContinue {
    if (FastingSafety.blocksFasting(_answers)) return true;
    if (!_none && _answers.isEmpty) return false;
    return !FastingSafety.needsDoctorNotice(_answers) || _doctorAcknowledged;
  }

  Future<void> _continue() async {
    if (FastingSafety.blocksFasting(_answers)) {
      setState(() => _blocked = true);
      unawaited(blockFasting(ref));
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(FastingSafety.statusKey, FastingSafety.cleared);
    if (!mounted) return;
    final onboarded = prefs.getBool('onboardingCompleted') ?? false;
    context.go(onboarded ? '/timer' : '/onboarding/goals');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _blocked ? _buildBlocked(l10n) : _buildQuestions(l10n),
        ),
      ),
    );
  }

  Widget _buildBlocked(AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 32),
        Icon(Icons.favorite_outline, size: 48, color: theme.colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          l10n.safety_blockedTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Text(
          l10n.safety_blockedDesc,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () => setState(() {
            _blocked = false;
            _answers.clear();
            _none = false;
            _doctorAcknowledged = false;
          }),
          child: Text(l10n.safety_reviewAnswers),
        ),
      ],
    );
  }

  Widget _buildQuestions(AppLocalizations l10n) {
    final theme = Theme.of(context);
    final options = {
      SafetyAnswer.under18: l10n.safety_under18,
      SafetyAnswer.pregnant: l10n.safety_pregnant,
      SafetyAnswer.eatingDisorder: l10n.safety_eatingDisorder,
      SafetyAnswer.underweight: l10n.safety_underweight,
      SafetyAnswer.diabetes: l10n.safety_diabetes,
      SafetyAnswer.medical: l10n.safety_medical,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.safety_title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(l10n.safety_desc, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 12),
        for (final option in options.entries)
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(option.value),
            value: _answers.contains(option.key),
            onChanged: (checked) => setState(() {
              checked == true
                  ? _answers.add(option.key)
                  : _answers.remove(option.key);
              _none = false;
            }),
          ),
        const Divider(),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(l10n.safety_none),
          value: _none,
          onChanged: (checked) => setState(() {
            _none = checked == true;
            if (_none) _answers.clear();
          }),
        ),
        if (FastingSafety.needsDoctorNotice(_answers) &&
            !FastingSafety.blocksFasting(_answers))
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(l10n.safety_ack),
            value: _doctorAcknowledged,
            onChanged: (checked) =>
                setState(() => _doctorAcknowledged = checked == true),
          ),
        const SizedBox(height: 16),
        GradientButton(
          text: l10n.onboarding_next,
          onPressed: _canContinue ? _continue : null,
        ),
      ],
    );
  }
}
