import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school/core/const.dart';
import 'package:school/features/Activities/data/data_source/activities_registrations_cache_data_source.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentProfile/cachDataStudentProfile.dart';
import 'package:school/features/Cross-role/Bulletin/data/dataSources/cachedataSource.dart';
import 'package:school/features/FirstStep/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_loans_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_reservations_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/loans/librarian_loans_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/reservations/librarian_reservations_cache_data_source.dart';
import 'package:school/features/Student/data/DataSource/library_cache_data_source.dart';
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
  LibraryCacheDataSource libraryCacheDataSource;
  LibrarianReservationsCacheDataSource librarianReservationsCacheDataSource;
  LibrarianLoansCacheDataSource librarianLoansCacheDataSource;
  BookReservationsCacheDataSource bookReservationsCacheDataSource;
  BookLoansCacheDataSource bookLoansCacheDataSource;
  ActivitiesRegistrationsCacheDataSource activitiesRegistrationsCacheDataSource;
  // CacheTeacherStudentProfile cacheTeacherStudentProfile;

  AuthBloc({
    required this.cacheTeacherStudentsList,
    required this.cacheDataStudentProfile,
    required this.cachedatasource,
    required this.cachedatasourceStudentList,
    required this.cachedatasourceGrade,
    required this.cacheDataTeacherFullProfile,
    required this.cacheTeacherStudentProfile,
    required this.libraryCacheDataSource,
    required this.loginUseCase,
    required this.getUserUsecase,
    required this.logoutUseCase,
    required this.librarianReservationsCacheDataSource,
    required this.librarianLoansCacheDataSource,
    required this.bookReservationsCacheDataSource,
    required this.bookLoansCacheDataSource,
    required this.activitiesRegistrationsCacheDataSource,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<CheckAuthEvent>(_onCheckAuth);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> clearCaches() async {
    await cachedatasource.deleteBulletins();
    await cachedatasourceGrade.deletegrades();
    await cachedatasourceStudentList.deleteStudentsBySection();
    await cacheDataStudentProfile.deleteStudentProfile();
    await cacheDataTeacherFullProfile.deleteTeacherFullProfile();
    await cacheTeacherStudentsList.deleteStudents();
    await libraryCacheDataSource.deleteBooks();
    await libraryCacheDataSource.deleteReservations();
    await librarianReservationsCacheDataSource.deleteLibrarianReservations();
    await librarianLoansCacheDataSource.deleteLibrarianLoans();
    await bookReservationsCacheDataSource.deleteBookAllReservations();
    await bookLoansCacheDataSource.deleteAllBookLoans();
    await activitiesRegistrationsCacheDataSource.deleteAll();
    await cacheTeacherStudentProfile.deleteCachedTeacherStudentProfile();
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
    await clearCaches();

    result.fold((failure) {
      final message = mapFailureToMessage(failure);
      emit(AuthErorr(message: message));
    }, (user) => emit(AuthLoaded(user: user)));
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    print("🟡 [Bloc] LogoutEvent received");

    emit(AuthLoading());

    await clearCaches();

    final result = await logoutUseCase();
    print("🟡 [Bloc] Usecase result: $result");

    result.fold(
      (failure) {
        final message = mapFailureToMessage(failure);
        emit(AuthErorr(message: message));
      },

      (_) {
        print("🟢 [Bloc] LogOut");
        emit(AuthInitial());
        // AuthLogout
      },
    );
  }
}
