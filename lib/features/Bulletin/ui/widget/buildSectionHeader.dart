// lib/features/Bulletin/ui/widget/buildSectionHeader.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buildsectionheader extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  // ✅ حسابات القيم الثابتة خارج build
  final double _containerWidth = 5.w;

  final double _containerHeight = 26.h;
  final double _gap = 12.w;
  final double _fontSize = 22.sp;
  Buildsectionheader({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: _containerWidth,
          height: _containerHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        SizedBox(width: _gap),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: _fontSize,
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
