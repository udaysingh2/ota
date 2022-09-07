import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_search_suggestion.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';

/// Interface for Playlist Data remote data source.
abstract class CarSearchSuggestionRemoteDataSource {
  /// Call API to get the Playlist Screen details.

  Future<CarSearchSuggestionData> getCarSearchSuggestionData(
      CarSearchSuggestionArgumentModelDomain argument);
}

/// CarSearchSuggestionRemoteDataSourceImpl will contain the CarSearchSuggestionRemoteDataSource implementation.
class CarSearchSuggestionRemoteDataSourceImpl
    implements CarSearchSuggestionRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarSearchSuggestionRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<CarSearchSuggestionData> getCarSearchSuggestionData(
      CarSearchSuggestionArgumentModelDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarSearchSuggestion.getCarSearchSuggestionData(argument),
        queryName: QueryNames.shared.getDataScienceAutoCompleteSearch);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarSearchSuggestionData.fromMap(result.data!);
    }
  }
}
