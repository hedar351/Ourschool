// lib/features/SchoolsInfo/presentation/widgets/section_chip_widget.dart

import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SectionsEntity.dart';

class SectionChipWidget extends StatelessWidget {
  final SectionsEntity section;
  final bool large;

  const SectionChipWidget({
    super.key,
    required this.section,
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
          colors: [Colors.green.shade100, Colors.green.shade50],
        ),
        borderRadius: BorderRadius.circular(large ? 16 : 12),
        border: Border.all(color: Colors.green.shade200, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.class_outlined,
            size: large ? 18 : 14,
            color: Colors.green.shade800,
          ),
          const SizedBox(width: 6),
          Text(
            _buildSectionText(),
            style: TextStyle(
              fontSize: large ? 14 : 12,
              fontWeight: FontWeight.w500,
              color: Colors.green.shade800,
            ),
          ),
        ],
      ),
    );
  }

  String _buildSectionText() {
    final grade = section.gradeName ?? '';
    final sectionName = section.sectionName ?? '';

    if (grade.isNotEmpty && sectionName.isNotEmpty) {
      return '$grade - $sectionName';
    } else if (grade.isNotEmpty) {
      return grade;
    } else if (sectionName.isNotEmpty) {
      return sectionName;
    }
    return 'شعبة غير معروفة';
  }
}
