import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel_detail_interest.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';

/// Interface for Hotel detail Data remote data source.
abstract class HotelDetailInterestRemoteDataSource {
  Future<HotelDetailInterestData> getHotelDetailInterestData(
      HotelDetailInterestDataArgument argument);
}

class HotelDetailInterestRemoteDataSourceImpl
    implements HotelDetailInterestRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelDetailInterestRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<HotelDetailInterestData> getHotelDetailInterestData(
      HotelDetailInterestDataArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getHotelsYouMayLike,
        query: QueriesHotelDetailInterest.getHotelInterest(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      HotelDetailInterestData output =
          HotelDetailInterestData.fromMap({"data": result.data!});
      return output;
    }
  }
}
