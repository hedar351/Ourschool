import 'package:equatable/equatable.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/SubjectEntity.dart';

class Schoolsentity extends Equatable {
  final int? schoolId;
  final String? schoolName;
  final List<Subjectentity>? subjects;

  const Schoolsentity({
    required this.schoolId,
    required this.schoolName,
    required this.subjects,
  });
  @override
  List<Object?> get props => [schoolId, schoolName, subjects];
}
