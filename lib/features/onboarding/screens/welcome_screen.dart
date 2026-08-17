import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
import '../widgets/onboarding_progress.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
              const OnboardingProgress(currentStep: 0),
              const Spacer(),

              // Logo / Icon
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: FastingArtSlot(
                    assetPath:
                        'assets/images/editorial/onboarding-welcome.webp',
                    height: 218,
                    borderRadius: 30,
                    variant: FastingArtVariant.bare,
                    semanticLabel: 'FastTrack',
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: Column(
                    children: [
                      Text(
                        'FastTrack',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.onboarding_welcomeDesc,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Features preview
              FadeTransition(
                opacity: _fadeIn,
                child: Column(
                  children: [
                    _buildFeatureRow(
                      context,
                      Icons.timer_outlined,
                      l10n.onboarding_featureTimer,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureRow(
                      context,
                      Icons.analytics_outlined,
                      l10n.onboarding_featureStats,
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureRow(
                      context,
                      Icons.restaurant_outlined,
                      l10n.onboarding_featureMeals,
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              GradientButton(
                text: l10n.onboarding_getStarted,
                onPressed: () => context.go('/onboarding/goals'),
              ),
              const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}
