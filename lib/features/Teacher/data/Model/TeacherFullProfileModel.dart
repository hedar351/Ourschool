import 'package:hive/hive.dart';
import 'package:school/features/Teacher/data/Model/SchoolModel.dart';
import 'package:school/features/Teacher/data/Model/TeacherModel.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/Teacher_fullProfileEntity.dart';

part 'TeacherFullProfileModel.g.dart';

@HiveType(typeId: 10)
class TeacherFullProfileModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final TeacherModel? teacher;

  @HiveField(2)
  final List<SchoolsModel>? schools;

  TeacherFullProfileModel({
    required this.message,
    required this.teacher,
    required this.schools,
  });

  factory TeacherFullProfileModel.fromEntity(TeacherFullprofileentity entity) {
    return TeacherFullProfileModel(
      message: entity.message,
      teacher: entity.teacherInfo != null
          ? TeacherModel.fromEntity(entity.teacherInfo!)
          : null,
      schools: entity.school?.map((s) => SchoolsModel.fromEntity(s)).toList(),
    );
  }

  factory TeacherFullProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return TeacherFullProfileModel(
      message: json['message'],
      teacher: data['teacher'] != null
          ? TeacherModel.fromJson(data['teacher'])
          : null,
      schools: (data['schools'] as List? ?? [])
          .map((e) => SchoolsModel.fromJson(e))
          .toList(),
    );
  }

  TeacherFullprofileentity toEntity() {
    return TeacherFullprofileentity(
      message: message,
      teacherInfo: teacher?.toEntity(),
      school: schools?.map((s) => s.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': {
        'teacher': teacher?.toJson(),
        'schools': schools?.map((s) => s.toJson()).toList(),
      },
    };
  }
}
