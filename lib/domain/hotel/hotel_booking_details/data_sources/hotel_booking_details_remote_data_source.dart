import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel_booking_detail.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_details_argument_model.dart';

/// Interface for Hotel detail Data remote data source.
abstract class HotelBookingDetailRemoteDataSource {
  Future<HotelBookingDetailModelDomain> getHotelBookingDetail(
      HotelBookingDetailArgumentDomain argument);
}

class HotelBookingDetailRemoteDataSourceImpl
    implements HotelBookingDetailRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelBookingDetailRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<HotelBookingDetailModelDomain> getHotelBookingDetail(
      HotelBookingDetailArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.bookingDetails,
        query: QueriesHotelBookingDetail.getHotelBookingDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelBookingDetailModelDomain.fromMap(
          result.data![QueryNames.shared.bookingDetails]);
    }
  }
}
