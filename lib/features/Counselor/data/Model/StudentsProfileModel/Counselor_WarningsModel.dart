import 'package:hive/hive.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';

part 'Counselor_WarningsModel.g.dart';

@HiveType(typeId: 9)
class CounselorWarningModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? type;

  @HiveField(2)
  final String? reason;

  @HiveField(3)
  final String? createdAt;

  CounselorWarningModel({
    required this.id,
    required this.type,
    required this.reason,
    required this.createdAt,
  });

  factory CounselorWarningModel.fromEntity(CounselorWarningsentity entity) {
    return CounselorWarningModel(
      id: entity.id,
      type: entity.type,
      reason: entity.reason,
      createdAt: entity.createdAt,
    );
  }

  factory CounselorWarningModel.fromJson(Map<String, dynamic> json) {
    return CounselorWarningModel(
      id: json['id'],
      type: json['type'],
      reason: json['reason'],
      createdAt: json['createdAt'],
    );
  }

  CounselorWarningsentity toEntity() {
    return CounselorWarningsentity(
      id: id,
      type: type,
      reason: reason,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'reason': reason, 'createdAt': createdAt};
  }
}
