// lib/features/Counselor/UI/widget/ShowDialog/show_warnings_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/UI/widget/WarningCard.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/generated/l10n.dart';

void showWarningsDialog(
  BuildContext context,
  List<CounselorWarningsentity> warnings,
) {
  // ✅ قيم ثابتة
  final double dialogPadding = 20.w;
  final double maxWidth = 520.w;
  final double maxHeight = 550.h;
  final double iconContainerPadding = 10.w;
  final double iconSize = 22.w;
  final double titleFontSize = 18.sp;
  final double closeIconSize = 22.w;
  final double emptyIconSize = 56.w;
  final double emptyFontSize = 15.sp;
  final double closeButtonSize = 36.w;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Container(
          padding: EdgeInsets.all(dialogPadding),
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ====== العنوان ======
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(iconContainerPadding),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.warning_amber,
                      color: Colors.red,
                      size: iconSize,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      S.of(context).warnings_title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.outline,
                      size: closeIconSize,
                    ),
                    splashRadius: 24.r,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: closeButtonSize,
                      minHeight: closeButtonSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // ====== المحتوى ======
              Expanded(
                child: warnings.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: emptyIconSize,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'لا توجد إنذارات',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: emptyFontSize,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: warnings.length,
                        separatorBuilder: (_, _) =>
                            Divider(height: 4.h, thickness: 0.3.w),
                        itemBuilder: (context, index) {
                          return WarningCard(warning: warnings[index]);
                        },
                      ),
              ),
              SizedBox(height: 12.h),

              // ====== زر الإغلاق ======
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      S.of(context).close,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
