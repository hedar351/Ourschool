import 'package:hive_flutter/adapters.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/studentModel.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';

part 'StudentsBySectionModel.g.dart';

@HiveType(typeId: 5)
class Studentsbysectionmodel extends HiveObject {
  @HiveField(0)
  final bool? success;
  @HiveField(1)
  final String? message;
  @HiveField(2)
  final List<Studentmodel>? students;

  Studentsbysectionmodel({
    required this.success,
    required this.message,
    required this.students,
  });
  factory Studentsbysectionmodel.fromEntity(StudentsBySectionEntity entity) {
    return Studentsbysectionmodel(
      success: entity.success,
      message: entity.message,
      students: entity.students
          ?.map((e) => Studentmodel.fromEntity(e))
          .toList(),
    );
  }

  factory Studentsbysectionmodel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final studentsList = data['students'] as List? ?? [];
    return Studentsbysectionmodel(
      success: json['success'],
      message: json['message'],
      students: studentsList.map((e) => Studentmodel.fromJson(e)).toList(),
    );
  }

  StudentsBySectionEntity toEntity() {
    return StudentsBySectionEntity(
      success: success,
      message: message,
      students: students?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {'students': students?.map((e) => e.toJson()).toList()},
    };
  }
}
