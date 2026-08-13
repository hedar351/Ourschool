import 'package:equatable/equatable.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SectionsEntity.dart';
import 'package:school/features/FirstStep/SchoolsInfo/domain/Entities/SubjectsEntity.dart';

class TeacherInfoEntity extends Equatable {
  final int? employeeId;
  final String? name;
  final String? phone;
  final List<SectionsEntity>? sections;
  final List<SubjectsEntity>? subjects;

  const TeacherInfoEntity({
    required this.employeeId,
    required this.name,
    required this.phone,
    required this.sections,
    required this.subjects,
  });
  @override
  List<Object?> get props => [employeeId, name, phone, sections, subjects];
}
