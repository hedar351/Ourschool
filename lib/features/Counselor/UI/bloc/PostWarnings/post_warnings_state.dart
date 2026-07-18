import 'package:equatable/equatable.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_WarningsEntity.dart';

final class PostWarningError extends PostWarningState {
  final String message;

  const PostWarningError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class PostWarningInitial extends PostWarningState {}

final class PostWarningLoading extends PostWarningState {}

sealed class PostWarningState extends Equatable {
  const PostWarningState();

  @override
  List<Object?> get props => [];
}

final class PostWarningSuccess extends PostWarningState {
  final CounselorWarningsentity warning;

  const PostWarningSuccess({required this.warning});

  @override
  List<Object?> get props => [warning];
}
