// lib/features/Librarian/data/Model/librarian_loans_model.dart

import 'package:hive/hive.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservation_model.dart';
import 'package:school/features/Librarian/domain/Entity/general_entity/librarian_loans_Entity.dart';

part 'librarian_loans_model.g.dart';

@HiveType(typeId: 35)
class LibrarianLoansModel extends HiveObject {
  @HiveField(0)
  final int? totalCount;

  @HiveField(1)
  final int? activeCount;

  @HiveField(2)
  final int? returnedCount;

  @HiveField(3)
  final List<LibrarianReservationModel>? loans;

  LibrarianLoansModel({
    required this.totalCount,
    required this.activeCount,
    required this.returnedCount,
    required this.loans,
  });

  // ----- fromEntity -----
  factory LibrarianLoansModel.fromEntity(LibrarianLoansEntity entity) {
    return LibrarianLoansModel(
      totalCount: entity.totalCount,
      activeCount: entity.activeCount,
      returnedCount: entity.returnedCount,
      loans: entity.loans
          ?.map((e) => LibrarianReservationModel.fromEntity(e))
          .toList(),
    );
  }

  // ----- fromJson -----
  factory LibrarianLoansModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return LibrarianLoansModel(
      totalCount: data['totalCount'] as int?,
      activeCount: data['activeCount'] as int?,
      returnedCount: data['returnedCount'] as int?,
      loans: (data['loans'] as List? ?? [])
          .map(
            (e) =>
                LibrarianReservationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  // ----- toEntity -----
  LibrarianLoansEntity toEntity() {
    return LibrarianLoansEntity(
      totalCount: totalCount,
      activeCount: activeCount,
      returnedCount: returnedCount,
      loans: loans?.map((e) => e.toEntity()).toList(),
    );
  }

  // ----- toJson -----
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'totalCount': totalCount,
        'activeCount': activeCount,
        'returnedCount': returnedCount,
        'loans': loans?.map((e) => e.toJson()).toList(),
      },
    };
  }
}
