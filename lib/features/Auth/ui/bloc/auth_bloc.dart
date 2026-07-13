// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Bulletin/data/dataSources/cachedataSource.dart';

import '../../domain/useCases/Log_out_UseCase.dart';
import '../../domain/useCases/LoginUseCase.dart';
import '../../domain/useCases/get_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// Future<void> clearHive() async {
//   try {
//     // 1. التأكد من أن الصندوق مفتوح
//     if (Hive.isBoxOpen('bulletinBox')) {
//       final box = Hive.box('bulletinBox');

//       // 2. مسح الصندوق مع معالجة الأخطاء الداخلية
//       try {
//         await box.clear();
//         print("🟢 [Bloc] Hive box cleared successfully");
//       } catch (innerError) {
//         print("🔴 [Bloc] Error while clearing Hive box: $innerError");
//         // لا نعيد رمي الخطأ، فقط نسجل
//       }
//     } else {
//       // 3. إذا كان الصندوق مغلقاً، نحاول فتحه ومسحه
//       print("🟡 [Bloc] Hive box is not open, attempting to open and clear");
//       try {
//         final box = await Hive.openBox('bulletinBox');
//         await box.clear();
//         print("🟢 [Bloc] Hive box opened and cleared successfully");
//       } catch (openError) {
//         print("🔴 [Bloc] Failed to open and clear Hive box: $openError");
//       }
//     }
//   } catch (e) {
//     // 4. معالجة أي خطأ غير متوقع
//     print("🔴 [Bloc] Unexpected error in clearHive: $e");
//   }
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Cachedatasource cachedatasource;
  final LoginUseCase loginUseCase;
  final GetUserUsecase getUserUsecase;
  final LogOutUseCase logoutUseCase;
  AuthBloc({
    required this.cachedatasource,
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

    await cachedatasource.deleteBulletins();
    // await clearHive();

    final result = await logoutUseCase();
    print("🟡 [Bloc] Usecase result: $result");

    result.fold(
      (failure) {
        emit(AuthErorr(message: mapFailureToMessage(failure)));
        print("🔴 [Bloc] No user found, emitting AuthInitial");
      },
      (_) {
        print("🟢 [Bloc] LogOut");
        emit(AuthInitial());
        // AuthLogout
      },
    );
  }
}
