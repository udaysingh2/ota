import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core_pack/graphql/graphql_client.dart';
import '../models/argument_data_model_room_detail_automation.dart';
import '../models/room_detail_model_automation.dart';
import 'query_room_automation.dart';

/// Interface for Hotel detail Data remote data source.
abstract class RoomDetailRemoteDataSourceAutomation {
  Future<RoomDetailAutomation> getRoomDetailAutomation(
      RoomDetailDataArgumentAutomation argument);
}

class RoomDetailRemoteDataSourceImpl
    implements RoomDetailRemoteDataSourceAutomation {
  RoomDetailRemoteDataSourceImpl();

  @override
  Future<RoomDetailAutomation> getRoomDetailAutomation(
      RoomDetailDataArgumentAutomation argument) async {
    // RoomDetailDataArgument argument1 = argument as RoomDetailDataArgument;
    // ignore: deprecated_member_use_from_same_package
    final QueryResult result = await getGraphQlResponse(
        query: QueriesRoomAutomation.getRoomDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RoomDetailAutomation.fromMap(result.data!);
    }
  }
}
