import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school/features/Activities/UI/bloc/activitiesBloc/activities_bloc.dart';
import 'package:school/features/Activities/UI/bloc/activities_registrations_bloc/activities_registrations_bloc.dart';
import 'package:school/features/Activities/data/data_source/activities_registrations_cache_data_source.dart';
import 'package:school/features/Activities/data/data_source/activities_registrations_remote_data_source.dart';
import 'package:school/features/Activities/data/data_source/activities_remote_data.dart';
import 'package:school/features/Activities/data/model/activities_registrations_model.dart';
import 'package:school/features/Activities/data/model/activities_statistics_model.dart';
import 'package:school/features/Activities/data/model/registrations_info_model.dart';
import 'package:school/features/Activities/data/repo_imp/activity_repo_imp.dart';
import 'package:school/features/Activities/domain/repo/activites_repo.dart';
import 'package:school/features/Activities/domain/useCase/activities_registrations_use_case.dart';
import 'package:school/features/Activities/domain/useCase/add_activity_use_case.dart';
import 'package:school/features/Activities/domain/useCase/approve_registrations_use_case.dart';
import 'package:school/features/Activities/domain/useCase/delete_activity_use_case.dart';
import 'package:school/features/Activities/domain/useCase/edit_activity_use_case.dart';
import 'package:school/features/Activities/domain/useCase/reject_registrations_use_case.dart';
import 'package:school/features/Librarian/UI/Bloc/AddDeleteEdit/add_delete_edit_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/BookLoansBloc/book_loans_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/BookReservationsBloc/book_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/LibrarianBloc/librarian_bloc.dart';
import 'package:school/features/Librarian/UI/Bloc/LibrarianReservationsLoansBloc/librarian_reservations_loans_bloc.dart';
import 'package:school/features/Librarian/data/DataSource/Actions_dataSource/actions_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_loans_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_loans_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_reservations_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/Book-reservations-loans-Data/book_reservations_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/LibrarianRemoteDataSource.dart';
import 'package:school/features/Librarian/data/DataSource/loans/librarian_loans_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/loans/librarian_loans_remote_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/reservations/librarian_reservations_cache_data_source.dart';
import 'package:school/features/Librarian/data/DataSource/reservations/librarian_reservations_remote_data_source.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/book_loan_model.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/book_reservations_model.dart';
import 'package:school/features/Librarian/data/Model/Book-reservations-loans-Model/statistics_loans_model.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_loans_model.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservation_model.dart';
import 'package:school/features/Librarian/data/Model/general_Model/librarian_reservations_model.dart';
import 'package:school/features/Librarian/data/RepoImp/Librarian_Repo_Imp.dart';
import 'package:school/features/Librarian/domain/Repo/Librarian_Repo.dart';
import 'package:school/features/Librarian/domain/UseCase/GetLibrarianLoansUsecase.dart';
import 'package:school/features/Librarian/domain/UseCase/addBooksUseCase.dart';
import 'package:school/features/Librarian/domain/UseCase/approve_reservations_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/delete_book_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/edit_book_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/getBookLoansUseCase.dart';
import 'package:school/features/Librarian/domain/UseCase/getBookReservationsUseCase.dart';
import 'package:school/features/Librarian/domain/UseCase/getBooksLibrarianUseCase.dart';
import 'package:school/features/Librarian/domain/UseCase/getLibrarianReservationsUseCase.dart';
import 'package:school/features/Librarian/domain/UseCase/post_loans_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/reject_reservations_use_case.dart';
import 'package:school/features/Librarian/domain/UseCase/return_loans_use_case.dart';
import 'package:school/features/Student/data/DataSource/library_cache_data_source.dart';
import 'package:school/features/Student/data/DataSource/library_remote_data_source.dart';
import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reservations_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_book_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_model.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/ActivitiesModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/MarksStatisticsModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StatisticsModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StudentFullProfileModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StudentInfoModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/SummonsModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/loan_model.dart';
import 'package:school/features/Student/data/RepoImp/library_repo_imp.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/useCase/GetReserveBookUseCase.dart';
import 'package:school/features/Student/domain/useCase/get_books_usecase.dart';
import 'package:school/features/Student/domain/useCase/reserveBookUseCase.dart';
import 'package:school/features/Student/ui/bloc/libraryBloc/library_bloc.dart';
import 'package:school/features/Student/ui/bloc/reservation_bloc/reservation_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ----- Counselor -----
import '../features/Counselor/UI/bloc/GradeBloc/grade_bloc.dart';
import '../features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
import '../features/Counselor/UI/bloc/StudentListBLoc/student_list_bloc.dart';
import '../features/Counselor/UI/bloc/Studentprofile/student_profile_bloc.dart';
import '../features/Counselor/UI/bloc/attendance/attendance_bloc.dart';
import '../features/Counselor/UI/bloc/schedule-imagesBloc/schedule_images_bloc.dart';
import '../features/Counselor/data/DataSources/Grade/cachedatasource.dart';
import '../features/Counselor/data/DataSources/Grade/remotdatasource.dart';
import '../features/Counselor/data/DataSources/PostWarnings/RemotedataPostWarnings.dart';
import '../features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
import '../features/Counselor/data/DataSources/StudentList/RemotedataSource.dart';
import '../features/Counselor/data/DataSources/StudentProfile/RemoteDataStudentProfile.dart';
import '../features/Counselor/data/DataSources/StudentProfile/cachDataStudentProfile.dart';
import '../features/Counselor/data/DataSources/attendance/attendanceRemoteData.dart';
import '../features/Counselor/data/DataSources/scheduleImage/remoteDataScheduleImage.dart';
import '../features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';
import '../features/Counselor/data/Model/StudentsBySectionModel/studentModel.dart';
import '../features/Counselor/data/Model/StudentsProfileModel/Counselor_MarkModel.dart';
import '../features/Counselor/data/Model/StudentsProfileModel/Counselor_SubjectsModel.dart';
import '../features/Counselor/data/Model/StudentsProfileModel/Counselor_WarningsModel.dart';
import '../features/Counselor/data/Model/StudentsProfileModel/Counselor_studentFullProfileModel.dart';
import '../features/Counselor/data/Model/attendanceModel/attendanceModel.dart';
import '../features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';
import '../features/Counselor/data/Model/gradeandSectionModel/sectionModel.dart';
import '../features/Counselor/data/RepoImp/Counselor_Repo_Imp.dart';
import '../features/Counselor/domain/Repo/CounselorRepo.dart';
import '../features/Counselor/domain/UseCases/AddAttendanceUseCase.dart';
import '../features/Counselor/domain/UseCases/DeleteAttendanceUseCase.dart';
import '../features/Counselor/domain/UseCases/GetScheduleImageUseCase.dart';
import '../features/Counselor/domain/UseCases/GradeAndSectionUseCase.dart';
import '../features/Counselor/domain/UseCases/Postwarningsusecase.dart';
import '../features/Counselor/domain/UseCases/StudentBySectionUseCase.dart';
import '../features/Counselor/domain/UseCases/StudentProfileUseCase.dart';
// ----- Bulletin -----
import '../features/Cross-role/Bulletin/data/dataSources/RemotedataSource.dart';
import '../features/Cross-role/Bulletin/data/dataSources/cachedataSource.dart';
import '../features/Cross-role/Bulletin/data/model/AnnouncementActivityModel.dart';
import '../features/Cross-role/Bulletin/data/model/BulletinModel.dart';
import '../features/Cross-role/Bulletin/data/repoImp/BulletinRepoImp.dart';
import '../features/Cross-role/Bulletin/domain/Repo/Bulletin_repo.dart';
import '../features/Cross-role/Bulletin/domain/Usecases/GetbulletinsUseCase.dart';
import '../features/Cross-role/Bulletin/ui/bloc/bulletin_bloc.dart';
// ----- Auth -----
import '../features/FirstStep/Auth/data/datasources/local_data_source.dart';
import '../features/FirstStep/Auth/data/datasources/remote_data_source.dart';
import '../features/FirstStep/Auth/data/repoImp/auth_repo_imp.dart';
import '../features/FirstStep/Auth/domain/repo/auth_repo.dart';
import '../features/FirstStep/Auth/domain/useCases/Log_out_UseCase.dart';
import '../features/FirstStep/Auth/domain/useCases/LoginUseCase.dart';
import '../features/FirstStep/Auth/domain/useCases/get_user_usecase.dart';
import '../features/FirstStep/Auth/ui/bloc/auth_bloc.dart';
// ----- SchoolsInfo -----
import '../features/FirstStep/SchoolsInfo/UI/bloc/school_info_bloc.dart';
import '../features/FirstStep/SchoolsInfo/data/DataSource/SchoolCacheDataSource.dart';
import '../features/FirstStep/SchoolsInfo/data/DataSource/SchoolRemoteDataSource.dart';
import '../features/FirstStep/SchoolsInfo/data/RepoImp/SchoolRepositoryImpl.dart';
import '../features/FirstStep/SchoolsInfo/data/models/SchoolInfoModel.dart';
import '../features/FirstStep/SchoolsInfo/data/models/SchoolWithTeacherModel.dart';
import '../features/FirstStep/SchoolsInfo/data/models/SectionsModel.dart';
import '../features/FirstStep/SchoolsInfo/data/models/SubjectsModel.dart';
import '../features/FirstStep/SchoolsInfo/data/models/TeacherInfoModel.dart';
import '../features/FirstStep/SchoolsInfo/domain/Repo/SchoolRepository.dart';
import '../features/FirstStep/SchoolsInfo/domain/UseCase/SchoolwithTeacherUseCase.dart';
// ----- Student -----
import '../features/Student/data/DataSource/StudentCacheDataSource.dart';
import '../features/Student/data/DataSource/StudentRemoteDataSource.dart';
import '../features/Student/data/RepoImp/StudentRepoImp.dart';
import '../features/Student/domain/Repo/StudentRepo.dart';
import '../features/Student/domain/useCase/GetFullProfileUseCase.dart';
import '../features/Student/ui/bloc/ProfileBloc/student_bloc.dart';
// ----- Teacher -----
import '../features/Teacher/data/Model/SchoolModel.dart';
import '../features/Teacher/data/Model/SubjectModel.dart';
import '../features/Teacher/data/Model/TeacherFullProfileModel.dart';
import '../features/Teacher/data/Model/TeacherModel.dart';
import '../features/Teacher/data/Model/TeacherStudentProfileModel/SemesterMarksModel.dart';
import '../features/Teacher/data/Model/TeacherStudentProfileModel/TeacherStudentProfileModel.dart';
import '../features/Teacher/data/RepoImp/TeacherRepoImp.dart';
import '../features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
import '../features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
import '../features/Teacher/data/dataSources/Marks/MarksRemoteDataSources.dart';
import '../features/Teacher/data/dataSources/TeacherStudentProfile/CacheTeacherStudentProfile.dart';
import '../features/Teacher/data/dataSources/TeacherStudentProfile/RemoteTeacherStudentProfile.dart';
import '../features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
import '../features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
import '../features/Teacher/domain/Repo/TeacherRepo.dart';
import '../features/Teacher/domain/UseCases/EditMarkUseCase.dart';
import '../features/Teacher/domain/UseCases/GetStudentsUseCase.dart';
import '../features/Teacher/domain/UseCases/GetTeacherFullProfile.dart';
import '../features/Teacher/domain/UseCases/GetTeacherSudentProfileUseCase.dart';
import '../features/Teacher/domain/UseCases/addMarksUseCase.dart';
import '../features/Teacher/domain/UseCases/deleteMarksUseCase.dart';
import '../features/Teacher/ui/bloc/MarkBloc/mark_bloc.dart';
import '../features/Teacher/ui/bloc/StudentListBloc/teacher_student_list_bloc.dart';
import '../features/Teacher/ui/bloc/TeacherBloc/teacher_bloc.dart';
import '../features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_bloc.dart';
// ----- Core -----
import 'services/network.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ====================================================================
  // 1. Hive Setup
  // ====================================================================
  await Hive.initFlutter();
  print('✅ Hive initialized');

  // ----- 1.1 Register Adapters -----
  // Bulletin
  Hive.registerAdapter(AnnouncementActivityModelAdapter());
  Hive.registerAdapter(BulletinmodelAdapter());

  // Counselor
  Hive.registerAdapter(GradeModelAdapter());
  Hive.registerAdapter(SectionModelAdapter());
  Hive.registerAdapter(StudentmodelAdapter());
  Hive.registerAdapter(StudentsbysectionmodelAdapter());
  Hive.registerAdapter(CounselorStudentFullProfileModelAdapter());
  Hive.registerAdapter(CounselorSubjectModelAdapter());
  Hive.registerAdapter(CounselorMarkModelAdapter());
  Hive.registerAdapter(CounselorWarningModelAdapter());

  // Teacher
  Hive.registerAdapter(TeacherFullProfileModelAdapter());
  Hive.registerAdapter(TeacherModelAdapter());
  Hive.registerAdapter(SchoolsModelAdapter());
  Hive.registerAdapter(SubjectModelAdapter());

  // Schools Info
  Hive.registerAdapter(SubjectsModelAdapter());
  Hive.registerAdapter(SectionsModelAdapter());
  Hive.registerAdapter(TeacherInfoModelAdapter());
  Hive.registerAdapter(SchoolInfoModelAdapter());
  Hive.registerAdapter(SchoolWithTeacherModelAdapter());

  // Teacher Student Profile
  Hive.registerAdapter(SemesterMarksModelAdapter());
  Hive.registerAdapter(TeacherStudentProfileModelAdapter());

  // Attendance
  Hive.registerAdapter(AttendancemodelAdapter());

  // Student
  Hive.registerAdapter(StudentInfoModelAdapter());
  Hive.registerAdapter(StatisticsModelAdapter());
  Hive.registerAdapter(ActivitiesModelAdapter());
  Hive.registerAdapter(SummonsModelAdapter());
  Hive.registerAdapter(StudentFullProfileModelAdapter());
  Hive.registerAdapter(BookModelAdapter()); // typeId: 27
  Hive.registerAdapter(ReserveBookModelAdapter()); // typeId: 28
  Hive.registerAdapter(ReserveModelAdapter());
  Hive.registerAdapter(ReservationsModelAdapter()); // typeId: 31
  Hive.registerAdapter(LoanModelAdapter()); // typeId: 31
  // ----- Librarian -----
  Hive.registerAdapter(LibrarianReservationModelAdapter()); // typeId: 32
  Hive.registerAdapter(LibrarianReservationsModelAdapter()); // typeId: 34
  Hive.registerAdapter(LibrarianLoansModelAdapter()); // typeId: 35
  Hive.registerAdapter(BookReservationsModelAdapter()); // typeId: 36
  Hive.registerAdapter(StatisticsLoansModelAdapter()); // typeId: 37
  Hive.registerAdapter(BookLoanModelAdapter()); // typeId: 38
  Hive.registerAdapter(MarksStatisticsModelAdapter()); // typeId: 39
  Hive.registerAdapter(ActivitiesStatisticsModelAdapter()); // typeId: 40
  Hive.registerAdapter(RegistrationsInfoModelAdapter()); // typeId: 41
  Hive.registerAdapter(ActivitiesRegistrationsModelAdapter()); // typeId: 42
  // ----- 1.2 Open Boxes -----
  final bulletinbox = await Hive.openBox<Bulletinmodel>('bulletinBox');
  final gradebox = await Hive.openBox<GradeModel>('gradebox');
  final studentsBySectionBox = await Hive.openBox<Studentsbysectionmodel>(
    'studentsBySectionBox',
  );
  final studentProfileBox =
      await Hive.openBox<CounselorStudentFullProfileModel>(
        'studentFullProfileBox',
      );
  final teacherFullProfileBox = await Hive.openBox<TeacherFullProfileModel>(
    'teacherFullProfileBox',
  );
  final schoolBox = await Hive.openBox<SchoolWithTeacherModel>('schoolBox');
  final semesterMarksBox = await Hive.openBox<SemesterMarksModel>(
    'semesterMarksBox',
  );
  final teacherStudentProfileBox =
      await Hive.openBox<TeacherStudentProfileModel>(
        'teacherStudentProfileBox',
      );
  final studentProfileBoxNew = await Hive.openBox<StudentFullProfileModel>(
    'studentProfileBox',
  );
  final libraryBox = await Hive.openBox<BookModel>('libraryBox');
  sl.registerLazySingleton(() => libraryBox);
  final reservationsBox = await Hive.openBox<ReservationsModel>(
    'reservationsBox',
  );
  sl.registerLazySingleton(() => reservationsBox);

  final librarianReservationsBox =
      await Hive.openBox<LibrarianReservationsModel>(
        'librarianReservationsBox',
      );

  sl.registerLazySingleton(() => librarianReservationsBox);

  final librarianLoansBox = await Hive.openBox<LibrarianLoansModel>(
    'librarianLoansBox',
  );

  sl.registerLazySingleton(() => librarianLoansBox);
  final bookReservationsBox = await Hive.openBox<BookReservationsModel>(
    'bookReservationsBox',
  );

  sl.registerLazySingleton(() => bookReservationsBox);

  final bookLoanBox = await Hive.openBox<BookLoanModel>('bookLoanBox');
  sl.registerLazySingleton(() => bookLoanBox);

  final activitiesRegistrationsBox =
      await Hive.openBox<ActivitiesRegistrationsModel>(
        'activitiesRegistrationsBox',
      );
  sl.registerLazySingleton(() => activitiesRegistrationsBox);
  print('✅ All Hive boxes opened');

  // ====================================================================
  // 2. External Dependencies
  // ====================================================================
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ====================================================================
  // 3. STUDENT FEATURE
  // ====================================================================
  _initStudent(studentProfileBoxNew);

  // ====================================================================
  // 4. AUTH FEATURE
  // ====================================================================
  _initAuth();

  // ====================================================================
  // 5. BULLETIN FEATURE
  // ====================================================================
  _initBulletin(bulletinbox);

  // ====================================================================
  // 6. COUNSELOR FEATURE
  // ====================================================================
  _initCounselor(
    gradebox: gradebox,
    studentsBySectionBox: studentsBySectionBox,
    studentProfileBox: studentProfileBox,
  );

  // ====================================================================
  // 7. TEACHER FEATURE
  // ====================================================================
  _initTeacher(
    teacherFullProfileBox: teacherFullProfileBox,
    studentsBySectionBox: studentsBySectionBox,
    semesterMarksBox: semesterMarksBox,
    teacherStudentProfileBox: teacherStudentProfileBox,
  );

  // ====================================================================
  // 8. SCHOOLS INFO FEATURE
  // ====================================================================
  _initSchoolsInfo(schoolBox: schoolBox);
  _initLibrary(libraryBox: libraryBox, reservationsBox: reservationsBox);
  // ====================================================================
  // 9. LIBRARIAN FEATURE
  // ====================================================================
  _initLibrarian();

  _initActivities();
  print('✅ All dependencies registered successfully!');
}

