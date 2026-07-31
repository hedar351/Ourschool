// lib/features/SchoolsInfo/presentation/widgets/teacher_card_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/Entities/TeacherInfoEntity.dart';

class TeacherCardWidget extends StatelessWidget {
  final TeacherInfoEntity teacher;
  final VoidCallback? onTap;

  // ✅ حسابات القيم الثابتة خارج build
  final double containerPadding = 16.w;

  final double containerRadius = 14.r;
  final double borderWidth = 0.5.w;
  final double avatarSize = 56.w;
  final double avatarGap = 16.w;
  final double nameFontSize = 16.sp;
  final double subjectFontSize = 11.sp;
  final double subjectPaddingHorizontal = 10.w;
  final double subjectPaddingVertical = 4.h;
  final double subjectGap = 6.w;
  final double subjectRunSpacing = 4.h;
  final double chevronSize = 20.w;
  TeacherCardWidget({super.key, required this.teacher, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subjects = teacher.subjects ?? [];
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(containerRadius),
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
        highlightColor: theme.colorScheme.primary.withOpacity(0.05),
        child: Container(
          padding: EdgeInsets.all(containerPadding),
          decoration: BoxDecoration(
            color: isDark
                ? theme.colorScheme.surface.withOpacity(0.3)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(containerRadius),
            border: Border.all(
              color: isDark
                  ? theme.colorScheme.outline.withOpacity(0.3)
                  : theme.colorScheme.outline.withOpacity(0.15),
              width: borderWidth,
            ),
          ),
          child: Row(
            children: [
              // ====== الصورة الرمزية ======
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
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onPrimary,
                    size: 28.w,
                  ),
                ),
              ),
              SizedBox(width: avatarGap),

              // ====== معلومات المعلم ======
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.name ?? 'معلم غير معروف',
                      style: TextStyle(
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // ====== المواد ======
                    if (subjects.isNotEmpty) ...[
                      Wrap(
                        spacing: subjectGap,
                        runSpacing: subjectRunSpacing,
                        children: subjects.map((subject) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: subjectPaddingHorizontal,
                              vertical: subjectPaddingVertical,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(
                                isDark ? 0.2 : 0.12,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: theme.colorScheme.primary.withOpacity(
                                  isDark ? 0.3 : 0.15,
                                ),
                                width: 0.5.w,
                              ),
                            ),
                            child: Text(
                              subject.subjectName ?? '',
                              style: TextStyle(
                                fontSize: subjectFontSize,
                                color: isDark
                                    ? theme.colorScheme.primary.withOpacity(0.9)
                                    : theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ],
                ),
              ),

              // ====== أيقونة السهم ======
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.primary,
                  size: chevronSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
