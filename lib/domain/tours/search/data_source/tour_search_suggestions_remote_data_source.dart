import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/query_tour_search_suggestions.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';

/// Interface for Search Suggestions Data remote data source.
abstract class TourSearchSuggestionsRemoteDataSource {
  /// Call API to get the Search Suggestions.
  ///
  /// [Either<Failure, TourSearchSuggestionsModelDomain>] to handle the Failure or result data.
  Future<TourSearchSuggestionsModelDomain> getTourSearchSuggestionsData(
      TourSearchSuggestionsArgumentDomain argument);
}

/// SearchSuggestionsRemoteDataSourceImpl will contain the TourSearchSuggestionsRemoteDataSource implementation.
class TourSearchSuggestionsRemoteDataSourceImpl
    implements TourSearchSuggestionsRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourSearchSuggestionsRemoteDataSourceImpl(
      {GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Search Suggestion.
  ///
  /// [Either<Failure, TourSearchSuggestionsModelDomain>] to handle the Failure or result data.
  @override
  Future<TourSearchSuggestionsModelDomain> getTourSearchSuggestionsData(
      TourSearchSuggestionsArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourSearchSuggestionsData,
        query: QueriesTourSearchSuggestions.getSearchSuggestionsData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourSearchSuggestionsModelDomain.fromMap(result.data!);
    }
  }
}
