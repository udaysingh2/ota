import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';

import '../../../mocks/fixture_reader.dart';

class RoomGalleryRemoteDataSourceImplSuccessMock
    implements RoomGalleryRemoteDataSource {
  @override
  Future<RoomGalleryModelDomain> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) async {
    String json = fixture("room_gallery/room_gallery_mock.json");
    RoomGalleryModelDomain roomGalleryModelDomain =
        RoomGalleryModelDomain.fromJson(json);
    return roomGalleryModelDomain;
  }
}
