// lib/features/Teacher/ui/widget/TeacherSchoolCard .dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherSchoolCard extends StatelessWidget {
  final Schoolsentity school;
  final VoidCallback onTap;

  // ✅ حسابات القيم الثابتة خارج build
  final double cardPadding = 20.w;

  final double containerSize = 60.w;
  final double containerRadius = 16.r;
  final double iconSize = 32.w;
  final double titleFontSize = 20.sp;
  final double subtitleFontSize = 14.sp;
  final double gap = 16.w;
  final double circleSize = 120.w;
  TeacherSchoolCard({super.key, required this.school, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'school_${school.schoolId}',
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -30.h,
                  right: -30.w,
                  child: Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Row(
                    children: [
                      Container(
                        width: containerSize,
                        height: containerSize,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(containerRadius),
                        ),
                        child: Icon(
                          Icons.school_rounded,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: gap),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              school.schoolName ?? S.of(context).unknown_school,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${school.subjects?.length ?? 0} ${S.of(context).subjects}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: subtitleFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white.withOpacity(0.8),
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
