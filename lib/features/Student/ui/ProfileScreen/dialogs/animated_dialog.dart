import 'package:flutter/material.dart';

Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 250),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedValue = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );

      return AnimatedBuilder(
        animation: curvedValue,
        builder: (context, _) {
          final double value = curvedValue.value.clamp(0.0, 1.0);
          final double scale = 0.7 + (0.3 * value);
          final double opacity = value;

          return Transform.scale(
            scale: scale,
            child: Opacity(opacity: opacity, child: child),
          );
        },
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );
}
