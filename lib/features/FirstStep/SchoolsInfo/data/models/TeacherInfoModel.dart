import 'package:hive/hive.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/TeacherInfoEntity.dart';

import 'SectionsModel.dart';
import 'SubjectsModel.dart';

part 'TeacherInfoModel.g.dart';

@HiveType(typeId: 16)
class TeacherInfoModel extends HiveObject {
  @HiveField(0)
  final int? employeeId;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? phone;

  @HiveField(3)
  final List<SectionsModel>? sections;

  @HiveField(4)
  final List<SubjectsModel>? subjects;

  TeacherInfoModel({
    required this.employeeId,
    required this.name,
    required this.phone,
    required this.sections,
    required this.subjects,
  });
  factory TeacherInfoModel.fromEntity(TeacherInfoEntity entity) {
    return TeacherInfoModel(
      employeeId: entity.employeeId,
      name: entity.name,
      phone: entity.phone,
      sections: entity.sections
          ?.map((e) => SectionsModel.fromEntity(e))
          .toList(),
      subjects: entity.subjects
          ?.map((e) => SubjectsModel.fromEntity(e))
          .toList(),
    );
  }

  factory TeacherInfoModel.fromJson(Map<String, dynamic> json) {
    final sectionsList = json['sections'] as List? ?? [];
    final sections = sectionsList
        .map((e) => SectionsModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final subjectsList = json['subjects'] as List? ?? [];
    final subjects = subjectsList
        .map((e) => SubjectsModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return TeacherInfoModel(
      employeeId: json['employeeId'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      sections: sections,
      subjects: subjects,
    );
  }
  TeacherInfoEntity toEntity() {
    return TeacherInfoEntity(
      employeeId: employeeId,
      name: name,
      phone: phone,
      sections: sections?.map((e) => e.toEntity()).toList(),
      subjects: subjects?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'name': name,
      'phone': phone,
      'sections': sections?.map((e) => e.toJson()).toList(),
      'subjects': subjects?.map((e) => e.toJson()).toList(),
    };
  }
}
