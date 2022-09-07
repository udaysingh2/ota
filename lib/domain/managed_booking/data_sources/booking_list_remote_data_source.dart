import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_booking_list.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';

/// Interface for BookingList Data remote data source.
abstract class BookingListRemoteDataSource {
  /// Call API to get the BookingList Screen details.
  ///
  /// [userId] to get the BookingList Data for users.
  /// [Either<Failure, BookingListModelDomain>] to handle the Failure or result data.
  Future<BookingListModelDomain> getBookingListData(
      BookingArgumentDomain argument);
}

/// BookingListRemoteDataSourceImpl will contain the BookingListRemoteDataSource implementation.
class BookingListRemoteDataSourceImpl implements BookingListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  BookingListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the BookingList Screen details.
  ///
  /// [userId] to get the BookingList Data for users.
  /// [Either<Failure, BookingListModelDomain>] to handle the Failure or result data.
  @override
  Future<BookingListModelDomain> getBookingListData(
      BookingArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getBookingSummary,
        query: QueriesBookingList.getBookingListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return BookingListModelDomain.fromMap(result.data!);
    }
  }
}
