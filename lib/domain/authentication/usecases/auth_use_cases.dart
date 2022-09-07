import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/authentication/models/login_detail.dart';
import 'package:ota/domain/authentication/models/logout_detail.dart';
import 'package:ota/domain/authentication/models/refresh_detail.dart';
import 'package:ota/domain/authentication/repositories/auth_repository_impl.dart';

/// Interface for Auth use cases.
abstract class AuthUseCases {
  Future<Either<Failure, LoginDetail>?> getLoginDetail(
      {required String username, required String password});
  Future<Either<Failure, RefreshDetail>?> refreshToken(String refreshToken);
  Future<Either<Failure, LogoutDetail>?> logOut(String username);
}

/// GalleryUseCasesImpl will contain the GalleryUseCases implementation.
class AuthUseCasesImpl implements AuthUseCases {
  AuthRepository? authRepository;

  /// Dependence injection via constructor
  AuthUseCasesImpl({AuthRepository? repository}) {
    if (repository == null) {
      authRepository = AuthRepositoryImpl();
    } else {
      authRepository = repository;
    }
  }

  /// Call API to get the Token details.
  ///
  /// [Either<Failure, Token>] to handle the Failure or result data.
  @override
  Future<Either<Failure, LoginDetail>?> getLoginDetail(
      {required String username, required String password}) async {
    return await authRepository?.getLoginDetail(
        username: username, password: password);
  }

  @override
  Future<Either<Failure, RefreshDetail>?> refreshToken(
      String refreshToken) async {
    return await authRepository?.refreshToken(refreshToken);
  }

  @override
  Future<Either<Failure, LogoutDetail>?> logOut(String username) async {
    return await authRepository?.logOut(username);
  }
}
