import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';

/// Interface for Search use cases.
abstract class SearchRecommendationUseCases {
  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  Future<Either<Failure, SearchRecommendationModel>?>
      getSearchRecommendationData(SearchServiceType serviceType);

  Future<Either<Failure, HotelRecommendationModelDomain>?>
      getHotelSearchRecommendationData(
          HotelRecommendationArgDomain recommendationArgument);
}

/// SearchUseCasesImpl will contain the SearchUseCases implementation.
class SearchRecommendationUseCasesImpl implements SearchRecommendationUseCases {
  SearchRepository? searchRepository;

  /// Dependence injection via constructor
  SearchRecommendationUseCasesImpl({SearchRepository? repository}) {
    if (repository == null) {
      searchRepository = SearchRepositoryImpl();
    } else {
      searchRepository = repository;
    }
  }

  /// Call API to get the Search Suggestion Screen Details details.
  ///
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.

  @override
  Future<Either<Failure, SearchRecommendationModel>?>
      getSearchRecommendationData(SearchServiceType serviceType) async {
    return await searchRepository?.getSearchRecommendationData(serviceType);
  }

  @override
  Future<Either<Failure, HotelRecommendationModelDomain>?>
      getHotelSearchRecommendationData(
          HotelRecommendationArgDomain recommendationArgument) async {
    return await searchRepository
        ?.getHotelSearchRecommendationData(recommendationArgument);
  }
}
