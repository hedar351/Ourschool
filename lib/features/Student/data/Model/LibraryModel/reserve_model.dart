// lib/features/Library/data/models/reserve_model.dart

import 'package:hive/hive.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_book_model.dart';
import 'package:school/features/Student/domain/entity/Library/reserveEntity.dart';

part 'reserve_model.g.dart';

@HiveType(typeId: 29)
class ReserveModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final ReserveBookModel? reserveBookInfo;

  ReserveModel({required this.message, required this.reserveBookInfo});

  factory ReserveModel.fromEntity(Reserveentity entity) {
    return ReserveModel(
      message: entity.message,
      reserveBookInfo: entity.reserveBookInfo != null
          ? ReserveBookModel.fromEntity(entity.reserveBookInfo!)
          : null,
    );
  }

  factory ReserveModel.fromJson(Map<String, dynamic> json) {
    return ReserveModel(
      message: json['message'] as String?,
      reserveBookInfo: json['data'] != null
          ? ReserveBookModel.fromJson(json['data'])
          : null,
    );
  }

  Reserveentity toEntity() {
    return Reserveentity(
      message: message,
      reserveBookInfo: reserveBookInfo?.toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': reserveBookInfo?.toJson()};
  }
}
