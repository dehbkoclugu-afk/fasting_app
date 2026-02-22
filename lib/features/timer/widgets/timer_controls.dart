import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/timer_provider.dart';

class TimerControls extends StatefulWidget {
  final TimerStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  const TimerControls({
    super.key,
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  @override
  State<TimerControls> createState() => _TimerControlsState();
}

class _TimerControlsState extends State<TimerControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.status == TimerStatus.running ||
            widget.status == TimerStatus.paused) ...[
          // Stop button
          _buildSecondaryButton(
            icon: PhosphorIcons.stop(PhosphorIconsStyle.fill),
            onTap: widget.onStop,
            color: AppColors.error,
          ),
          const SizedBox(width: 24),
        ],

        // Main button
        GestureDetector(
          onTapDown: (_) => _scaleController.forward(),
          onTapUp: (_) {
            _scaleController.reverse();
            HapticFeedback.heavyImpact();
            _handleMainTap();
          },
          onTapCancel: () => _scaleController.reverse(),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _mainButtonColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _mainButtonColors.first.withValues(alpha:0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                _mainButtonIcon,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleMainTap() {
    switch (widget.status) {
      case TimerStatus.idle:
      case TimerStatus.completed:
        widget.onStart();
      case TimerStatus.running:
        widget.onPause();
      case TimerStatus.paused:
        widget.onResume();
    }
  }

  IconData get _mainButtonIcon {
    switch (widget.status) {
      case TimerStatus.idle:
      case TimerStatus.completed:
        return PhosphorIcons.play(PhosphorIconsStyle.fill);
      case TimerStatus.running:
        return PhosphorIcons.pause(PhosphorIconsStyle.fill);
      case TimerStatus.paused:
        return PhosphorIcons.play(PhosphorIconsStyle.fill);
    }
  }

  List<Color> get _mainButtonColors {
    switch (widget.status) {
      case TimerStatus.idle:
      case TimerStatus.completed:
        return [AppColors.primary, AppColors.primaryDark];
      case TimerStatus.running:
        return [AppColors.warning, AppColors.warning.withValues(alpha:0.8)];
      case TimerStatus.paused:
        return [AppColors.success, AppColors.success.withValues(alpha:0.8)];
    }
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha:0.3)),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
