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
import 'package:school/features/Counselor/UI/bloc/grade_bloc.dart';
import 'package:school/features/Counselor/data/DataSources/cachedatasource.dart';
import 'package:school/features/Counselor/data/DataSources/remotdatasource.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/gradeModel.dart';
import 'package:school/features/Counselor/data/Model/gradeandSectionModel/sectionModel.dart';
import 'package:school/features/Counselor/data/RepoImp/Counselor_Repo_Imp.dart';
import 'package:school/features/Counselor/domain/Repo/CounselorRepo.dart';
import 'package:school/features/Counselor/domain/UseCases/GradeAndSectionUseCase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Auth/data/datasources/remote_data_source.dart';
import '../features/Auth/domain/useCases/Log_out_UseCase.dart';
import '../features/Auth/domain/useCases/LoginUseCase.dart';
import 'network.dart';

final sl = GetIt.instance;
Future<void> init() async {
  await Hive.initFlutter();
  print('✅ Hive initialized');

  Hive.registerAdapter(AnnouncementActivityModelAdapter());
  Hive.registerAdapter(BulletinmodelAdapter());
  Hive.registerAdapter(GradeModelAdapter());
  Hive.registerAdapter(SectionModelAdapter());
  final bulletinbox = await Hive.openBox<Bulletinmodel>('bulletinBox');

  // await Hive.deleteBoxFromDisk('gradebox');

  final gradebox = await Hive.openBox<GradeModel>('gradebox');

  print('✅ Hive box opened: postsCache');
  //!features Counselor
  // Bloc

  sl.registerFactory(
    () => GradeBloc(counselorRepo: sl(), gradeAndSectionUseCase: sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => GradeAndSectionUseCase(repository: sl()));
  // Repo

  sl.registerLazySingleton<CounselorRepo>(
    () => CounselorRepoImp(networkInfo: sl(), remote: sl(), cache: sl()),
  );

  sl.registerLazySingleton<RemotdatasourceGrade>(
    () => RemotedatasourceImpGrade(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceGrade>(
    () => CachedatasourceImpGrade(boxGrade: gradebox),
  );
  //!features Bulletin
  // Bloc

  sl.registerFactory(
    () => BulletinBloc(getbulletinsUseCase: sl(), bulletinRepo: sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => GetbulletinsUseCase(bulletinRepo: sl()));
  // Repo
  sl.registerLazySingleton<BulletinRepo>(
    () => Bulletinrepoimp(networkInfo: sl(), remote: sl(), cache: sl()),
  );

  // DataSources
  sl.registerLazySingleton<RemotedataSourceBulletin>(
    () => RemoteDataSourceImpBulletin(client: sl(), authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CachedatasourceBulletin>(
    () => CacheDataSourceImpBulletin(box: bulletinbox),
  );

  //!featuresAuth
  //Bloc
  sl.registerFactory(
    () => AuthBloc(
      getUserUsecase: sl(),
      loginUseCase: sl(),
      logoutUseCase: sl(),
      cachedatasource: sl(),
    ),
  );

  //UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(repository: sl()));

  //repo
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      networkInfo: sl(),
      authRemoteDataSources: sl(),
      authLocalDataSource: sl(),
    ),
  );
  //datasource
  sl.registerLazySingleton<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImp(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImp(sharedPreferences: sl()),
  );

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}
