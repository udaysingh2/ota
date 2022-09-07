import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class SearchRepositoryImplSuccessMock implements SearchRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  SearchRemoteDataSource? searchRemoteDataSource;

  @override
  Future<Either<Failure, SearchRecommendationModel>>
      getSearchRecommendationData(SearchServiceType searchServiceType) async {
    String json = fixture("search/search_recommendation.json");
    SearchRecommendationModel model = SearchRecommendationModel.fromJson(json);
    return Right(model);
  }

  @override
  Future<Either<Failure, SearchSuggestionModel>> getSearchSuggestionData(
      SuggestionDataArgument argument) async {
    String json = fixture("search/search_suggestion.json");
    SearchSuggestionModel model = SearchSuggestionModel.fromJson(json);
    return Right(model);
  }

  @override
  Future<Either<Failure, HotelRecommendationModelDomain>>
      getHotelSearchRecommendationData(
          HotelRecommendationArgDomain recommendationArgument) async {
    String json = fixture("search/hotel_recommendation.json");
    HotelRecommendationModelDomain model =
        HotelRecommendationModelDomain.fromJson(json);
    return Right(model);
  }
}
