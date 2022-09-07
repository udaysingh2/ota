import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel_booking_list.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';

/// Interface for HotelBookingList Data remote data source.
abstract class HotelBookingListRemoteDataSource {
  /// Call API to get the HotelBookingList Screen details.
  ///
  /// [userId] to get the HotelBookingList Data for users.
  /// [Either<Failure, HotelBookingListModelDomain>] to handle the Failure or result data.
  Future<HotelBookingListModelDomain> getHotelBookingListData(
      HotelBookingArgumentDomain argument);
}

/// HotelBookingListRemoteDataSourceImpl will contain the HotelBookingListRemoteDataSource implementation.
class HotelBookingListRemoteDataSourceImpl
    implements HotelBookingListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelBookingListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the HotelBookingList Screen details.
  ///
  /// [userId] to get the HotelBookingList Data for users.
  /// [Either<Failure, HotelBookingListModelDomain>] to handle the Failure or result data.
  @override
  Future<HotelBookingListModelDomain> getHotelBookingListData(
      HotelBookingArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getBookingSummary,
        query: QueriesHotelBookingList.getHotelBookingListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelBookingListModelDomain.fromMap(result.data!);
    }
  }
}
