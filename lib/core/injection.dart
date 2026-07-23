import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Auth/data/repoImp/auth_repo_imp.dart';
import 'package:school/features/Auth/domain/repo/auth_repo.dart';
import 'package:school/features/Auth/domain/useCases/get_user_usecase.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:school/features/Bulletin/data/dataSources/RemotedataSource.dart';
import 'package:school/features/Bulletin/data/dataSources/cachedataSource.dart';
import 'package:school/features/Bulletin/data/model/AnnouncementActivityModel.dart';
import 'package:school/features/Bulletin/data/model/BulletinModel.dart';
import 'package:school/features/Bulletin/data/repoImp/BulletinRepoImp.dart';
import 'package:school/features/Bulletin/domain/Repo/Bulletin_repo.dart';
import 'package:school/features/Bulletin/domain/Usecases/GetbulletinsUseCase.dart';
import 'package:school/features/Bulletin/ui/bloc/bulletin_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/GradeBloc/grade_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/PostWarnings/post_warnings_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/StudentListBLoc/student_list_bloc.dart';
import 'package:school/features/Counselor/UI/bloc/Studentprofile/student_profile_bloc.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/Grade/remotdatasource.dart';
import 'package:school/features/Counselor/data/DataSources/PostWarnings/RemotedataPostWarnings.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/Cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentList/RemotedataSource.dart';
import 'package:school/features/Counselor/data/DataSources/StudentProfile/RemoteDataStudentProfile.dart';
import 'package:school/features/Counselor/data/DataSources/StudentProfile/cachDataStudentProfile.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/StudentsBySectionModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsBySectionModel/studentModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_MarkModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_SubjectsModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_WarningsModel.dart';
import 'package:school/features/Counselor/data/Model/StudentsProfileModel/Counselor_studentFullProfileModel.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/sectionModel.dart';
import 'package:school/features/Counselor/data/RepoImp/Counselor_Repo_Imp.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/features/Counselor/domain/UseCases/GradeAndSectionUseCase.dart';
import 'package:school/features/Counselor/domain/UseCases/StudentBySectionUseCase.dart';
import 'package:school/features/Counselor/domain/UseCases/StudentProfileUseCase.dart';
import 'package:school/features/Teacher/data/Model/SchoolModel.dart';
import 'package:school/features/Teacher/data/Model/SubjectModel.dart';
import 'package:school/features/Teacher/data/Model/TeacherFullProfileModel.dart';
import 'package:school/features/Teacher/data/Model/TeacherModel.dart';
import 'package:school/features/Teacher/domain/Repo/TeacherRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Auth/data/datasources/remote_data_source.dart';
import '../features/Auth/domain/useCases/Log_out_UseCase.dart';
import '../features/Auth/domain/useCases/LoginUseCase.dart';
import '../features/Counselor/UI/bloc/schedule-imagesBloc/schedule_images_bloc.dart';
import '../features/Counselor/data/DataSources/scheduleImage/remoteDataScheduleImage.dart';
import '../features/Counselor/domain/UseCases/GetScheduleImageUseCase.dart';
import '../features/Teacher/data/RepoImp/TeacherRepoImp.dart';
import '../features/Teacher/data/dataSources/GetTeacherFullprofile/cacheDataGetTeacherFullprofile.dart';
import '../features/Teacher/data/dataSources/GetTeacherFullprofile/remoteDataGetTeacherFullProfile.dart';
import '../features/Teacher/data/dataSources/TeacherStudentsList/CacheTeacherStudentsList.dart';
import '../features/Teacher/data/dataSources/TeacherStudentsList/RemotedataTeacherStudentsList.dart';
import '../features/Teacher/domain/UseCases/GetStudentsUseCase.dart';
import '../features/Teacher/domain/UseCases/GetTeacherFullProfile.dart';
import '../features/Teacher/ui/bloc/StudentListBloc/teacher_student_list_bloc.dart';
import '../features/Teacher/ui/bloc/TeacherBloc/teacher_bloc.dart';
import 'network.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ==================== Hive Setup ====================
  await Hive.initFlutter();
  print('✅ Hive initialized');

  Hive.registerAdapter(AnnouncementActivityModelAdapter());
  Hive.registerAdapter(BulletinmodelAdapter());
  Hive.registerAdapter(GradeModelAdapter());
  Hive.registerAdapter(SectionModelAdapter());
  Hive.registerAdapter(StudentmodelAdapter());
  Hive.registerAdapter(StudentsbysectionmodelAdapter());
  Hive.registerAdapter(CounselorStudentFullProfileModelAdapter());
  Hive.registerAdapter(CounselorSubjectModelAdapter());
  Hive.registerAdapter(CounselorMarkModelAdapter());
  Hive.registerAdapter(CounselorWarningModelAdapter());
  Hive.registerAdapter(TeacherFullProfileModelAdapter());
  Hive.registerAdapter(TeacherModelAdapter());
  Hive.registerAdapter(SchoolsModelAdapter());
  Hive.registerAdapter(SubjectModelAdapter());
  final studentProfileBox =
      await Hive.openBox<CounselorStudentFullProfileModel>(
        'studentFullProfileBox',
      );
  final bulletinbox = await Hive.openBox<Bulletinmodel>('bulletinBox');
  final gradebox = await Hive.openBox<GradeModel>('gradebox');
  final studentsBySectionBox = await Hive.openBox<Studentsbysectionmodel>(
    'studentsBySectionBox',
  );
  final teacherFullProfileBox = await Hive.openBox<TeacherFullProfileModel>(
    'teacherFullProfileBox',
  );
  print('✅ All Hive boxes opened');

  // ==================== Data Sources (All) ====================
  // Auth
  sl.registerLazySingleton<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImp(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImp(sharedPreferences: sl()),
  );
  // ==================== Schedule Image Data Source ====================
  sl.registerLazySingleton<Remotedatascheduleimage>(
    () => RemotedatascheduleimageImpl(client: sl(), authLocalDataSource: sl()),
  );

  // Bulletin
  sl.registerLazySingleton<RemotedataSourceBulletin>(
    () => RemoteDataSourceImpBulletin(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceBulletin>(
    () => CacheDataSourceImpBulletin(box: bulletinbox),
  );

  // Counselor - Grade
  sl.registerLazySingleton<RemotdatasourceGrade>(
    () => RemotedatasourceImpGrade(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceGrade>(
    () => CachedatasourceImpGrade(boxGrade: gradebox),
  );

  // Counselor - Student List (by section)
  sl.registerLazySingleton<RemotedatasourceStudentList>(
    () =>
        RemotedatasourceStudentListImp(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceStudentList>(
    () => CachedatasourceStudentListImp(box: studentsBySectionBox),
  );

  // Counselor - Student Profile
  sl.registerLazySingleton<RemoteDataStudentProfile>(
    () => RemoteDataStudentProfileImp(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CacheDataStudentProfile>(
    () => CacheDataStudentProfileImp(box: studentProfileBox),
  );

  // Counselor - Post Warning
  sl.registerLazySingleton<Remotedatapostwarnings>(
    () => RemotedatapostwarningsImp(authLocalDataSource: sl(), client: sl()),
  );
  // ==================== Teacher Data Sources ====================
  sl.registerLazySingleton<RemoteDataTeacherFullProfile>(
    () => RemoteDataTeacherFullProfileImp(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<CacheDataTeacherFullProfile>(
    () => CacheDataTeacherFullProfileImp(box: teacherFullProfileBox),
  );
  // ==================== Teacher Students Data Sources ====================
  sl.registerLazySingleton<Remotedatateacherstudentslist>(
    () => RemotedatateacherstudentslistImp(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CacheTeacherStudentsList>(
    () => CacheTeacherStudentsListImp(box: studentsBySectionBox),
  );
  // ==================== Repositories ====================
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      networkInfo: sl(),
      authRemoteDataSources: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<BulletinRepo>(
    () => Bulletinrepoimp(networkInfo: sl(), remote: sl(), cache: sl()),
  );

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
    ),
  );
  // ==================== Teacher Repository ====================

  sl.registerLazySingleton<Teacherrepo>(
    () => Teacherrepoimp(
      networkInfo: sl(),
      remote: sl(),
      cache: sl(),
      remoteStudents: sl(),
      cacheStudents: sl(),
    ),
  );
  // ==================== Use Cases ====================
  // Auth
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(repository: sl()));

  // Bulletin
  sl.registerLazySingleton(() => GetbulletinsUseCase(bulletinRepo: sl()));

  // Counselor - Grade
  sl.registerLazySingleton(() => GradeAndSectionUseCase(repository: sl()));

  // Counselor - Student List
  sl.registerLazySingleton(() => StudentBySectionUseCase(repository: sl()));

  // Counselor - Student Profile
  sl.registerLazySingleton(() => Studentprofileusecase(repository: sl()));

  // ==================== Teacher Use Case ====================
  sl.registerLazySingleton(() => Getteacherfullprofile(repository: sl()));
  // Counselor - Post Warning
  // sl.registerLazySingleton(() => Postwarningsusecase(repository: sl()));
  // print("🟢 [injection] Postwarningsusecase registered successfully");

  sl.registerLazySingleton(() => Getstudentsusecase(repository: sl()));
  // ==================== Schedule Image Use Cases ====================
  sl.registerLazySingleton(() => Getscheduleimageusecase(repository: sl()));
  // sl.registerLazySingleton(() => Postscheduleimageusecase(repository: sl()));
  // sl.registerLazySingleton(() => Deletescheduleimageusecase(repository: sl()));
  // ==================== Blocs ====================
  // Auth
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
    ),
  );

  // Bulletin
  sl.registerFactory(
    () => BulletinBloc(getbulletinsUseCase: sl(), bulletinRepo: sl()),
  );

  // Counselor - Grade
  sl.registerFactory(
    () => GradeBloc(counselorRepo: sl(), gradeAndSectionUseCase: sl()),
  );

  // Counselor - Student List
  sl.registerFactory(
    () => StudentsBloc(studentBySectionUseCase: sl(), counselorRepo: sl()),
  );

  // Counselor - Student Profile
  sl.registerFactory(
    () => StudentProfileBloc(studentProfileUseCase: sl(), counselorRepo: sl()),
  );

  // Counselor - Post Warning
  sl.registerFactory(
    () => PostWarningBloc(postWarningsUseCase: sl(), counselorRepo: sl()),
  );
  // ==================== Teacher Bloc ====================
  sl.registerFactory(() => TeacherBloc(teacherRepo: sl()));
  // ==================== Core ====================
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // ==================== Teacher Student List Bloc ====================
  sl.registerFactory(() => TeacherStudentListBloc(teacherRepo: sl()));
  // ==================== Schedule Images Bloc ====================
  sl.registerFactory(
    () => ScheduleImagesBloc(
      getScheduleImageUseCase: sl(),
      // uploadScheduleImageUseCase: sl(),
      // deleteScheduleImageUseCase: sl(),
    ),
  );
  // ==================== External ====================
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}
