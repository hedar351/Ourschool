// lib/features/SchoolsInfo/presentation/widgets/subject_chip_widget.dart

import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SubjectsEntity.dart';

class SubjectChipWidget extends StatelessWidget {
  final SubjectsEntity subject;
  final bool large;

  const SubjectChipWidget({
    super.key,
    required this.subject,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 16 : 10,
        vertical: large ? 10 : 6,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(large ? 16 : 12),
        border: Border.all(color: Colors.blue.shade200, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.menu_book,
            size: large ? 18 : 14,
            color: Colors.blue.shade800,
          ),
          const SizedBox(width: 6),
          Text(
            subject.subjectName ?? 'مادة غير معروفة',
            style: TextStyle(
              fontSize: large ? 14 : 12,
              fontWeight: FontWeight.w500,
              color: Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
