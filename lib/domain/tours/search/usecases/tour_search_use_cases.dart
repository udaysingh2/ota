import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/search/model/tour_search_history_model_domain.dart';
import 'package:ota/domain/tours/search/repositories/tour_search_repository_impl.dart';

/// Interface for Search use cases.
abstract class TourSearchHistoryUseCases {
  /// Call API to get the Search History.
  ///
  /// [Either<Failure, TourAndTicketRecentSearchesModel>] to handle the Failure or result data.
  Future<Either<Failure, TourSearchHistoryModelDomain>?>
      getTourSearchHistoryData();
}

/// TourSearchUseCasesImpl will contain the TourSearchUseCases implementation.
class TourSearchHistoryUseCasesImpl implements TourSearchHistoryUseCases {
  TourSearchRepository? searchRepository;

  /// Dependence injection via constructor
  TourSearchHistoryUseCasesImpl({TourSearchRepository? repository}) {
    if (repository == null) {
      searchRepository = TourSearchRepositoryImpl();
    } else {
      searchRepository = repository;
    }
  }

  /// Call API to get the Search History.
  ///
  /// [Either<Failure, TourAndTicketRecentSearchesModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourSearchHistoryModelDomain>?>
      getTourSearchHistoryData() async {
    return await searchRepository?.getTourSearchHistoryData();
  }
}
