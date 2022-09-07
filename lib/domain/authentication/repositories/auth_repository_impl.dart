import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/authentication/data_sources/auth_remote_data_source.dart';
import 'package:ota/domain/authentication/models/login_detail.dart';
import 'package:ota/domain/authentication/models/logout_detail.dart';
import 'package:ota/domain/authentication/models/refresh_detail.dart';

/// Interface for AuthRepository repository.
abstract class AuthRepository {
  Future<Either<Failure, LoginDetail>> getLoginDetail(
      {required String username, required String password});
  Future<Either<Failure, RefreshDetail>> refreshToken(String refreshToken);
  Future<Either<Failure, LogoutDetail>> logOut(String username);
}

/// AuthRepositoryImpl will contain the AuthRepository implementation.
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource? authRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  AuthRepositoryImpl(
      {AuthRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      authRemoteDataSource = AuthRemoteDataSourceImpl();
    } else {
      authRemoteDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Auth token details.
  /// [Either<Failure, Token>] to handle the Failure or result data.
  @override
  Future<Either<Failure, LoginDetail>> getLoginDetail(
      {required String username, required String password}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final authResult = await authRemoteDataSource?.getLoginDetail(
            username: username, password: password);
        return Right(authResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, RefreshDetail>> refreshToken(
      String refreshToken) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final authResult =
            await authRemoteDataSource?.refreshToken(refreshToken);
        return Right(authResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, LogoutDetail>> logOut(String username) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final authResult = await authRemoteDataSource?.logOut(username);
        return Right(authResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
