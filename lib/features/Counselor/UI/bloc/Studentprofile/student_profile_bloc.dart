import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/domain/Entities/StudentsProfileEntity/Counselor_studentFullProfile.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/features/Counselor/domain/UseCases/StudentProfileUseCase.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final Studentprofileusecase studentProfileUseCase;
  final CounselorRepo counselorRepo;
  Stream<CounselorStudentfullprofile>? _cachedStream;
  StreamSubscription? _subscription;

  StudentProfileBloc({
    required this.studentProfileUseCase,
    required this.counselorRepo,
  }) : super(StudentProfileInitial()) {
    on<GetStudentProfileEvent>(_onGet);
    on<RefreshStudentProfileEvent>(_onRefresh);
    on<WatchCachedStudentProfileEvent>(_onWatchCached);
    on<RevalidateStudentProfileEvent>(_onRevalidate);
    on<UpdateCachedStudentProfileEvent>(_onUpdateCached);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onGet(
    GetStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(StudentProfileLoading());
    final either = await studentProfileUseCase(event.localStudentNumber);
    either.fold(
      (failure) =>
          emit(StudentProfileError(message: mapFailureToMessage(failure))),
      (profile) {
        emit(StudentProfileLoaded(profile: profile, isRevalidating: false));
        add(
          WatchCachedStudentProfileEvent(
            localStudentNumber: event.localStudentNumber,
          ),
        );
      },
    );
  }

  FutureOr<void> _onRefresh(
    RefreshStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    if (state is StudentProfileLoaded) {
      final currentState = state as StudentProfileLoaded;
      emit(currentState.copyWith(isRevalidating: true));

      final either = await counselorRepo
          .getCounselorStudentfullProfileWithCache(event.localStudentNumber);
      either.fold(
        (failure) {
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        },
        (newProfile) {
          emit(
            currentState.copyWith(
              profile: newProfile,
              isRevalidating: false,
              errorMessage: null,
            ),
          );
        },
      );
    } else {
      add(GetStudentProfileEvent(localStudentNumber: event.localStudentNumber));
    }
  }

  FutureOr<void> _onRevalidate(
    RevalidateStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    if (state is StudentProfileLoaded) {
      final currentState = state as StudentProfileLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }
    final networkEither = await counselorRepo.getCounselorStudentfullProfile(
      event.localStudentNumber,
    );
    networkEither.fold(
      (failure) {
        if (state is StudentProfileLoaded) {
          final currentState = state as StudentProfileLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        }
      },
      (newProfile) {
        if (state is StudentProfileLoaded) {
          final currentState = state as StudentProfileLoaded;
          emit(
            currentState.copyWith(isRevalidating: false, errorMessage: null),
          );
        }
      },
    );
  }

  FutureOr<void> _onUpdateCached(
    UpdateCachedStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) {
    if (state is StudentProfileLoaded) {
      final currentState = state as StudentProfileLoaded;
      emit(currentState.copyWith(profile: event.profile));
    } else {
      emit(StudentProfileLoaded(profile: event.profile, isRevalidating: false));
    }
  }

  FutureOr<void> _onWatchCached(
    WatchCachedStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    await _subscription?.cancel();
    _cachedStream = counselorRepo.watchCachedgetCounselorStudentfullProfile(
      event.localStudentNumber,
    );
    _subscription = _cachedStream?.listen((profile) {
      if (state is StudentProfileLoaded) {
        add(UpdateCachedStudentProfileEvent(profile: profile));
      }
    });
  }
}
