// lib/features/Librarian/data/models/librarian_reservations_model.dart

import 'package:hive/hive.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservation_model.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_reservations_Entity.dart';

part 'librarian_reservations_model.g.dart';

@HiveType(typeId: 33)
class LibrarianReservationsModel extends HiveObject {
  @HiveField(0)
  final int? totalCount;

  @HiveField(1)
  final int? pendingCount;

  @HiveField(2)
  final int? approvedCount;

  @HiveField(3)
  final int? rejectedCount;

  @HiveField(4)
  final int? cancelledCount;

  @HiveField(5)
  final int? expiredCount;

  @HiveField(6)
  final List<LibrarianReservationModel>? reservations;

  LibrarianReservationsModel({
    required this.totalCount,
    required this.pendingCount,
    required this.approvedCount,
    required this.rejectedCount,
    required this.cancelledCount,
    required this.expiredCount,
    required this.reservations,
  });

  // ----- fromEntity -----
  factory LibrarianReservationsModel.fromEntity(
    LibrarianReservationsEntity entity,
  ) {
    return LibrarianReservationsModel(
      totalCount: entity.totalCount,
      pendingCount: entity.pendingCount,
      approvedCount: entity.approvedCount,
      rejectedCount: entity.rejectedCount,
      cancelledCount: entity.cancelledCount,
      expiredCount: entity.expiredCount,
      reservations: entity.reservations
          ?.map((e) => LibrarianReservationModel.fromEntity(e))
          .toList(),
    );
  }

  // ----- fromJson -----
  factory LibrarianReservationsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return LibrarianReservationsModel(
      totalCount: data['totalCount'] as int?,
      pendingCount: data['pendingCount'] as int?,
      approvedCount: data['approvedCount'] as int?,
      rejectedCount: data['rejectedCount'] as int?,
      cancelledCount: data['cancelledCount'] as int?,
      expiredCount: data['expiredCount'] as int?,
      reservations: (data['reservations'] as List? ?? [])
          .map(
            (e) =>
                LibrarianReservationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  // ----- toEntity -----
  LibrarianReservationsEntity toEntity() {
    return LibrarianReservationsEntity(
      totalCount: totalCount,
      pendingCount: pendingCount,
      approvedCount: approvedCount,
      rejectedCount: rejectedCount,
      cancelledCount: cancelledCount,
      expiredCount: expiredCount,
      reservations: reservations?.map((e) => e.toEntity()).toList(),
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'totalCount': totalCount,
        'pendingCount': pendingCount,
        'approvedCount': approvedCount,
        'rejectedCount': rejectedCount,
        'cancelledCount': cancelledCount,
        'expiredCount': expiredCount,
        'reservations': reservations?.map((e) => e.toJson()).toList(),
      },
    };
  }
}
