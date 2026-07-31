part of 'mark_bloc.dart';

final class ErrorMarkState extends MarkState {
  final String message;

  const ErrorMarkState({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoadingMarkState extends MarkState {}

final class MarkInitial extends MarkState {}

sealed class MarkState extends Equatable {
  const MarkState();

  @override
  List<Object> get props => [];
}

final class SuccessMarkState extends MarkState {
  final String message;

  const SuccessMarkState({required this.message});
  @override
  List<Object> get props => [message];
}
