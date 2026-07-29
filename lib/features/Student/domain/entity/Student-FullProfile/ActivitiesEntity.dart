import 'package:equatable/equatable.dart';

class ActivitiesEntity extends Equatable {
  final String? activityName;
  final String? status;
  final String? date;

  const ActivitiesEntity({
    required this.activityName,
    required this.status,
    required this.date,
  });

  @override
  List<Object?> get props => [activityName, status, date];
}
