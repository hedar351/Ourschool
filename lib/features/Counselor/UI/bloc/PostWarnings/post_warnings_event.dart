import 'package:equatable/equatable.dart';

class AddPostWarningEvent extends PostWarningEvent {
  final int localStudentNumber;
  final String type;
  final String reason;

  const AddPostWarningEvent({
    required this.localStudentNumber,
    required this.type,
    required this.reason,
  });

  @override
  List<Object?> get props => [localStudentNumber, type, reason];
}

sealed class PostWarningEvent extends Equatable {
  const PostWarningEvent();

  @override
  List<Object?> get props => [];
}
