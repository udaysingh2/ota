import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/domain/search/repositories/ota_search_repository_impl.dart';

/// Interface for ota search use cases.
abstract class OtaSearchUseCases {
  /// Call API to get the ota search details.
  ///
  /// [Either<Failure, OtaSearchData>] to handle the Failure or result data.
  Future<Either<Failure, OtaSearchData>?> getOtaSearchData(
      OtaSearchDataArgument argument);
}

/// OtaSearchUseCasesImpl will contain the OtaSearchUseCases implementation.
class OtaSearchUseCasesImpl implements OtaSearchUseCases {
  OtaSearchRepository? _otaSearchRepository;

  /// Dependence injection via constructor
  OtaSearchUseCasesImpl({OtaSearchRepository? repository}) {
    if (repository == null) {
      _otaSearchRepository = OtaSearchRepositoryImpl();
    } else {
      _otaSearchRepository = repository;
    }
  }

  /// Call API to get the search result details.
  ///
  /// [Either<Failure, OtaSearchData>] to handle the Failure or result data.
  @override
  Future<Either<Failure, OtaSearchData>?> getOtaSearchData(
      OtaSearchDataArgument argument) async {
    return await _otaSearchRepository?.getOtaSearchData(argument);
  }
}
