import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Student/ui/ProfileScreen/utils/date_formatter.dart';
import 'package:school/generated/l10n.dart';

class WarningsDialog extends StatelessWidget {
  final List<CounselorWarningsentity> warnings;

  const WarningsDialog({super.key, required this.warnings});

  @override
  Widget build(BuildContext context) {
    if (warnings.isEmpty) {
      return _emptyDialog(context, S.of(context).warnings_title);
    }
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange),
          SizedBox(width: 8.w),
          Text(S.of(context).warnings_title),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: warnings.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (_, i) {
            final item = warnings[i];
            return ListTile(
              title: Text(
                item.type ?? S.of(context).type_general,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.reason ?? ''),
                  Text(
                    item.createdAt != null
                        ? formatDate(DateTime.parse(item.createdAt!))
                        : S.of(context).date_unknown,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
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
