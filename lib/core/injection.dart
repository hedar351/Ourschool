import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school/features/Student/data/DataSource/library_cache_data_source.dart';
import 'package:school/features/Student/data/DataSource/library_remote_data_source.dart';
import 'package:school/features/Student/data/Model/LibraryModel/book_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_book_model.dart';
import 'package:school/features/Student/data/Model/LibraryModel/reserve_model.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/ActivitiesModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StatisticsModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StudentFullProfileModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/StudentInfoModel.dart';
import 'package:school/features/Student/data/Model/ProfilrModel/SummonsModel.dart';
import 'package:school/features/Student/data/RepoImp/library_repo_imp.dart';
import 'package:school/features/Student/domain/Repo/library_repo.dart';
import 'package:school/features/Student/domain/useCase/get_books_usecase.dart';
import 'package:school/features/Student/domain/useCase/reserveBookUseCase.dart';
import 'package:school/features/Student/ui/bloc/libraryBloc/library_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ----- Auth -----
import '../features/Auth/data/datasources/local_data_source.dart';
import '../features/Auth/data/datasources/remote_data_source.dart';
import '../features/Auth/data/repoImp/auth_repo_imp.dart';
import '../features/Auth/domain/repo/auth_repo.dart';
import '../features/Auth/domain/useCases/Log_out_UseCase.dart';
import '../features/Auth/domain/useCases/LoginUseCase.dart';
import '../features/Auth/domain/useCases/get_user_usecase.dart';
import '../features/Auth/ui/bloc/auth_bloc.dart';
// ----- Bulletin -----
import '../features/Bulletin/data/dataSources/RemotedataSource.dart';
import '../features/Bulletin/data/dataSources/cachedataSource.dart';
import '../features/Bulletin/data/model/AnnouncementActivityModel.dart';
import '../features/Bulletin/data/model/BulletinModel.dart';
import '../features/Bulletin/data/repoImp/BulletinRepoImp.dart';
import '../features/Bulletin/domain/Repo/Bulletin_repo.dart';
import '../features/Bulletin/domain/Usecases/GetbulletinsUseCase.dart';
import '../features/Bulletin/ui/bloc/bulletin_bloc.dart';
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
// ----- SchoolsInfo -----
import '../features/SchoolsInfo/UI/bloc/school_info_bloc.dart';
import '../features/SchoolsInfo/data/DataSource/SchoolCacheDataSource.dart';
import '../features/SchoolsInfo/data/DataSource/SchoolRemoteDataSource.dart';
import '../features/SchoolsInfo/data/RepoImp/SchoolRepositoryImpl.dart';
import '../features/SchoolsInfo/data/models/SchoolInfoModel.dart';
import '../features/SchoolsInfo/data/models/SchoolWithTeacherModel.dart';
import '../features/SchoolsInfo/data/models/SectionsModel.dart';
import '../features/SchoolsInfo/data/models/SubjectsModel.dart';
import '../features/SchoolsInfo/data/models/TeacherInfoModel.dart';
import '../features/SchoolsInfo/domain/Repo/SchoolRepository.dart';
import '../features/SchoolsInfo/domain/UseCase/SchoolwithTeacherUseCase.dart';
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
import 'network.dart';

// ======================================================================
// ====== GET IT INSTANCE ======
// ======================================================================

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
  // 3. STUDENT FEATURE (يجب أن يكون قبل Auth)
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
  _initLibrary(libraryBox: libraryBox);

  print('✅ All dependencies registered successfully!');
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
// ====== 8. LIBRARY ======
// ======================================================================

void _initLibrary({required Box<BookModel> libraryBox}) {
  // ----- Data Sources -----
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  sl.registerLazySingleton<LibraryCacheDataSource>(
    () => LibraryCacheDataSourceImpl(box: sl()),
  );

  // ----- Repository -----
  sl.registerLazySingleton<LibraryRepo>(
    () => LibraryRepoImp(remote: sl(), cache: sl(), networkInfo: sl()),
  );

  // ----- Use Case -----
  sl.registerLazySingleton(() => GetBooksUseCase(repository: sl()));
  sl.registerLazySingleton(() => ReserveBookUseCase(repository: sl()));
  // ----- Bloc -----
  sl.registerFactory(
    () => LibraryBloc(
      getBooksUseCase: sl(),
      libraryRepo: sl(),
      reserveBookUseCase: sl(),
    ),
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
