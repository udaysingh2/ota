import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("room_detail/cancellation_policy_model.json");
  test("Cancellation Policy Model", () {
    ///Convert into Model
    CancellationPolicy? model = CancellationPolicy.fromJson(json);
    expect(model.days != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CancellationPolicy? mapFromModel = CancellationPolicy.fromMap(map);
    expect(mapFromModel.days != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
