import 'package:equatable/equatable.dart';

class ActivitiesEntity extends Equatable {
  final String? activityName;
  final int? localActivityId;
  final String? status;
  final String? date;

  const ActivitiesEntity({
    required this.activityName,
    required this.status,
    required this.date,
    required this.localActivityId,
  });

  @override
  List<Object?> get props => [activityName, status, date, localActivityId];
}
