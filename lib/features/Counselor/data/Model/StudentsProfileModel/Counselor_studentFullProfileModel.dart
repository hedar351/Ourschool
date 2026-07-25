import 'package:hive/hive.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/studentModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_MarkModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_SubjectsModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_WarningsModel.dart';
import 'package:school/features/Counselor/data/Model/attendanceModel/attendanceModel.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';

part 'Counselor_studentFullProfileModel.g.dart';

@HiveType(typeId: 6)
class CounselorStudentFullProfileModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final Studentmodel? student;

  @HiveField(2)
  final List<CounselorSubjectModel>? subjects;

  @HiveField(3)
  final List<CounselorMarkModel>? marks;

  @HiveField(4)
  final List<CounselorWarningModel>? warnings;
  @HiveField(5)
  final List<Attendancemodel>? attendance;
  CounselorStudentFullProfileModel({
    required this.message,
    required this.student,
    required this.subjects,
    required this.marks,
    required this.warnings,
    required this.attendance,
  });

  factory CounselorStudentFullProfileModel.fromEntity(
    CounselorStudentfullprofile entity,
  ) {
    return CounselorStudentFullProfileModel(
      message: entity.message,
      student: entity.studententity != null
          ? Studentmodel.fromEntity(entity.studententity!)
          : null,
      subjects: entity.subjectsentity
          ?.map((e) => CounselorSubjectModel.fromEntity(e))
          .toList(),
      marks: entity.makrentity
          ?.map((e) => CounselorMarkModel.fromEntity(e))
          .toList(),
      warnings: entity.warningsentity
          ?.map((e) => CounselorWarningModel.fromEntity(e))
          .toList(),
      attendance: entity.attendance
          ?.map((e) => Attendancemodel.fromEntity(e))
          .toList(),
    );
  }

  factory CounselorStudentFullProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return CounselorStudentFullProfileModel(
      message: json['message'] as String?,
      student: data['student'] != null
          ? Studentmodel.fromJson(data['student'])
          : null,
      subjects: (data['subjects'] as List? ?? [])
          .map((e) => CounselorSubjectModel.fromJson(e))
          .toList(),
      marks: (data['marks'] as List? ?? [])
          .map((e) => CounselorMarkModel.fromJson(e))
          .toList(),
      warnings: (data['warnings'] as List? ?? [])
          .map((e) => CounselorWarningModel.fromJson(e))
          .toList(),
      attendance: (data['attendance'] as List? ?? [])
          .map((e) => Attendancemodel.fromJson(e))
          .toList(),
    );
  }
  CounselorStudentfullprofile toEntity() {
    return CounselorStudentfullprofile(
      message: message,
      studententity: student?.toEntity(),
      subjectsentity: subjects?.map((e) => e.toEntity()).toList(),
      makrentity: marks?.map((e) => e.toEntity()).toList() ?? [],
      warningsentity: warnings?.map((e) => e.toEntity()).toList(),
      attendance: attendance?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': {
        'student': student?.toJson(),
        'subjects': subjects?.map((e) => e.toJson()).toList(),
        'marks': marks?.map((e) => e.toJson()).toList(),
        'warnings': warnings?.map((e) => e.toJson()).toList(),
        "attendance": attendance?.map((e) => e.toJson()).toList(),
      },
    };
  }
}
