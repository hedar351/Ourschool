import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/UI/bloc/attendance/attendance_bloc.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/generated/l10n.dart';

void showAttendanceDialog(
  BuildContext context,
  List<AttendanceEntity> attendance,
  Studententity? student,
) {
  final attendanceBloc = context.read<AttendanceBloc>();
  final studentId = student?.localStudentNumber;
  final double dialogPadding = 20.w;
  final double maxWidth = 480.w;
  final double maxHeight = 580.h;
  final double iconContainerPadding = 10.w;
  final double iconSize = 22.w;
  final double titleFontSize = 18.sp;
  final double closeIconSize = 22.w;
  final double headerPaddingHorizontal = 14.w;
  final double headerPaddingVertical = 10.h;
  final double headerIconSize = 15.w;
  final double headerFontSize = 13.sp;

  final double buttonFontSize = 14.sp;
  final double borderRadius = 10.r;
  final double dialogBorderRadius = 24.r;
  final double closeButtonSize = 36.w;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: attendanceBloc,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dialogBorderRadius),
          ),
          child: Container(
            padding: EdgeInsets.all(dialogPadding),
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
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
                        Icons.event_available,
                        color: Theme.of(context).colorScheme.primary,
                        size: iconSize,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        '${S.of(context).Attendance_Record} ',
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
                  child: attendance.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                size: 56.w,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'لا توجد سجلات غياب',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: headerPaddingHorizontal,
                                vertical: headerPaddingVertical,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(
                                  borderRadius,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: headerIconSize,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          S.of(context).date,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: headerFontSize,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 60.w),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),

                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: attendance.length,
                                separatorBuilder: (_, _) =>
                                    Divider(height: 2.h, thickness: 0.3.w),
                                itemBuilder: (context, index) {
                                  final record = attendance[index];
                                  return _buildAttendanceItem(
                                    context,
                                    record,
                                    index,
                                    studentId,
                                  );
                                },
                              ),
                            ),
                          ],
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
                        " ${S.of(context).close}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: buttonFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildAttendanceItem(
  BuildContext context,
  AttendanceEntity record,
  int index,
  int? studentId,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final double itemPaddingHorizontal = 4.w;
  final double itemPaddingVertical = 4.h;
  final double dateIconSize = 11.w;
  final double dateFontSize = 14.sp;
  final double deleteIconSize = 20.w;
  final double borderRadius = 8.r;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: itemPaddingHorizontal,
      vertical: itemPaddingVertical,
    ),
    decoration: BoxDecoration(
      color: index.isEven
          ? (isDark
                ? Colors.grey.shade800.withOpacity(0.15)
                : Colors.grey.shade50)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(isDark ? 0.2 : 0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    size: dateIconSize,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    record.date ?? 'غير محدد',
                    style: TextStyle(
                      fontSize: dateFontSize,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 68.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  context.read<AttendanceBloc>().add(
                    DeleteAttendanceEvent(
                      localStudentNumber: studentId!,
                      date: record.date!,
                    ),
                  );
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: deleteIconSize,
                    color: Colors.red.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
