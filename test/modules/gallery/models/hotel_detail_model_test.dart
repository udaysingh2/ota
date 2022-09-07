import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/models/hotel_detail_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("gallery/hotel_detail_model.json");
  test("Gallery Model", () {
    ///Convert into Model
    HotelDetailModel model = HotelDetailModel.fromJson(json);
    expect(model.images != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelDetailModel mapFromModel = HotelDetailModel.fromMap(map);
    expect(mapFromModel.images != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
