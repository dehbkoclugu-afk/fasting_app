import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/fasting_plans.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/editorial_screen_hero.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../../profile/providers/settings_provider.dart';
import '../../paywall/providers/subscription_provider.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../widgets/onboarding_progress.dart';

class PlanSelectScreen extends ConsumerStatefulWidget {
  const PlanSelectScreen({super.key});

  @override
  ConsumerState<PlanSelectScreen> createState() => _PlanSelectScreenState();
}

class _PlanSelectScreenState extends ConsumerState<PlanSelectScreen> {
  String _selectedPlanId = '16_8';

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
              const OnboardingProgress(currentStep: 2),
              const SizedBox(height: 24),

              EditorialScreenHero(
                assetPath: 'assets/images/editorial/v3/plan-clock-16-8.webp',
                title: l10n.onboarding_selectPlan,
                subtitle: l10n.onboarding_selectPlanDesc,
                icon: Icons.schedule_outlined,
                height: 124,
              ),
              const SizedBox(height: 18),

              Expanded(
                child: ListView.separated(
                  itemCount: FastingPlans.all.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final plan = FastingPlans.all[index];
                    final isSelected = _selectedPlanId == plan.id;
                    final isPremium = ref.watch(isPremiumProvider);
                    final isLocked = plan.isPremium && !isPremium;

                    return InkWell(
                      borderRadius: AppSpacing.borderRadiusLg,
                      onTap: () {
                        if (isLocked) {
                          context.push('/paywall');
                          return;
                        }
                        HapticFeedback.selectionClick();
                        setState(() => _selectedPlanId = plan.id);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(
                          isSelected && !isLocked ? 2 : 1,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected && !isLocked
                              ? AppColors.primary
                              : theme.dividerColor,
                          borderRadius: AppSpacing.borderRadiusLg,
                        ),
                        child: Opacity(
                          opacity: isLocked ? .58 : 1,
                          child: FastingArtSlot(
                            assetPath: _planArtwork(plan.id),
                            height: 102,
                            borderRadius: 17,
                            variant: FastingArtVariant.row,
                            semanticLabel: plan.name,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 30,
                                  top: 12,
                                  child: _ClockDirectionDial(
                                    progress: _fastingRatio(plan),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    14,
                                    12,
                                    14,
                                    12,
                                  ),
                                  child: Row(
                                children: [
                                  Container(
                                    width: 54,
                                    height: 54,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: .3),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: .16),
                                      ),
                                    ),
                                    child: Text(
                                      plan.shortName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                plan.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme.textTheme.titleSmall
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                              ),
                                            ),
                                            if (isLocked) ...[
                                              const SizedBox(width: 6),
                                              _proBadge(),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          '${plan.fastingHours}s oruç · ${plan.eatingHours}s yemek',
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: Colors.white.withValues(alpha: .76),
                                          ),
                                        ),
                                        Text(
                                          plan.description(l10n),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: Colors.white.withValues(alpha: .58),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    isLocked
                                        ? Icons.lock_outline
                                        : isSelected
                                        ? Icons.check_circle
                                        : Icons.chevron_right,
                                    color: Colors.white,
                                    size: isSelected ? 24 : 20,
                                  ),
                                ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              GradientButton(
                text: l10n.onboarding_next,
                onPressed: () {
                  ref
                      .read(settingsProvider.notifier)
                      .setSelectedPlan(_selectedPlanId);
                  context.go('/onboarding/body-info');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _planArtwork(String id) => switch (id) {
    '12_12' => 'assets/images/editorial/v3/plan-clock-12-12.webp',
    '16_8' => 'assets/images/editorial/v3/plan-clock-16-8.webp',
    '18_6' => 'assets/images/editorial/v3/plan-clock-18-6.webp',
    '20_4' => 'assets/images/editorial/v3/plan-clock-20-4.webp',
    'omad' => 'assets/images/editorial/v3/plan-clock-omad.webp',
    '5_2' => 'assets/images/editorial/v3/plan-clock-5-2.webp',
    'eat_stop_eat' => 'assets/images/editorial/v3/plan-clock-ese.webp',
    _ => 'assets/images/editorial/v3/plan-clock-warrior.webp',
  };

  double _fastingRatio(FastingPlan plan) => switch (plan.id) {
    '5_2' => 5 / 7,
    'eat_stop_eat' => 1,
    _ => plan.fastingHours / 24,
  };

  Widget _proBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      'PRO',
      style: TextStyle(
        color: Colors.white,
        fontSize: 9,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

/// The fasting interval always starts at 12 o'clock and advances clockwise.
/// Keeping this in code prevents the direction from being ambiguous in art.
class _ClockDirectionDial extends StatelessWidget {
  const _ClockDirectionDial({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: CustomPaint(
      size: const Size.square(78),
      painter: _ClockDirectionPainter(progress.clamp(0, 1).toDouble()),
    ),
  );
}

class _ClockDirectionPainter extends CustomPainter {
  const _ClockDirectionPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 7;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final base = Paint()
      ..color = Colors.white.withValues(alpha: .18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final fast = Paint()
      ..color = AppColors.primary.withValues(alpha: .94)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7;
    canvas.drawCircle(center, radius, base);
    final sweep = 2 * 3.141592653589793 * progress;
    canvas.drawArc(rect, -3.141592653589793 / 2, sweep, false, fast);

    final angle = -3.141592653589793 / 2 + sweep;
    final end = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
    final tangent = Offset(-math.sin(angle), math.cos(angle));
    final normal = Offset(math.cos(angle), math.sin(angle));
    final path = Path()
      ..moveTo(end.dx + tangent.dx * 6, end.dy + tangent.dy * 6)
      ..lineTo(end.dx - tangent.dx * 6 + normal.dx * 3, end.dy - tangent.dy * 6 + normal.dy * 3)
      ..lineTo(end.dx - tangent.dx * 6 - normal.dx * 3, end.dy - tangent.dy * 6 - normal.dy * 3)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant _ClockDirectionPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
