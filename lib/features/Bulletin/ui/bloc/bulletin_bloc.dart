import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Bulletin/domain/Entities/BulletinEntity.dart';
import 'package:school/features/Bulletin/domain/Repo/Bulletin_repo.dart';
import 'package:school/features/BulletinScreen/domain/Usecases/GetbulletinsUseCase.dart';

part 'bulletin_event.dart';
part 'bulletin_state.dart';

class BulletinBloc extends Bloc<BulletinEvent, BulletinState> {
  final GetbulletinsUseCase getbulletinsUseCase;
  final BulletinRepo bulletinRepo;
  Stream<List<BulletinEntity>>? _cachedStream;
  StreamSubscription? _subscription;
  BulletinBloc({required this.getbulletinsUseCase, required this.bulletinRepo})
    : super(BulletinInitial()) {
    on<GetBulletinsEvent>(_onGetAll);
    on<RefreshBulletinsEvent>(_onRefresh);
    on<WatchCachedBulletinsEvent>(_onWatchCached);
    on<RevalidateBulletinsEvent>(_onRevalidate);
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // FutureOr<void> _onGetAll(
  //   GetBulletinsEvent event,
  //   Emitter<BulletinState> emit,
  // ) async {
  //   final cachedEither = await getbulletinsUseCase();
  //   cachedEither.fold(
  //     (ifLeft) async {
  //       emit(BulletinLoading());
  //       final networkEither = await bulletinRepo.getBulletins();
  //       networkEither.fold(
  //         (ifLeft) => emit(BulletinError(message: mapFailureToMessage(ifLeft))),
  //         (ifRight) =>
  //             emit(BulletinLoaded(bulletins: ifRight, isRevalidating: false)),
  //       );
  //     },
  //     (ifRight) async {
  //       emit(BulletinLoaded(bulletins: ifRight, isRevalidating: true));
  //     },
  //   );
  //   add(RevalidateBulletinsEvent());
  // }

  FutureOr<void> _onGetAll(
    GetBulletinsEvent event,
    Emitter<BulletinState> emit,
  ) async {
    emit(BulletinLoading());
    final either = await getbulletinsUseCase();
    either.fold(
      (failure) => emit(BulletinError(message: mapFailureToMessage(failure))),
      (bulletins) {
        emit(BulletinLoaded(bulletins: bulletins, isRevalidating: false));
        add(WatchCachedBulletinsEvent());
      },
    );
  }

  FutureOr<void> _onRefresh(
    RefreshBulletinsEvent event,
    Emitter<BulletinState> emit,
  ) async {
    final either = await bulletinRepo.getBulletinsWithCache();
    either.fold(
      (ifLeft) {
        emit(BulletinError(message: mapFailureToMessage(ifLeft)));
      },
      (ifRight) {
        emit(BulletinLoaded(bulletins: ifRight, isRevalidating: false));
      },
    );
  }

  FutureOr<void> _onRevalidate(
    RevalidateBulletinsEvent event,
    Emitter<BulletinState> emit,
  ) async {
    if (state is BulletinLoaded) {
      final currentState = state as BulletinLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }
    final networkEither = await bulletinRepo.getBulletins();
    networkEither.fold(
      (ifLeft) {
        if (state is BulletinLoaded) {
          final currentState = state as BulletinLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(ifLeft),
            ),
          );
        }
      },
      (ifRight) {
        if (state is BulletinLoaded) {
          final currentState = state as BulletinLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  FutureOr<void> _onWatchCached(
    WatchCachedBulletinsEvent event,
    Emitter<BulletinState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = bulletinRepo.watchCachedBulletins();
    _subscription = _cachedStream?.listen((bulletin) {
      if (state is BulletinLoaded) {
        add(UpdateCachedbulletinEvent(bulletins: bulletin));
      }
    });
  }
}
