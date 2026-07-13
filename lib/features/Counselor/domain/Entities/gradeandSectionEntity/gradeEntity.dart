import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/gradeandSectionEntity/SectionEntity.dart';

class Gradeentity extends Equatable {
  final int? id;
  final String? name;
  final int? localGradeNumber;
  final List<Sectionentity>? sections;
  final String? message;

  const Gradeentity({
    required this.id,
    required this.name,
    required this.localGradeNumber,
    required this.sections,
    required this.message,
  });
  @override
  List<Object?> get props => [id, name, localGradeNumber, sections, message];
}
