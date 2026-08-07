import 'package:dartz/dartz.dart';
import 'package:school/core/error/EXP.dart';
import 'package:school/core/error/failures.dart';
import 'package:school/core/network.dart';
import 'package:school/features/Auth/data/datasources/local_data_source.dart';
import 'package:school/features/Auth/data/datasources/remote_data_source.dart';
import 'package:school/features/Auth/domain/entities/auth_entities.dart';
import 'package:school/features/Auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  AuthRemoteDataSources authRemoteDataSources;
  AuthLocalDataSource authLocalDataSource;
  NetworkInfo networkInfo;
  AuthRepoImp({
    required this.authRemoteDataSources,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, AuthEntities>> getuser() async {
    print("🟡 [Repo] No network, trying cached user");
    try {
      final cache = await authLocalDataSource.getUser();
      print("🟢 [Repo] Cache hit, returning Right(cache)");
      return Right(cache);
    } on EmptyCacheExp {
      print(
        "🔴 [Repo] EmptyCacheExp caught, returning Left(EmptyCacheFailure)",
      );
      return Left(EmptyCacheFailure());
    } catch (e) {
      print(
        "🔴 [Repo] Unexpected cache error: $e, returning Left(EmptyCacheFailure)",
      );
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, AuthEntities>> login(
    String username,
    String password,
    bool rememberMe,
  ) async {
    print("🟡 [Repo] login called for username: $username");

    final isConnected = await networkInfo.isConnected;
    print("🟡 [Repo] Network connected: $isConnected");

    if (isConnected) {
      print("🟢 [Repo] Network available, trying remote login");
      try {
        final remote = await authRemoteDataSources.remotelogin(
          password,
          username,
        );
        print("🟢 [Repo] Remote login success, caching user");

        if (remote.token != null && remote.token!.isNotEmpty) {
          await authLocalDataSource.cacheToken(remote.token!);
          print("🟢 [Repo] Token cached always");
        }

        if (rememberMe) {
          await authLocalDataSource.cacheUser(remote);
          print("🟢 [Repo] Saved user because rememberMe = true");
        } else {
          await authLocalDataSource.deleteUser();
          print(
            "🟡 [Repo] Cleared user cache because rememberMe = false (token kept)",
          );
        }

        print("🟢 [Repo] Returning Right(remote)");
        return Right(remote);
      } on OfflineExp {
        print("🔴 [Repo] OfflineExp caught, returning Left(OfflineFailure)");
        return Left(OfflineFailure());
      } on ServerExp catch (e) {
        print("🔴 [Repo] ServerExp caught: $e, returning Left(ServerFailure)");
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> logout() async {
    print("🟡 [Repo] logout called");
    try {
      await authLocalDataSource.deleteUser();
      await authLocalDataSource.deleteToken();
      print("🟢 [Repo] User logged out successfully, returning Right(unit)");
      return Right(unit);
    } catch (e) {
      print("🔴 [Repo] Logout error: $e, returning Left(LogoutFailure)");
      return Left(LogoutFailure());
    }
  }
}
