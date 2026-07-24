// lib/features/SchoolsInfo/data/models/SubjectsModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SubjectsEntity.dart';

part 'SubjectsModel.g.dart';

@HiveType(typeId: 14)
class SubjectsModel extends HiveObject {
  @HiveField(0)
  final int? subjectId;

  @HiveField(1)
  final String? subjectName;

  @HiveField(2)
  final int? localSubjectId;

  SubjectsModel({
    required this.subjectId,
    required this.subjectName,
    required this.localSubjectId,
  });

  // ----- fromEntity: من Entity إلى Model -----
  factory SubjectsModel.fromEntity(SubjectsEntity entity) {
    return SubjectsModel(
      subjectId: entity.subjectId,
      subjectName: entity.subjectName,
      localSubjectId: entity.localSubjectId,
    );
  }

  // ----- fromJson: من JSON إلى Model -----
  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    return SubjectsModel(
      subjectId: json['subjectId'] as int?,
      subjectName: json['subjectName'] as String?,
      localSubjectId: json['localSubjectId'] as int?,
    );
  }

  // ----- toEntity: من Model إلى Entity -----
  SubjectsEntity toEntity() {
    return SubjectsEntity(
      subjectId: subjectId,
      subjectName: subjectName,
      localSubjectId: localSubjectId,
    );
  }

  // ----- toJson: من Model إلى JSON -----
  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'subjectName': subjectName,
      'localSubjectId': localSubjectId,
    };
  }
}
