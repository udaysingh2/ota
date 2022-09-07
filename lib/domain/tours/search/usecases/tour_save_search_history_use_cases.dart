import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_model_domain.dart';
import 'package:ota/domain/tours/search/repositories/tour_save_search_history_repository_impl.dart';

/// Interface for Search suggestions use cases.
abstract class TourSaveSearchHistoryUseCases {
  /// Call API to save the Search History.
  ///
  /// [Either<Failure, TourSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, TourSaveSearchHistoryModelDomain>?>
      saveTourSearchHistoryData(TourSaveSearchHistoryArgumentDomain argument);
}

/// TourSaveSearchHistoryUseCasesImpl will contain the TourSaveSearchHistoryUseCases implementation.
class TourSaveSearchHistoryUseCasesImpl
    implements TourSaveSearchHistoryUseCases {
  TourSaveSearchHistoryRepository? saveSearchHistoryRepository;

  /// Dependence injection via constructor
  TourSaveSearchHistoryUseCasesImpl(
      {TourSaveSearchHistoryRepository? repository}) {
    if (repository == null) {
      saveSearchHistoryRepository = TourSaveSearchHistoryRepositoryImpl();
    } else {
      saveSearchHistoryRepository = repository;
    }
  }

  /// Call API to save the Search History.
  ///
  /// [Either<Failure, TourSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourSaveSearchHistoryModelDomain>?>
      saveTourSearchHistoryData(
          TourSaveSearchHistoryArgumentDomain argument) async {
    return await saveSearchHistoryRepository!
        .saveTourSearchHistoryData(argument);
  }
}
