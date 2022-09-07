import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';
import 'package:ota/domain/tours/search/repositories/tour_search_suggestions_repository_impl.dart';

/// Interface for Search suggestions use cases.
abstract class TourSearchSuggestionsUseCases {
  /// Call API to get the Search Suggestions.
  ///
  /// [Either<Failure, TourSearchSuggestionsModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, TourSearchSuggestionsModelDomain>?>
      getTourSearchSuggestionsData(
          TourSearchSuggestionsArgumentDomain argument);
}

/// TourSearchSuggestionsUseCasesImpl will contain the TourSearchSuggestionsUseCases implementation.
class TourSearchSuggestionsUseCasesImpl
    implements TourSearchSuggestionsUseCases {
  TourSearchSuggestionsRepository? searchSuggestionsRepository;

  /// Dependence injection via constructor
  TourSearchSuggestionsUseCasesImpl(
      {TourSearchSuggestionsRepository? repository}) {
    if (repository == null) {
      searchSuggestionsRepository = TourSearchSuggestionsRepositoryImpl();
    } else {
      searchSuggestionsRepository = repository;
    }
  }

  /// Call API to get the Search Suggestions.
  ///
  /// [Either<Failure, TourSearchSuggestionsModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourSearchSuggestionsModelDomain>?>
      getTourSearchSuggestionsData(
          TourSearchSuggestionsArgumentDomain argument) async {
    return await searchSuggestionsRepository
        ?.getTourSearchSuggestionsData(argument);
  }
}
