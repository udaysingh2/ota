import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "channels/ota_landing_noti_handler/ota_landing_noti_handler.json");

  OtaLandingNotiHandlerModelChannel otaLandingNotiHandlerModelChannel =
      OtaLandingNotiHandlerModelChannel.fromJson(json);

  test("ota landing noti handler Model", () {
    ///Convert into Model
    OtaLandingNotiHandlerModelChannel model = otaLandingNotiHandlerModelChannel;
    expect(model.userId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaLandingNotiHandlerModelChannel mapFromModel =
        OtaLandingNotiHandlerModelChannel.fromMap(map);
    expect(mapFromModel.userId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    OtaLandingNotiHandlerModelChannel modelFromJson =
        OtaLandingNotiHandlerModelChannel.fromJson(jsondata);
    expect(modelFromJson.userId != null, true);
  });
}
