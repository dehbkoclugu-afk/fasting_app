import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;

  const OnboardingProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (onBack != null) ...[
            IconButton(
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: onBack,
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            const SizedBox(width: 6),
          ],
          ...List.generate(totalSteps, (index) {
            final isActive = index <= currentStep;
            final isCurrent = index == currentStep;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                height: isCurrent ? 4 : 3,
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? 4 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: isActive
                      ? AppColors.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
