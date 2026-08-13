// lib/features/SchoolsInfo/data/models/SchoolWithTeacherModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/FirstStep/SchoolsInfo/data/models/SchoolInfoModel.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SchoolWithTeacherEntity.dart';

part 'SchoolWithTeacherModel.g.dart';

@HiveType(typeId: 18)
class SchoolWithTeacherModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final List<SchoolInfoModel>? schoolInfo;

  SchoolWithTeacherModel({required this.message, required this.schoolInfo});

  factory SchoolWithTeacherModel.fromEntity(Schoolwithteacherentity entity) {
    return SchoolWithTeacherModel(
      message: entity.message,
      schoolInfo: entity.schoolInfo
          ?.map((e) => SchoolInfoModel.fromEntity(e))
          .toList(),
    );
  }

  factory SchoolWithTeacherModel.fromJson(Map<String, dynamic> json) {
    final schoolsList = json['data'] as List? ?? [];
    final schools = schoolsList
        .map((e) => SchoolInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return SchoolWithTeacherModel(
      message: json['message'] as String?,
      schoolInfo: schools,
    );
  }

  Schoolwithteacherentity toEntity() {
    return Schoolwithteacherentity(
      message: message,
      schoolInfo: schoolInfo?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': schoolInfo?.map((e) => e.toJson()).toList(),
    };
  }
}
