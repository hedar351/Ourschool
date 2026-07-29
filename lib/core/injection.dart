// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:school/features/Auth/data/datasources/local_data_source.dart';
// import 'package:school/features/Auth/data/repoImp/auth_repo_imp.dart';
// import 'package:school/features/Auth/domain/repo/auth_repo.dart';
// import 'package:school/features/Auth/domain/useCases/get_user_usecase.dart';
// import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
// import 'package:school/features/Bulletin/data/dataSources/RemotedataSource.dart';
// import 'package:school/features/Bulletin/data/dataSources/cachedataSource.dart';
// import 'package:school/features/Bulletin/data/model/AnnouncementActivityModel.dart';
// import 'package:school/features/Bulletin/data/model/BulletinModel.dart';
// import 'package:school/features/Bulletin/data/repoImp/BulletinRepoImp.dart';
// import 'package:school/features/Bulletin/domain/Repo/Bulletin_repo.dart';
// import 'package:school/features/Bulletin/domain/Usecases/GetbulletinsUseCase.dart';
// import 'package:school/features/Bulletin/ui/bloc/bulletin_bloc.dart';
// import 'package:school/features/Counselor/UI/bloc/GradeBloc/grade_bloc.dart';
// import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
// import 'package:school/features/Counselor/UI/bloc/StudentListBLoc/student_list_bloc.dart';
// import 'package:school/features/Counselor/UI/bloc/Studentprofile/student_profile_bloc.dart';
// import 'package:school/features/Counselor/UI/bloc/attendance/attendance_bloc.dart';
// import 'package:school/features/Counselor/data/DataSources/Grade/cachedatasource.dart';
// import 'package:school/features/Counselor/data/DataSources/Grade/remotdatasource.dart';
// import 'package:school/features/Counselor/data/DataSources/PostWarnings/RemotedataPostWarnings.dart';
// import 'package:school/features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
// import 'package:school/features/Counselor/data/DataSources/StudentList/RemotedataSource.dart';
// import 'package:school/features/Counselor/data/DataSources/StudentProfile/RemoteDataStudentProfile.dart';
// import 'package:school/features/Counselor/data/DataSources/StudentProfile/cachDataStudentProfile.dart';
// import 'package:school/features/Counselor/data/DataSources/attendance/attendanceRemoteData.dart';
// import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';
// import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/studentModel.dart';
// import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_MarkModel.dart';
// import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_SubjectsModel.dart';
// import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_WarningsModel.dart';
// import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_studentFullProfileModel.dart';
// import 'package:school/features/Counselor/data/Model/attendanceModel/attendanceModel.dart';
// import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';
// import 'package:school/features/Counselor/data/Model/gradeandSectionModel/sectionModel.dart';
// import 'package:school/features/Counselor/data/RepoImp/Counselor_Repo_Imp.dart';
// import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
// import 'package:school/features/Counselor/domain/UseCases/AddAttendanceUseCase.dart';
// import 'package:school/features/Counselor/domain/UseCases/DeleteAttendanceUseCase.dart';
// import 'package:school/features/Counselor/domain/UseCases/GradeAndSectionUseCase.dart';
// import 'package:school/features/Counselor/domain/UseCases/StudentBySectionUseCase.dart';
// import 'package:school/features/Counselor/domain/UseCases/StudentProfileUseCase.dart';
// import 'package:school/features/Teacher/data/Model/SchoolModel.dart';
// import 'package:school/features/Teacher/data/Model/SubjectModel.dart';
// import 'package:school/features/Teacher/data/Model/TeacherFullProfileModel.dart';
// import 'package:school/features/Teacher/data/Model/TeacherModel.dart';
// import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../features/Auth/data/datasources/remote_data_source.dart';
// import '../features/Auth/domain/useCases/Log_out_UseCase.dart';
// import '../features/Auth/domain/useCases/LoginUseCase.dart';
// import '../features/Counselor/UI/bloc/schedule-imagesBloc/schedule_images_bloc.dart';
// import '../features/Counselor/data/DataSources/scheduleImage/remoteDataScheduleImage.dart';
// import '../features/Counselor/domain/UseCases/GetScheduleImageUseCase.dart';
// import '../features/SchoolsInfo/UI/bloc/school_info_bloc.dart';
// import '../features/SchoolsInfo/data/DataSource/SchoolCacheDataSource.dart';
// import '../features/SchoolsInfo/data/DataSource/SchoolRemoteDataSource.dart';
// import '../features/SchoolsInfo/data/RepoImp/SchoolRepositoryImpl.dart';
// import '../features/SchoolsInfo/data/models/SchoolInfoModel.dart';
// import '../features/SchoolsInfo/data/models/SchoolWithTeacherModel.dart';
// import '../features/SchoolsInfo/data/models/SectionsModel.dart';
// import '../features/SchoolsInfo/data/models/SubjectsModel.dart';
// import '../features/SchoolsInfo/data/models/TeacherInfoModel.dart';
// import '../features/SchoolsInfo/domain/Repo/SchoolRepository.dart';
// import '../features/SchoolsInfo/domain/UseCase/SchoolwithTeacherUseCase.dart';
// import '../features/Teacher/data/RepoImp/TeacherRepoImp.dart';
// import '../features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
// import '../features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
// import '../features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
// import '../features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
// import '../features/Teacher/domain/UseCases/GetStudentsUseCase.dart';
// import '../features/Teacher/domain/UseCases/GetTeacherFullProfile.dart';
// import '../features/Teacher/ui/bloc/StudentListBloc/teacher_student_list_bloc.dart';
// import '../features/Teacher/ui/bloc/TeacherBloc/teacher_bloc.dart';
// import 'network.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   // ==================== Hive Setup ====================
//   await Hive.initFlutter();
//   print('✅ Hive initialized');

