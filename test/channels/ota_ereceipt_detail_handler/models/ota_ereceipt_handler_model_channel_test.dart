import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("channels/ota_ereceipt_handler/ota_ereceipt_handler.json");

  OtaEReceiptHandlerModelChannel otaEReceiptHandlerModelChannel =
      OtaEReceiptHandlerModelChannel.fromJson(json);

  test("ota e receipt  handler Model", () {
    ///Convert into Model
    OtaEReceiptHandlerModelChannel model = otaEReceiptHandlerModelChannel;
    expect(model.userId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaEReceiptHandlerModelChannel mapFromModel =
        OtaEReceiptHandlerModelChannel.fromMap(map);
    expect(mapFromModel.userId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    OtaEReceiptHandlerModelChannel modelFromJson =
        OtaEReceiptHandlerModelChannel.fromJson(jsondata);
    expect(modelFromJson.userId != null, true);
  });
}
