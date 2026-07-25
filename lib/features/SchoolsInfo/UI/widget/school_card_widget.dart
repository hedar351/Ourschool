// lib/features/SchoolsInfo/presentation/widgets/school_card_widget.dart

import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SchoolInfoEntity.dart';

import '../page/school_teachers_screen.dart';

class SchoolCardWidget extends StatelessWidget {
  final SchoolInfoEntity school;

  const SchoolCardWidget({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final teachers = school.teacherInfo ?? [];
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchoolTeachersScreen(school: school),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====== رأس البطاقة ======
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.school,
                      color: theme.colorScheme.onPrimary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          school.name ?? 'مدرسة غير معروفة',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.verified,
                              size: 14,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              school.typename ?? 'مدرسة',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 6,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: theme.colorScheme.primary.withOpacity(0.1),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Text(
                  //     teachers.length.toString(),
                  //     style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold,
                  //       color: theme.colorScheme.primary,
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              const SizedBox(height: 14),

              // ====== معلومات المدرسة ======
              if (school.address != null && school.address!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          school.address!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              if (school.phone != null && school.phone!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        school.phone!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