//   Hive.registerAdapter(AnnouncementActivityModelAdapter());
//   Hive.registerAdapter(BulletinmodelAdapter());
//   Hive.registerAdapter(GradeModelAdapter());
//   Hive.registerAdapter(SectionModelAdapter());
//   Hive.registerAdapter(StudentmodelAdapter());
//   Hive.registerAdapter(StudentsbysectionmodelAdapter());
//   Hive.registerAdapter(CounselorStudentFullProfileModelAdapter());
//   Hive.registerAdapter(CounselorSubjectModelAdapter());
//   Hive.registerAdapter(CounselorMarkModelAdapter());
//   Hive.registerAdapter(CounselorWarningModelAdapter());
//   Hive.registerAdapter(TeacherFullProfileModelAdapter());
//   Hive.registerAdapter(TeacherModelAdapter());
//   Hive.registerAdapter(SchoolsModelAdapter());
//   Hive.registerAdapter(SubjectModelAdapter());
//   Hive.registerAdapter(SubjectsModelAdapter()); // typeId: 14
//   Hive.registerAdapter(SectionsModelAdapter()); // typeId: 15
//   Hive.registerAdapter(TeacherInfoModelAdapter()); // typeId: 16
//   Hive.registerAdapter(SchoolInfoModelAdapter()); // typeId: 17
//   Hive.registerAdapter(SchoolWithTeacherModelAdapter()); // typeId: 18
//   Hive.registerAdapter(AttendancemodelAdapter()); // typeId: 19

//   final studentProfileBox =
//       await Hive.openBox<CounselorStudentFullProfileModel>(
//         'studentFullProfileBox',
//       );
//   final bulletinbox = await Hive.openBox<Bulletinmodel>('bulletinBox');
//   final gradebox = await Hive.openBox<GradeModel>('gradebox');
//   final studentsBySectionBox = await Hive.openBox<Studentsbysectionmodel>(
//     'studentsBySectionBox',
//   );
//   final teacherFullProfileBox = await Hive.openBox<TeacherFullProfileModel>(
//     'teacherFullProfileBox',
//   );

//   final schoolBox = await Hive.openBox<SchoolWithTeacherModel>('schoolBox');

//   print('✅ All Hive boxes opened');

//   // ==================== Data Sources (All) ====================
//   // Auth
//   sl.registerLazySingleton<AuthRemoteDataSources>(
//     () => AuthRemoteDataSourcesImp(client: sl()),
//   );
//   sl.registerLazySingleton<AuthLocalDataSource>(
//     () => AuthLocalDataSourceImp(sharedPreferences: sl()),
//   );
//   // ==================== Schedule Image Data Source ====================
//   sl.registerLazySingleton<Remotedatascheduleimage>(
//     () => RemotedatascheduleimageImpl(client: sl(), authLocalDataSource: sl()),
//   );

//   // Bulletin
//   sl.registerLazySingleton<RemotedataSourceBulletin>(
//     () => RemoteDataSourceImpBulletin(client: sl(), authLocalDataSource: sl()),
//   );
//   sl.registerLazySingleton<CachedatasourceBulletin>(
//     () => CacheDataSourceImpBulletin(box: bulletinbox),
//   );

