import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/repositories/loading_repository_impl.dart';

/// Interface for Loading use cases.
abstract class LoadingUseCases {
  /// Call API to get the Loading Screen details.
  ///
  /// [Either<Failure, LoadingModel>] to handle the Failure or result data.
  Future<Either<Failure, LoadingModelData>?> getLoadingData(String serviceName);
}

/// LoadingUseCasesImpl will contain the LoadingUseCases implementation.
class LoadingUseCasesImpl implements LoadingUseCases {
  LoadingRepository? loadingRepository;

  /// Dependence injection via constructor
  LoadingUseCasesImpl({LoadingRepository? repository}) {
    if (repository == null) {
      loadingRepository = LoadingRepositoryImpl();
    } else {
      loadingRepository = repository;
    }
  }

  /// Call API to get the Loading Screen Details details.
  ///
  /// [Either<Failure, LoadingModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, LoadingModelData>?> getLoadingData(
      String serviceName) async {
    return await loadingRepository?.getLoadingData(serviceName);
  }
}
