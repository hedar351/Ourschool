// lib/features/Student/data/model/Student-FullProfile/StudentInfoModel.dart

import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentInfoEntity.dart';

part 'StudentInfoModel.g.dart';

@HiveType(typeId: 26)
class StudentInfoModel extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final int? localStudentNumber;

  @HiveField(3)
  final String? sectionName;

  @HiveField(4)
  final String? gradeName;

  @HiveField(5)
  final int? localSectionNumber;

  @HiveField(6)
  final int? localGradeNumber;

  @HiveField(7)
  final int? academicYear;

  @HiveField(8)
  final String? guardianName;

  @HiveField(9)
  final String? guardianPhone;

  StudentInfoModel({
    required this.name,
    required this.email,
    required this.localStudentNumber,
    required this.sectionName,
    required this.gradeName,
    required this.localSectionNumber,
    required this.localGradeNumber,
    required this.academicYear,
    required this.guardianName,
    required this.guardianPhone,
  });

  // ----- fromEntity -----
  factory StudentInfoModel.fromEntity(StudentInfoEntity entity) {
    return StudentInfoModel(
      name: entity.name,
      email: entity.email,
      localStudentNumber: entity.localStudentNumber,
      sectionName: entity.sectionName,
      gradeName: entity.gradeName,
      localSectionNumber: entity.localSectionNumber,
      localGradeNumber: entity.localGradeNumber,
      academicYear: entity.academicYear,
      guardianName: entity.guardianName,
      guardianPhone: entity.guardianPhone,
    );
  }

  // ----- fromJson -----
  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      localStudentNumber: json['localStudentNumber'] as int?,
      sectionName: json['sectionName'] as String?,
      gradeName: json['gradeName'] as String?,
      localSectionNumber: json['localSectionNumber'] as int?,
      localGradeNumber: json['localGradeNumber'] as int?,
      academicYear: json['academicYear'] as int?,
      guardianName: json['guardianName'] as String?,
      guardianPhone: json['guardianPhone'] as String?,
    );
  }

  // ----- toEntity -----
  StudentInfoEntity toEntity() {
    return StudentInfoEntity(
      name: name,
      email: email,
      localStudentNumber: localStudentNumber,
      sectionName: sectionName,
      gradeName: gradeName,
      localSectionNumber: localSectionNumber,
      localGradeNumber: localGradeNumber,
      academicYear: academicYear,
      guardianName: guardianName,
      guardianPhone: guardianPhone,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'localStudentNumber': localStudentNumber,
      'sectionName': sectionName,
      'gradeName': gradeName,
      'localSectionNumber': localSectionNumber,
      'localGradeNumber': localGradeNumber,
      'academicYear': academicYear,
      'guardianName': guardianName,
      'guardianPhone': guardianPhone,
    };
  }
}
