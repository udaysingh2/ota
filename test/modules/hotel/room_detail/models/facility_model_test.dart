import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("room_detail/facility_model.json");
  test("facility Model", () {
    ///Convert into Model
    Facility? model = Facility.fromJson(json);
    expect(model.key != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Facility? mapFromModel = Facility.fromMap(map);
    expect(mapFromModel.key != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
