import 'package:hive/hive.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_MarkEntity.dart';

part 'Counselor_MarkModel.g.dart';

@HiveType(typeId: 8)
class CounselorMarkModel extends HiveObject {
  @HiveField(0)
  final int? subjectId;

  @HiveField(1)
  final int? localSubjectId;

  @HiveField(2)
  final String? subjectName;

  @HiveField(3)
  final int? semester;

  @HiveField(4)
  final int? quiz1;

  @HiveField(5)
  final int? quiz2;

  @HiveField(6)
  final int? homework;

  @HiveField(7)
  final int? finalExam;

  @HiveField(8)
  final int? total;

  CounselorMarkModel({
    required this.subjectId,
    required this.localSubjectId,
    required this.subjectName,
    required this.semester,
    required this.quiz1,
    required this.quiz2,
    required this.homework,
    required this.finalExam,
    required this.total,
  });

  factory CounselorMarkModel.fromEntity(CounselorMarkentity entity) {
    return CounselorMarkModel(
      subjectId: entity.subjectId,
      localSubjectId: entity.localSubjectId,
      subjectName: entity.subjectName,
      semester: entity.semester,
      quiz1: entity.quiz1,
      quiz2: entity.quiz2,
      homework: entity.homework,
      finalExam: entity.finalExam,
      total: entity.total,
    );
  }

  factory CounselorMarkModel.fromJson(Map<String, dynamic> json) {
    return CounselorMarkModel(
      subjectId: json['subjectId'] as int?,
      localSubjectId: json['localSubjectId'] as int?,
      subjectName: json['subjectName'] as String?,
      semester: (json['semester'] as num?)?.toInt(),
      quiz1: (json['quiz1'] as num?)?.toInt(),
      quiz2: (json['quiz2'] as num?)?.toInt(),
      homework: (json['homework'] as num?)?.toInt(),
      finalExam: (json['finalExam'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );
  }
  CounselorMarkentity toEntity() {
    return CounselorMarkentity(
      subjectId: subjectId,
      localSubjectId: localSubjectId,
      subjectName: subjectName,
      semester: semester,
      quiz1: quiz1,
      quiz2: quiz2,
      homework: homework,
      finalExam: finalExam,
      total: total,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'localSubjectId': localSubjectId,
      'subjectName': subjectName,
      'semester': semester,
      'quiz1': quiz1,
      'quiz2': quiz2,
      'homework': homework,
      'finalExam': finalExam,
      'total': total,
    };
  }
}
