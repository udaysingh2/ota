import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_confirm_payment_handler/models/booking_confirm_handler_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "channels/booking_confirm_payment_handler/booking_confirm_payment_handler.json");

  BookingConfirmHandlerModelChannel bookingConfirmHandlerModelChannel =
      BookingConfirmHandlerModelChannel.fromJson(json);

  test("ota booking handler Model", () {
    ///Convert into Model
    BookingConfirmHandlerModelChannel model = bookingConfirmHandlerModelChannel;
    expect(model.orderId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    BookingConfirmHandlerModelChannel mapFromModel =
        BookingConfirmHandlerModelChannel.fromMap(map);
    expect(mapFromModel.orderId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    BookingConfirmHandlerModelChannel modelFromJson =
        BookingConfirmHandlerModelChannel.fromJson(jsondata);
    expect(modelFromJson.orderId != null, true);
  });
}
