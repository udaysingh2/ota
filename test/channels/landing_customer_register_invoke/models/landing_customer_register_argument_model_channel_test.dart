import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "channels/landing_customer_register_invoke/landing_customer_register_invoke.json");

  LandingCustomerRegisterArgumentModelChannel
      landingCustomerRegisterArgumentModelChannel =
      LandingCustomerRegisterArgumentModelChannel.fromJson(json);
  test("Landing Customer Register Argument Model test", () {
    ///Convert into Model
    LandingCustomerRegisterArgumentModelChannel model =
        landingCustomerRegisterArgumentModelChannel;
    expect(model.userType != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    LandingCustomerRegisterArgumentModelChannel mapFromModel =
        LandingCustomerRegisterArgumentModelChannel.fromMap(map);
    expect(mapFromModel.userType != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    LandingCustomerRegisterArgumentModelChannel modelFromJson =
        LandingCustomerRegisterArgumentModelChannel.fromJson(jsondata);
    expect(modelFromJson.userType != null, true);
  });
}
