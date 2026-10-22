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
    if (widget.durationMinutes >= widget.targetMinutes) {
      await Future<void>.delayed(const Duration(milliseconds: 90));
      await HapticFeedback.mediumImpact();
    }
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
    final successful = completion >= 1;

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
                    const SizedBox(height: 12),
                    if (successful) ...[
                      FastingArtSlot(
                        assetPath: 'assets/images/editorial/fast-complete.webp',
                        height: 220,
                        borderRadius: 28,
                        variant: FastingArtVariant.bare,
                        fit: BoxFit.contain,
                        semanticLabel: l10n.timer_completed,
                        child: const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 18),
                    ] else Center(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: (successful ? AppColors.success : AppColors.primary)
                              .withValues(alpha: .10),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          successful ? Icons.check_rounded : Icons.flag_outlined,
                          size: 34,
                          color: successful ? AppColors.success : AppColors.primary,
                        ),
                      ),
                    ),
                    if (!successful) const SizedBox(height: 18),
                    Text(successful ? l10n.timer_completed : l10n.completion_earlyTitle, textAlign: TextAlign.center, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text(successful ? l10n.timer_completedMessage : l10n.completion_earlyMessage, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
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
                                _durationLabel(hours, minutes),
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
                          LayoutBuilder(
                            builder: (context, constraints) => Container(
                              height: 9,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.outlineVariant.withValues(alpha: .45),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              alignment: Alignment.centerLeft,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 450),
                                width: constraints.maxWidth * completion,
                                color: successful ? AppColors.success : AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Align(alignment: Alignment.centerRight, child: Text('${(completion * 100).round()}%', style: theme.textTheme.labelLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        if (successful) Expanded(
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
                        if (successful) const SizedBox(width: 10),
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

  String _durationLabel(int hours, int minutes) {
    final language = Localizations.localeOf(context).languageCode;
    if (language == 'tr') {
      if (hours == 0) return '$minutes dk';
      if (minutes == 0) return '$hours sa';
      return '$hours sa $minutes dk';
    }
    if (hours == 0) return '$minutes min';
    if (minutes == 0) return '$hours hr';
    return '$hours hr $minutes min';
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
