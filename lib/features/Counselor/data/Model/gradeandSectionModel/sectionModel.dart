import 'package:hive_flutter/hive_flutter.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/SectionEntity.dart';

part 'sectionModel.g.dart';

@HiveType(typeId: 3)
class SectionModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? nameSection;
  @HiveField(2)
  final int? localSectionNumber;

  SectionModel({this.id, this.nameSection, this.localSectionNumber});

  factory SectionModel.fromEntity(Sectionentity entity) {
    return SectionModel(
      id: entity.id,
      nameSection: entity.nameSection,
      localSectionNumber: entity.localSectionNumber,
    );
  }

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      nameSection: json['nameSection'],
      localSectionNumber: json['localSectionNumber'],
    );
  }

  Sectionentity toEntity() {
    return Sectionentity(
      id: id,
      localSectionNumber: localSectionNumber,
      nameSection: nameSection,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'localSectionNumber': localSectionNumber,
      'nameSection': nameSection,
    };
  }
}
