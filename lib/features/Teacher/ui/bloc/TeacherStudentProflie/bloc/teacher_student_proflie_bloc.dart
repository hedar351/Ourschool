// // lib/features/Teacher/ui/bloc/TeacherStudentProfile/teacher_student_profile_bloc.dart

// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:school/core/const.dart';
// import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
// import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';
// import 'package:school/features/Teacher/domain/UseCases/GetTeacherSudentProfileUseCase.dart';
// import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_event.dart';
// import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_state.dart';

// class TeacherStudentProfileBloc
//     extends Bloc<TeacherStudentProfileEvent, TeacherStudentProfileState> {
//   final Getteachersudentprofileusecase getTeacherStudentProfileUseCase;
//   final Teacherrepo teacherRepo;

//   Stream<Teacherstudentprofileentity>? _cachedStream;
//   StreamSubscription? _subscription;

//   TeacherStudentProfileBloc({
//     required this.getTeacherStudentProfileUseCase,
//     required this.teacherRepo,
//   }) : super(TeacherStudentProfileInitial()) {
//     on<GetTeacherStudentProfileEvent>(_onGetProfile);
//     on<RefreshTeacherStudentProfileEvent>(_onRefreshProfile);
//     on<RevalidateTeacherStudentProfileEvent>(_onRevalidateProfile);
//     on<WatchTeacherStudentProfileEvent>(_onWatchCached);
//     on<UpdateCachedTeacherStudentProfileEvent>(_onUpdateCached);
//   }

//   @override
//   Future<void> close() {
//     _subscription?.cancel();
//     return super.close();
//   }

//   // ====================================================================
//   // ====== 1. GET PROFILE ======
//   // ====================================================================
//   FutureOr<void> _onGetProfile(
//     GetTeacherStudentProfileEvent event,
//     Emitter<TeacherStudentProfileState> emit,
//   ) async {
//     emit(TeacherStudentProfileLoading());

//     final result = await getTeacherStudentProfileUseCase.call(
//       event.localStudentNumber,
//       event.schoolId,
//     );

//     result.fold(
//       (failure) {
//         print('❌ [Bloc] Error: ${ mapFailureToMessage(failure)}');

//         emit(TeacherStudentProfileError(message: mapFailureToMessage(failure)));
//       },
//       (profile) {
//         print('✅ [Bloc] Profile received: ${profile.name}');
//         print('📚 Semester 1 marks: ${profile.semester1Marks?.length}');
//         print('📚 Semester 2 marks: ${profile.semester2Marks?.length}');
//         emit(TeacherStudentProfileLoaded(profile: profile));
//         add(
//           WatchTeacherStudentProfileEvent(
//             localStudentNumber: event.localStudentNumber,
//             schoolId: event.schoolId,
//           ),
//         );
//       },
//     );
//   }

//   // ====================================================================
//   // ====== 2. REFRESH PROFILE (Force network) ======
//   // ====================================================================
//   FutureOr<void> _onRefreshProfile(
//     RefreshTeacherStudentProfileEvent event,
//     Emitter<TeacherStudentProfileState> emit,
//   ) async {
//     emit(TeacherStudentProfileLoading());

//     final result = await teacherRepo.getTeacherStudentsProfileWithCached(
//       event.localStudentNumber,
//       event.schoolId,
//     );

//     result.fold(
//       (failure) => emit(
//         TeacherStudentProfileError(message: mapFailureToMessage(failure)),
//       ),
//       (profile) {
//         emit(TeacherStudentProfileLoaded(profile: profile));
//       },
//     );
//   }

//   // ====================================================================
//   // ====== 3. REVALIDATE PROFILE (Background) ======
//   // ====================================================================
//   FutureOr<void> _onRevalidateProfile(
//     RevalidateTeacherStudentProfileEvent event,
//     Emitter<TeacherStudentProfileState> emit,
//   ) async {
//     if (state is TeacherStudentProfileLoaded) {
//       final currentState = state as TeacherStudentProfileLoaded;
//       emit(currentState.copyWith(isRevalidating: true));
//     }

