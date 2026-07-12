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
  final box = await Hive.openBox<Bulletinmodel>('postsCache');
  print('✅ Hive box opened: postsCache');
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
  sl.registerLazySingleton<RemotedataSource>(
    () => RemoteDataSourceImp(client: sl()),
  );
  sl.registerLazySingleton<Cachedatasource>(() => CacheDataSourceImp(box: box));

  //!featuresAuth
  //Bloc
  sl.registerFactory(
    () =>
        AuthBloc(getUserUsecase: sl(), loginUseCase: sl(), logoutUseCase: sl()),
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
