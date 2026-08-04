// lib/features/Student/presentation/widgets/academic_info_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentInfoEntity.dart';
import 'package:school/generated/l10n.dart';

class AcademicInfoCard extends StatelessWidget {
  final StudentInfoEntity studentInfo;

  const AcademicInfoCard({super.key, required this.studentInfo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' ${S.of(context).academic_year_info}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),

            Divider(height: 24.h),
            _buildInfoRow(
              context,
              S.of(context).fullName,
              studentInfo.name ?? S.of(context).unknown_name,
            ),
            _buildInfoRow(
              context,
              S.of(context).class_name,
              '${studentInfo.gradeName ?? ''} - ${studentInfo.sectionName ?? ''}',
            ),
            _buildInfoRow(
              context,
              S.of(context).academic_year,
              '${studentInfo.academicYear ?? ''}',
            ),
            _buildInfoRow(
              context,
              S.of(context).guardianName,
              studentInfo.guardianName ?? S.of(context).not_specified,
            ),
            _buildInfoRow(
              context,
              S.of(context).phone,
              studentInfo.guardianPhone ?? '-',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
