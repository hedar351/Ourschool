part of 'librarian_bloc.dart';

class LibrarianError extends LibrarianState {
  final String message;

  const LibrarianError({required this.message});

  @override
  List<Object> get props => [message];
}

class LibrarianInitial extends LibrarianState {}

class LibrarianLoaded extends LibrarianState {
  final List<BookEntity> books;
  final bool isRevalidating;
  final String? errorMessage;

  const LibrarianLoaded({
    required this.books,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [books, isRevalidating, errorMessage];

  LibrarianLoaded copyWith({
    List<BookEntity>? books,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return LibrarianLoaded(
      books: books ?? this.books,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LibrarianLoading extends LibrarianState {}

sealed class LibrarianState extends Equatable {
  const LibrarianState();

  @override
  List<Object?> get props => [];
}
