// lib/features/SchoolsInfo/presentation/widgets/subject_chip_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SubjectsEntity.dart';

class SubjectChipWidget extends StatelessWidget {
  final SubjectsEntity subject;
  final bool large;

  // ✅ حسابات القيم الثابتة خارج build
  final double smallPaddingHorizontal = 10.w;

  final double smallPaddingVertical = 6.h;
  final double largePaddingHorizontal = 16.w;
  final double largePaddingVertical = 10.h;
  final double smallFontSize = 12.sp;
  final double largeFontSize = 14.sp;
  final double smallIconSize = 14.w;
  final double largeIconSize = 18.w;
  final double smallRadius = 12.r;
  final double largeRadius = 16.r;
  SubjectChipWidget({super.key, required this.subject, this.large = false});

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = large
        ? largePaddingHorizontal
        : smallPaddingHorizontal;
    final paddingVertical = large ? largePaddingVertical : smallPaddingVertical;
    final radius = large ? largeRadius : smallRadius;
    final iconSize = large ? largeIconSize : smallIconSize;
    final fontSize = large ? largeFontSize : smallFontSize;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.blue.shade200, width: 0.5.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book, size: iconSize, color: Colors.blue.shade800),
          SizedBox(width: 6.w),
          Text(
            subject.subjectName ?? 'مادة غير معروفة',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
