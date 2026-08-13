import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Library/BookEntity.dart';

part 'book_model.g.dart';

@HiveType(typeId: 27)
class BookModel extends HiveObject {
  @HiveField(0)
  final int localBookNumber;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final int copies;

  @HiveField(4)
  final int availableCopies;

  @HiveField(5)
  final bool isAvailable;

  BookModel({
    required this.localBookNumber,
    required this.title,
    required this.author,
    required this.copies,
    required this.availableCopies,
    required this.isAvailable,
  });

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      localBookNumber: entity.localBookNumber,
      title: entity.title,
      author: entity.author,
      copies: entity.copies,
      availableCopies: entity.availableCopies,
      isAvailable: entity.isAvailable,
    );
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    print('[Model] تحويل JSON إلى BookModel: $json');
    return BookModel(
      localBookNumber: json['localBookNumber'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      copies: json['copies'] as int,
      availableCopies: json['availableCopies'] as int,
      isAvailable: json['isAvailable'] as bool,
    );
  }

  BookEntity toEntity() {
    return BookEntity(
      localBookNumber: localBookNumber,
      title: title,
      author: author,
      copies: copies,
      availableCopies: availableCopies,
      isAvailable: isAvailable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localBookNumber': localBookNumber,
      'title': title,
      'author': author,
      'copies': copies,
      'availableCopies': availableCopies,
      'isAvailable': isAvailable,
    };
  }
}
