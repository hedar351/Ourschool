import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Auth/data/repoImp/auth_repo_imp.dart';
import 'package:school/features/Auth/domain/repo/auth_repo.dart';
import 'package:school/features/Auth/domain/useCases/get_user_usecase.dart';
import 'package:school/features/Auth/ui/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Auth/data/datasources/remote_data_source.dart';
import '../features/Auth/domain/useCases/Log_out_UseCase.dart';
import '../features/Auth/domain/useCases/LoginUseCase.dart';
import 'network.dart';

final sl = GetIt.instance;
Future<void> init() async {
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
