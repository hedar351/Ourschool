import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Student/domain/Repo/StudentRepo.dart';
import 'package:school/features/Student/domain/entity/Student-FullProfile/StudentFullProfileEntity.dart';
import 'package:school/features/Student/domain/useCase/GetFullProfileUseCase.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final Getfullprofileusecase getFullProfileUseCase;
  final StudentRepo studentRepo;
  Stream<List<Studentfullprofileentity>>? _cachedStream;
  StreamSubscription? _subscription;

  StudentBloc({required this.getFullProfileUseCase, required this.studentRepo})
    : super(StudentInitial()) {
    on<GetStudentProfileEvent>(_onGetProfile);
    on<RefreshStudentProfileEvent>(_onRefresh);
    on<WatchCachedStudentProfileEvent>(_onWatchCached);
    on<UpdateCachedStudentProfileEvent>(_onUpdateCached);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // ---- Get Profile (First Load) ----
  Future<void> _onGetProfile(
    GetStudentProfileEvent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    final either = await getFullProfileUseCase();
    either.fold(
      (failure) => emit(StudentError(message: mapFailureToMessage(failure))),
      (profile) {
        emit(StudentLoaded(profile: profile, isRevalidating: false));
        add(WatchCachedStudentProfileEvent());
      },
    );
  }

  // ---- Refresh (Pull to Refresh) ----
  Future<void> _onRefresh(
    RefreshStudentProfileEvent event,
    Emitter<StudentState> emit,
  ) async {
    final either = await studentRepo.getFullprofileWithCached();
    either.fold(
      (failure) => emit(StudentError(message: mapFailureToMessage(failure))),
      (profile) {
        emit(StudentLoaded(profile: profile, isRevalidating: false));
      },
    );
  }

  // ---- Update Cached (Background Update) ----
  Future<void> _onUpdateCached(
    UpdateCachedStudentProfileEvent event,
    Emitter<StudentState> emit,
  ) async {
    if (state is StudentLoaded) {
      final currentState = state as StudentLoaded;
      emit(currentState.copyWith(profile: event.profile));
    } else {
      emit(StudentLoaded(profile: event.profile, isRevalidating: false));
    }
  }

  // ---- Watch Cached (Stream) ----
  Future<void> _onWatchCached(
    WatchCachedStudentProfileEvent event,
    Emitter<StudentState> emit,
  ) async {
    await _subscription?.cancel();

    _cachedStream = studentRepo.watchStudentProfile().map(
      (either) => either.fold(
        (_) => <Studentfullprofileentity>[],
        (profile) => profile,
      ),
    );

    _subscription = _cachedStream?.listen((profile) {
      add(UpdateCachedStudentProfileEvent(profile: profile));
    });
  }
}
