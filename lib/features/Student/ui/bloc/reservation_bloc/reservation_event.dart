import 'package:equatable/equatable.dart';
import 'package:school/features/Student/domain/entity/Library/reservations.dart';

/// جلب الحجوزات (أول مرة)
class GetReservationsEvent extends ReservationEvent {}

/// تحديث الحجوزات (سحب للأسفل)
class RefreshReservationsEvent extends ReservationEvent {}

sealed class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

/// إعادة التحقق من الحجوزات (خلفية)
class RevalidateReservationsEvent extends ReservationEvent {}

/// تحديث الحجوزات من الكاش
class UpdateCachedReservationsEvent extends ReservationEvent {
  final Reservations reservations;

  const UpdateCachedReservationsEvent({required this.reservations});

  @override
  List<Object> get props => [reservations];
}

/// بدء مراقبة الحجوزات في الكاش
class WatchCachedReservationsEvent extends ReservationEvent {}
