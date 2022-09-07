import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "channels/payment_management_invoke/payment_management_invoke.json");

  PaymentManagementArgumentModelChannel paymentManagementArgumentModelChannel =
      PaymentManagementArgumentModelChannel.fromJson(json);
  test("Payment Management Argument Model test", () {
    ///Convert into Model
    PaymentManagementArgumentModelChannel model =
        paymentManagementArgumentModelChannel;
    expect(model.serviceType != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    PaymentManagementArgumentModelChannel mapFromModel =
        PaymentManagementArgumentModelChannel.fromMap(map);
    expect(mapFromModel.serviceType != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    PaymentManagementArgumentModelChannel modelFromJson =
        PaymentManagementArgumentModelChannel.fromJson(jsondata);
    expect(modelFromJson.serviceType != null, true);
  });
}
