// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Bulletin/data/dataSources/cachedataSource.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentProfile/cachDataStudentProfile.dart';
import 'package:school/features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentProfile/CacheTeacherStudentProfile.dart';
import 'package:school/features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';

import '../../domain/useCases/Log_out_UseCase.dart';
import '../../domain/useCases/LoginUseCase.dart';
import '../../domain/useCases/get_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  CachedatasourceBulletin cachedatasource;
  final LoginUseCase loginUseCase;
  final GetUserUsecase getUserUsecase;
  final LogOutUseCase logoutUseCase;
  CachedatasourceGrade cachedatasourceGrade;
  CachedatasourceStudentList cachedatasourceStudentList;
  CacheDataStudentProfile cacheDataStudentProfile;
  CacheDataTeacherFullProfile cacheDataTeacherFullProfile;
  CacheTeacherStudentsList cacheTeacherStudentsList;
  CacheTeacherStudentProfile cacheTeacherStudentProfile;
  // StudentCacheDataSource studentCacheDataSource;
  AuthBloc({
    required this.cacheTeacherStudentsList,
    required this.cacheDataStudentProfile,
    required this.cachedatasource,
    required this.cachedatasourceStudentList,
    required this.cachedatasourceGrade,
    required this.cacheDataTeacherFullProfile,
    required this.cacheTeacherStudentProfile,
    // required this.studentCacheDataSource,
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
    await cachedatasource.deleteBulletins();
    await cachedatasourceGrade.deletegrades();
    await cachedatasourceStudentList.deleteStudentsBySection();
    await cacheDataStudentProfile.deleteStudentProfile();
    await cacheDataTeacherFullProfile.deleteTeacherFullProfile();
    await cacheTeacherStudentsList.deleteStudents();
    await cacheTeacherStudentProfile.deleteCachedTeacherStudentProfile();
    // await studentCacheDataSource.deleteProfile();
    result.fold(
      (failure) => emit(AuthErorr(message: mapFailureToMessage(failure))),
      (user) => emit(AuthLoaded(user: user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    print("🟡 [Bloc] LogoutEvent received");

    emit(AuthLoading());

    await cachedatasource.deleteBulletins();
    await cachedatasourceGrade.deletegrades();
    await cachedatasourceStudentList.deleteStudentsBySection();
    await cacheDataStudentProfile.deleteStudentProfile();
    await cacheDataTeacherFullProfile.deleteTeacherFullProfile();
    await cacheTeacherStudentsList.deleteStudents();
    // await studentCacheDataSource.deleteProfile();

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
