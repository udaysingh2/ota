import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/domain/confi_api/repositories/config_repository_impl.dart';

abstract class ConfigUseCases {
  Future<Either<Failure, ConfigResultModel>?> getConfigDetails();
}

class ConfigUseCasesImpl implements ConfigUseCases {
  ConfigRepository? configRepository;

  /// Dependence injection via constructor
  ConfigUseCasesImpl({ConfigRepository? repository}) {
    if (repository == null) {
      configRepository = ConfigRepositoryImpl();
    } else {
      configRepository = repository;
    }
  }
  @override
  Future<Either<Failure, ConfigResultModel>?> getConfigDetails() async {
    return await configRepository?.getConfigDetails();
  }
}
