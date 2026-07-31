// lib/features/onboarding/Ui/welcome_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/generated/l10n.dart';

class WelcomeHeader extends StatelessWidget {
  // ✅ حسابات القيم الثابتة خارج build
  final double _logoSize = 200.w;

  final double _blurRadius = 60.w;
  WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          Container(
            width: _logoSize,
            height: _logoSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.29),
                  blurRadius: _blurRadius,
                ),
              ],
            ),
            child: Image.asset(
              'assets/logo.png',
              width: _logoSize,
              height: _logoSize,
            ),
          ),
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
