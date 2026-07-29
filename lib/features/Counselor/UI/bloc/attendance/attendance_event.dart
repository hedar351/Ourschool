// lib/features/Counselor/UI/bloc/Attendance/attendance_event.dart

part of 'attendance_bloc.dart';

// ====== إضافة غياب ======
class AddAttendanceEvent extends AttendanceEvent {
  final int localStudentNumber;
  final String date;

  const AddAttendanceEvent({
    required this.localStudentNumber,
    required this.date,
  });

  @override
  List<Object> get props => [localStudentNumber, date];
}

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

// ====== حذف غياب ======
class DeleteAttendanceEvent extends AttendanceEvent {
  final int localStudentNumber;
  final String date;

  const DeleteAttendanceEvent({
    required this.localStudentNumber,
    required this.date,
  });

  @override
  List<Object> get props => [localStudentNumber, date];
}

// ====== إعادة تعيين الحالة ======
class ResetAttendanceEvent extends AttendanceEvent {}
