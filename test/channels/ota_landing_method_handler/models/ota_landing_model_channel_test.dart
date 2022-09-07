import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_method_handler/models/ota_landing_handler_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("channels/ota_landing_handler/ota_landing_handler.json");

  OtaLandingHandlerModelChannel otaLandingHandlerModelChannel =
      OtaLandingHandlerModelChannel.fromJson(json);

  test("ota landing handler Model test", () {
    ///Convert into Model
    OtaLandingHandlerModelChannel model = otaLandingHandlerModelChannel;
    expect(model.userId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaLandingHandlerModelChannel mapFromModel =
        OtaLandingHandlerModelChannel.fromMap(map);
    expect(mapFromModel.userId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    OtaLandingHandlerModelChannel modelFromJson =
        OtaLandingHandlerModelChannel.fromJson(jsondata);
    expect(modelFromJson.userId != null, true);
  });
}
