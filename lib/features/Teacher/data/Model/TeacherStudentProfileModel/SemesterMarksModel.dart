// lib/features/Teacher/data/Model/TeacherStudentProfile/SemesterMarksModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';

part 'SemesterMarksModel.g.dart';

@HiveType(typeId: 21)
class SemesterMarksModel extends HiveObject {
  @HiveField(0)
  final int? localSubjectId;

  @HiveField(1)
  final String? subjectName;

  @HiveField(2)
  final double? total;
  @HiveField(3)
  final double? quiz1;

  @HiveField(4)
  final double? quiz2;

  @HiveField(5)
  final double? homework;

  @HiveField(6)
  final double? finalExam;

  SemesterMarksModel({
    required this.localSubjectId,
    required this.subjectName,

    required this.quiz1,
    required this.quiz2,
    required this.homework,
    required this.finalExam,
    required this.total,
  });

  // ----- fromEntity: من Entity إلى Model -----
  factory SemesterMarksModel.fromEntity(SemesterMarks entity) {
    return SemesterMarksModel(
      localSubjectId: entity.localSubjectId,
      subjectName: entity.subjectName,
      quiz1: entity.quiz1,
      quiz2: entity.quiz2,
      homework: entity.homework,
      finalExam: entity.finalExam,
      total: entity.totle,
    );
  }

  // ----- fromJson: من JSON إلى Model -----
  factory SemesterMarksModel.fromJson(Map<String, dynamic> json) {
    return SemesterMarksModel(
      localSubjectId: json['localSubjectId'] as int?,
      subjectName: json['subjectName'] as String?,
      quiz1: (json['quiz1'] as num?)?.toDouble(),
      quiz2: (json['quiz2'] as num?)?.toDouble(),
      homework: (json['homework'] as num?)?.toDouble(),
      finalExam: (json['finalExam'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );
  }

  // ----- toEntity: من Model إلى Entity -----
  SemesterMarks toEntity() {
    return SemesterMarks(
      localSubjectId: localSubjectId,
      subjectName: subjectName,
      quiz1: quiz1,
      quiz2: quiz2,
      homework: homework,
      finalExam: finalExam,
      totle: total,
    );
  }

  // ----- toJson: من Model إلى JSON -----
  Map<String, dynamic> toJson() {
    return {
      'localSubjectId': localSubjectId,
      'subjectName': subjectName,

      'quiz1': quiz1,
      'quiz2': quiz2,
      'homework': homework,
      'finalExam': finalExam,
      'total': total,
    };
  }
}
