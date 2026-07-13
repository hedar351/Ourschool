import 'package:hive_flutter/hive_flutter.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/sectionModel.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';

part 'gradeModel.g.dart';

@HiveType(typeId: 2)
class GradeModel extends HiveObject {
  @HiveField(0)
  final int? gradeId;

  @HiveField(1)
  final String? gradeName;

  @HiveField(2)
  final int? localGradeNumber;

  @HiveField(3)
  final List<SectionModel>? sections;

  @HiveField(4)
  final String? message;

  GradeModel({
    required this.gradeId,
    required this.gradeName,
    required this.localGradeNumber,
    required this.sections,
    this.message,
  });

  factory GradeModel.fromEntity(Gradeentity entity) {
    return GradeModel(
      gradeId: entity.id,
      gradeName: entity.name,
      localGradeNumber: entity.localGradeNumber,
      sections:
          entity.sections?.map((s) => SectionModel.fromEntity(s)).toList() ??
          [],
      message: entity.message,
    );
  }

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    var sectionsJson = json['sections'] as List? ?? [];

    return GradeModel(
      gradeId: json['gradeId'],
      gradeName: json['gradeName'],
      localGradeNumber: json['localGradeNumber'],
      sections: sectionsJson.map((s) => SectionModel.fromJson(s)).toList(),
    );
  }

  Gradeentity toEntity() {
    return Gradeentity(
      id: gradeId,
      name: gradeName,
      localGradeNumber: localGradeNumber,
      sections: sections?.map((s) => s.toEntity()).toList() ?? [],
      message: message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeId': gradeId,
      'gradeName': gradeName,
      'localGradeNumber': localGradeNumber,
      'sections': sections?.map((s) => s.toJson()).toList() ?? [],
    };
  }
}
