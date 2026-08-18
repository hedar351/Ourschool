import 'package:equatable/equatable.dart';

class ActivitiesStatisticsEntity extends Equatable {
  final int? total;
  final int? pending;
  final int? approved;
  final int? rejected;

  const ActivitiesStatisticsEntity({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  @override
  List<Object?> get props => [total, pending, approved, rejected];
}
