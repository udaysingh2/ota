import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/room_detail/data_sources/room_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

class RoomDetailRemoteDataSourceFailureMock
    implements RoomDetailRemoteDataSource {
  @override
  Future<RoomDetailData> getRoomDetail(RoomDetailDataArgument argument) {
    throw exp.ServerException(null);
  }
}
