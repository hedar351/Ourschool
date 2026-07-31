// lib/features/Teacher/ui/widget/teacher_student_info_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
import 'package:school/generated/l10n.dart';

class TeacherStudentInfoCard extends StatelessWidget {
  final Teacherstudentprofileentity? profile;

  // ✅ حسابات القيم الثابتة خارج build
  final double cardPadding = 16.w;

  final double avatarSize = 60.w;
  final double avatarFontSize = 24.sp;
  final double nameFontSize = 20.sp;
  final double infoLabelFontSize = 12.sp;
  final double infoValueFontSize = 14.sp;
  final double iconSize = 14.w;
  final double gap = 16.w;
  TeacherStudentInfoCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      color: isDark ? Colors.grey.shade800.withOpacity(0.6) : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.7),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      profile?.name?.isNotEmpty == true
                          ? profile!.name![0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: avatarFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile?.name ?? 'غير معروف',
                        style: TextStyle(
                          fontSize: nameFontSize,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: theme.dividerColor),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    context,
                    label: S.of(context).guardianName,
                    value: profile?.guardianName ?? 'غير محدد',
                    icon: Icons.person_outline,
                  ),
                ),
                SizedBox(width: gap),
                Expanded(
                  child: _buildInfoItem(
                    context,
                    label: S.of(context).phone,
                    value: profile?.guardianPhone ?? 'غير محدد',
                    icon: Icons.phone_outlined,
                  ),
                ),
              ],
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
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: iconSize, color: theme.colorScheme.outline),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: infoLabelFontSize,
                color: theme.colorScheme.outline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: infoValueFontSize,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
