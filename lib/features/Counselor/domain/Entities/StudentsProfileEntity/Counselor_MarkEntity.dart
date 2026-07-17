import 'package:equatable/equatable.dart';

class CounselorMarkentity extends Equatable {
  final int? subjectId;
  final int? localSubjectId;
  final String? subjectName;
  final int? semester;
  final int? quiz1;
  final int? quiz2;
  final int? homework;
  final int? finalExam;
  final int? total;

  const CounselorMarkentity({
    required this.subjectId,
    required this.localSubjectId,
    required this.subjectName,
    required this.semester,
    required this.quiz1,
    required this.quiz2,
    required this.homework,
    required this.finalExam,
    required this.total,
  });

  @override
  List<Object?> get props => [
    subjectId,
    localSubjectId,
    subjectName,
    semester,
    quiz1,
    quiz2,
    homework,
    finalExam,
    total,
  ];
}
