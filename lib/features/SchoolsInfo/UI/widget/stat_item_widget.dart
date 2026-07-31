// lib/features/SchoolsInfo/presentation/widgets/stat_item_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatItemWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  // ✅ حسابات القيم الثابتة خارج build
  final double verticalPadding = 8.h;

  final double borderRadius = 12.r;
  final double iconSize = 16.w;
  final double valueFontSize = 16.sp;
  final double labelFontSize = 11.sp;
  StatItemWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color.withOpacity(isDark ? 0.15 : 0.1),
          width: 0.5.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: color),
              SizedBox(width: 4.w),
              Text(
                value,
                style: TextStyle(
                  fontSize: valueFontSize,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: labelFontSize,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
