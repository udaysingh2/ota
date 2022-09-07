import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("gallery/gallery_result_model.json");
  test("Gallery Model", () {
    ///Convert into Model
    GalleryResultModel model = GalleryResultModel.fromJson(json);
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GalleryResultModel mapFromModel = GalleryResultModel.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
