// lib/features/Library/presentation/bloc/library_event.dart

part of 'library_bloc.dart';

/// جلب الكتب (أول مرة)
class GetBooksEvent extends LibraryEvent {}

sealed class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class RefreshBooksEvent extends LibraryEvent {}

class ReserveBookEvent extends LibraryEvent {
  final int localBookNumber;

  const ReserveBookEvent({required this.localBookNumber});

  @override
  List<Object> get props => [localBookNumber];
}

class ResetReserveStateEvent extends LibraryEvent {}

class RevalidateBooksEvent extends LibraryEvent {}

class UpdateCachedBooksEvent extends LibraryEvent {
  final List<BookEntity> books;

  const UpdateCachedBooksEvent({required this.books});

  @override
  List<Object> get props => [books];
}

class WatchCachedBooksEvent extends LibraryEvent {}