//   // Counselor - Grade
//   sl.registerLazySingleton<RemotdatasourceGrade>(
//     () => RemotedatasourceImpGrade(client: sl(), authLocalDataSource: sl()),
//   );
//   sl.registerLazySingleton<CachedatasourceGrade>(
//     () => CachedatasourceImpGrade(boxGrade: gradebox),
//   );

//   // Counselor - Student List (by section)
//   sl.registerLazySingleton<RemotedatasourceStudentList>(
//     () =>
//         RemotedatasourceStudentListImp(client: sl(), authLocalDataSource: sl()),
//   );
//   sl.registerLazySingleton<CachedatasourceStudentList>(
//     () => CachedatasourceStudentListImp(box: studentsBySectionBox),
//   );

//   // Counselor - Student Profile
//   sl.registerLazySingleton<RemoteDataStudentProfile>(
//     () => RemoteDataStudentProfileImp(client: sl(), authLocalDataSource: sl()),
//   );
//   sl.registerLazySingleton<CacheDataStudentProfile>(
//     () => CacheDataStudentProfileImp(box: studentProfileBox),
//   );

//   sl.registerLazySingleton(() => schoolBox);

//   // Counselor - Post Warning
//   sl.registerLazySingleton<Remotedatapostwarnings>(
//     () => RemotedatapostwarningsImp(authLocalDataSource: sl(), client: sl()),
//   );
//   // ==================== Teacher Data Sources ====================
//   sl.registerLazySingleton<RemoteDataTeacherFullProfile>(
//     () => RemoteDataTeacherFullProfileImp(
//       client: sl(),
//       authLocalDataSource: sl(),
//     ),
//   );

//   sl.registerLazySingleton<CacheDataTeacherFullProfile>(
//     () => CacheDataTeacherFullProfileImp(box: teacherFullProfileBox),
//   );
//   // ==================== Teacher Students Data Sources ====================
//   sl.registerLazySingleton<Remotedatateacherstudentslist>(
//     () => RemotedatateacherstudentslistImp(
//       client: sl(),
//       authLocalDataSource: sl(),
//     ),
//   );
//   sl.registerLazySingleton<CacheTeacherStudentsList>(
//     () => CacheTeacherStudentsListImp(box: studentsBySectionBox),
//   );
//   // ----- Remote Data Source -----
//   sl.registerLazySingleton<AttendanceRemoteDataSource>(
//     () =>
//         AttendanceRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
//   );
//   // ==================== Repositories ====================
//   sl.registerLazySingleton<AuthRepo>(
//     () => AuthRepoImp(
//       networkInfo: sl(),
//       authRemoteDataSources: sl(),
//       authLocalDataSource: sl(),
//     ),
//   );

//   sl.registerLazySingleton<BulletinRepo>(
//     () => Bulletinrepoimp(networkInfo: sl(), remote: sl(), cache: sl()),
//   );

//   sl.registerLazySingleton<CounselorRepo>(
//     () => CounselorRepoImp(
//       networkInfo: sl(),
//       remote: sl(),
//       cache: sl(),
//       remotedatasourceStudentList: sl(),
//       cachedatasourceStudentList: sl(),
//       remoteStudentProfile: sl(),
//       cacheStudentProfile: sl(),
//       remotedatapostwarnings: sl(),
//       remotedatascheduleimage: sl(),
//       attendanceremotedata: sl(),
//     ),
//   );
//   // ==================== Teacher Repository ====================

//   sl.registerLazySingleton<Teacherrepo>(
//     () => Teacherrepoimp(
//       networkInfo: sl(),
//       remote: sl(),
//       cache: sl(),
//       remoteStudents: sl(),
//       cacheStudents: sl(),
//     ),
//   );
//   // ==================== Use Cases ====================
//   // Auth
//   sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
//   sl.registerLazySingleton(() => GetUserUsecase(repository: sl()));
//   sl.registerLazySingleton(() => LogOutUseCase(repository: sl()));

//   // Bulletin
//   sl.registerLazySingleton(() => GetbulletinsUseCase(bulletinRepo: sl()));

//   // Counselor - Grade
//   sl.registerLazySingleton(() => GradeAndSectionUseCase(repository: sl()));

//   // Counselor - Student List
//   sl.registerLazySingleton(() => StudentBySectionUseCase(repository: sl()));

//   // Counselor - Student Profile
//   sl.registerLazySingleton(() => Studentprofileusecase(repository: sl()));

