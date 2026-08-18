part of 'attendance_bloc.dart';

// ====== حالة الخطأ ======
final class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError({required this.message});

  @override
  List<Object> get props => [message];
}

// ====== الحالة الابتدائية ======
final class AttendanceInitial extends AttendanceState {}

// ====== حالة التحميل ======
final class AttendanceLoading extends AttendanceState {}

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

// ====== حالة النجاح ======
final class AttendanceSuccess extends AttendanceState {
  final String message;

  const AttendanceSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
