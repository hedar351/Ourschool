// lib/features/Librarian/presentation/bloc/librarian_event.dart

part of 'librarian_bloc.dart';

class GetBooksLibrarianEvent extends LibrarianEvent {}

sealed class LibrarianEvent extends Equatable {
  const LibrarianEvent();

  @override
  List<Object?> get props => [];
}

class RefreshBooksLibrarianEvent extends LibrarianEvent {}

class RevalidateBooksLibrarianEvent extends LibrarianEvent {}

class UpdateCachedBooksLibrarianEvent extends LibrarianEvent {
  final List<BookEntity> books;

  const UpdateCachedBooksLibrarianEvent({required this.books});

  @override
  List<Object> get props => [books];
}

class WatchCachedBooksLibrarianEvent extends LibrarianEvent {}
