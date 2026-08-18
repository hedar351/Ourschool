import 'package:hive/hive.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_book_model.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';

part 'reservations_model.g.dart';

@HiveType(typeId: 30)
class ReservationsModel extends HiveObject {
  @HiveField(0)
  final String? message;

  @HiveField(1)
  final int? totalReservations;

  @HiveField(2)
  final int? pendingReservations;

  @HiveField(3)
  final int? approvedReservations;

  @HiveField(4)
  final List<ReserveBookModel>? reserveBookInfo;

  ReservationsModel({
    required this.message,
    required this.totalReservations,
    required this.pendingReservations,
    required this.approvedReservations,
    required this.reserveBookInfo,
  });

  factory ReservationsModel.fromEntity(Reservations entity) {
    return ReservationsModel(
      message: entity.message,
      totalReservations: entity.totalReservations,
      pendingReservations: entity.pendingReservations,
      approvedReservations: entity.approvedReservations,
      reserveBookInfo: entity.reserveBookInfo
          ?.map((e) => ReserveBookModel.fromEntity(e))
          .toList(),
    );
  }

  factory ReservationsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return ReservationsModel(
      message: json['message'] as String?,
      totalReservations: data['totalReservations'] as int?,
      pendingReservations: data['pendingReservations'] as int?,
      approvedReservations: data['approvedReservations'] as int?,
      reserveBookInfo: (data['reservations'] as List? ?? [])
          .map((e) => ReserveBookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Reservations toEntity() {
    return Reservations(
      message: message,
      totalReservations: totalReservations,
      pendingReservations: pendingReservations,
      approvedReservations: approvedReservations,
      reserveBookInfo: reserveBookInfo?.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': {
        'totalReservations': totalReservations,
        'pendingReservations': pendingReservations,
        'approvedReservations': approvedReservations,
        'reservations': reserveBookInfo?.map((e) => e.toJson()).toList(),
      },
    };
  }
}
