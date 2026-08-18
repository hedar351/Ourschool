import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/generated/l10n.dart';

class LoginHeader extends StatelessWidget {
  final double _containerPadding = 16.w;

  final double _iconSize = 64.w;
  final double _gapSmall = 8.h;
  final double _gapMedium = 16.h;
  final double _titleSize = 24.sp;
  final double _subtitleSize = 16.sp;
  LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(_containerPadding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            Icons.school_rounded,
            size: _iconSize,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: _gapMedium),
        Text(
          S.of(context).title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 0.5,
            fontSize: _titleSize,
          ),
        ),
        SizedBox(height: _gapSmall),
        Text(
          S.of(context).school_management_system,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.textTheme.bodySmall?.color,
            fontSize: _subtitleSize,
          ),
        ),
      ],
    );
  }
}
