import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/FirstStep/SchoolsInfo/UI/page/schools_screen.dart';
import 'package:school/generated/l10n.dart';

class LoginFooter extends StatelessWidget {
  final bool isLoading;

  final double _dividerPadding = 12.w;

  final double _gap = 24.h;
  final double _buttonPaddingVertical = 14.h;
  final double _buttonPaddingHorizontal = 25.w;
  final double _iconSize = 22.w;
  final double _fontSize = 16.sp;
  LoginFooter({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: theme.dividerColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _dividerPadding),
              child: Text(
                S.of(context).or_explore,
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Expanded(child: Divider(color: theme.dividerColor)),
          ],
        ),
        SizedBox(height: _gap),
        OutlinedButton.icon(
          onPressed: isLoading
              ? null
              : () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SchoolsScreen(),
                    ),
                  );
                },
          icon: Icon(
            Icons.school_outlined,
            color: theme.colorScheme.primary,
            size: _iconSize,
          ),
          label: Text(
            S.of(context).browse_school,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: _fontSize,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: _buttonPaddingVertical,
              horizontal: _buttonPaddingHorizontal,
            ),
            side: BorderSide(color: theme.colorScheme.primary, width: 1.5.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            minimumSize: Size(double.infinity, 48.h),
          ),
        ),
      ],
    );
  }
}
