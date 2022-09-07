import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_details.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/details/models/tour_package_details_argument_domain.dart';

/// Interface for Interesting attraction Data remote data source.
abstract class TourDetailsRemoteDataSource {
  Future<TourDetail> getTourDetails(TourDetailArgumentDomain argument);

  Future<TourDetail> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument);
}

class TourDetailsRemoteDataSourceImpl implements TourDetailsRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourDetailsRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<TourDetail> getTourDetails(TourDetailArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourDetails,
        query: QueriesTourDetailsData.getTourDetailsData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourDetail.fromMap(result.data!);
    }
  }

  @override
  Future<TourDetail> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourPackageDetails,
        query: QueriesTourDetailsData.getPackageDetailsData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourDetail.fromMap(result.data!);
    }
  }
}
