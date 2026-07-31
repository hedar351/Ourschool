// lib/features/Counselor/UI/widget/SubjectCard.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_SubjectsEntity.dart';
import 'package:school/generated/l10n.dart';

class SubjectCard extends StatelessWidget {
  final CounselorSubjectsentity subject;

  // ✅ حسابات القيم الثابتة خارج build
  final double _cardMarginBottom = 12.h;

  final double _cardPadding = 16.w;
  final double _cardRadius = 20.r;
  final double _elevation = 4;
  final double _subjectFontSize = 17.sp;
  final double _iconSize = 16.w;
  final double _gap = 6.h;
  final double _teacherFontSize = 14.sp;
  final double _iconGap = 6.w;
  SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _elevation,
      margin: EdgeInsets.only(bottom: _cardMarginBottom),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(_cardPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.subjectName ?? S.of(context).subject,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _subjectFontSize,
                    ),
                  ),
                  SizedBox(height: _gap),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: _iconSize,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: _iconGap),
                      Text(
                        '${S.of(context).teacher_prefix} ${subject.teacherName ?? S.of(context).not_specified}',
                        style: TextStyle(
                          fontSize: _teacherFontSize,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
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
