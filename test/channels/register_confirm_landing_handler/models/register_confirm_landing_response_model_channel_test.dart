import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_mock_data_source.dart';

import 'package:ota/channels/register_confirm_landing_handler/models/register_confirm_landing_response_model_channel.dart';

void main() {
  test("Register Confirm Landing Response MOdel Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(RegisterConfirmLandingMockDataSourceImpl.getMockData());

    ///For class Message Model Domain
    RegisterConfirmLandingModelChannel registerConfirmLandingModelChannel = RegisterConfirmLandingModelChannel.fromMap(jsonMap);
    String jsonStringData = registerConfirmLandingModelChannel.toJson();
    RegisterConfirmLandingModelChannel messageJson =
        RegisterConfirmLandingModelChannel.fromJson(jsonStringData);
    expect(messageJson.env != null, true);

  });
}
