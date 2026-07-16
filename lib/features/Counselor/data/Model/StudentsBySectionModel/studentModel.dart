import 'package:hive_flutter/hive_flutter.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';

part 'studentModel.g.dart';

@HiveType(typeId: 4)
class Studentmodel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? localStudentNumber;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? guardianName;
  @HiveField(4)
  final String? guardianPhone;

  Studentmodel({
    required this.id,
    required this.localStudentNumber,
    required this.name,
    required this.guardianName,
    required this.guardianPhone,
  });
  factory Studentmodel.fromEntity(Studententity entity) {
    return Studentmodel(
      id: entity.id,
      localStudentNumber: entity.localStudentNumber,
      name: entity.name,
      guardianName: entity.guardianName,
      guardianPhone: entity.guardianPhone,
    );
  }

  // من JSON إلى Model
  factory Studentmodel.fromJson(Map<String, dynamic> json) {
    return Studentmodel(
      id: json['id'],
      localStudentNumber: json['localStudentNumber'],
      name: json['name'],
      guardianName: json['guardianName'],
      guardianPhone: json['guardianPhone'],
    );
  }

  // من Model إلى Entity
  Studententity toEntity() {
    return Studententity(
      id: id,
      localStudentNumber: localStudentNumber,
      name: name,
      guardianName: guardianName,
      guardianPhone: guardianPhone,
    );
  }

  // إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'localStudentNumber': localStudentNumber,
      'name': name,
      'guardianName': guardianName,
      'guardianPhone': guardianPhone,
    };
  }
}
