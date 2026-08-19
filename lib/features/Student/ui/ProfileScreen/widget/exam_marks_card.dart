import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Student/ui/ProfileScreen/utils/progress_color.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';
import 'package:school/generated/l10n.dart';

class ExamMarksCard extends StatefulWidget {
  final List<SemesterMarks> semesterMarks1;
  final List<SemesterMarks> semesterMarks2;

  const ExamMarksCard({
    super.key,
    required this.semesterMarks1,
    required this.semesterMarks2,
  });

  @override
  State<ExamMarksCard> createState() => _ExamMarksCardState();
}

class _ExamMarksCardState extends State<ExamMarksCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // العنوان الرئيسي
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.auto_graph_rounded,
                    color: colorScheme.primary,
                    size: 22.w,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  S.of(context).marks_title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // شريط التنقل بين الفصول (TabBar)
            Container(
              height: 42.h,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                  0.4,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: colorScheme.onPrimary,
                unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
                tabs: [
                  Tab(text: S.of(context).semester_1),
                  Tab(text: S.of(context).semester_2),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // عرض علامات الفصل المختار
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, _) {
                final isFirstSemester = _tabController.index == 0;
                final currentMarks = isFirstSemester
                    ? widget.semesterMarks1
                    : widget.semesterMarks2;

                return _buildSemesterSection(context, currentMarks);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildDetailBadge(
    BuildContext context,
    String label,
    String value,
    String maxvalue, {
    bool isHighlight = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isHighlight
            ? colorScheme.primary.withOpacity(0.12)
            : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.r),
        border: isHighlight
            ? Border.all(
                color: colorScheme.primary.withOpacity(0.3),
                width: 1.w,
              )
            : null,
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 11.sp,
            color: isHighlight
                ? colorScheme.primary
                : theme.textTheme.bodyMedium?.color,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "$maxvalue/$value",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterSection(
    BuildContext context,
    List<SemesterMarks> marks,
  ) {
    final theme = Theme.of(context);

    if (marks.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 28.h),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.assignment_late_outlined,
                size: 42.w,
                color: theme.hintColor.withOpacity(0.4),
              ),
              SizedBox(height: 10.h),
              Text(
                S.of(context).There_are_no_Marks_at_the_moment,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: marks.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return _buildSubjectCard(context, marks[index]);
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, SemesterMarks mark) {
    final theme = Theme.of(context);
    final total = mark.total ?? 0;
    const maxTotal = 100.0;
    final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0.0;
    final progressColor = getProgressColor(percent / 100);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: theme.dividerColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اسم المادة والدرجة الكلية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  mark.subjectName ?? S.of(context).unknown_name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                total.toStringAsFixed(1),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          if (mark.oral != null ||
              mark.quiz1 != null ||
              mark.quiz2 != null ||
              mark.homework != null ||
              mark.finalExam != null) ...[
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: [
                if (mark.oral != null)
                  _buildDetailBadge(
                    context,
                    S.of(context).oral,
                    mark.oral.toString(),
                    mark.maxOral.toString(),
                  ),
                if (mark.quiz1 != null)
                  _buildDetailBadge(
                    context,
                    S.of(context).quiz1,
                    mark.quiz1.toString(),
                    mark.maxQuiz1.toString(),
                  ),
                if (mark.quiz2 != null)
                  _buildDetailBadge(
                    context,
                    S.of(context).quiz2,
                    mark.quiz2.toString(),
                    mark.maxQuiz2.toString(),
                  ),
                if (mark.homework != null)
                  _buildDetailBadge(
                    context,
                    S.of(context).homework,
                    mark.homework.toString(),
                    mark.maxHomework.toString(),
                  ),
                if (mark.finalExam != null)
                  _buildDetailBadge(
                    context,
                    S.of(context).final_exam,
                    mark.finalExam.toString(),
                    mark.maxFinalExam.toString(),
                    isHighlight: true,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
