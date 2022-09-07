import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_booking_cancellation.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

abstract class CarBookingCancellationRemoteDataSource {
  Future<CarBookingCancellationModelDomain> getCarBookingCancellationData(
      CarBookingCancellationArgument argument);
}

class CarBookingCancellationRemoteDataSourceImpl
    implements CarBookingCancellationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarBookingCancellationRemoteDataSourceImpl(
      {GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<CarBookingCancellationModelDomain> getCarBookingCancellationData(
      CarBookingCancellationArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query:
            QueriesCarBookingCancellation.getCarBookingCancellation(argument),
        queryName: QueryNames.shared.getCarBookingCancellationData);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarBookingCancellationModelDomain.fromMap(
          result.data!["getCarRejectBookingResponse"]);
    }
  }
}
