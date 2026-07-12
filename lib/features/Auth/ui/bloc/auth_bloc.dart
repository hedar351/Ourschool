// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Bulletin/data/model/BulletinModel.dart';

import '../../domain/useCases/Log_out_UseCase.dart';
import '../../domain/useCases/LoginUseCase.dart';
import '../../domain/useCases/get_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

void clearHive() async {
  try {
    await Hive.box<Bulletinmodel>('bulletinBox').clear();

    //  مسح باقي Boxes إذا كان لديك أخرى (مثلاً لـ Notifications، إلخ)
    // await Hive.box<AnotherModel>('anotherBox').clear();
    print("🟢 Boxs cleared");
  } catch (e) {
    print("🔴 [Bloc] Failed to clear Boxs: $e");
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetUserUsecase getUserUsecase;
  final LogOutUseCase logoutUseCase;
  AuthBloc({
    required this.loginUseCase,
    required this.getUserUsecase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<CheckAuthEvent>(_onCheckAuth);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckAuth(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    print("🟡 [Bloc] CheckAuthEvent received");

    emit(AuthLoading());
    final result = await getUserUsecase();
    print("🟡 [Bloc] Usecase result: $result");

    result.fold(
      (failure) {
        emit(AuthInitial());
        print("🔴 [Bloc] No user found, emitting AuthInitial");
      },
      (user) {
        print("🟢 [Bloc] User found: ${user.name}, emitting AuthLoaded");
        emit(AuthLoaded(user: user));
      },
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(
      event.username,
      event.password,
      event.rememberMe,
    );
    result.fold(
      (failure) => emit(AuthErorr(message: mapFailureToMessage(failure))),
      (user) => emit(AuthLoaded(user: user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    print("🟡 [Bloc] LogoutEvent received");

    emit(AuthLoading());

    clearHive();

    final result = await logoutUseCase();
    print("🟡 [Bloc] Usecase result: $result");

    result.fold(
      (failure) {
        emit(AuthErorr(message: mapFailureToMessage(failure)));
        print("🔴 [Bloc] No user found, emitting AuthInitial");
      },
      (user) {
        print("🟢 [Bloc] LogOut");
        emit(AuthLogout());
      },
    );
  }
}
