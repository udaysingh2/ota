import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_booling_detail_handler/models/ota_booking_handler_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("channels/ota_booking_detail_handler/ota_booking_detail.json");

  OtaBookingDetailHandlerModelChannel otaBookingDetailHandlerModelChannel =
      OtaBookingDetailHandlerModelChannel.fromJson(json);
  test("ota booking handler Model", () {
    ///Convert into Model
    OtaBookingDetailHandlerModelChannel model =
        otaBookingDetailHandlerModelChannel;
    expect(model.bookingType != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaBookingDetailHandlerModelChannel mapFromModel =
        OtaBookingDetailHandlerModelChannel.fromMap(map);
    expect(mapFromModel.bookingType != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    OtaBookingDetailHandlerModelChannel modelFromJson =
        OtaBookingDetailHandlerModelChannel.fromJson(jsondata);
    expect(modelFromJson.bookingType != null, true);
  });
}
