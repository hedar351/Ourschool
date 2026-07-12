import 'package:equatable/equatable.dart';

class Sectionentity extends Equatable {
  final int? id;
  final int? localSectionNumber;
  final String? nameSection;

  const Sectionentity({
    required this.id,
    required this.localSectionNumber,
    required this.nameSection,
  });

  @override
  List<Object?> get props => [id, localSectionNumber, nameSection];
}
