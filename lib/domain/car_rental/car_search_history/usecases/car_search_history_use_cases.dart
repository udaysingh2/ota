import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';
import 'package:ota/domain/car_rental/car_search_history/repositories/car_search_history_repository.dart';

/// Interface for Search use cases.
abstract class CarSearchHistoryUseCases {
  Future<Either<Failure, CarSearchHistoryModelDomainData>?>
      getCarSearchHistoryData();
}

class CarSearchHistoryUseCasesImpl implements CarSearchHistoryUseCases {
  CarSearchHistoryRepository? searchRepository;

  /// Dependence injection via constructor
  CarSearchHistoryUseCasesImpl({CarSearchHistoryRepository? repository}) {
    if (repository == null) {
      searchRepository = CarSearchHistoryRepositoryImpl();
    } else {
      searchRepository = repository;
    }
  }

  @override
  Future<Either<Failure, CarSearchHistoryModelDomainData>?>
      getCarSearchHistoryData() async {
    return await searchRepository?.getCarSearchHistoryData();
  }
}
