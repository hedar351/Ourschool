// lib/features/Counselor/UI/widget/StudentInfoCard.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';
import 'package:school/generated/l10n.dart';

class StudentInfoCard extends StatelessWidget {
  final Studententity? student;

  // ✅ حسابات القيم الثابتة خارج build
  final double _cardPadding = 20.w;

  final double _avatarSize = 70.w;
  final double _avatarRadius = 20.r;
  final double _gap = 16.w;
  final double _nameFontSize = 20.sp;
  final double _infoFontSize = 14.sp;
  final double _cardRadius = 24.r;
  final double _elevation = 6;
  StudentInfoCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: _elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(_cardPadding),
        child: Row(
          children: [
            Container(
              width: _avatarSize,
              height: _avatarSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(_avatarRadius),
              ),
              child: Center(
                child: Text(
                  student?.name?.isNotEmpty == true ? student!.name![0] : '?',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: _gap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student?.name ?? S.of(context).unknown_name,
                    style: TextStyle(
                      fontSize: _nameFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${S.of(context).guardianName}: ${student?.guardianName ?? S.of(context).not_specified}',
                    style: TextStyle(
                      fontSize: _infoFontSize,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${S.of(context).phone}: ${student?.guardianPhone ?? S.of(context).not_specified}',
                    style: TextStyle(
                      fontSize: _infoFontSize,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
