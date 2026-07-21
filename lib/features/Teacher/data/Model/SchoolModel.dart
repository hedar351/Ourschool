import 'package:hive/hive.dart';
import 'package:school/features/Teacher/data/Model/SubjectModel.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';

part 'SchoolModel.g.dart';

@HiveType(typeId: 12)
class SchoolsModel extends HiveObject {
  @HiveField(0)
  final int? schoolId;

  @HiveField(1)
  final String? schoolName;

  @HiveField(2)
  final List<SubjectModel>? subjects;

  @HiveField(3)
  final int? localEmployeeNumber;

  SchoolsModel({
    required this.schoolId,
    required this.schoolName,
    required this.subjects,
    this.localEmployeeNumber,
  });

  factory SchoolsModel.fromEntity(Schoolsentity entity) {
    return SchoolsModel(
      schoolId: entity.schoolId,
      schoolName: entity.schoolName,
      subjects: entity.subjects
          ?.map((s) => SubjectModel.fromEntity(s))
          .toList(),
    );
  }

  factory SchoolsModel.fromJson(Map<String, dynamic> json) {
    return SchoolsModel(
      schoolId: json['schoolId'],
      schoolName: json['schoolName'],
      localEmployeeNumber: json['localEmployeeNumber'],
      subjects: (json['subjects'] as List? ?? [])
          .map((e) => SubjectModel.fromJson(e))
          .toList(),
    );
  }

  Schoolsentity toEntity() {
    return Schoolsentity(
      schoolId: schoolId,
      schoolName: schoolName,
      subjects: subjects?.map((s) => s.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'schoolName': schoolName,
      'localEmployeeNumber': localEmployeeNumber,
      'subjects': subjects?.map((s) => s.toJson()).toList(),
    };
  }
}
