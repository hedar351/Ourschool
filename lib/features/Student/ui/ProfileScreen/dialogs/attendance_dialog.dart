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
    if (attendances.isEmpty) {
      return _emptyDialog(context, S.of(context).Attendance);
    }
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.red),
          SizedBox(width: 4.w),
          Text(S.of(context).Attendance_Record),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: attendances.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (_, i) {
            final item = attendances[i];
            return ListTile(
              title: Text(
                item.date != null
                    ? formatDate(DateTime.parse(item.date!))
                    : S.of(context).date_unknown,
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).close),
        ),
      ],
    );
  }

  AlertDialog _emptyDialog(BuildContext context, String title) {
    return AlertDialog(
      title: Text(title),
      content: Text(S.of(context).There_are_no_bulletins_at_the_moment),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).Ok),
        ),
      ],
    );
  }
}
