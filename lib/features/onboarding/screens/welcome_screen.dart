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
    final artHeight = (MediaQuery.sizeOf(context).height * .42)
        .clamp(280.0, 360.0)
        .toDouble();

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
                    height: artHeight,
                    borderRadius: 30,
                    variant: FastingArtVariant.bare,
                    semanticLabel: 'FastTrack',
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),

              const SizedBox(height: 14),
              const _WelcomeDots(),
              const SizedBox(height: 18),

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

              // Three compact feature dots sit directly under the welcome art.
              FadeTransition(
                opacity: _fadeIn,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFeatureDot(
                      context,
                      Icons.timer_outlined,
                      l10n.onboarding_featureTimer,
                    ),
                    _buildFeatureDot(
                      context,
                      Icons.analytics_outlined,
                      l10n.onboarding_featureStats,
                    ),
                    _buildFeatureDot(
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

  Widget _buildFeatureDot(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.14),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: .32),
            ),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(height: 7),
        Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
      ],
      ),
    );
  }
}

class _WelcomeDots extends StatelessWidget {
  const _WelcomeDots();

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 24,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
      const SizedBox(width: 7),
      for (var index = 0; index < 2; index++) ...[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .2),
            shape: BoxShape.circle,
          ),
        ),
        if (index == 0) const SizedBox(width: 7),
      ],
    ],
  );
}
