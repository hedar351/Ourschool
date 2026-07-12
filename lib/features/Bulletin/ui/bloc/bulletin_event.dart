part of 'bulletin_bloc.dart';

sealed class BulletinEvent extends Equatable {
  const BulletinEvent();

  @override
  List<Object> get props => [];
}

class GetBulletinsEvent extends BulletinEvent {}

class RefreshBulletinsEvent extends BulletinEvent {}

class RevalidateBulletinsEvent extends BulletinEvent {}

class UpdateCachedbulletinEvent extends BulletinEvent {
  final List<BulletinEntity> bulletins;
  const UpdateCachedbulletinEvent({required this.bulletins});
  @override
  List<Object> get props => [bulletins];
}

class WatchCachedBulletinsEvent extends BulletinEvent {}
