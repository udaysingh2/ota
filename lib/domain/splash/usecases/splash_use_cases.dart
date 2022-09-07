import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/splash/models/splash_model.dart';
import 'package:ota/domain/splash/repositories/splash_repository_impl.dart';

/// Interface for splash use cases.
abstract class SplashUseCases {
  /// Call API to get the splash Screen details.
  ///
  /// [Either<Failure, SplashModel>] to handle the Failure or result data.
  Future<Either<Failure, SplashModel>?> getSplashData();
}

/// SplashUseCasesImpl will contain the SplashUseCases implementation.
class SplashUseCasesImpl implements SplashUseCases {
  SplashRepository? splashRepository;

  /// Dependence injection via constructor
  SplashUseCasesImpl({SplashRepository? repository}) {
    if (repository == null) {
      splashRepository = SplashRepositoryImpl();
    } else {
      splashRepository = repository;
    }
  }

  /// Call API to get the Splash Screen Details details.
  ///
  /// [Either<Failure, SplashModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, SplashModel>?> getSplashData() async {
    return await splashRepository?.getSplashData();
  }
}
