import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_MarkEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_SubjectsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';
import 'package:school/features/Counselor/domain/Entities/attendanceEntity/attendanceEntity.dart';

class CounselorStudentfullprofile extends Equatable {
  final String? message;
  final Studententity? studententity;
  final List<CounselorSubjectsentity>? subjectsentity;
  final List<CounselorMarkentity>? makrentity;
  final List<CounselorWarningsentity>? warningsentity;
  final List<AttendanceEntity>? attendance;
  const CounselorStudentfullprofile({
    required this.message,
    required this.studententity,
    required this.subjectsentity,
    required this.makrentity,
    required this.warningsentity,
    required this.attendance,
  });
  @override
  List<Object?> get props => [
    message,
    studententity,
    subjectsentity,
    makrentity,
    warningsentity,
    attendance,
  ];
}
