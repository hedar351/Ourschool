import 'package:equatable/equatable.dart';

class Sectionentity extends Equatable {
  final int? id;
  final int? localSectionNumber;
  final String? name;

  const Sectionentity({
    required this.id,
    required this.localSectionNumber,
    required this.name,
  });

  @override
  List<Object?> get props => [id, localSectionNumber, name];
}
