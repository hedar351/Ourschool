import 'package:equatable/equatable.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/schoolsEntity.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherProfileEntities/teacherEntity.dart';

class TeacherFullprofileentity extends Equatable {
  final String? message;
  final Teacherentity? teacherInfo;
  final List<Schoolsentity>? school;

  const TeacherFullprofileentity({
    required this.message,
    required this.teacherInfo,
    required this.school,
  });

  @override
  List<Object?> get props => [message, teacherInfo, school];
}
