import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/generated/l10n.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double logoSize = 200.w;

    return Center(
      child: Column(
        children: [
          Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.25),
                  blurRadius: 60.w,
                ),
              ],
            ),
            child: Image.asset(
              'assets/logo.png',
              width: logoSize,
              height: logoSize,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            S.of(context).title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34.sp,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            S.of(context).we_build_leaders,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
