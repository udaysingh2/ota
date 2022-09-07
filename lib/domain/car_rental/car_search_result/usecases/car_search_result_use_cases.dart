import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';
import 'package:ota/domain/car_rental/car_search_result/repositories/car_search_result_repository_impl.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

/// Interface for Gallery use cases.
abstract class CarSearchResultUseCases {
  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchResultDomainModel>] to handle the Failure or result data.
  Future<Either<Failure, CarSearchResultDomainModel>?> getCarSearchResultData(
      {required CarSearchResultDomainArgumentModel argument,
      required int pageNumber,
      required int pageSize,
      required LocationModel? pickupLocation,
      required LocationModel? dropLocation,
      required String dataSearchType,
      required bool isSearchSave});
}

/// CarSearchResultUseCasesImpl will contain the CarSearchResultUseCases implementation.
class CarSearchResultUseCasesImpl implements CarSearchResultUseCases {
  CarSearchResultRepository? carSearchResultRepository;

  /// Dependence injection via constructor
  CarSearchResultUseCasesImpl({CarSearchResultRepository? repository}) {
    if (repository == null) {
      carSearchResultRepository = CarSearchResultRepositoryImpl();
    } else {
      carSearchResultRepository = repository;
    }
  }

  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchResultDomainModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSearchResultDomainModel>?> getCarSearchResultData(
      {required CarSearchResultDomainArgumentModel argument,
      required int pageNumber,
      required int pageSize,
      required LocationModel? pickupLocation,
      required LocationModel? dropLocation,
      required String dataSearchType,
      required bool isSearchSave}) async {
    return await carSearchResultRepository?.getCarSearchResultData(
        argument,
        pageNumber,
        pageSize,
        pickupLocation,
        dropLocation,
        dataSearchType,
        isSearchSave);
  }
}
