import 'package:equatable/equatable.dart';

class RegistrationsInfoEntity extends Equatable {
  final int? studentLocalNumber;
  final String? studentName;
  final String? sectionName;
  final String? gradeName;
  final String? status;

  const RegistrationsInfoEntity({
    required this.studentLocalNumber,
    required this.studentName,
    required this.sectionName,
    required this.gradeName,
    required this.status,
  });
  @override
  List<Object?> get props => [
    studentLocalNumber,
    studentName,
    sectionName,
    gradeName,
    status,
  ];
}
