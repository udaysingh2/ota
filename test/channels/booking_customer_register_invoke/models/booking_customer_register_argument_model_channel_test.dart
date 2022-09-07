import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "channels/booking_confirm_register_invoke/booking_confirm_register_invoke.json");

  BookingCustomerRegisterArgumentModelChannel
      bookingCustomerRegisterArgumentModelChannel =
      BookingCustomerRegisterArgumentModelChannel.fromJson(json);

  test("ota booking handler Model", () {
    ///Convert into Model
    BookingCustomerRegisterArgumentModelChannel model =
        bookingCustomerRegisterArgumentModelChannel;
    expect(model.userId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    BookingCustomerRegisterArgumentModelChannel mapFromModel =
        BookingCustomerRegisterArgumentModelChannel.fromMap(map);
    expect(mapFromModel.userId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    BookingCustomerRegisterArgumentModelChannel modelFromJson =
        BookingCustomerRegisterArgumentModelChannel.fromJson(jsondata);
    expect(modelFromJson.userId != null, true);
  });
}
