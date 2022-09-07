import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';

class SearchRemoteDataSourceFailureMock implements SearchRemoteDataSource {
  @override
  Future<SearchRecommendationModel> getSearchRecommendationData(
      SearchServiceType serviceType) async {
    throw exp.ServerException(null);
  }

  @override
  Future<SearchSuggestionModel> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt) async {
    throw exp.ServerException(null);
  }

  @override
  Future<HotelRecommendationModelDomain> getHotelSearchRecommendationData(
      HotelRecommendationArgDomain recommendationArgument) {
    throw exp.ServerException(null);
  }
}