//   // ==================== Teacher Use Case ====================
//   sl.registerLazySingleton(() => Getteacherfullprofile(repository: sl()));
//   // Counselor - Post Warning
//   // sl.registerLazySingleton(() => Postwarningsusecase(repository: sl()));
//   // print("🟢 [injection] Postwarningsusecase registered successfully");

//   sl.registerLazySingleton(() => Getstudentsusecase(repository: sl()));
//   // ==================== Schedule Image Use Cases ====================
//   sl.registerLazySingleton(() => Getscheduleimageusecase(repository: sl()));
//   sl.registerLazySingleton(() => AddAttendanceUseCase(repository: sl()));
//   sl.registerLazySingleton(() => DeleteAttendanceUseCase(repository: sl()));
//   // ==================== Blocs ====================
//   // Auth
//   sl.registerFactory(
//     () => AuthBloc(
//       getUserUsecase: sl(),
//       loginUseCase: sl(),
//       logoutUseCase: sl(),
//       cachedatasource: sl(),
//       cachedatasourceGrade: sl(),
//       cachedatasourceStudentList: sl(),
//       cacheDataStudentProfile: sl(),
//       cacheDataTeacherFullProfile: sl(),
//       cacheTeacherStudentsList: sl(),
//     ),
//   );

//   // Bulletin
//   sl.registerFactory(
//     () => BulletinBloc(getbulletinsUseCase: sl(), bulletinRepo: sl()),
//   );

//   // Counselor - Grade
//   sl.registerFactory(
//     () => GradeBloc(counselorRepo: sl(), gradeAndSectionUseCase: sl()),
//   );

//   // Counselor - Student List
//   sl.registerFactory(
//     () => StudentsBloc(studentBySectionUseCase: sl(), counselorRepo: sl()),
//   );

//   // Counselor - Student Profile
//   sl.registerFactory(
//     () => StudentProfileBloc(studentProfileUseCase: sl(), counselorRepo: sl()),
//   );

//   // Counselor - Post Warning
//   sl.registerFactory(
//     () => PostWarningBloc(postWarningsUseCase: sl(), counselorRepo: sl()),
//   );
//   // ==================== Teacher Bloc ====================
//   sl.registerFactory(() => TeacherBloc(teacherRepo: sl()));
//   // ==================== Core ====================
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//   // ==================== Teacher Student List Bloc ====================
//   sl.registerFactory(() => TeacherStudentListBloc(teacherRepo: sl()));
//   // ==================== Schedule Images Bloc ====================
//   sl.registerFactory(
//     () => ScheduleImagesBloc(
//       getScheduleImageUseCase: sl(),
//       // uploadScheduleImageUseCase: sl(),
//       // deleteScheduleImageUseCase: sl(),
//     ),
//   );
//   sl.registerFactory(
//     () => AttendanceBloc(
//       addAttendanceUseCase: sl(),
//       deleteAttendanceUseCase: sl(),
//     ),
//   );
//   // ==================== External ====================
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker.instance);

//   // ======================================================================
//   // ======== 3. SCHOOLS INFO ========
//   // ======================================================================

//   // ----- 3.1 Data Sources -----
//   sl.registerLazySingleton<SchoolRemoteDataSource>(
//     () => SchoolRemoteDataSourceImpl(client: sl()),
//   );

//   sl.registerLazySingleton<SchoolCacheDataSource>(
//     () => SchoolCacheDataSourceImpl(box: schoolBox),
//   );

//   // ----- 3.2 Repository -----
//   sl.registerLazySingleton<SchoolRepository>(
//     () => SchoolRepositoryImpl(remote: sl(), cache: sl(), networkInfo: sl()),
//   );

//   // ----- 3.3 UseCase -----
//   sl.registerLazySingleton(() => SchoolwithTeacherUseCase(repo: sl()));

