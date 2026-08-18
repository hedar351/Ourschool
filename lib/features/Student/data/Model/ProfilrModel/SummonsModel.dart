import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/SummonsEntity.dart';

part 'SummonsModel.g.dart';

@HiveType(typeId: 24)
class SummonsModel extends HiveObject {
  @HiveField(0)
  final String? reason;

  @HiveField(1)
  final String? date;

  @HiveField(2)
  final String? createdAt;

  SummonsModel({
    required this.reason,
    required this.date,
    required this.createdAt,
  });

  // ----- fromEntity -----
  factory SummonsModel.fromEntity(SummonsEntity entity) {
    // SummonsEntity فارغ، نرجع قيم افتراضية
    return SummonsModel(
      reason: entity.reason,
      date: entity.date,
      createdAt: entity.createdAt,
    );
  }

  // ----- fromJson -----
  factory SummonsModel.fromJson(Map<String, dynamic> json) {
    return SummonsModel(
      reason: json['reason'] as String?,
      date: json['date'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  // ----- toEntity -----
  SummonsEntity toEntity() {
    return SummonsEntity(reason: reason, date: date, createdAt: createdAt);
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {'reason': reason, 'date': date, 'createdAt': createdAt};
  }
}
