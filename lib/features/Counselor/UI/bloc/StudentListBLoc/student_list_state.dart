import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsBySectionEntity/StudentsBySectionEntity.dart';

class StudentsError extends StudentsState {
  final String message;

  const StudentsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class StudentsInitial extends StudentsState {}

class StudentsLoaded extends StudentsState {
  final StudentsBySectionEntity students;
  final bool isRevalidating;
  final String? errorMessage;

  const StudentsLoaded({
    required this.students,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [students, isRevalidating, errorMessage];

  StudentsLoaded copyWith({
    StudentsBySectionEntity? students,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return StudentsLoaded(
      students: students ?? this.students,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class StudentsLoading extends StudentsState {}

sealed class StudentsState extends Equatable {
  const StudentsState();

  @override
  List<Object?> get props => [];
}
