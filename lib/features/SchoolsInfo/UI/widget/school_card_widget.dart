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
    final teachers = school.teacherInfo ?? [];
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

              // const SizedBox(height: 14),

              // // ====== الإحصائيات ======
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: StatItemWidget(
              //         icon: Icons.people_outline,
              //         value: teachers.length.toString(),
              //         label: 'معلمين',
              //         color: theme.colorScheme.primary,
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Expanded(
              //       child: StatItemWidget(
              //         icon: Icons.school_outlined,
              //         value: '${teachers.length * 2}',
              //         label: 'طلاب',
              //         color: theme.colorScheme.secondary,
              //       ),
              //     ),

              //     // Expanded(
              //     //   child: StatItemWidget(
              //     //     icon: Icons.book_outlined,
              //     //     value: '${teachers.length * 3}',
              //     //     label: 'مواد',
              //     //     color: Colors.orange.shade600,
              //     //   ),
              //     // ),
              //   ],
              // ),

              // // const SizedBox(height: 16),

              // // ====== عرض المعلمين ======
              // if (teachers.isNotEmpty) ...[
              //   Row(
              //     children: [
              //       Container(
              //         width: 3,
              //         height: 18,
              //         decoration: BoxDecoration(
              //           color: theme.colorScheme.primary,
              //           borderRadius: BorderRadius.circular(2),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       Text(
              //         'الكادر التدريسي',
              //         style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w600,
              //           color: theme.colorScheme.onSurface,
              //         ),
              //       ),
              //       const Spacer(),
              //       InkWell(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) =>
              //                   SchoolTeachersScreen(school: school),
              //             ),
              //           );
              //         },
              //         child: Row(
              //           children: [
              //             Text(
              //               'عرض الكل',
              //               style: TextStyle(
              //                 fontSize: 12,
              //                 color: theme.colorScheme.primary,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Icon(
              //               Icons.chevron_right,
              //               size: 18,
              //               color: theme.colorScheme.primary,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              //   const SizedBox(height: 12),

              //   // ...teachers
              //   //     .take(2)
              //   //     .map(
              //   //       (teacher) => Padding(
              //   //         padding: const EdgeInsets.only(bottom: 8),
              //   //         child: TeacherCardWidget(
              //   //           teacher: teacher,
              //   //           onTap: () {
              //   //             Navigator.push(
              //   //               context,
              //   //               MaterialPageRoute(
              //   //                 builder: (context) => TeacherDetailsScreen(
              //   //                   teacher: teacher,
              //   //                   schoolName: school.name ?? '',
              //   //                 ),
              //   //               ),
              //   //             );
              //   //           },
              //   //         ),
              //   //       ),
              //   // ),
              //   if (teachers.length > 2)
              //     Padding(
              //       padding: const EdgeInsets.only(top: 4),
              //       child: Center(
              //         child: Text(
              //           '+${teachers.length - 2} معلمين آخرين',
              //           style: TextStyle(
              //             fontSize: 12,
              //             color: Colors.grey.shade500,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //     ),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
