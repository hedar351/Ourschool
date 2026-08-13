import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/generated/l10n.dart';

class WelcomeContentCard extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onExplorePressed;

  const WelcomeContentCard({
    super.key,
    required this.onLoginPressed,
    required this.onExplorePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double buttonHeight = 52.h;

    return Card(
      elevation: 6,
      shadowColor: theme.colorScheme.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          children: [
            Text(
              S.of(context).welcome_school,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              S.of(context).school_description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: theme.textTheme.bodyMedium?.color,
                height: 1.6,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: onLoginPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 2,
                minimumSize: Size(double.infinity, buttonHeight),
              ),
              child: Text(
                S.of(context).login,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: onExplorePressed,
              icon: Icon(
                Icons.explore_outlined,
                color: theme.colorScheme.primary,
                size: 22.w,
              ),
              label: Text(
                S.of(context).browse_school,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.colorScheme.primary, width: 1.8),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                minimumSize: Size(double.infinity, buttonHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
