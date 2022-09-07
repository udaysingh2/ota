import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../models/argument_data_model_automation.dart';
import '../models/argument_data_model_room_detail_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../models/room_detail_model_automation.dart';
import 'queries_hotel_automation.dart';
import 'query_room_automation.dart';

/// Interface for Hotel detail Data remote data source.
abstract class HotelDetailRemoteDataSourceAutomation {
  Future<HotelAutomation> getHotelDetail(
      HotelDetailDataArgumentAutomation argument);
  Future<RoomDetailDataAutomation> getRoomDetail(
      RoomDetailDataArgumentAutomation argument);
}

class HotelDetailRemoteDataSourceImpl
    implements HotelDetailRemoteDataSourceAutomation {
  HotelDetailRemoteDataSourceImpl();
  @override
  Future<HotelAutomation> getHotelDetail(
      HotelDetailDataArgumentAutomation argument) async {
    // ignore: deprecated_member_use_from_same_package
    final QueryResult result = await getGraphQlResponse(
        query: QueriesHotelAutomation.getHotelDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<RoomDetailDataAutomation> getRoomDetail(
      RoomDetailDataArgumentAutomation argument) async {
    // ignore: deprecated_member_use_from_same_package
    final QueryResult result = await getGraphQlResponse(
        query: QueriesRoomAutomation.getRoomDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RoomDetailDataAutomation.fromMap(result.data!);
    }
  }
}