//     final result = await teacherRepo.getTeacherStudentsProfile(
//       event.localStudentNumber,
//       event.schoolId,
//     );

//     result.fold(
//       (failure) {
//         if (state is TeacherStudentProfileLoaded) {
//           final currentState = state as TeacherStudentProfileLoaded;
//           emit(
//             currentState.copyWith(
//               isRevalidating: false,
//               errorMessage: mapFailureToMessage(failure),
//             ),
//           );
//         } else {
//           emit(
//             TeacherStudentProfileError(message: mapFailureToMessage(failure)),
//           );
//         }
//       },
//       (profile) {
//         if (state is TeacherStudentProfileLoaded) {
//           final currentState = state as TeacherStudentProfileLoaded;
//           emit(
//             currentState.copyWith(isRevalidating: false, errorMessage: null),
//           );
//         } else {
//           emit(TeacherStudentProfileLoaded(profile: profile));
//         }
//       },
//     );
//   }

//   // ====================================================================
//   // ====== 5. UPDATE CACHED PROFILE (from stream) ======
//   // ====================================================================
//   FutureOr<void> _onUpdateCached(
//     UpdateCachedTeacherStudentProfileEvent event,
//     Emitter<TeacherStudentProfileState> emit,
//   ) {
//     if (state is TeacherStudentProfileLoaded) {
//       final currentState = state as TeacherStudentProfileLoaded;
//       emit(currentState.copyWith(profile: event.profile));
//     } else {
//       emit(TeacherStudentProfileLoaded(profile: event.profile));
//     }
//   }

//   // ====================================================================
//   // ====== 4. WATCH CACHED PROFILE ======
//   // ====================================================================
//   FutureOr<void> _onWatchCached(
//     WatchTeacherStudentProfileEvent event,
//     Emitter<TeacherStudentProfileState> emit,
//   ) async {
//     await _subscription?.cancel();

//     _cachedStream = teacherRepo.watchCacheTeacherStudentsProfile(
//       event.localStudentNumber,
//       event.schoolId,
//     );

//     _subscription = _cachedStream?.listen(
//       (profile) {
//         add(UpdateCachedTeacherStudentProfileEvent(profile: profile));
//       },
//       onError: (error) {
//         print('❌ [Bloc] Error watching teacher student profile: $error');
//       },
//     );
//   }
// }
// lib/features/Teacher/ui/bloc/TeacherStudentProfile/bloc/teacher_student_profile_bloc.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Teacher/domain/Entities/TeacherStudentProfile/TeacherStudentProfileEntity.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';
import 'package:school/features/Teacher/domain/UseCases/GetTeacherSudentProfileUseCase.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_event.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_state.dart';

