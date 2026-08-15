import 'package:hive/hive.dart';
import 'package:school/features/Librarian/domain/Entity/Book-reservations-loans-Entity/statistics_loans.dart';

part 'statistics_loans_model.g.dart';

@HiveType(typeId: 37)
class StatisticsLoansModel extends HiveObject {
  @HiveField(0)
  final int? totalLoans;

  @HiveField(1)
  final int? activeLoans;

  @HiveField(2)
  final int? returnedLoans;

  @HiveField(3)
  final int? overdueLoans;

  StatisticsLoansModel({
    required this.totalLoans,
    required this.activeLoans,
    required this.returnedLoans,
    required this.overdueLoans,
  });

  factory StatisticsLoansModel.fromEntity(StatisticsLoans entity) {
    return StatisticsLoansModel(
      totalLoans: entity.totalLoans,
      activeLoans: entity.activeLoans,
      returnedLoans: entity.returnedLoans,
      overdueLoans: entity.overdueLoans,
    );
  }

  factory StatisticsLoansModel.fromJson(Map<String, dynamic> json) {
    return StatisticsLoansModel(
      totalLoans: json['totalLoans'] as int?,
      activeLoans: json['activeLoans'] as int?,
      returnedLoans: json['returnedLoans'] as int?,
      overdueLoans: json['overdueLoans'] as int?,
    );
  }

  StatisticsLoans toEntity() {
    return StatisticsLoans(
      totalLoans: totalLoans,
      activeLoans: activeLoans,
      returnedLoans: returnedLoans,
      overdueLoans: overdueLoans,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalLoans': totalLoans,
      'activeLoans': activeLoans,
      'returnedLoans': returnedLoans,
      'overdueLoans': overdueLoans,
    };
  }
}
