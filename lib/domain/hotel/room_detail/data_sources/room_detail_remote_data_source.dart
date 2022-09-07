import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_room_detail.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

/// Interface for Room detail Data remote data source.
/// Change the argument model
abstract class RoomDetailRemoteDataSource {
  Future<RoomDetailData> getRoomDetail(RoomDetailDataArgument argument);
}

class RoomDetailRemoteDataSourceImpl implements RoomDetailRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  RoomDetailRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<RoomDetailData> getRoomDetail(RoomDetailDataArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getRoomDetails,
        query: QueriesRoom.getRoomDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RoomDetailData.fromMap(result.data!);
    }
  }
}
