part of 'teacher_bloc.dart';

sealed class TeacherState extends Equatable {
  const TeacherState();
  
  @override
  List<Object> get props => [];
}

final class TeacherInitial extends TeacherState {}
