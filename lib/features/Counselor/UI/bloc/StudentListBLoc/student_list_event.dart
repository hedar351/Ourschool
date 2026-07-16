import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';

class GetStudentsEvent extends StudentsEvent {
  final int localGradeNumber;
  final int localSectionNumber;

  const GetStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber];
}

class RefreshStudentsEvent extends StudentsEvent {
  final int localGradeNumber;
  final int localSectionNumber;

  const RefreshStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber];
}

class RevalidateStudentsEvent extends StudentsEvent {
  final int localGradeNumber;
  final int localSectionNumber;

  const RevalidateStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber];
}

sealed class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCachedStudentsEvent extends StudentsEvent {
  final StudentsBySectionEntity students;

  const UpdateCachedStudentsEvent({required this.students});

  @override
  List<Object?> get props => [students];
}

class WatchCachedStudentsEvent extends StudentsEvent {
  final int localGradeNumber;
  final int localSectionNumber;

  const WatchCachedStudentsEvent({
    required this.localGradeNumber,
    required this.localSectionNumber,
  });

  @override
  List<Object?> get props => [localGradeNumber, localSectionNumber];
}
