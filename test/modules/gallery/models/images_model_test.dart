import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/models/images_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("gallery/images_model.json");
  test("Gallery Model", () {
    ///Convert into Model
    ImagesModel model = ImagesModel.fromJson(json);
    expect(model.baseUri != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    ImagesModel mapFromModel = ImagesModel.fromMap(map);
    expect(mapFromModel.baseUri != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
