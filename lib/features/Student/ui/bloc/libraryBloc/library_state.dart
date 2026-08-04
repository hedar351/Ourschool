part of 'library_bloc.dart';

class LibraryError extends LibraryState {
  final String message;

  const LibraryError({required this.message});

  @override
  List<Object> get props => [message];
}

class LibraryInitial extends LibraryState {}

class LibraryLoaded extends LibraryState {
  final List<BookEntity> books;
  final bool isRevalidating;
  final String? errorMessage;

  const LibraryLoaded({
    required this.books,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [books, isRevalidating, errorMessage];

  LibraryLoaded copyWith({
    List<BookEntity>? books,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return LibraryLoaded(
      books: books ?? this.books,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LibraryLoading extends LibraryState {}

class LibraryReserved extends LibraryState {
  final String message;
  final Reserveentity reserveData;

  const LibraryReserved({required this.message, required this.reserveData});

  @override
  List<Object> get props => [message, reserveData];
}

class LibraryReserveError extends LibraryState {
  final String message;

  const LibraryReserveError({required this.message});

  @override
  List<Object> get props => [message];
}

class LibraryReserving extends LibraryState {}

sealed class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}
