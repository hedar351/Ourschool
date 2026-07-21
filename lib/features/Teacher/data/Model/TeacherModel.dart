import 'package:hive/hive.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/teacherEntity.dart';

part 'TeacherModel.g.dart';

@HiveType(typeId: 11)
class TeacherModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? localEmployeeNumber;

  @HiveField(2)
  final String? name;

  TeacherModel({
    required this.id,
    required this.localEmployeeNumber,
    required this.name,
  });

  factory TeacherModel.fromEntity(Teacherentity entity) {
    return TeacherModel(
      id: entity.id,
      localEmployeeNumber: entity.localEmployeeNumber,
      name: entity.name,
    );
  }

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      localEmployeeNumber: json['localEmployeeNumber'],
      name: json['name'],
    );
  }

  Teacherentity toEntity() {
    return Teacherentity(
      id: id,
      localEmployeeNumber: localEmployeeNumber,
      name: name ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'localEmployeeNumber': localEmployeeNumber, 'name': name};
  }
}
