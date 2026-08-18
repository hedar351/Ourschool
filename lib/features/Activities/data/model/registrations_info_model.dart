
import 'package:hive/hive.dart';
import 'package:school/features/Activities/domain/entity/registrations_info_entity.dart';

part 'registrations_info_model.g.dart';

@HiveType(typeId: 41)
class RegistrationsInfoModel extends HiveObject {
  @HiveField(0)
  final int? studentLocalNumber;

  @HiveField(1)
  final String? studentName;

  @HiveField(2)
  final String? sectionName;

  @HiveField(3)
  final String? gradeName;

  @HiveField(4)
  final String? status;

  RegistrationsInfoModel({
    required this.studentLocalNumber,
    required this.studentName,
    required this.sectionName,
    required this.gradeName,
    required this.status,
  });

  // ----- fromEntity -----
  factory RegistrationsInfoModel.fromEntity(RegistrationsInfoEntity entity) {
    return RegistrationsInfoModel(
      studentLocalNumber: entity.studentLocalNumber,
      studentName: entity.studentName,
      sectionName: entity.sectionName,
      gradeName: entity.gradeName,
      status: entity.status,
    );
  }

  // ----- fromJson -----
  factory RegistrationsInfoModel.fromJson(Map<String, dynamic> json) {
    return RegistrationsInfoModel(
      studentLocalNumber: json['studentLocalNumber'] as int?,
      studentName: json['studentName'] as String?,
      sectionName: json['sectionName'] as String?,
      gradeName: json['gradeName'] as String?,
      status: json['status'] as String?,
    );
  }

  // ----- toEntity -----
  RegistrationsInfoEntity toEntity() {
    return RegistrationsInfoEntity(
      studentLocalNumber: studentLocalNumber,
      studentName: studentName,
      sectionName: sectionName,
      gradeName: gradeName,
      status: status,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'studentLocalNumber': studentLocalNumber,
      'studentName': studentName,
      'sectionName': sectionName,
      'gradeName': gradeName,
      'status': status,
    };
  }
}
