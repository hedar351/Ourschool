import 'package:equatable/equatable.dart';

class SectionsEntity extends Equatable {
  final int? sectionId;
  final String? sectionName;
  final int? localSectionNumber;
  final String? gradeName;
  final int? localGradeNumber;

  const SectionsEntity({
    required this.sectionId,
    required this.sectionName,
    required this.localSectionNumber,
    required this.gradeName,
    required this.localGradeNumber,
  });
  @override
  List<Object?> get props => [
    sectionId,
    sectionName,
    localSectionNumber,
    gradeName,
    localGradeNumber,
  ];
}
