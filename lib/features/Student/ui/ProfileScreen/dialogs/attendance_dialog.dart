import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/features/Student/ui/ProfileScreen/utils/date_formatter.dart';
import 'package:school/generated/l10n.dart';

class AttendanceDialog extends StatelessWidget {
  final List<AttendanceEntity> attendances;

  const AttendanceDialog({super.key, required this.attendances});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (attendances.isEmpty) {
      return _emptyDialog(context);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      elevation: 0,
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
        constraints: BoxConstraints(maxHeight: 500.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---- مؤشر السحب (للدلالة على قابلية التمرير) ----
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),

            // ---- العنوان مع أيقونة ----
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.red,
                    size: 22.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  S.of(context).Attendance_Record,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: attendances.length,
                separatorBuilder: (_, _) =>
                    Divider(height: 12.h, color: Colors.grey.shade200),
                itemBuilder: (_, i) {
                  final item = attendances[i];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,

                    title: Text(
                      item.date != null
                          ? formatDate(DateTime.parse(item.date!))
                          : S.of(context).date_unknown,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),

            // ---- زر إغلاق ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  S.of(context).close,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Dialog فارغ ----
  Widget _emptyDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info_outline, size: 48.w, color: Colors.grey.shade400),
            SizedBox(height: 12.h),
            Text(
              S.of(context).There_are_no_bulletins_at_the_moment,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).Ok),
            ),
          ],
        ),
      ),
    );
  }
}
