// // lib/features/Teacher/data/Model/TeacherStudentProfile/SemesterMarksModel.dart

// import 'package:hive/hive.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';

// part 'SemesterMarksModel.g.dart';

// @HiveType(typeId: 21)
// class SemesterMarksModel extends HiveObject {
//   @HiveField(0)
//   final int? localSubjectId;

//   @HiveField(1)
//   final String? subjectName;

//   @HiveField(2)
//   final double? total;
//   @HiveField(3)
//   final double? quiz1;

//   @HiveField(4)
//   final double? quiz2;

//   @HiveField(5)
//   final double? homework;

//   @HiveField(6)
//   final double? finalExam;

//   SemesterMarksModel({
//     required this.localSubjectId,
//     required this.subjectName,

//     required this.quiz1,
//     required this.quiz2,
//     required this.homework,
//     required this.finalExam,
//     required this.total,
//   });

//   // ----- fromEntity: من Entity إلى Model -----
//   factory SemesterMarksModel.fromEntity(SemesterMarks entity) {
//     return SemesterMarksModel(
//       localSubjectId: entity.localSubjectId,
//       subjectName: entity.subjectName,
//       quiz1: entity.quiz1,
//       quiz2: entity.quiz2,
//       homework: entity.homework,
//       finalExam: entity.finalExam,
//       total: entity.total,
//     );
//   }

//   // ----- fromJson: من JSON إلى Model -----
//   factory SemesterMarksModel.fromJson(Map<String, dynamic> json) {
//     return SemesterMarksModel(
//       localSubjectId: json['localSubjectId'] as int?,
//       subjectName: json['subjectName'] as String?,
//       quiz1: (json['quiz1'] as num?)?.toDouble(),
//       quiz2: (json['quiz2'] as num?)?.toDouble(),
//       homework: (json['homework'] as num?)?.toDouble(),
//       finalExam: (json['finalExam'] as num?)?.toDouble(),
//       total: (json['total'] as num?)?.toDouble(),
//     );
//   }

//   // ----- toEntity: من Model إلى Entity -----
//   SemesterMarks toEntity() {
//     return SemesterMarks(
//       localSubjectId: localSubjectId,
//       subjectName: subjectName,
//       quiz1: quiz1,
//       quiz2: quiz2,
//       homework: homework,
//       finalExam: finalExam,
//       total: total,
//     );
//   }

//   // ----- toJson: من Model إلى JSON -----
//   Map<String, dynamic> toJson() {
//     return {
//       'localSubjectId': localSubjectId,
//       'subjectName': subjectName,
//       'quiz1': quiz1,
//       'quiz2': quiz2,
//       'homework': homework,
//       'finalExam': finalExam,
//       'total': total,
//     };
//   }
// }
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
  final double? oral;

  @HiveField(3)
  final double? maxOral;

  @HiveField(4)
  final double? quiz1;

  @HiveField(5)
  final double? maxQuiz1;

  @HiveField(6)
  final double? quiz2;

  @HiveField(7)
  final double? maxQuiz2;

  @HiveField(8)
  final double? homework;

  @HiveField(9)
  final double? maxHomework;

  @HiveField(10)
  final double? finalExam;

  @HiveField(11)
  final double? maxFinalExam;

  @HiveField(12)
  final double? total;

  SemesterMarksModel({
    required this.localSubjectId,
    required this.subjectName,
    required this.oral,
    required this.maxOral,
    required this.quiz1,
    required this.maxQuiz1,
    required this.quiz2,
    required this.maxQuiz2,
    required this.homework,
    required this.maxHomework,
    required this.finalExam,
    required this.maxFinalExam,
    required this.total,
  });

  // ----- fromEntity: من Entity إلى Model -----
  factory SemesterMarksModel.fromEntity(SemesterMarks entity) {
    return SemesterMarksModel(
      localSubjectId: entity.localSubjectId,
      subjectName: entity.subjectName,
      oral: entity.oral,
      maxOral: entity.maxOral,
      quiz1: entity.quiz1,
      maxQuiz1: entity.maxQuiz1,
      quiz2: entity.quiz2,
      maxQuiz2: entity.maxQuiz2,
      homework: entity.homework,
      maxHomework: entity.maxHomework,
      finalExam: entity.finalExam,
      maxFinalExam: entity.maxFinalExam,
      total: entity.total,
    );
  }

  // ----- fromJson: من JSON إلى Model -----
  factory SemesterMarksModel.fromJson(Map<String, dynamic> json) {
    return SemesterMarksModel(
      localSubjectId: json['localSubjectId'] as int?,
      subjectName: json['subjectName'] as String?,
      oral: (json['oral'] as num?)?.toDouble(),
      maxOral: (json['maxOral'] as num?)?.toDouble(),
      quiz1: (json['quiz1'] as num?)?.toDouble(),
      maxQuiz1: (json['maxQuiz1'] as num?)?.toDouble(),
      quiz2: (json['quiz2'] as num?)?.toDouble(),
      maxQuiz2: (json['maxQuiz2'] as num?)?.toDouble(),
      homework: (json['homework'] as num?)?.toDouble(),
      maxHomework: (json['maxHomework'] as num?)?.toDouble(),
      finalExam: (json['finalExam'] as num?)?.toDouble(),
      maxFinalExam: (json['maxFinalExam'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );
  }

  // ----- toEntity: من Model إلى Entity -----
  SemesterMarks toEntity() {
    return SemesterMarks(
      localSubjectId: localSubjectId,
      subjectName: subjectName,
      oral: oral,
      maxOral: maxOral,
      quiz1: quiz1,
      maxQuiz1: maxQuiz1,
      quiz2: quiz2,
      maxQuiz2: maxQuiz2,
      homework: homework,
      maxHomework: maxHomework,
      finalExam: finalExam,
      maxFinalExam: maxFinalExam,
      total: total,
    );
  }

  // ----- toJson: من Model إلى JSON -----
  Map<String, dynamic> toJson() {
    return {
      'localSubjectId': localSubjectId,
      'subjectName': subjectName,
      'oral': oral,
      'maxOral': maxOral,
      'quiz1': quiz1,
      'maxQuiz1': maxQuiz1,
      'quiz2': quiz2,
      'maxQuiz2': maxQuiz2,
      'homework': homework,
      'maxHomework': maxHomework,
      'finalExam': finalExam,
      'maxFinalExam': maxFinalExam,
      'total': total,
    };
  }
}
