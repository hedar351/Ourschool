import 'package:equatable/equatable.dart';

class StudentInfoEntity extends Equatable {
  final String? name;
  final String? email;
  final int? localStudentNumber;
  final String? sectionName;
  final String? gradeName;
  final int? localSectionNumber;
  final int? localGradeNumber;
  // final AcademicYearEntity? academicYear;
  final String? guardianName;
  final String? guardianPhone;

  const StudentInfoEntity({
    required this.name,
    required this.email,
    required this.localStudentNumber,
    required this.sectionName,
    required this.gradeName,
    required this.localSectionNumber,
    required this.localGradeNumber,
    // required this.academicYear,
    required this.guardianName,
    required this.guardianPhone,
  });
  @override
  List<Object?> get props => [
    name,
    email,
    localStudentNumber,
    sectionName,
    gradeName,
    localSectionNumber,
    localGradeNumber,
    // academicYear,
    guardianName,
    guardianPhone,
  ];
}
