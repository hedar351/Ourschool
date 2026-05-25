import 'package:equatable/equatable.dart';

class EmptyCacheFailure extends Failures {
  @override
  List<Object?> get props => [];
}

abstract class Failures extends Equatable {}

class LogoutFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failures {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures {
  @override
  List<Object?> get props => [];
}
