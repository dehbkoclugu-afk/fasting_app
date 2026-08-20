import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final List<Color>? colors;
  final double? width;
  final double height;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.colors,
    this.width,
    this.height = 56,
    this.isLoading = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;
    final primary = colors?.first ?? AppColors.primary;

    return Semantics(
      button: true,
      enabled: !widget.isLoading && widget.onPressed != null,
      label: widget.text,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 160),
        opacity: widget.onPressed == null ? .45 : 1,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                clipBehavior: Clip.antiAlias,
                child: Ink(
                  width: widget.width ?? double.infinity,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: colors == null ? primary : null,
                    gradient:
                        colors == null
                            ? null
                            : LinearGradient(
                              colors: colors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.22),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onHighlightChanged:
                        (pressed) =>
                            pressed
                                ? _controller.forward()
                                : _controller.reverse(),
                    onTap:
                        widget.isLoading || widget.onPressed == null
                            ? null
                            : () {
                              HapticFeedback.lightImpact();
                              widget.onPressed!();
                            },
                    child: Center(
                      child:
                          widget.isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.text,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
