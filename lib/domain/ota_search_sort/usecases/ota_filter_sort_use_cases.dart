import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';
import 'package:ota/domain/ota_search_sort/repositories/ota_filter_sort_repository_impl.dart';

/// Interface for OtaSearchSort use cases.
abstract class OtaSearchSortUseCases {
  /// Call API to get the OtaSearchSort Screen details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  Future<Either<Failure, OtaFilterSort>?> getOtaSearchSortData();
}

/// OtaSearchSortUseCasesImpl will contain the OtaSearchSortUseCases implementation.
class OtaSearchSortUseCasesImpl implements OtaSearchSortUseCases {
  OtaSearchSortRepository? otaSearchSortRepository;

  /// Dependence injection via constructor
  OtaSearchSortUseCasesImpl({OtaSearchSortRepository? repository}) {
    if (repository == null) {
      otaSearchSortRepository = OtaSearchSortRepositoryImpl();
    } else {
      otaSearchSortRepository = repository;
    }
  }

  /// Call API to get the OtaSearchSort Screen Details details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  @override
  Future<Either<Failure, OtaFilterSort>?> getOtaSearchSortData() async {
    return await otaSearchSortRepository?.getOtaSearchSortData();
  }
}
