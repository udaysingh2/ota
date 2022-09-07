import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture("room_gallery/room_gallery_mock.json");

  RoomGalleryModelDomain response = RoomGalleryModelDomain.fromJson(json);

  test('Room Gallery data check model', () async {
    ///Convert in Model
    RoomGalleryModelDomain model = response;

    expect(model.getRoomImages != null, true);

    expect(model.getRoomImages?.data != null, true);

    ///convert in map
    Map<String, dynamic> map = model.toMap();

    RoomGalleryModelDomain modelMap = RoomGalleryModelDomain.fromMap(map);

    expect(modelMap.getRoomImages != null, true);

    expect(modelMap.getRoomImages?.data != null, true);

    ///Convert to json
    String json = model.toJson();
    expect(json.isNotEmpty, true);

    RoomGalleryModelDomain modelJson = RoomGalleryModelDomain.fromJson(json);

    expect(modelJson.getRoomImages != null, true);

    expect(modelJson.getRoomImages?.data != null, true);
  });

  test('To check Room Image List', () {
    RoomGalleryModelDomain model = response;

    expect(model.getRoomImages?.data?.images != null, true);

    expect(model.getRoomImages?.data?.roomImageCount != null, true);

    expect(model.getRoomImages?.data?.roomImageCount, 1);

    expect(model.getRoomImages?.data?.images?.length, 4);

    expect(model.getRoomImages?.data?.images?[0].url != null, true);
  });
}
