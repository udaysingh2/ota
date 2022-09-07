import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("channels/ota_payment_handler/ota_payment_handler.json");

  OtaPaymentModelChannel otaPaymentModelChannel =
      OtaPaymentModelChannel.fromJson(json);

  test("OTA payment handler Model", () {
    ///Convert into Model
    OtaPaymentModelChannel model = otaPaymentModelChannel;
    expect(model.cardType != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaPaymentModelChannel mapFromModel = OtaPaymentModelChannel.fromMap(map);
    expect(mapFromModel.cardType != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    OtaPaymentModelChannel modelFromJson =
        OtaPaymentModelChannel.fromJson(jsondata);
    expect(modelFromJson.cardType != null, true);
  });
}
