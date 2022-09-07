import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_booking_detail.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart';

abstract class CarBookingDetailRemoteDataSource {
  /// Call API to get the Car booking detail result Data.
  ///
  /// [Either<Failure, CarBookingDetailDomainModel>] to handle the Failure or result data.
  Future<CarBookingDetailDomainModel> getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  });
}

/// CarBookingDetailRemoteDataSourceImpl will contain the CarBookingDetailRemoteDataSource implementation.
class CarBookingDetailRemoteDataSourceImpl
    implements CarBookingDetailRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarBookingDetailRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Car booking detail result Data.
  ///
  /// [Either<Failure, CarBookingDetailDomainModel>] to handle the Failure or result data.
  @override
  Future<CarBookingDetailDomainModel> getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  }) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarBookingDetail.getQueriesCarBookingDetailData(
          bookingId: bookingId,
          bookingUrn: bookingUrn,
          bookingType: bookingType,
        ),
        queryName: QueryNames.shared.getCarBookingDetailData);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      CarBookingDetailDomainModel carBookingDetailDomainModel =
          CarBookingDetailDomainModel.fromMap(
              result.data?[QueryNames.shared.getCarBookingDetailData]);
      return carBookingDetailDomainModel;
    }
  }
}