void _initActivities() {
  // ============================================================
  // ====== Remote Data Source ======
  // ============================================================

  sl.registerLazySingleton<ActivitiesRemoteData>(
    () => ActivitiesRemoteDataImp(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<ActivitiesRegistrationsRemoteDataSource>(
    () => ActivitiesRegistrationsRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ActivitiesRegistrationsCacheDataSource>(
    () => ActivitiesRegistrationsCacheDataSourceImpl(
      box: sl<Box<ActivitiesRegistrationsModel>>(),
    ),
  );
  // ============================================================
  // ====== Repository ======
  // ============================================================

  sl.registerLazySingleton<ActivitesRepo>(
    () => ActivityRepoImp(
      activitiesRemoteData: sl(),
      networkInfo: sl(),
      remote: sl(),
      cache: sl(),
    ),
  );

  // ============================================================
  // ====== Use Cases ======
  // ============================================================

  sl.registerLazySingleton(() => AddActivityUseCase(repository: sl()));

  sl.registerLazySingleton(() => EditActivityUseCase(repository: sl()));

  sl.registerLazySingleton(() => DeleteActivityUseCase(repository: sl()));
  sl.registerLazySingleton(() => ActivitiesRegistrationsUseCase(repo: sl()));
  sl.registerLazySingleton(() => ApproveRegistrationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => RejectRegistrationsUseCase(repository: sl()));
  // ============================================================
  // ====== Bloc ======
  // ============================================================

  sl.registerFactory(
    () => ActivitiesBloc(
      addActivityUseCase: sl(),
      editActivityUseCase: sl(),
      deleteActivityUseCase: sl(),
      activitiesRepo: sl(),
      approveRegistrationsUseCase: sl(),
      rejectRegistrationsUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ActivitiesRegistrationsBloc(
      getRegistrationsUseCase: sl(),
      activitiesRepo: sl<ActivitesRepo>(),
    ),
  );
  print('✅ Activities feature registered');
}

// ======================================================================
// ====== AUTH FEATURE ======
// ======================================================================

void _initAuth() {
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImp(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImp(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      networkInfo: sl(),
      authRemoteDataSources: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // ----- Use Cases (مع تمرير studentCacheDataSource) -----
  sl.registerLazySingleton(
    () => LoginUseCase(repository: sl(), studentCacheDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetUserUsecase(repository: sl()));

  sl.registerLazySingleton(
    () => LogOutUseCase(repository: sl(), studentCacheDataSource: sl()),
  );

  // ----- Bloc (نظيف وبسيط) -----
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      getUserUsecase: sl(),
      logoutUseCase: sl(),
      cachedatasource: sl(),
      cachedatasourceGrade: sl(),
      cachedatasourceStudentList: sl(),
      cacheDataStudentProfile: sl(),
      cacheDataTeacherFullProfile: sl(),
      cacheTeacherStudentsList: sl(),
      cacheTeacherStudentProfile: sl(),
      libraryCacheDataSource: sl(),
      librarianReservationsCacheDataSource: sl(),
      librarianLoansCacheDataSource: sl(),
      bookReservationsCacheDataSource: sl(),
      bookLoansCacheDataSource: sl(),
      activitiesRegistrationsCacheDataSource: sl(),
    ),
  );

  print('✅ Auth feature registered');
}

// ======================================================================
// ====== BULLETIN FEATURE ======
// ======================================================================

void _initBulletin(Box<Bulletinmodel> bulletinbox) {
  // Data Sources
  sl.registerLazySingleton<RemotedataSourceBulletin>(
    () => RemoteDataSourceImpBulletin(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceBulletin>(
    () => CacheDataSourceImpBulletin(box: bulletinbox),
  );

  // Repository
  sl.registerLazySingleton<BulletinRepo>(
    () => Bulletinrepoimp(networkInfo: sl(), remote: sl(), cache: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => GetbulletinsUseCase(bulletinRepo: sl()));

  // Bloc
  sl.registerFactory(
    () => BulletinBloc(getbulletinsUseCase: sl(), bulletinRepo: sl()),
  );

  print('✅ Bulletin feature registered');
}

// ======================================================================
// ====== COUNSELOR FEATURE ======
// ======================================================================

void _initCounselor({
  required Box<GradeModel> gradebox,
  required Box<Studentsbysectionmodel> studentsBySectionBox,
  required Box<CounselorStudentFullProfileModel> studentProfileBox,
}) {
  // ----- 5.1 Grade -----
  sl.registerLazySingleton<RemotdatasourceGrade>(
    () => RemotedatasourceImpGrade(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceGrade>(
    () => CachedatasourceImpGrade(boxGrade: gradebox),
  );

  // ----- 5.2 Student List -----
  sl.registerLazySingleton<RemotedatasourceStudentList>(
    () =>
        RemotedatasourceStudentListImp(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceStudentList>(
    () => CachedatasourceStudentListImp(box: studentsBySectionBox),
  );

  // ----- 5.3 Student Profile -----
  sl.registerLazySingleton<RemoteDataStudentProfile>(
    () => RemoteDataStudentProfileImp(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CacheDataStudentProfile>(
    () => CacheDataStudentProfileImp(box: studentProfileBox),
  );

  // ----- 5.4 Post Warning -----
  sl.registerLazySingleton<Remotedatapostwarnings>(
    () => RemotedatapostwarningsImp(authLocalDataSource: sl(), client: sl()),
  );

  // ----- 5.5 Schedule Image -----
  sl.registerLazySingleton<Remotedatascheduleimage>(
    () => RemotedatascheduleimageImpl(client: sl(), authLocalDataSource: sl()),
  );

  // ----- 5.6 Attendance -----
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () =>
        AttendanceRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  // ----- 5.7 Repository -----
  sl.registerLazySingleton<CounselorRepo>(
    () => CounselorRepoImp(
      networkInfo: sl(),
      remote: sl(),
      cache: sl(),
      remotedatasourceStudentList: sl(),
      cachedatasourceStudentList: sl(),
      remoteStudentProfile: sl(),
      cacheStudentProfile: sl(),
      remotedatapostwarnings: sl(),
      remotedatascheduleimage: sl(),
      attendanceremotedata: sl(),
    ),
  );

  // ----- 5.8 Use Cases -----
  sl.registerLazySingleton(() => GradeAndSectionUseCase(repository: sl()));
  sl.registerLazySingleton(() => StudentBySectionUseCase(repository: sl()));
  sl.registerLazySingleton(() => Studentprofileusecase(repository: sl()));
  sl.registerLazySingleton(() => Getscheduleimageusecase(repository: sl()));
  sl.registerLazySingleton(() => AddAttendanceUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAttendanceUseCase(repository: sl()));
  sl.registerLazySingleton(() => Postwarningsusecase(repository: sl()));

  // ----- 5.9 Blocs -----
  sl.registerFactory(
    () => GradeBloc(counselorRepo: sl(), gradeAndSectionUseCase: sl()),
  );
  sl.registerFactory(
    () => StudentsBloc(studentBySectionUseCase: sl(), counselorRepo: sl()),
  );
  sl.registerFactory(
    () => StudentProfileBloc(studentProfileUseCase: sl(), counselorRepo: sl()),
  );
  sl.registerFactory(
    () => PostWarningBloc(postWarningsUseCase: sl(), counselorRepo: sl()),
  );
  sl.registerFactory(() => ScheduleImagesBloc(getScheduleImageUseCase: sl()));
  sl.registerFactory(
    () => AttendanceBloc(
      addAttendanceUseCase: sl(),
      deleteAttendanceUseCase: sl(),
    ),
  );

  print('✅ Counselor feature registered');
}

// ======================================================================
// ====== LIBRARIAN FEATURE ======
// ======================================================================

void _initLibrarian() {
  // ============================================================
  // ====== Remote Data Sources ======
  // ============================================================

  // ----- الكتب -----
  sl.registerLazySingleton<LibrarianRemoteDataSource>(
    () =>
        LibrarianRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  // ----- الحجوزات العامة -----
  sl.registerLazySingleton<LibrarianReservationsRemoteDataSource>(
    () => LibrarianReservationsRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // ----- الاستعارات العامة -----
  sl.registerLazySingleton<LibrarianLoansRemoteDataSource>(
    () => LibrarianLoansRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // ----- حجوزات الكتاب -----
  sl.registerLazySingleton<BookReservationsRemoteDataSource>(
    () => BookReservationsRemoteDataSourceImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );

  // ----- استعارات الكتاب (جديد) -----
  sl.registerLazySingleton<BookLoansRemoteDataSource>(
    () =>
        BookLoansRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<ActionsRemoteDataSource>(
    () => ActionsRemoteDataSourceImp(client: sl(), authLocalDataSource: sl()),
  );
  // ============================================================
  // ====== Cache Data Sources ======
  // ============================================================

  // ----- الحجوزات العامة -----
  sl.registerLazySingleton<LibrarianReservationsCacheDataSource>(
    () => LibrarianReservationsCacheDataSourceImpl(
      box: sl<Box<LibrarianReservationsModel>>(),
    ),
  );

  // ----- الاستعارات العامة -----
  sl.registerLazySingleton<LibrarianLoansCacheDataSource>(
    () =>
        LibrarianLoansCacheDataSourceImpl(box: sl<Box<LibrarianLoansModel>>()),
  );

  // ----- حجوزات الكتاب -----
  sl.registerLazySingleton<BookReservationsCacheDataSource>(
    () => BookReservationsCacheDataSourceImpl(
      box: sl<Box<BookReservationsModel>>(),
    ),
  );

  // ----- استعارات الكتاب (جديد) -----
  sl.registerLazySingleton<BookLoansCacheDataSource>(
    () => BookLoansCacheDataSourceImpl(box: sl<Box<BookLoanModel>>()),
  );

  // ============================================================
  // ====== Repository ======
  // ============================================================

  sl.registerLazySingleton<LibrarianRepo>(
    () => LibrarianRepoImp(
      cache: sl(),
      networkInfo: sl(),
      librarianRemoteDataSource: sl(),
      reservationsRemoteDataSource: sl(),
      reservationsCacheDataSource: sl(),
      loansRemoteDataSource: sl(),
      loansCacheDataSource: sl(),
      bookReservationsRemoteDataSource: sl(),
      bookReservationsCacheDataSource: sl(),
      bookLoansRemoteDataSource: sl(), // جديد
      bookLoansCacheDataSource: sl(),
      actionsRemoteDataSource: sl(),
    ),
  );

  // ============================================================
  // ====== Use Cases ======
  // ============================================================

  sl.registerLazySingleton(() => Getbookslibrarianusecase(repository: sl()));
  sl.registerLazySingleton(() => Addbooksusecase(repository: sl()));
  sl.registerLazySingleton(() => EditBookUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteBookUseCase(repository: sl()));

  sl.registerLazySingleton(
    () => GetLibrarianReservationsUseCase(repository: sl()),
  );

  sl.registerLazySingleton(() => GetLibrarianLoansUsecase(repository: sl()));

  sl.registerLazySingleton(() => Getbookreservationsusecase(repository: sl()));

  // جديد
  sl.registerLazySingleton(() => Getbookloansusecase(repository: sl()));
  sl.registerLazySingleton(() => ApproveReservationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => RejectReservationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => PostLoansUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReturnLoansUseCase(repository: sl()));
  // ============================================================
  // ====== Blocs ======
  // ============================================================

  sl.registerFactory(
    () => LibrarianBloc(getBooksLibrarianUseCase: sl(), librarianRepo: sl()),
  );

  sl.registerFactory(
    () => AddDeleteEditBloc(
      addBooksUseCase: sl<Addbooksusecase>(),
      deleteBookUseCase: sl(),
      editBookUseCase: sl(),
      approveReservationsUseCase: sl(),
      rejectReservationsUseCase: sl(),
      postLoansUseCase: sl(),
      returnLoansUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => LibrarianReservationsLoansBloc(
      getLibrarianReservationsUseCase: sl(),
      getLibrarianLoansUsecase: sl(),
      librarianRepo: sl(),
    ),
  );

  sl.registerFactory(
    () => BookReservationsLoansBloc(
      getBookReservationsUseCase: sl(),
      librarianRepo: sl(),
    ),
  );

  // جديد
  sl.registerFactory(
    () => BookLoansBloc(getBookLoansUseCase: sl(), librarianRepo: sl()),
  );

  print('✅ Librarian feature registered');
}

// ======================================================================
// ====== 8. LIBRARY ======
// ======================================================================

void _initLibrary({
  required Box<BookModel> libraryBox,
  required Box<ReservationsModel> reservationsBox,
}) {
  // ----- Data Sources -----
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  sl.registerLazySingleton<LibraryCacheDataSource>(
    () => LibraryCacheDataSourceImpl(bookBox: sl(), reservationsBox: sl()),
  );

  // ----- Repository -----
  sl.registerLazySingleton<LibraryRepo>(
    () => LibraryRepoImp(remote: sl(), cache: sl(), networkInfo: sl()),
  );

  // ----- Use Case -----
  sl.registerLazySingleton(() => GetBooksUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReserveBookUseCase(repository: sl()));
  sl.registerLazySingleton(() => Getreservebookusecase(repository: sl()));
  // ----- Bloc -----
  sl.registerFactory(
    () => LibraryBloc(
      getBooksUseCase: sl(),
      libraryRepo: sl(),
      reserveBookUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ReservationsBloc(getReserveBookUseCase: sl(), libraryRepo: sl()),
  );
  print('✅ Library feature registered');
}

// ======================================================================
// ====== SCHOOLS INFO FEATURE ======
// ======================================================================

void _initSchoolsInfo({required Box<SchoolWithTeacherModel> schoolBox}) {
  // Data Sources
  sl.registerLazySingleton<SchoolRemoteDataSource>(
    () => SchoolRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<SchoolCacheDataSource>(
    () => SchoolCacheDataSourceImpl(box: schoolBox),
  );

  // Repository
  sl.registerLazySingleton<SchoolRepository>(
    () => SchoolRepositoryImpl(remote: sl(), cache: sl(), networkInfo: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => SchoolwithTeacherUseCase(repo: sl()));

  // Bloc
  sl.registerFactory(
    () => SchoolInfoBloc(getSchoolsUseCase: sl(), repository: sl()),
  );

  print('✅ Schools Info feature registered');
}
// ======================================================================
// ====== STUDENT FEATURE ======
// ======================================================================

void _initStudent(Box<StudentFullProfileModel> studentProfileBox) {
  sl.registerLazySingleton(() => studentProfileBox);

  // Student Remote Data Source
  sl.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  // Student Cache Data Source
  sl.registerLazySingleton<StudentCacheDataSource>(
    () => StudentCacheDataSourceImpl(box: sl()),
  );

  // Student Repository
  sl.registerLazySingleton<StudentRepo>(
    () => StudentRepoImp(remote: sl(), cache: sl(), networkInfo: sl()),
  );

  // Student UseCase
  sl.registerLazySingleton(() => Getfullprofileusecase(repo: sl()));

  // Student Bloc
  sl.registerLazySingleton(
    () => StudentBloc(getFullProfileUseCase: sl(), studentRepo: sl()),
  );

  print('✅ Student feature registered');
}

// ======================================================================
// ====== TEACHER FEATURE ======
// ======================================================================

void _initTeacher({
  required Box<TeacherFullProfileModel> teacherFullProfileBox,
  required Box<Studentsbysectionmodel> studentsBySectionBox,
  required Box<SemesterMarksModel> semesterMarksBox,
  required Box<TeacherStudentProfileModel> teacherStudentProfileBox,
}) {
  // ----- 6.1 Teacher Full Profile -----
  sl.registerLazySingleton<RemoteDataTeacherFullProfile>(
    () => RemoteDataTeacherFullProfileImp(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CacheDataTeacherFullProfile>(
    () => CacheDataTeacherFullProfileImp(box: teacherFullProfileBox),
  );

  // ----- 6.2 Teacher Students List -----
  sl.registerLazySingleton<Remotedatateacherstudentslist>(
    () => RemotedatateacherstudentslistImp(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CacheTeacherStudentsList>(
    () => CacheTeacherStudentsListImp(box: studentsBySectionBox),
  );

  // ----- 6.3 Teacher Student Profile -----
  sl.registerLazySingleton<RemoteTeacherStudentProfile>(
    () => RemoteTeacherStudentProfileImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CacheTeacherStudentProfile>(
    () => CacheTeacherStudentProfileImpl(box: teacherStudentProfileBox),
  );
  sl.registerLazySingleton<Marksremotedatasources>(
    () => MarksremotedatasourcesImp(client: sl(), authLocalDataSource: sl()),
  );

  // ----- 6.4 Repository -----
  sl.registerLazySingleton<Teacherrepo>(
    () => Teacherrepoimp(
      networkInfo: sl(),
      remote: sl(),
      cache: sl(),
      remoteStudents: sl(),
      cacheStudents: sl(),
      remoteStudentProfile: sl(),
      cacheStudentProfile: sl(),
      marksremotedatasources: sl(),
    ),
  );

  // ----- 6.5 Use Cases -----
  sl.registerLazySingleton(() => Getteacherfullprofile(repository: sl()));
  sl.registerLazySingleton(() => Getstudentsusecase(repository: sl()));
  sl.registerLazySingleton(
    () => Getteachersudentprofileusecase(repository: sl()),
  );
  sl.registerLazySingleton(() => Addmarksusecase(repository: sl()));
  sl.registerLazySingleton(() => Deletemarksusecase(repository: sl()));
  sl.registerLazySingleton(() => Editmarkusecase(repository: sl()));

  // ----- 6.6 Blocs -----
  sl.registerFactory(() => TeacherBloc(teacherRepo: sl()));
  sl.registerFactory(() => TeacherStudentListBloc(teacherRepo: sl()));
  sl.registerFactory(
    () => TeacherStudentProfileBloc(
      getTeacherStudentProfileUseCase: sl(),
      teacherRepo: sl(),
    ),
  );
  sl.registerFactory(
    () => MarkBloc(
      addMarksUseCase: sl(),
      deleteMarksUseCase: sl(),
      editMarksUseCase: sl(),
    ),
  );

  print('✅ Teacher feature registered');
}
