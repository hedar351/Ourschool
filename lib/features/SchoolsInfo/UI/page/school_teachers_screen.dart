// // lib/features/SchoolsInfo/presentation/pages/school_teachers_screen.dart

// class SchoolTeachersScreen extends StatelessWidget {
//   final SchoolInfoEntity school;

//   const SchoolTeachersScreen({super.key, required this.school});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final teachers = school.teacherInfo ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('معلمي ${school.name ?? 'المدرسة'}'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: theme.scaffoldBackgroundColor,
//         foregroundColor: theme.colorScheme.onSurface,
//       ),
//       body: teachers.isEmpty
//           ? _buildEmptyState(context)
//           : _buildTeachersList(context, teachers),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.person_off_outlined,
//             size: 80,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'لا يوجد معلمين في هذه المدرسة',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTeachersList(
//     BuildContext context,
//     List<TeacherInfoEntity> teachers,
//   ) {
//     final theme = Theme.of(context);

//     return Column(
//       children: [
//         // ====== عدد المعلمين ======
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.people_outline,
//                 size: 20,
//                 color: theme.colorScheme.primary,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '${teachers.length} معلمين',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: theme.colorScheme.primary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Divider(height: 1),

//         // ====== قائمة المعلمين ======
//         Expanded(
//           child: ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: teachers.length,
//             separatorBuilder: (_, _) => const SizedBox(height: 12),
//             itemBuilder: (context, index) {
//               final teacher = teachers[index];
//               return TeacherCardWidget(
//                 teacher: teacher,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TeacherDetailsScreen(
//                         teacher: teacher,
//                         schoolName: school.name ?? '',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
// lib/features/SchoolsInfo/presentation/pages/school_teachers_screen.dart

import 'package:flutter/material.dart';
import 'package:school/features/SchoolsInfo/UI/page/teacher_details_screen.dart';
import 'package:school/features/SchoolsInfo/UI/widget/teacher_card_widget.dart';
import 'package:school/generated/l10n.dart';

import '../../domain/Entities/SchoolInfoEntity.dart';
import '../../domain/Entities/TeacherInfoEntity.dart';

class SchoolTeachersScreen extends StatelessWidget {
  final SchoolInfoEntity school;

  const SchoolTeachersScreen({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teachers = school.teacherInfo ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          school.name ?? '',
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: teachers.isEmpty
          ? _buildEmptyState(context)
          : _buildTeachersList(context, teachers),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 80,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).noTeachers,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachersList(
    BuildContext context,
    List<TeacherInfoEntity> teachers,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // ====== عدد المعلمين ======
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //   decoration: BoxDecoration(
        //     color: isDark
        //         ? Colors.grey.shade800.withOpacity(0.2)
        //         : Colors.grey.shade50,
        //     borderRadius: const BorderRadius.only(
        //       bottomLeft: Radius.circular(16),
        //       bottomRight: Radius.circular(16),
        //     ),
        //   ),
        //   child: Row(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: theme.colorScheme.primary.withOpacity(0.12),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Icon(
        //           Icons.people_outline,
        //           size: 20,
        //           color: theme.colorScheme.primary,
        //         ),
        //       ),
        //       const SizedBox(width: 12),
        //       Text(
        //         '${teachers.length} ${S.of(context).teachers}',
        //         style: TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w600,
        //           color: theme.colorScheme.primary,
        //         ),
        //       ),
        //       const Spacer(),
        //       Container(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 12,
        //           vertical: 4,
        //         ),
        //         decoration: BoxDecoration(
        //           color: theme.colorScheme.primary.withOpacity(0.08),
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: Text(
        //           '${teachers.length} ${S.of(context).teachersCount}',
        //           style: TextStyle(
        //             fontSize: 12,
        //             color: theme.colorScheme.outline,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const Divider(height: 1, color: Colors.transparent),

        // ====== قائمة المعلمين ======
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: teachers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return TeacherCardWidget(
                teacher: teacher,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherDetailsScreen(
                        teacher: teacher,
                        schoolName: school.name ?? '',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
