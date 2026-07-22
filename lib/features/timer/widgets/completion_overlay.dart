import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/gradient_button.dart';

class CompletionOverlay extends StatefulWidget {
  final int durationMinutes;
  final String planName;
  final String phaseName;
  final int targetMinutes;
  final VoidCallback onDismiss;

  const CompletionOverlay({
    super.key,
    required this.durationMinutes,
    required this.planName,
    required this.phaseName,
    required this.targetMinutes,
    required this.onDismiss,
  });

  @override
  State<CompletionOverlay> createState() => _CompletionOverlayState();
}

class _CompletionOverlayState extends State<CompletionOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _playCompletionHaptic();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _scaleController.forward();
  }

  Future<void> _playCompletionHaptic() async {
    await HapticFeedback.lightImpact();
    await Future<void>.delayed(const Duration(milliseconds: 90));
    await HapticFeedback.mediumImpact();
    await Future<void>.delayed(const Duration(milliseconds: 120));
    await HapticFeedback.heavyImpact();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('sound_enabled') ?? false) {
      await SystemSound.play(SystemSoundType.click);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final hours = widget.durationMinutes ~/ 60;
    final minutes = widget.durationMinutes % 60;
    final earnedXp =
        100 + (widget.durationMinutes.clamp(0, widget.targetMinutes) ~/ 60) * 4;

    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return FadeTransition(
      opacity:
          reduceMotion ? const AlwaysStoppedAnimation(1.0) : _fadeAnimation,
      child: Material(
        color: Colors.black54,
        child: Stack(
          children: [
            Center(
              child: ScaleTransition(
                scale:
                    reduceMotion
                        ? const AlwaysStoppedAnimation(1.0)
                        : _scaleAnimation,
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
                          color: AppColors.primary.withValues(alpha: .08),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.workspace_premium_outlined,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '+$earnedXp Rhythm XP',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
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
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: .35),
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year} · ${widget.planName}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.primary,
                          ),
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
                            _buildStat(
                              context,
                              '${hours}h ${minutes}m',
                              l10n.completion_duration,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: theme.dividerTheme.color,
                            ),
                            _buildStat(
                              context,
                              widget.planName,
                              l10n.completion_plan,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: theme.dividerTheme.color,
                            ),
                            _buildStat(
                              context,
                              widget.phaseName,
                              l10n.completion_lastPhase,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final replay = l10n.replay_text(
                                  widget.planName,
                                  hours,
                                  minutes,
                                  widget.phaseName,
                                );
                                await Clipboard.setData(
                                  ClipboardData(text: replay),
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(l10n.replay_copied)),
                                  );
                                }
                              },
                              icon: const Icon(Icons.ios_share_outlined),
                              label: Text(l10n.replay_button),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GradientButton(
                              text: l10n.common_ok,
                              onPressed: widget.onDismiss,
                            ),
                          ),
                        ],
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
