import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../../../../core_pack/graphql/queries/queries_car_reservation.dart';
import '../models/car_reservation_argument_model.dart';
import '../models/car_reservation_domain_model.dart';

abstract class CarReservationRemoteDataSource {
  Future<CarReservationScreenDomainData> getCarReservationData(
      CarReservationDomainArgumentModel argument);
}

class CarReservationRemoteDataSourceImpl
    implements CarReservationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarReservationRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<CarReservationScreenDomainData> getCarReservationData(
      CarReservationDomainArgumentModel argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarReservation.getCarReservationData(argument),
        queryName: QueryNames.shared.getCarInitiateBookingResponse);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarReservationScreenDomainData.fromMap(result.data!);
    }
  }
}
