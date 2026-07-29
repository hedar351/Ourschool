// lib/features/Student/data/model/Student-FullProfile/StudentFullProfileModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_WarningsModel.dart';
import 'package:school/features/Counselor/data/Model/attendanceModel/attendanceModel.dart';
import 'package:school/features/Student/data/Model/ActivitiesModel.dart';
import 'package:school/features/Student/data/Model/StatisticsModel.dart';
import 'package:school/features/Student/data/Model/StudentInfoModel.dart';
import 'package:school/features/Student/data/Model/SummonsModel.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';
import 'package:school/features/Teacher/data/Model/TeacherStudentProfileModel/SemesterMarksModel.dart';

part 'StudentFullProfileModel.g.dart';

@HiveType(typeId: 25)
class StudentFullProfileModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final StudentInfoModel? studentInfo;

  @HiveField(2)
  final StatisticsModel? statistics;

  @HiveField(3)
  final List<SemesterMarksModel>? semesterMarks1;

  @HiveField(4)
  final List<SemesterMarksModel>? semesterMark2;

  @HiveField(5)
  final List<Attendancemodel>? attendance;

  @HiveField(6)
  final String? scheduleImage;

  @HiveField(7)
  final List<ActivitiesModel>? activities;

  @HiveField(8)
  final List<CounselorWarningModel>? warnings;

  @HiveField(9)
  final List<SummonsModel>? summons;

  StudentFullProfileModel({
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

  // ----- fromEntity -----
  factory StudentFullProfileModel.fromEntity(Studentfullprofileentity entity) {
    return StudentFullProfileModel(
      message: entity.message,
      studentInfo: entity.studentInfo != null
          ? StudentInfoModel.fromEntity(entity.studentInfo!)
          : null,
      statistics: entity.statistics != null
          ? StatisticsModel.fromEntity(entity.statistics!)
          : null,
      semesterMarks1: entity.semesterMarks1
          ?.map((e) => SemesterMarksModel.fromEntity(e))
          .toList(),
      semesterMark2: entity.semesterMark2
          ?.map((e) => SemesterMarksModel.fromEntity(e))
          .toList(),
      attendance: entity.attendance
          ?.map((e) => Attendancemodel.fromEntity(e))
          .toList(),
      scheduleImage: entity.scheduleImage,
      activities: entity.activities
          ?.map((e) => ActivitiesModel.fromEntity(e))
          .toList(),
      warnings: entity.warnings
          ?.map((e) => CounselorWarningModel.fromEntity(e))
          .toList(),
      summons: entity.summons?.map((e) => SummonsModel.fromEntity(e)).toList(),
    );
  }

  // ----- fromJson -----
  factory StudentFullProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return StudentFullProfileModel(
      message: json['message'] as String?,
      studentInfo: data['student'] != null
          ? StudentInfoModel.fromJson(data['student'])
          : null,
      statistics: data['statistics'] != null
          ? StatisticsModel.fromJson(data['statistics'])
          : null,
      semesterMarks1: (data['semesterMarks1'] as List? ?? [])
          .map((e) => SemesterMarksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      semesterMark2: (data['semesterMarks2'] as List? ?? [])
          .map((e) => SemesterMarksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendance: (data['attendance'] as List? ?? [])
          .map((e) => Attendancemodel.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduleImage: data['scheduleImage'] as String?,
      activities: (data['activities'] as List? ?? [])
          .map((e) => ActivitiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      warnings: (data['warnings'] as List? ?? [])
          .map((e) => CounselorWarningModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summons: (data['summons'] as List? ?? [])
          .map((e) => SummonsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // ----- toEntity -----
  Studentfullprofileentity toEntity() {
    return Studentfullprofileentity(
      message: message,
      studentInfo: studentInfo?.toEntity(),
      statistics: statistics?.toEntity(),
      semesterMarks1: semesterMarks1?.map((e) => e.toEntity()).toList(),
      semesterMark2: semesterMark2?.map((e) => e.toEntity()).toList(),
      attendance: attendance?.map((e) => e.toEntity()).toList(),
      scheduleImage: scheduleImage,
      activities: activities?.map((e) => e.toEntity()).toList(),
      warnings: warnings?.map((e) => e.toEntity()).toList(),
      summons: summons?.map((e) => e.toEntity()).toList(),
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': {
        'student': studentInfo?.toJson(),
        'statistics': statistics?.toJson(),
        'semesterMarks1': semesterMarks1?.map((e) => e.toJson()).toList(),
        'semesterMarks2': semesterMark2?.map((e) => e.toJson()).toList(),
        'attendance': attendance?.map((e) => e.toJson()).toList(),
        'scheduleImage': scheduleImage,
        'activities': activities?.map((e) => e.toJson()).toList(),
        'warnings': warnings?.map((e) => e.toJson()).toList(),
        'summons': summons?.map((e) => e.toJson()).toList(),
      },
    };
  }
}
