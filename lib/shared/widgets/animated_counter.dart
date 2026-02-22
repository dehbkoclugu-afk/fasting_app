import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;
  final String? suffix;
  final String? prefix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 600),
    this.suffix,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, val, child) {
        return Text(
          '${prefix ?? ''}$val${suffix ?? ''}',
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
