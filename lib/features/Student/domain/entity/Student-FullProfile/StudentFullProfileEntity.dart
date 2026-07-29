import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/ActivitiesEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StatisticsEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentInfoEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';

class Studentfullprofileentity extends Equatable {
  final String? message;
  final StudentInfoEntity? studentInfo;
  final StatisticsEntity? statistics;
  final List<SemesterMarks>? semesterMarks1;
  final List<SemesterMarks>? semesterMark2;
  final List<AttendanceEntity>? attendance;
  final String? scheduleImage;
  final List<ActivitiesEntity>? activities;
  final List<CounselorWarningsentity>? warnings;
  final List<SummonsEntity>? summons;

  const Studentfullprofileentity({
    required this.message,
    required this.studentInfo,
    required this.statistics,
    required this.semesterMarks1,
    required this.semesterMark2,
    required this.attendance,
    required this.scheduleImage,
    required this.activities,
    required this.warnings,
    required this.summons,
  });
  @override
  List<Object?> get props => [
    message,
    studentInfo,
    statistics,
    semesterMarks1,
    semesterMark2,
    attendance,
    scheduleImage,
    activities,
    warnings,
    summons,
  ];
}
