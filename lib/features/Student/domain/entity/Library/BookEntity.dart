import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int localBookNumber;
  final String title;
  final String author;
  final int copies;
  final int availableCopies;
  final bool isAvailable;

  const BookEntity({
    required this.localBookNumber,
    required this.title,
    required this.author,
    required this.copies,
    required this.availableCopies,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [
    localBookNumber,
    title,
    author,
    copies,
    availableCopies,
    isAvailable,
  ];
}
