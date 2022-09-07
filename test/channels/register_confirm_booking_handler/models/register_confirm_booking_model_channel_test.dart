import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_mock_data_source.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';

void main() {
  test("Register Confirm Booking MOdel Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(RegisterConfirmBookingMockDataSourceImpl.getMockData());

    ///For class Message Model Domain
    RegisterConfirmBookingModelChannel registerConfirmBookingModelChannel = RegisterConfirmBookingModelChannel.fromMap(jsonMap);
    String jsonStringData = registerConfirmBookingModelChannel.toJson();
    RegisterConfirmBookingModelChannel messageJson =
        RegisterConfirmBookingModelChannel.fromJson(jsonStringData);
    expect(messageJson.env != null, true);

  });
}
