import 'package:equatable/equatable.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/SemesterMarks.dart';

class Teacherstudentprofileentity extends Equatable {
  final int? id;
  final String? name;
  final int? localStudentNumber;
  final String? guardianName;
  final String? guardianPhone;
  final List<SemesterMarks>? semester1Marks;
  final List<SemesterMarks>? semester2Marks;

  const Teacherstudentprofileentity({
    required this.id,
    required this.name,
    required this.localStudentNumber,
    required this.guardianName,
    required this.guardianPhone,
    required this.semester1Marks,
    required this.semester2Marks,
  });
  @override
  List<Object?> get props => [
    id,
    name,
    localStudentNumber,
    guardianName,
    guardianPhone,
    semester1Marks,
    semester2Marks,
  ];
}
