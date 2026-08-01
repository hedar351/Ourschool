// lib/features/Student/presentation/widgets/empty_error_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/ui/bloc/student_bloc.dart';
import 'package:school/generated/l10n.dart';

Widget buildEmptyState(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.person_off, size: 80.w, color: Colors.grey),
        SizedBox(height: 16.h),
        Text(
          S.of(context).There_are_no_bulletins_at_the_moment,
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextButton.icon(
          onPressed: () =>
              context.read<StudentBloc>().add(RefreshStudentProfileEvent()),
          icon: Icon(Icons.refresh, size: 20.w),
          label: Text(S.of(context).retry),
        ),
      ],
    ),
  );
}

Widget buildErrorState(BuildContext context, String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 80.w, color: Colors.red),
        SizedBox(height: 16.h),
        Text(message, style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 8.h),
        TextButton.icon(
          onPressed: () =>
              context.read<StudentBloc>().add(RefreshStudentProfileEvent()),
          icon: Icon(Icons.refresh, size: 20.w),
          label: Text(S.of(context).retry),
        ),
      ],
    ),
  );
}
