import 'package:ota/domain/hotel/room_detail/data_sources/room_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

import '../../../../mocks/fixture_reader.dart';

class RoomDetailRemoteDataSourceImplNullDataMock
    implements RoomDetailRemoteDataSource {
  @override
  Future<RoomDetailData> getRoomDetail(RoomDetailDataArgument argument) async {
    String json = fixture("room_detail/room_detail_null_data.json");
    RoomDetailData model = RoomDetailData.fromJson(json);
    return model;
  }
}
