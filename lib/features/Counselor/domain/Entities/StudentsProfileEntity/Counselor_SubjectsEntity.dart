import 'package:equatable/equatable.dart';

class CounselorSubjectsentity extends Equatable {
  final int? subjectId;
  final String? subjectName;
  final int? teacherId;
  final String? teacherName;

  const CounselorSubjectsentity({
    required this.subjectName,
    required this.teacherName,
    required this.subjectId,
    required this.teacherId,
  });

  @override
  List<Object?> get props => [subjectName, teacherName, subjectId, teacherId];
}
