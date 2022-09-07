import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';
import 'package:ota/domain/car_rental/car_save_search_history/repositories/car_save_search_repository_impl.dart';

/// Interface for Search save use cases.
abstract class CarSaveSearchHistoryUseCases {
  /// Call API to save the Search History.
  ///
  /// [Either<Failure, CarSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, CarSaveSearchHistoryModelDomain>?>
      saveCarSearchHistoryData(CarSaveSearchHistoryArgumentDomain argument);
}

/// CarSaveSearchHistoryUseCasesImpl will contain the CarSaveSearchHistoryUseCases implementation.
class CarSaveSearchHistoryUseCasesImpl implements CarSaveSearchHistoryUseCases {
  CarSaveSearchHistoryRepository? saveSearchHistoryRepository;

  /// Dependence injection via constructor
  CarSaveSearchHistoryUseCasesImpl(
      {CarSaveSearchHistoryRepository? repository}) {
    if (repository == null) {
      saveSearchHistoryRepository = CarSaveSearchHistoryRepositoryImpl();
    } else {
      saveSearchHistoryRepository = repository;
    }
  }

  /// Call API to save the Search History.
  ///
  /// [Either<Failure, CarSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSaveSearchHistoryModelDomain>?>
      saveCarSearchHistoryData(
          CarSaveSearchHistoryArgumentDomain argument) async {
    return await saveSearchHistoryRepository!
        .saveCarSearchHistoryData(argument);
  }
}
