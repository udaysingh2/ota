import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/models/data_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("gallery/data_model.json");
  test("Gallery Model", () {
    ///Convert into Model
    DataModel model = DataModel.fromJson(json);
    expect(model.hotelDetail != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    DataModel mapFromModel = DataModel.fromMap(map);
    expect(mapFromModel.hotelDetail != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
