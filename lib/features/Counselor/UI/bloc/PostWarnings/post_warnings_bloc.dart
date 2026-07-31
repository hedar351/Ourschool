import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_event.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_state.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/features/Counselor/domain/UseCases/Postwarningsusecase.dart';

class PostWarningBloc extends Bloc<PostWarningEvent, PostWarningState> {
  final Postwarningsusecase postWarningsUseCase;
  final CounselorRepo counselorRepo;

  PostWarningBloc({
    required this.postWarningsUseCase,
    required this.counselorRepo,
  }) : super(PostWarningInitial()) {
    print("🟢 [PostWarningBloc] Constructor called");

    on<AddPostWarningEvent>(_onPostWarning);
  }

  FutureOr<void> _onPostWarning(
    AddPostWarningEvent event,
    Emitter<PostWarningState> emit,
  ) async {
    emit(PostWarningLoading());

    final either = await postWarningsUseCase(
      event.localStudentNumber,
      event.type,
      event.reason,
    );

    await either.fold(
      (failure) {
        emit(PostWarningError(message: mapFailureToMessage(failure)));
      },
      (warning) async {
        await _updateStudentProfileCache(event.localStudentNumber);
        print("🟡 [PostWarningBloc] Emitting PostWarningSuccess");
        emit(PostWarningSuccess(warning: warning));
      },
    );
  }

  Future<void> _updateStudentProfileCache(int localStudentNumber) async {
    try {
      final updatedProfile = await counselorRepo
          .getCounselorStudentfullProfileWithCache(localStudentNumber);
      updatedProfile.fold(
        (failure) => print('⚠️ Failed to update profile cache: $failure'),
        (profile) {
          print('✅ Profile cache updated with new warning');
        },
      );
    } catch (e) {
      print('🔴 Error updating profile cache: $e');
    }
  }
}
