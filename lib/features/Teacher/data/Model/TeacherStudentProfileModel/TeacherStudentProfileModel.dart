import 'package:hive/hive.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';

import 'SemesterMarksModel.dart';

part 'TeacherStudentProfileModel.g.dart';

@HiveType(typeId: 20)
class TeacherStudentProfileModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final int? localStudentNumber;

  @HiveField(3)
  final String? guardianName;

  @HiveField(4)
  final String? guardianPhone;

  @HiveField(5)
  final List<SemesterMarksModel>? semester1Marks;

  @HiveField(6)
  final List<SemesterMarksModel>? semester2Marks;

  TeacherStudentProfileModel({
    required this.id,
    required this.name,
    required this.localStudentNumber,
    required this.guardianName,
    required this.guardianPhone,
    required this.semester1Marks,
    required this.semester2Marks,
  });

  factory TeacherStudentProfileModel.fromEntity(
    Teacherstudentprofileentity entity,
  ) {
    return TeacherStudentProfileModel(
      id: entity.id,
      name: entity.name,
      localStudentNumber: entity.localStudentNumber,
      guardianName: entity.guardianName,
      guardianPhone: entity.guardianPhone,
      semester1Marks: entity.semester1Marks
          ?.map((e) => SemesterMarksModel.fromEntity(e))
          .toList(),
      semester2Marks: entity.semester2Marks
          ?.map((e) => SemesterMarksModel.fromEntity(e))
          .toList(),
    );
  }

  // factory TeacherStudentProfileModel.fromJson(Map<String, dynamic> json) {
  //   return TeacherStudentProfileModel(
  //     id: json['id'] as int?,
  //     name: json['name'] as String?,
  //     localStudentNumber: json['localStudentNumber'] as int?,
  //     guardianName: json['guardianName'] as String?,
  //     guardianPhone: json['guardianPhone'] as String?,
  //     semester1Marks: (json['semester1Marks'] as List? ?? [])
  //         .map((e) => SemesterMarksModel.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //     semester2Marks: (json['semester2Marks'] as List? ?? [])
  //         .map((e) => SemesterMarksModel.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  //   );
  // }
  // lib/features/Teacher/data/Model/TeacherStudentProfile/TeacherStudentProfileModel.dart

  factory TeacherStudentProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    print('🟢 [Model] data keys: ${data.keys}');
    print('🟢 [Model] name: ${data['name']}');
    print('🟢 [Model] id: ${data['id']}');

    return TeacherStudentProfileModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      localStudentNumber: data['localStudentNumber'] as int?,
      guardianName: data['guardianName'] as String?,
      guardianPhone: data['guardianPhone'] as String?,
      semester1Marks: (data['semester1Marks'] as List? ?? [])
          .map((e) => SemesterMarksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      semester2Marks: (data['semester2Marks'] as List? ?? [])
          .map((e) => SemesterMarksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Teacherstudentprofileentity toEntity() {
    return Teacherstudentprofileentity(
      id: id,
      name: name,
      localStudentNumber: localStudentNumber,
      guardianName: guardianName,
      guardianPhone: guardianPhone,
      semester1Marks: semester1Marks?.map((e) => e.toEntity()).toList(),
      semester2Marks: semester2Marks?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'localStudentNumber': localStudentNumber,
      'guardianName': guardianName,
      'guardianPhone': guardianPhone,
      'semester1Marks': semester1Marks?.map((e) => e.toJson()).toList(),
      'semester2Marks': semester2Marks?.map((e) => e.toJson()).toList(),
    };
  }
}
