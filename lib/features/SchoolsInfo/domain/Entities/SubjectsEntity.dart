import 'package:equatable/equatable.dart';

class SubjectsEntity extends Equatable {
  final int? subjectId;
  final String? subjectName;
  final int? localSubjectId;

  const SubjectsEntity({
    required this.subjectId,
    required this.subjectName,
    required this.localSubjectId,
  });
  @override
  List<Object?> get props => [subjectId, subjectName, localSubjectId];
}
