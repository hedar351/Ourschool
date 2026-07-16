import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/studentEntity.dart';

class StudentsBySectionEntity extends Equatable {
  final bool? success;
  final String? message;
  final List<Studententity>? students;

  const StudentsBySectionEntity({
    required this.success,
    required this.message,
    required this.students,
  });

  @override
  List<Object?> get props => [success, message, students];
}
