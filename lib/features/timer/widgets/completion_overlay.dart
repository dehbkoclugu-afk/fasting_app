import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/gradient_button.dart';

class CompletionOverlay extends StatefulWidget {
  final int durationMinutes;
  final String planName;
  final String phaseName;
  final VoidCallback onDismiss;

  const CompletionOverlay({
    super.key,
    required this.durationMinutes,
    required this.planName,
    required this.phaseName,
    required this.onDismiss,
  });

  @override
  State<CompletionOverlay> createState() => _CompletionOverlayState();
}

class _CompletionOverlayState extends State<CompletionOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _confettiController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  final _confettiParticles = <_ConfettiParticle>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Generate confetti
    for (int i = 0; i < 50; i++) {
      _confettiParticles.add(_ConfettiParticle(
        x: _random.nextDouble(),
        y: -_random.nextDouble() * 0.3,
        speed: 0.3 + _random.nextDouble() * 0.7,
        size: 4 + _random.nextDouble() * 8,
        color: [
          AppColors.primary,
          AppColors.secondary,
          AppColors.tertiary,
          AppColors.success,
          Colors.orange,
          Colors.yellow,
        ][_random.nextInt(6)],
        rotation: _random.nextDouble() * 2 * pi,
      ));
    }

    _fadeController.forward();
    _scaleController.forward();
    _confettiController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final hours = widget.durationMinutes ~/ 60;
    final minutes = widget.durationMinutes % 60;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Material(
        color: Colors.black54,
        child: Stack(
          children: [
            // Confetti
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _confettiController,
                builder: (context, child) {
                  return CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: _ConfettiPainter(
                      particles: _confettiParticles,
                      progress: _confettiController.value,
                    ),
                  );
                },
              ),
            ),

            // Content
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(50),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Trophy icon
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(80),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        l10n.timer_completed,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.timer_completedMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(150),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Stats row
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onSurface.withAlpha(8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat(context, '${hours}h ${minutes}m', l10n.completion_duration),
                            Container(
                              width: 1,
                              height: 40,
                              color: theme.dividerTheme.color,
                            ),
                            _buildStat(context, widget.planName, l10n.completion_plan),
                            Container(
                              width: 1,
                              height: 40,
                              color: theme.dividerTheme.color,
                            ),
                            _buildStat(context, widget.phaseName, l10n.completion_lastPhase),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      GradientButton(
                        text: l10n.common_ok,
                        onPressed: widget.onDismiss,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
        ),
      ],
    );
  }
}

class _ConfettiParticle {
  double x, y, speed, size, rotation;
  Color color;

  _ConfettiParticle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotation,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final y = p.y + progress * p.speed * 1.5;
      if (y > 1.1) continue;

      final paint = Paint()
        ..color = p.color.withAlpha((255 * (1 - progress * 0.5)).toInt());

      canvas.save();
      canvas.translate(p.x * size.width, y * size.height);
      canvas.rotate(p.rotation + progress * 5);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
