import 'package:flutter/material.dart';

class Buildsectionheader extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const Buildsectionheader({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ---- الشريط الجانبي ----
        Container(
          width: 5,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 12),
        // ---- العنوان ----
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}
