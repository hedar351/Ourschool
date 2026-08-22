// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/SectionEntity.dart';
// import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
// import 'package:school/features/Teacher/ui/page/teacher_students_list_screen.dart';
// import 'package:school/generated/l10n.dart';

// class TeacherSectionsScreen extends StatelessWidget {
//   final Subjectentity subject;
//   final Schoolsentity school;

//   const TeacherSectionsScreen({
//     super.key,
//     required this.subject,
//     required this.school,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<_SectionWithGrade> sections = [];
//     for (var grade in subject.grades) {
//       for (var section in grade.sections ?? []) {
//         sections.add(_SectionWithGrade(section: section, grade: grade));
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           '${school.schoolName ?? ''} - ${subject.subjectName ?? ''}',
//           style: TextStyle(fontSize: 18.sp),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: sections.isEmpty
//           ? Center(
//               child: Text(
//                 " S.of(context).no_sections",
//                 style: TextStyle(fontSize: 16.sp),
//               ),
//             )
//           : ListView.builder(
//               padding: EdgeInsets.all(16.w),
//               itemCount: sections.length,
//               itemBuilder: (context, index) {
//                 final item = sections[index];
//                 return _buildSectionCard(context, item);
//               },
//             ),
//     );
//   }

//   Widget _buildSectionCard(BuildContext context, _SectionWithGrade item) {
//     final theme = Theme.of(context);
//     final section = item.section;
//     final grade = item.grade;

//     return Card(
//       margin: EdgeInsets.only(bottom: 12.h),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => TeacherStudentsListScreen(
//                 localGradeNumber: grade.localGradeNumber ?? 0,
//                 localSectionNumber: section.localSectionNumber ?? 0,
//                 localSubjectId: subject.localSubjectId ?? 0,
//                 gradeName: grade.name ?? '',
//                 sectionName: section.name ?? '',
//                 subjectName: subject.subjectName ?? '',
//                 school: school,
//               ),
//             ),
//           );
//         },
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Row(
//             children: [
//               Container(
//                 width: 50.w,
//                 height: 50.w,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.secondary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Icon(
//                   Icons.group_outlined,
//                   color: theme.colorScheme.secondary,
//                   size: 28.w,
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       grade.name ?? S.of(context).Sections,
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       section.name ?? '',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         // color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(Icons.chevron_right, color: theme.colorScheme.secondary),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SectionWithGrade {
//   final Sectionentity section;
//   final Gradeentity grade;
//   _SectionWithGrade({required this.section, required this.grade});
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school/core/injection.dart' as di;
import 'package:school/core/widget/showImageViewer.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/SectionEntity.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherScheduleImageBloc/schedule_image_bloc.dart';
import 'package:school/features/Teacher/ui/page/teacher_students_list_screen.dart';
import 'package:school/generated/l10n.dart';

class TeacherSectionsScreen extends StatelessWidget {
  final Subjectentity subject;
  final Schoolsentity school;

  const TeacherSectionsScreen({
    super.key,
    required this.subject,
    required this.school,
  });

  @override
  Widget build(BuildContext context) {
    List<_SectionWithGrade> sections = [];
    for (var grade in subject.grades) {
      for (var section in grade.sections ?? []) {
        sections.add(_SectionWithGrade(section: section, grade: grade));
      }
    }

    return BlocProvider(
      create: (context) => di.sl<ScheduleImageBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${school.schoolName ?? ''} - ${subject.subjectName ?? ''}',
                style: TextStyle(fontSize: 18.sp),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<ScheduleImageBloc>().add(
                  GetTeacherScheduleImageEvent(schoolId: school.schoolId ?? 0),
                );
              },
              backgroundColor: Colors.green,
              tooltip: 'عرض جدول الحصص',
              child: Icon(Icons.image, size: 24.w, color: Colors.white),
            ),
            body: BlocListener<ScheduleImageBloc, ScheduleImageState>(
              listener: (context, state) {
                if (state is ScheduleImageLoaded) {
                  showImageViewer(context, state.scheduleImage.imageUrl);
                } else if (state is ScheduleImageError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: sections.isEmpty
                  ? Center(
                      child: Text(
                        "   S.of(context).no_sections",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: sections.length,
                      itemBuilder: (context, index) {
                        final item = sections[index];
                        return _buildSectionCard(
                          context,
                          item,
                          subject, // ✅ تمرير subject
                          school, // ✅ تمرير school
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    _SectionWithGrade item,
    Subjectentity subject,
    Schoolsentity school,
  ) {
    final theme = Theme.of(context);
    final section = item.section;
    final grade = item.grade;

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeacherStudentsListScreen(
                localGradeNumber: grade.localGradeNumber ?? 0,
                localSectionNumber: section.localSectionNumber ?? 0,
                localSubjectId: subject.localSubjectId ?? 0,
                gradeName: grade.name ?? '',
                sectionName: section.name ?? '',
                subjectName: subject.subjectName ?? '',
                school: school,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.group_outlined,
                  color: theme.colorScheme.secondary,
                  size: 28.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      grade.name ?? S.of(context).Sections,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(section.name ?? '', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.secondary),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionWithGrade {
  final Sectionentity section;
  final Gradeentity grade;
  _SectionWithGrade({required this.section, required this.grade});
}
