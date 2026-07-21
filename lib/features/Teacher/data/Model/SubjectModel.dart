import 'package:hive/hive.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';

part 'SubjectModel.g.dart';

@HiveType(typeId: 13)
class SubjectModel extends HiveObject {
  @HiveField(0)
  final int? subjectId;

  @HiveField(1)
  final int? localSubjectId;

  @HiveField(2)
  final String? subjectName;

  @HiveField(3)
  final List<GradeModel>? grades;

  SubjectModel({
    required this.subjectId,
    required this.localSubjectId,
    required this.subjectName,
    required this.grades,
  });

  factory SubjectModel.fromEntity(Subjectentity entity) {
    return SubjectModel(
      subjectId: entity.subjectId,
      localSubjectId: entity.localSubjectId,
      subjectName: entity.subjectName,
      grades: entity.grades.map((g) => GradeModel.fromEntity(g)).toList(),
    );
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectId: json['subjectId'],
      localSubjectId: json['localSubjectId'],
      subjectName: json['subjectName'],
      grades: (json['grades'] as List? ?? [])
          .map((e) => GradeModel.fromJson(e))
          .toList(),
    );
  }

  Subjectentity toEntity() {
    return Subjectentity(
      subjectId: subjectId,
      localSubjectId: localSubjectId,
      subjectName: subjectName ?? '',
      grades: grades?.map((g) => g.toEntity()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'localSubjectId': localSubjectId,
      'subjectName': subjectName,
      'grades': grades?.map((g) => g.toJson()).toList(),
    };
  }
}
