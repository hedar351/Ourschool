// lib/features/Teacher/ui/bloc/TeacherStudentProfile/teacher_student_profile_event.dart

import 'package:equatable/equatable.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';

// ====== تحميل الملف ======
class GetTeacherStudentProfileEvent extends TeacherStudentProfileEvent {
  final int localStudentNumber;
  final int schoolId;

  const GetTeacherStudentProfileEvent({
    required this.localStudentNumber,
    required this.schoolId,
  });

  @override
  List<Object> get props => [localStudentNumber, schoolId];
}

// ====== تحديث يدوي (سحب للأسفل) ======
class RefreshTeacherStudentProfileEvent extends TeacherStudentProfileEvent {
  final int localStudentNumber;
  final int schoolId;

  const RefreshTeacherStudentProfileEvent({
    required this.localStudentNumber,
    required this.schoolId,
  });

  @override
  List<Object> get props => [localStudentNumber, schoolId];
}

// ====== إعادة التحقق في الخلفية ======
class RevalidateTeacherStudentProfileEvent extends TeacherStudentProfileEvent {
  final int localStudentNumber;
  final int schoolId;

  const RevalidateTeacherStudentProfileEvent({
    required this.localStudentNumber,
    required this.schoolId,
  });

  @override
  List<Object> get props => [localStudentNumber, schoolId];
}

sealed class TeacherStudentProfileEvent extends Equatable {
  const TeacherStudentProfileEvent();

  @override
  List<Object?> get props => [];
}

// ====== تحديث من الكاش ======
class UpdateCachedTeacherStudentProfileEvent
    extends TeacherStudentProfileEvent {
  final Teacherstudentprofileentity profile;

  const UpdateCachedTeacherStudentProfileEvent({required this.profile});

  @override
  List<Object> get props => [profile];
}

// ====== بدء مراقبة الكاش ======
class WatchTeacherStudentProfileEvent extends TeacherStudentProfileEvent {
  final int localStudentNumber;
  final int schoolId;

  const WatchTeacherStudentProfileEvent({
    required this.localStudentNumber,
    required this.schoolId,
  });

  @override
  List<Object> get props => [localStudentNumber, schoolId];
}
