import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("room_detail/room_category_model.json");
  test("Room category Model", () {
    ///Convert into Model
    RoomCategory? model = RoomCategory.fromJson(json);
    expect(model.roomName != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RoomCategory? mapFromModel = RoomCategory.fromMap(map);
    expect(mapFromModel.roomName != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
