// lib/features/SchoolsInfo/data/models/SchoolWithTeacherModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/SchoolsInfo/data/models/SchoolInfoModel.dart';
import 'package:school/features/SchoolsInfo/domain/Entities/SchoolWithTeacherEntity.dart';

part 'SchoolWithTeacherModel.g.dart';

@HiveType(typeId: 18) 
class SchoolWithTeacherModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final List<SchoolInfoModel>? schoolInfo;

  SchoolWithTeacherModel({required this.message, required this.schoolInfo});

  // ----- fromEntity: من Entity إلى Model -----
  factory SchoolWithTeacherModel.fromEntity(Schoolwithteacherentity entity) {
    return SchoolWithTeacherModel(
      message: entity.message,
      schoolInfo: entity.schoolInfo
          ?.map((e) => SchoolInfoModel.fromEntity(e))
          .toList(),
    );
  }

  // ----- fromJson: من JSON إلى Model (معالج JSON الرئيسي) -----
  factory SchoolWithTeacherModel.fromJson(Map<String, dynamic> json) {
    // معالجة قائمة المدارس
    final schoolsList = json['data'] as List? ?? [];
    final schools = schoolsList
        .map((e) => SchoolInfoModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return SchoolWithTeacherModel(
      message: json['message'] as String?,
      schoolInfo: schools,
    );
  }

  // ----- toEntity: من Model إلى Entity -----
  Schoolwithteacherentity toEntity() {
    return Schoolwithteacherentity(
      message: message,
      schoolInfo: schoolInfo?.map((e) => e.toEntity()).toList(),
    );
  }

  // ----- toJson: من Model إلى JSON -----
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': schoolInfo?.map((e) => e.toJson()).toList(),
    };
  }
}
