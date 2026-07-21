import 'package:equatable/equatable.dart';

class Teacherentity extends Equatable {
  final int? id;
  final int? localEmployeeNumber;
  final String name;

  const Teacherentity({
    required this.id,
    required this.localEmployeeNumber,
    required this.name,
  });

  @override
  List<Object?> get props => [id, localEmployeeNumber, name];
}
