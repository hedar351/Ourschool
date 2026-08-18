import 'package:hive/hive.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/reservations.dart';

part 'librarian_reservation_model.g.dart';

@HiveType(typeId: 34)
class LibrarianReservationModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? localBookNumber;

  @HiveField(2)
  final String? bookTitle;

  @HiveField(3)
  final String? bookAuthor;

  @HiveField(4)
  final int? localStudentNumber;

  @HiveField(5)
  final String? studentName;

  @HiveField(6)
  final String? sectionName;

  @HiveField(7)
  final int? localSectionNumber;

  @HiveField(8)
  final String? gradeName;

  @HiveField(9)
  final int? localGradeNumber;

  @HiveField(10)
  final String? date;

  @HiveField(11)
  final String? expiryDate;

  @HiveField(12)
  final bool? isExpired;

  @HiveField(13)
  final String? statusName;

  LibrarianReservationModel({
    required this.id,
    required this.localBookNumber,
    required this.bookTitle,
    required this.bookAuthor,
    required this.localStudentNumber,
    required this.studentName,
    required this.sectionName,
    required this.localSectionNumber,
    required this.gradeName,
    required this.localGradeNumber,
    required this.date,
    required this.expiryDate,
    required this.isExpired,
    required this.statusName,
  });

  // ----- fromEntity -----
  factory LibrarianReservationModel.fromEntity(Reservations entity) {
    return LibrarianReservationModel(
      id: entity.id,
      localBookNumber: entity.localBookNumber,
      bookTitle: entity.bookTitle,
      bookAuthor: entity.bookAuthor,
      localStudentNumber: entity.localStudentNumber,
      studentName: entity.studentName,
      sectionName: entity.sectionName,
      localSectionNumber: entity.localSectionNumber,
      gradeName: entity.gradeName,
      localGradeNumber: entity.localGradeNumber,
      date: entity.date?.toIso8601String(),
      expiryDate: entity.expiryDate?.toIso8601String(),
      isExpired: entity.isExpired,
      statusName: entity.statusName,
    );
  }

  // ----- fromJson -----
  factory LibrarianReservationModel.fromJson(Map<String, dynamic> json) {
    return LibrarianReservationModel(
      id: json['id'] as int?,
      localBookNumber: json['localBookNumber'] as int?,
      bookTitle: json['bookTitle'] as String?,
      bookAuthor: json['bookAuthor'] as String?,
      localStudentNumber: json['localStudentNumber'] as int?,
      studentName: json['studentName'] as String?,
      sectionName: json['sectionName'] as String?,
      localSectionNumber: json['localSectionNumber'] as int?,
      gradeName: json['gradeName'] as String?,
      localGradeNumber: json['localGradeNumber'] as int?,
      date: json['date'] as String?,
      expiryDate: json['expiryDate'] as String?,
      isExpired: json['isExpired'] as bool?,
      statusName: json['statusName'] as String?,
    );
  }

  // ----- toEntity -----
  Reservations toEntity() {
    return Reservations(
      id: id,
      localBookNumber: localBookNumber,
      bookTitle: bookTitle,
      bookAuthor: bookAuthor,
      localStudentNumber: localStudentNumber,
      studentName: studentName,
      sectionName: sectionName,
      localSectionNumber: localSectionNumber,
      gradeName: gradeName,
      localGradeNumber: localGradeNumber,
      date: date != null ? DateTime.parse(date!) : null,
      expiryDate: expiryDate != null ? DateTime.parse(expiryDate!) : null,
      isExpired: isExpired,
      statusName: statusName,
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'localBookNumber': localBookNumber,
      'bookTitle': bookTitle,
      'bookAuthor': bookAuthor,
      'localStudentNumber': localStudentNumber,
      'studentName': studentName,
      'sectionName': sectionName,
      'localSectionNumber': localSectionNumber,
      'gradeName': gradeName,
      'localGradeNumber': localGradeNumber,
      'date': date,
      'expiryDate': expiryDate,
      'isExpired': isExpired,
      'statusName': statusName,
    };
  }
}
