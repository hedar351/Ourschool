// lib/features/SchoolsInfo/data/models/SchoolInfoModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/FirstStep/SchoolsInfo/data/models/TeacherInfoModel.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SchoolInfoEntity.dart';

part 'SchoolInfoModel.g.dart';

@HiveType(typeId: 17)
class SchoolInfoModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? typename;

  @HiveField(3)
  final String? address;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final List<TeacherInfoModel>? teacherInfo;

  SchoolInfoModel({
    required this.id,
    required this.name,
    required this.typename,
    required this.address,
    required this.phone,
    required this.teacherInfo,
  });
  factory SchoolInfoModel.fromEntity(SchoolInfoEntity entity) {
    return SchoolInfoModel(
      id: entity.id,
      name: entity.name,
      typename: entity.typename,
      address: entity.address,
      phone: entity.phone,
      teacherInfo: entity.teacherInfo
          ?.map((e) => TeacherInfoModel.fromEntity(e))
          .toList(),
    );
  }

  factory SchoolInfoModel.fromJson(Map<String, dynamic> json) {
    final teachersList = json['teachers'] as List? ?? [];
    final teachers = teachersList
        .map((e) => TeacherInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return SchoolInfoModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      typename: json['typeName'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      teacherInfo: teachers,
    );
  }
  SchoolInfoEntity toEntity() {
    return SchoolInfoEntity(
      id: id,
      name: name,
      typename: typename,
      address: address,
      phone: phone,
      teacherInfo: teacherInfo?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'typeName': typename,
      'address': address,
      'phone': phone,
      'teachers': teacherInfo?.map((e) => e.toJson()).toList(),
    };
  }
}
