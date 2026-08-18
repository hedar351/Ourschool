import 'package:equatable/equatable.dart';

class StatisticsEntity extends Equatable {
  final int? totalAttendance;

  const StatisticsEntity({required this.totalAttendance});
  @override
  List<Object?> get props => [totalAttendance];
}
