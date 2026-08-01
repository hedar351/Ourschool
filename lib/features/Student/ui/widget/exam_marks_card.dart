// // lib/features/Student/presentation/widgets/exam_marks_card.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:school/features/Student/ui/utils/progress_color.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';
// import 'package:school/generated/l10n.dart';

// class ExamMarksCard extends StatelessWidget {
//   final List<SemesterMarks> semesterMarks1;
//   final List<SemesterMarks> semesterMarks2;

//   const ExamMarksCard({
//     super.key,
//     required this.semesterMarks1,
//     required this.semesterMarks2,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               ' ${S.of(context).marks_title}',
//               style: theme.textTheme.titleLarge?.copyWith(
//                 color: theme.colorScheme.primary,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.sp,
//               ),
//             ),
//             SizedBox(height: 16.h),
//             _buildSemesterSection(
//               context,
//               S.of(context).semester_1,
//               semesterMarks1,
//             ),
//             SizedBox(height: 20.h),
//             _buildSemesterSection(
//               context,
//               S.of(context).semester_2,
//               semesterMarks2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChip(BuildContext context, String label) {
//     return Chip(
//       label: Text(label, style: TextStyle(fontSize: 11.sp)),
//       padding: EdgeInsets.zero,
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       visualDensity: VisualDensity.compact,
//     );
//   }

//   Widget _buildMarkRow(BuildContext context, SemesterMarks mark) {
//     final theme = Theme.of(context);
//     final total = mark.total ?? 0;
//     final maxTotal = 100.0;
//     final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               mark.subjectName ?? S.of(context).unknown_name,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14.sp,
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   total.toStringAsFixed(1),
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: getProgressColor(percent / 100),
//                     fontSize: 14.sp,
//                   ),
//                 ),
//                 Text(
//                   ' / $maxTotal',
//                   style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
//                 ),
//                 SizedBox(width: 8.w),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.r),
//                     color: Colors.blue.withOpacity(0.1),
//                   ),
//                   child: Text(
//                     '${percent.toStringAsFixed(0)}%',
//                     style: TextStyle(
//                       fontSize: 11.sp,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 4.h),
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: percent / 100),
//           duration: const Duration(milliseconds: 900),
//           curve: Curves.easeInOut,
//           builder: (context, value, child) {
//             return LinearProgressIndicator(
//               value: value,
//               backgroundColor: Colors.grey.shade200,
//               color: getProgressColor(value),
//               minHeight: 8.h,
//             );
//           },
//         ),
//         if (mark.quiz1 != null || mark.homework != null)
//           Padding(
//             padding: EdgeInsets.only(top: 4.h),
//             child: Wrap(
//               spacing: 8.w,
//               children: [
//                 if (mark.quiz1 != null)
//                   _buildChip(context, '${S.of(context).quiz1}: ${mark.quiz1}'),
//                 if (mark.quiz2 != null)
//                   _buildChip(context, '${S.of(context).quiz2}: ${mark.quiz2}'),
//                 if (mark.homework != null)
//                   _buildChip(
//                     context,
//                     '${S.of(context).homework}: ${mark.homework}',
//                   ),
//                 if (mark.finalExam != null)
//                   _buildChip(
//                     context,
//                     '${S.of(context).final_exam}: ${mark.finalExam}',
//                   ),
//               ],
//             ),
//           ),
//         Divider(height: 16.h),
//       ],
//     );
//   }

//   Widget _buildSemesterSection(
//     BuildContext context,
//     String title,
//     List<SemesterMarks> marks,
//   ) {
//     final theme = Theme.of(context);
//     if (marks.isEmpty) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: 8.h),
//         child: Text(
//           S.of(context).There_are_no_Marks_at_the_moment,
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: theme.hintColor,
//             fontSize: 14.sp,
//           ),
//         ),
//       );
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w600,
//             fontSize: 16.sp,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         ...marks.map(
//           (mark) => Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.h),
//             child: _buildMarkRow(context, mark),
//           ),
//         ),
//       ],
//     );
//   }
// }
// lib/features/Student/presentation/widgets/exam_marks_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/ui/utils/progress_color.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';
import 'package:school/generated/l10n.dart';

class ExamMarksCard extends StatelessWidget {
  final List<SemesterMarks> semesterMarks1;
  final List<SemesterMarks> semesterMarks2;

  const ExamMarksCard({
    super.key,
    required this.semesterMarks1,
    required this.semesterMarks2,
  });

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
              ' 📚 ${S.of(context).marks_title}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 16.h),
            _buildSemesterSection(
              context,
              S.of(context).semester_1,
              semesterMarks1,
            ),
            SizedBox(height: 20.h),

            Divider(height: 24.h),
            SizedBox(height: 20.h),
            _buildSemesterSection(
              context,
              S.of(context).semester_2,
              semesterMarks2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Chip(
      label: Text(label, style: TextStyle(fontSize: 11.sp)),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildMarkRow(BuildContext context, SemesterMarks mark) {
    final theme = Theme.of(context);
    final total = mark.total ?? 0;
    final maxTotal = 100.0;
    final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${mark.subjectName} /",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              total.toStringAsFixed(1),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: getProgressColor(percent / 100),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        if (mark.quiz1 != null || mark.homework != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Wrap(
              spacing: 2.w,
              children: [
                if (mark.quiz1 != null)
                  _buildChip(context, '${S.of(context).quiz1}: ${mark.quiz1}'),
                if (mark.quiz2 != null)
                  _buildChip(context, '${S.of(context).quiz2}: ${mark.quiz2}'),
                if (mark.homework != null)
                  _buildChip(
                    context,
                    '${S.of(context).homework}: ${mark.homework}',
                  ),
                if (mark.finalExam != null)
                  _buildChip(
                    context,
                    '${S.of(context).final_exam}: ${mark.finalExam}',
                  ),
              ],
            ),
          ),
        SizedBox(height: 10.h),
        // Divider(height: 16.h),
      ],
    );
  }

  Widget _buildSemesterSection(
    BuildContext context,
    String title,
    List<SemesterMarks> marks,
  ) {
    final theme = Theme.of(context);
    if (marks.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          S.of(context).There_are_no_Marks_at_the_moment,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor,
            fontSize: 14.sp,
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 8.h),
        ...marks.map(
          (mark) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: _buildMarkRow(context, mark),
          ),
        ),
      ],
    );
  }
}
