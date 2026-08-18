import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/ActivitiesEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/LoansEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/MarksStatisticsEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StatisticsEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentInfoEntity.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';

class Studentfullprofileentity extends Equatable {
  final String? message;
  final StudentInfoEntity? studentInfo;
  final MarksStatisticsEntity? marksstatistics;
  final List<SemesterMarks>? semesterMarks1;
  final List<SemesterMarks>? semesterMark2;
  final double? semester1Average;
  final double? semester2Average;
  final double? finalAverage;
  final List<AttendanceEntity>? attendance;
  final String? scheduleImage;
  final List<Loansentity>? loans;
  final List<ActivitiesEntity>? activities;
  final List<CounselorWarningsentity>? warnings;
  final List<SummonsEntity>? summons;
  final StatisticsEntity statistics;
  const Studentfullprofileentity({
    required this.message,
    required this.studentInfo,
    required this.marksstatistics,
    required this.semesterMarks1,
    required this.semesterMark2,
    required this.attendance,
    required this.scheduleImage,
    required this.activities,
    required this.warnings,
    required this.summons,
    required this.loans,
    required this.semester1Average,
    required this.semester2Average,
    required this.finalAverage,
    required this.statistics,
  });
  @override
  List<Object?> get props => [
    message,
    studentInfo,
    marksstatistics,
    semesterMarks1,
    semesterMark2,
    attendance,
    scheduleImage,
    activities,
    warnings,
    summons,
    loans,
    semester1Average,
    semester2Average,
    finalAverage,
    statistics,
  ];
}
