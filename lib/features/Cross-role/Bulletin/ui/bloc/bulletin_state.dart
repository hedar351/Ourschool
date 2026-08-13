part of 'bulletin_bloc.dart';

final class BulletinError extends BulletinState {
  final String message;
  const BulletinError({required this.message});
  @override
  List<Object?> get props => [message];
}

final class BulletinInitial extends BulletinState {}

final class BulletinLoaded extends BulletinState {
  final List<BulletinEntity> bulletins;
  final bool isRevalidating;
  final String? errorMessage;

  const BulletinLoaded({
    required this.bulletins,
    this.isRevalidating = false,
    this.errorMessage,
  });
  @override
  List<Object?> get props => [bulletins, isRevalidating, errorMessage];

  BulletinLoaded copyWith({
    List<BulletinEntity>? bulletins,
    bool? isRevalidating,
    String? errorMessage,
  }) {
    return BulletinLoaded(
      bulletins: bulletins ?? this.bulletins,
      isRevalidating: isRevalidating ?? this.isRevalidating,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class BulletinLoading extends BulletinState {}

sealed class BulletinState extends Equatable {
  const BulletinState();

  @override
  List<Object?> get props => [];
}
