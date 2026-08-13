part of 'school_info_bloc.dart';

class SchoolInfoError extends SchoolInfoState {
  final String message;

  const SchoolInfoError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SchoolInfoInitial extends SchoolInfoState {}

class SchoolInfoLoaded extends SchoolInfoState {
  final Schoolwithteacherentity schools;
  final bool isRevalidating;
  final String? errorMessage;

  const SchoolInfoLoaded({
    required this.schools,
    this.isRevalidating = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [schools, isRevalidating, errorMessage];

  SchoolInfoLoaded copyWith({
    Schoolwithteacherentity? schools,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return SchoolInfoLoaded(
      schools: schools ?? this.schools,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SchoolInfoLoading extends SchoolInfoState {}

sealed class SchoolInfoState extends Equatable {
  const SchoolInfoState();

  @override
  List<Object?> get props => [];
}
