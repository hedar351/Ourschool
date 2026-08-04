// lib/features/Student/presentation/widgets/animated_section.dart

import 'package:flutter/material.dart';

class AnimatedSection extends StatelessWidget {
  final Widget child;
  final Animation<double> fadeAnim;
  final Animation<Offset> slideAnim;
  final Animation<double> scaleAnim;

  const AnimatedSection({
    super.key,
    required this.child,
    required this.fadeAnim,
    required this.slideAnim,
    required this.scaleAnim,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnim,
      builder: (context, _) {
        return FadeTransition(
          opacity: fadeAnim,
          child: SlideTransition(
            position: slideAnim,
            child: ScaleTransition(scale: scaleAnim, child: child),
          ),
        );
      },
    );
  }
}
