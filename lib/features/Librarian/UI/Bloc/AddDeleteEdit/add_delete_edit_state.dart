// lib/features/Librarian/UI/LibrarianBloc/AddDeleteEditBloc/add_delete_edit_state.dart

part of 'add_delete_edit_bloc.dart';

class AddDeleteEditError extends AddDeleteEditState {
  final String message;

  const AddDeleteEditError({required this.message});

  @override
  List<Object> get props => [message];
}

// ============================================================
// ====== STATES ======
// ============================================================

class AddDeleteEditInitial extends AddDeleteEditState {}

class AddDeleteEditLoading extends AddDeleteEditState {}

// ============================================================
// ====== BASE STATE ======
// ============================================================

sealed class AddDeleteEditState extends Equatable {
  const AddDeleteEditState();

  @override
  List<Object?> get props => [];
}

class AddDeleteEditSuccess extends AddDeleteEditState {
  final String message;

  const AddDeleteEditSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
