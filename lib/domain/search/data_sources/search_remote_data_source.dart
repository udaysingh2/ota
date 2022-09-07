import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_search.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';

/// Interface for Search Data remote data source.
abstract class SearchRemoteDataSource {
  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [suggestionDataArgurmnt] to get the Search Suggestion Data for users.
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  Future<SearchSuggestionModel> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt);

  Future<SearchRecommendationModel> getSearchRecommendationData(
      SearchServiceType serviceType);

  Future<HotelRecommendationModelDomain> getHotelSearchRecommendationData(
      HotelRecommendationArgDomain recommendationArgument);
}

/// SearchRemoteDataSourceImpl will contain the SearchRemoteDataSource implementation.
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  SearchRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [suggestionDataArgurmnt] to get the Search Suggestion Data for users.
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  @override
  Future<SearchSuggestionModel> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getDataScienceAutoCompleteSearch,
        query: QueriesSearch.getSearchAutoCompleteSuggestionData(
            suggestionDataArgurmnt));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SearchSuggestionModel.fromMap(result.data!);
    }
  }

  @override
  Future<SearchRecommendationModel> getSearchRecommendationData(
      SearchServiceType serviceType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getSearchRecommendation,
        query: QueriesSearch.getSearchRecommendationData(serviceType));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SearchRecommendationModel.fromMap(result.data!);
    }
  }

  @override
  Future<HotelRecommendationModelDomain> getHotelSearchRecommendationData(
      HotelRecommendationArgDomain recommendationArgument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getHotelSearchRecommendation,
        query: QueriesSearch.getHotelSearchRecommendationData(
            recommendationArgument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelRecommendationModelDomain.fromMap(result.data!);
    }
  }
}
