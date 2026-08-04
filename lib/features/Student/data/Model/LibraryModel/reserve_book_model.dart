// lib/features/Library/data/models/reserve_book_model.dart

import 'package:hive/hive.dart';
import 'package:school/features/Student/domain/entity/Library/reserveBookInfoEntity.dart';

part 'reserve_book_model.g.dart';

@HiveType(typeId: 28)
class ReserveBookModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? localBookNumber;

  @HiveField(2)
  final String? bookTitle;

  @HiveField(3)
  final String? date;

  @HiveField(4)
  final String? expiryDate;

  @HiveField(5)
  final String? status;

  @HiveField(6)
  final String? statusName;

  ReserveBookModel({
    required this.id,
    required this.localBookNumber,
    required this.bookTitle,
    required this.date,
    required this.expiryDate,
    required this.status,
    required this.statusName,
  });

  factory ReserveBookModel.fromEntity(ReserveBookInfoEntity entity) {
    return ReserveBookModel(
      id: entity.id,
      localBookNumber: entity.localBookNumber,
      bookTitle: entity.bookTitle,
      date: entity.date,
      expiryDate: entity.expiryDate,
      status: entity.status,
      statusName: entity.statusName,
    );
  }

  factory ReserveBookModel.fromJson(Map<String, dynamic> json) {
    return ReserveBookModel(
      id: json['id'] as int?,
      localBookNumber: json['localBookNumber'] as int?,
      bookTitle: json['bookTitle'] as String?,
      date: json['date'] as String?,
      expiryDate: json['expiryDate'] as String?,
      status: json['status'] as String?,
      statusName: json['statusName'] as String?,
    );
  }

  ReserveBookInfoEntity toEntity() {
    return ReserveBookInfoEntity(
      id: id,
      localBookNumber: localBookNumber,
      bookTitle: bookTitle,
      date: date,
      expiryDate: expiryDate,
      status: status,
      statusName: statusName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'localBookNumber': localBookNumber,
      'bookTitle': bookTitle,
      'date': date,
      'expiryDate': expiryDate,
      'status': status,
      'statusName': statusName,
    };
  }
}
