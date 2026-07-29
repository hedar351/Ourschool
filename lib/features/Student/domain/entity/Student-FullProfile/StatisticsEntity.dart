import 'package:equatable/equatable.dart';

class StatisticsEntity extends Equatable {
  final int? totalAttendance;
  final int? totalActivities;
  final int? totalWarnings;

  const StatisticsEntity({
    required this.totalAttendance,
    required this.totalActivities,
    required this.totalWarnings,
  });

  @override
  List<Object?> get props => [totalAttendance, totalActivities, totalWarnings];
}