//   // ----- 3.4 Bloc -----
//   sl.registerFactory(
//     () => SchoolInfoBloc(getSchoolsUseCase: sl(), repository: sl()),
//   );
// }
// lib/core/injection.dart

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school/features/Teacher/data/Model/TeacherStudentProfileModel/SemesterMarksModel.dart';
import 'package:school/features/Teacher/data/Model/TeacherStudentProfileModel/TeacherStudentProfileModel.dart';
import 'package:school/features/Teacher/ui/bloc/TeacherStudentProflie/bloc/teacher_student_proflie_bloc.dart';
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
// ----- Teacher -----
import '../features/Teacher/data/Model/SchoolModel.dart';
import '../features/Teacher/data/Model/SubjectModel.dart';
import '../features/Teacher/data/Model/TeacherFullProfileModel.dart';
import '../features/Teacher/data/Model/TeacherModel.dart';
import '../features/Teacher/data/RepoImp/TeacherRepoImp.dart';
import '../features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
import '../features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
import '../features/Teacher/data/dataSources/TeacherStudentProfile/CacheTeacherStudentProfile.dart';
import '../features/Teacher/data/dataSources/TeacherStudentProfile/RemoteTeacherStudentProfile.dart';
import '../features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
import '../features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
import '../features/Teacher/domain/Repo/TeacherRepo.dart';
import '../features/Teacher/domain/UseCases/GetStudentsUseCase.dart';
import '../features/Teacher/domain/UseCases/GetTeacherFullProfile.dart';
import '../features/Teacher/domain/UseCases/GetTeacherSudentProfileUseCase.dart';
import '../features/Teacher/ui/bloc/StudentListBloc/teacher_student_list_bloc.dart';
import '../features/Teacher/ui/bloc/TeacherBloc/teacher_bloc.dart';
// ======================================================================
// ====== IMPORTS حسب الأدوار ======
// ======================================================================

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
  Hive.registerAdapter(SubjectsModelAdapter()); // 14
  Hive.registerAdapter(SectionsModelAdapter()); // 15
  Hive.registerAdapter(TeacherInfoModelAdapter()); // 16
  Hive.registerAdapter(SchoolInfoModelAdapter()); // 17
  Hive.registerAdapter(SchoolWithTeacherModelAdapter()); // 18

  Hive.registerAdapter(SemesterMarksModelAdapter()); // 19
  Hive.registerAdapter(TeacherStudentProfileModelAdapter()); // 20

  Hive.registerAdapter(AttendancemodelAdapter());

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
  // 3. AUTH FEATURE
  // ====================================================================
  _initAuth();

  // ====================================================================
  // 4. BULLETIN FEATURE
  // ====================================================================
  _initBulletin(bulletinbox);

  // ====================================================================
  // 5. COUNSELOR FEATURE
  // ====================================================================
  _initCounselor(
    gradebox: gradebox,
    studentsBySectionBox: studentsBySectionBox,
    studentProfileBox: studentProfileBox,
  );

  // ====================================================================
  // 6. TEACHER FEATURE
  // ====================================================================
  _initTeacher(
    teacherFullProfileBox: teacherFullProfileBox,
    studentsBySectionBox: studentsBySectionBox,
    semesterMarksBox: semesterMarksBox,
    teacherStudentProfileBox: teacherStudentProfileBox,
  );

  // ====================================================================
  // 7. SCHOOLS INFO FEATURE
  // ====================================================================
  _initSchoolsInfo(schoolBox: schoolBox);
}

// ======================================================================
// ====== 3. AUTH ======
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

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(repository: sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      getUserUsecase: sl(),
      loginUseCase: sl(),
      logoutUseCase: sl(),
      cachedatasource: sl(),
      cachedatasourceGrade: sl(),
      cachedatasourceStudentList: sl(),
      cacheDataStudentProfile: sl(),
      cacheDataTeacherFullProfile: sl(),
      cacheTeacherStudentsList: sl(),
      cacheTeacherStudentProfile: sl(),
    ),
  );
}

// ======================================================================
// ====== 4. BULLETIN ======
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
}

// ======================================================================
// ====== 5. COUNSELOR ======
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
}

// ======================================================================
// ====== 7. SCHOOLS INFO ======
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
}

// ======================================================================
// ====== 6. TEACHER ======
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

  // ----- 6.3 Teacher Student Profile (new) -----
  sl.registerLazySingleton<RemoteTeacherStudentProfile>(
    () => RemoteTeacherStudentProfileImpl(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CacheTeacherStudentProfile>(
    () => CacheTeacherStudentProfileImpl(box: teacherStudentProfileBox),
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
    ),
  );

  // ----- 6.5 Use Cases -----
  sl.registerLazySingleton(() => Getteacherfullprofile(repository: sl()));
  sl.registerLazySingleton(() => Getstudentsusecase(repository: sl()));
  sl.registerLazySingleton(
    () => Getteachersudentprofileusecase(repository: sl()),
  );

  // ----- 6.6 Blocs -----
  sl.registerFactory(() => TeacherBloc(teacherRepo: sl()));
  sl.registerFactory(() => TeacherStudentListBloc(teacherRepo: sl()));
  sl.registerFactory(
    () => TeacherStudentProfileBloc(
      getTeacherStudentProfileUseCase: sl(),
      teacherRepo: sl(),
    ),
  );
}
