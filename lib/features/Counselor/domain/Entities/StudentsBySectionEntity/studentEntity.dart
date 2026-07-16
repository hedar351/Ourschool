import 'package:equatable/equatable.dart';

class Studententity extends Equatable {
  final int? id;
  final int? localStudentNumber;
  final String? name;
  final String? guardianName;
  final String? guardianPhone;

  const Studententity({
    required this.id,
    required this.localStudentNumber,
    required this.name,
    required this.guardianName,
    required this.guardianPhone,
  });

  @override
  List<Object?> get props => [
    id,
    localStudentNumber,
    name,
    guardianName,
    guardianPhone,
  ];
}
