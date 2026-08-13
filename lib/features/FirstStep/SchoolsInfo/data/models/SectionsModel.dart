// lib/features/SchoolsInfo/data/models/SectionsModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SectionsEntity.dart';

part 'SectionsModel.g.dart';

@HiveType(typeId: 15)
class SectionsModel extends HiveObject {
  @HiveField(0)
  final int? sectionId;

  @HiveField(1)
  final String? sectionName;

  @HiveField(2)
  final int? localSectionNumber;

  @HiveField(3)
  final String? gradeName;

  @HiveField(4)
  final int? localGradeNumber;

  SectionsModel({
    required this.sectionId,
    required this.sectionName,
    required this.localSectionNumber,
    required this.gradeName,
    required this.localGradeNumber,
  });

  factory SectionsModel.fromEntity(SectionsEntity entity) {
    return SectionsModel(
      sectionId: entity.sectionId,
      sectionName: entity.sectionName,
      localSectionNumber: entity.localSectionNumber,
      gradeName: entity.gradeName,
      localGradeNumber: entity.localGradeNumber,
    );
  }

  factory SectionsModel.fromJson(Map<String, dynamic> json) {
    return SectionsModel(
      sectionId: json['sectionId'] as int?,
      sectionName: json['sectionName'] as String?,
      localSectionNumber: json['localSectionNumber'] as int?,
      gradeName: json['gradeName'] as String?,
      localGradeNumber: json['localGradeNumber'] as int?,
    );
  }

  SectionsEntity toEntity() {
    return SectionsEntity(
      sectionId: sectionId,
      sectionName: sectionName,
      localSectionNumber: localSectionNumber,
      gradeName: gradeName,
      localGradeNumber: localGradeNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sectionId': sectionId,
      'sectionName': sectionName,
      'localSectionNumber': localSectionNumber,
      'gradeName': gradeName,
      'localGradeNumber': localGradeNumber,
    };
  }
}
