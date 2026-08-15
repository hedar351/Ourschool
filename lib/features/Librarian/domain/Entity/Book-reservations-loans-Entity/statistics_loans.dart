import 'package:equatable/equatable.dart';

class StatisticsLoans extends Equatable {
  final int? totalLoans;
  final int? activeLoans;
  final int? returnedLoans;
  final int? overdueLoans;
  const StatisticsLoans({
    required this.totalLoans,
    required this.activeLoans,
    required this.returnedLoans,
    required this.overdueLoans,
  });

  @override
  List<Object?> get props => [
    totalLoans,
    activeLoans,
    returnedLoans,
    overdueLoans,
  ];
}
