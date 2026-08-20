import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';

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
    final completion = widget.targetMinutes <= 0
        ? 0.0
        : (widget.durationMinutes / widget.targetMinutes).clamp(0.0, 1.0);

    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return FadeTransition(
      opacity:
          reduceMotion ? const AlwaysStoppedAnimation(1.0) : _fadeAnimation,
      child: Material(
        color: theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: ScaleTransition(
            scale: reduceMotion
                ? const AlwaysStoppedAnimation(1.0)
                : _scaleAnimation,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
              children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: widget.onDismiss,
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ),
                    FastingArtSlot(
                      assetPath: 'assets/images/editorial/fast-complete.webp',
                      height: 210,
                      borderRadius: 28,
                      variant: FastingArtVariant.bare,
                      semanticLabel: l10n.timer_completed,
                      child: const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 24),
                    Text(l10n.timer_completed, textAlign: TextAlign.center, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text(l10n.timer_completedMessage, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                              child: _buildStat(
                                context,
                                '${hours}h ${minutes}m',
                                l10n.completion_duration,
                              ),
                            ),
                            Expanded(
                              child: _buildStat(
                                context,
                                widget.planName,
                                l10n.completion_plan,
                              ),
                            ),
                            Expanded(
                              child: _buildStat(
                                context,
                                widget.phaseName,
                                l10n.completion_lastPhase,
                              ),
                            ),
                          ]),
                          const SizedBox(height: 18),
                          ClipRRect(borderRadius: BorderRadius.circular(99), child: LinearProgressIndicator(value: completion, minHeight: 9)),
                          const SizedBox(height: 7),
                          Align(alignment: Alignment.centerRight, child: Text('${(completion * 100).round()}%', style: theme.textTheme.labelLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final summary = l10n.replay_text(widget.planName, hours, minutes, widget.phaseName);
                              await Clipboard.setData(ClipboardData(text: summary));
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.profile_share)),
                                );
                              }
                            },
                            icon: const Icon(Icons.ios_share_outlined),
                            label: Text(l10n.profile_share),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: FilledButton(onPressed: widget.onDismiss, child: Text(l10n.common_ok))),
                      ],
                    ),
              ],
            ),
          ),
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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
        ),
      ],
    );
  }
}
