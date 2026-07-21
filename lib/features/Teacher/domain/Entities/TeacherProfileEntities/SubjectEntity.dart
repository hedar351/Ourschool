import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/gradeEntity.dart';

class Subjectentity extends Equatable {
  final int? subjectId;
  final int? localSubjectId;
  final String? subjectName;
  final List<Gradeentity> grades;

  const Subjectentity({
    required this.subjectId,
    required this.localSubjectId,
    required this.subjectName,
    required this.grades,
  });

  @override
  List<Object?> get props => [subjectId, localSubjectId, subjectName, grades];
}
