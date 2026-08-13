import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/UI/widget/MarkCard.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_MarkEntity.dart';
import 'package:school/generated/l10n.dart';

void showMarksDialog(BuildContext context, List<CounselorMarkentity> marks) {
  final double dialogPadding = 20.w;
  final double maxWidth = 520.w;
  final double maxHeight = 550.h;
  final double iconContainerPadding = 10.w;
  final double iconSize = 22.w;
  final double titleFontSize = 18.sp;
  final double closeIconSize = 22.w;
  final double emptyIconSize = 56.w;
  final double emptyFontSize = 15.sp;
  final double sectionIconSize = 22.w;
  final double sectionFontSize = 16.sp;
  final double closeButtonSize = 36.w;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      final marksBySemester = <int, List<CounselorMarkentity>>{};
      for (var mark in marks) {
        final semester = mark.semester ?? 0;
        marksBySemester.putIfAbsent(semester, () => []).add(mark);
      }

      List<Widget> marksWidgets = [];
      for (final entry in marksBySemester.entries) {
        final semester = entry.key;
        final semesterMarks = entry.value;

        final semesterTitle = switch (semester) {
          1 => S.of(context).semester_1,
          2 => S.of(context).semester_2,
          _ => '${S.of(context).semester} $semester',
        };

        marksWidgets.add(
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Row(
              children: [
                Icon(
                  Icons.bookmark,
                  color: Theme.of(context).colorScheme.primary,
                  size: sectionIconSize,
                ),
                SizedBox(width: 8.w),
                Text(
                  semesterTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: sectionFontSize,
                  ),
                ),
              ],
            ),
          ),
        );
        marksWidgets.addAll(semesterMarks.map((m) => MarkCard(mark: m)));
        marksWidgets.add(SizedBox(height: 8.h));
      }

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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(iconContainerPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.bar_chart,
                      color: Theme.of(context).colorScheme.primary,
                      size: iconSize,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      S.of(context).marks_title,
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

              Expanded(
                child: marks.isEmpty
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
                              'لا توجد علامات',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: emptyFontSize,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        physics: const BouncingScrollPhysics(),
                        children: marksWidgets,
                      ),
              ),
              SizedBox(height: 12.h),

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
                      'إغلاق',
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
