import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ticket_details.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';

abstract class TicketDetailsRemoteDataSource {
  Future<TicketDetail> getTicketDetails(TicketDetailArgumentDomain argument);

  Future<TicketDetail> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument);
}

class TicketDetailsRemoteSourceDataImpl
    implements TicketDetailsRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TicketDetailsRemoteSourceDataImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (_mockGraphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TicketDetail> getTicketDetails(
      TicketDetailArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTicketDetails,
        query: QueriesTicketDetailsData.get(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TicketDetail.fromMap(result.data!);
    }
  }

  /*
  * Created on 11.01.22
  * To get the ticket details on ticket booking calender screen
  * with additional arguments.
  *  "adults",
  *  "children",
  * "countryId": ,
  * "cityId",
  * "ticketId",
  * "ticketDate",
  * "refCode",
  * "rateKey",
  * "serviceId",
  */

  @override
  Future<TicketDetail> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTicketPackageDetails,
        query: QueriesTicketDetailsData.getTicketPackageDetail(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TicketDetail.fromMap(result.data!);
    }
  }
}