class TeacherStudentProfileBloc
    extends Bloc<TeacherStudentProfileEvent, TeacherStudentProfileState> {
  final Getteachersudentprofileusecase getTeacherStudentProfileUseCase;
  final Teacherrepo teacherRepo;

  Stream<Teacherstudentprofileentity>? _cachedStream;
  StreamSubscription? _subscription;

  TeacherStudentProfileBloc({
    required this.getTeacherStudentProfileUseCase,
    required this.teacherRepo,
  }) : super(TeacherStudentProfileInitial()) {
    on<GetTeacherStudentProfileEvent>(_onGetProfile);
    on<RefreshTeacherStudentProfileEvent>(_onRefreshProfile);
    on<RevalidateTeacherStudentProfileEvent>(_onRevalidateProfile);
    on<WatchTeacherStudentProfileEvent>(_onWatchCached);
    on<UpdateCachedTeacherStudentProfileEvent>(_onUpdateCached);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  // ====== 1. GET PROFILE (التحميل الأولي) ======
  FutureOr<void> _onGetProfile(
    GetTeacherStudentProfileEvent event,
    Emitter<TeacherStudentProfileState> emit,
  ) async {
    emit(TeacherStudentProfileLoading());

    final result = await getTeacherStudentProfileUseCase.call(
      event.localStudentNumber,
      event.schoolId,
    );

    result.fold(
      (failure) => emit(
        TeacherStudentProfileError(message: mapFailureToMessage(failure)),
      ),
      (profile) {
        emit(TeacherStudentProfileLoaded(profile: profile));
        add(
          WatchTeacherStudentProfileEvent(
            localStudentNumber: event.localStudentNumber,
            schoolId: event.schoolId,
          ),
        );
      },
    );
  }

  // ====== 2. REFRESH PROFILE (تحديث يدوي - سحب للأسفل) ======
  FutureOr<void> _onRefreshProfile(
    RefreshTeacherStudentProfileEvent event,
    Emitter<TeacherStudentProfileState> emit,
  ) async {
    if (state is TeacherStudentProfileLoaded) {
      final currentState = state as TeacherStudentProfileLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final result = await teacherRepo.getTeacherStudentsProfileWithCached(
      event.localStudentNumber,
      event.schoolId,
    );

    result.fold(
      (failure) {
        if (state is TeacherStudentProfileLoaded) {
          final currentState = state as TeacherStudentProfileLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        } else {
          emit(
            TeacherStudentProfileError(message: mapFailureToMessage(failure)),
          );
        }
      },
      (profile) {
        if (state is TeacherStudentProfileLoaded) {
          final currentState = state as TeacherStudentProfileLoaded;
          emit(
            currentState.copyWith(
              profile: profile,
              isRevalidating: false,
              errorMessage: null,
            ),
          );
        } else {
          emit(TeacherStudentProfileLoaded(profile: profile));
        }
      },
    );
  }

  // ====== 3. REVALIDATE PROFILE (تحديث خلفي) ======
  FutureOr<void> _onRevalidateProfile(
    RevalidateTeacherStudentProfileEvent event,
    Emitter<TeacherStudentProfileState> emit,
  ) async {
    if (state is TeacherStudentProfileLoaded) {
      final currentState = state as TeacherStudentProfileLoaded;
      emit(currentState.copyWith(isRevalidating: true));
    }

    final result = await teacherRepo.getTeacherStudentsProfile(
      event.localStudentNumber,
      event.schoolId,
    );

    result.fold(
      (failure) {
        if (state is TeacherStudentProfileLoaded) {
          final currentState = state as TeacherStudentProfileLoaded;
          emit(
            currentState.copyWith(
              isRevalidating: false,
              errorMessage: mapFailureToMessage(failure),
            ),
          );
        } else {
          emit(
            TeacherStudentProfileError(message: mapFailureToMessage(failure)),
          );
        }
      },
      (profile) {
        if (state is TeacherStudentProfileLoaded) {
          final currentState = state as TeacherStudentProfileLoaded;
          emit(
            currentState.copyWith(
              profile: profile,
              isRevalidating: false,
              errorMessage: null,
            ),
          );
        } else {
          emit(TeacherStudentProfileLoaded(profile: profile));
        }
      },
    );
  }

  // ====== 5. UPDATE CACHED ======
  FutureOr<void> _onUpdateCached(
    UpdateCachedTeacherStudentProfileEvent event,
    Emitter<TeacherStudentProfileState> emit,
  ) {
    if (state is TeacherStudentProfileLoaded) {
      final currentState = state as TeacherStudentProfileLoaded;
      emit(currentState.copyWith(profile: event.profile));
    } else {
      emit(TeacherStudentProfileLoaded(profile: event.profile));
    }
  }

  // ====== 4. WATCH CACHED ======
  FutureOr<void> _onWatchCached(
    WatchTeacherStudentProfileEvent event,
    Emitter<TeacherStudentProfileState> emit,
  ) async {
    await _subscription?.cancel();

    _cachedStream = teacherRepo.watchCacheTeacherStudentsProfile(
      event.localStudentNumber,
      event.schoolId,
    );

    _subscription = _cachedStream?.listen(
      (profile) {
        add(UpdateCachedTeacherStudentProfileEvent(profile: profile));
      },
      onError: (error) {
        print('❌ [Bloc] Error watching teacher student profile: $error');
      },
    );
  }
}
