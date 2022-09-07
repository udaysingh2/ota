import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_search_filter/model/car_search_filter_domain_model.dart';
import 'package:ota/domain/car_rental/car_search_filter/repositories/car_search_filter_repository_impl.dart';

/// Interface for Gallery use cases.
abstract class CarSearchFilterUseCases {
  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchFilterDomainModel>] to handle the Failure or result data.
  Future<Either<Failure, CarSearchFilterDomainModel>?> getCarSearchFilterData();
}

/// CarSearchFilterUseCasesImpl will contain the CarSearchFilterUseCases implementation.
class CarSearchFilterUseCasesImpl implements CarSearchFilterUseCases {
  CarSearchFilterRepository? carSearchFilterRepository;

  /// Dependence injection via constructor
  CarSearchFilterUseCasesImpl({CarSearchFilterRepository? repository}) {
    if (repository == null) {
      carSearchFilterRepository = CarSearchFilterRepositoryImpl();
    } else {
      carSearchFilterRepository = repository;
    }
  }

  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchFilterDomainModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSearchFilterDomainModel>?>
      getCarSearchFilterData() async {
    return await carSearchFilterRepository?.getCarSearchFilterData();
  }
}
