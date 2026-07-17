import 'package:hive/hive.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_SubjectsEntity.dart';

part 'Counselor_SubjectsModel.g.dart';

@HiveType(typeId: 7)
class CounselorSubjectModel extends HiveObject {
  @HiveField(0)
  final int? subjectId;

  @HiveField(1)
  final String? subjectName;

  @HiveField(2)
  final int? teacherId;

  @HiveField(3)
  final String? teacherName;

  CounselorSubjectModel({
    required this.subjectId,
    required this.subjectName,
    required this.teacherId,
    required this.teacherName,
  });

  factory CounselorSubjectModel.fromEntity(CounselorSubjectsentity entity) {
    return CounselorSubjectModel(
      subjectId: entity.subjectId,
      subjectName: entity.subjectName,
      teacherId: entity.teacherId,
      teacherName: entity.teacherName,
    );
  }

  factory CounselorSubjectModel.fromJson(Map<String, dynamic> json) {
    return CounselorSubjectModel(
      subjectId: json['subjectId'],
      subjectName: json['subjectName'],
      teacherId: json['teacherId'],
      teacherName: json['teacherName'],
    );
  }

  CounselorSubjectsentity toEntity() {
    return CounselorSubjectsentity(
      subjectId: subjectId,
      subjectName: subjectName,
      teacherId: teacherId,
      teacherName: teacherName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'teacherId': teacherId,
      'teacherName': teacherName,
    };
  }
}
