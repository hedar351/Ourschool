// lib/features/SchoolsInfo/presentation/widgets/teacher_details_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/TeacherInfoEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherDetailsWidget extends StatelessWidget {
  final TeacherInfoEntity teacher;
  final String schoolName;

  final double cardPadding = 24.w;

  final double avatarSize = 100.w;
  final double avatarFontSize = 40.sp;
  final double nameFontSize = 22.sp;
  final double schoolChipPaddingHorizontal = 16.w;
  final double schoolChipPaddingVertical = 6.h;
  final double schoolChipRadius = 20.r;
  final double contactButtonPaddingHorizontal = 20.w;
  final double contactButtonPaddingVertical = 10.h;
  final double contactButtonRadius = 12.r;
  final double contactIconSize = 18.w;
  final double infoLabelFontSize = 11.sp;
  final double infoValueFontSize = 14.sp;
  final double sectionTitleFontSize = 18.sp;
  final double sectionIconSize = 22.w;
  final double sectionHeaderHeight = 24.h;
  final double sectionHeaderGap = 12.w;
  final double sectionHeaderIconGap = 10.w;
  final double sectionItemPaddingHorizontal = 16.w;
  final double sectionItemPaddingVertical = 12.h;
  final double sectionItemGap = 8.h;
  final double sectionItemRadius = 12.r;
  final double borderWidth = 0.5.w;
  final double subjectPaddingHorizontal = 16.w;
  final double subjectPaddingVertical = 10.h;
  final double subjectRadius = 14.r;
  final double subjectSpacing = 10.w;
  final double subjectRunSpacing = 10.h;
  final double subjectIconSize = 18.w;
  final double subjectFontSize = 14.sp;
  TeacherDetailsWidget({
    super.key,
    required this.teacher,
    required this.schoolName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = teacher.sections ?? [];
    final subjects = teacher.subjects ?? [];
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.6),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      teacher.name?.isNotEmpty == true
                          ? teacher.name![0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: avatarFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                Text(
                  teacher.name ?? 'معلم غير معروف',
                  style: TextStyle(
                    fontSize: nameFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: schoolChipPaddingHorizontal,
                    vertical: schoolChipPaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(schoolChipRadius),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.school,
                        size: 16.w,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        schoolName,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContactButton(
                      context,
                      icon: Icons.phone_outlined,
                      label: S.of(context).call,
                      onTap: () {},
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                Divider(color: theme.dividerColor),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        context,
                        label: S.of(context).fullName,
                        value: teacher.name ?? 'غير معروف',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        context,
                        label: S.of(context).phone,
                        value: teacher.phone ?? 'غير متوفر',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 24.h),

        if (sections.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            title: S.of(context).classesTaught,
            icon: Icons.class_outlined,
            color: Colors.green,
          ),
          SizedBox(height: 12.h),
          ...sections.map(
            (section) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: sectionItemPaddingHorizontal,
                vertical: sectionItemPaddingVertical,
              ),
              margin: EdgeInsets.only(bottom: sectionItemGap),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade800.withOpacity(0.3)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(sectionItemRadius),
                border: Border.all(
                  color: isDark
                      ? Colors.grey.shade700.withOpacity(0.3)
                      : Colors.grey.shade200,
                  width: borderWidth,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.class_outlined,
                    size: 20.w,
                    color: Colors.green.shade600,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '${section.gradeName ?? ''} - ${section.sectionName ?? ''}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],

        if (subjects.isNotEmpty) ...[
          _buildSectionHeader(
            context,
            title: S.of(context).subjectsTaught,
            icon: Icons.book,
            color: Colors.blue,
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: subjectSpacing,
            runSpacing: subjectRunSpacing,
            children: subjects.map((subject) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: subjectPaddingHorizontal,
                  vertical: subjectPaddingVertical,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(
                        isDark ? 0.3 : 0.12,
                      ),
                      theme.colorScheme.primary.withOpacity(
                        isDark ? 0.15 : 0.05,
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(subjectRadius),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(
                      isDark ? 0.3 : 0.15,
                    ),
                    width: borderWidth,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu_book,
                      size: subjectIconSize,
                      color: isDark
                          ? theme.colorScheme.primary.withOpacity(0.9)
                          : theme.colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      subject.subjectName ?? 'مادة غير معروفة',
                      style: TextStyle(
                        fontSize: subjectFontSize,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? theme.colorScheme.primary.withOpacity(0.9)
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(contactButtonRadius),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: contactButtonPaddingHorizontal,
          vertical: contactButtonPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(contactButtonRadius),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.2),
            width: 0.5.w,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: contactIconSize, color: theme.colorScheme.primary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: infoLabelFontSize,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: infoValueFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: sectionHeaderHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: sectionHeaderGap),
        Icon(icon, color: color, size: sectionIconSize),
        SizedBox(width: sectionHeaderIconGap),
        Text(
          title,
          style: TextStyle(
            fontSize: sectionTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
