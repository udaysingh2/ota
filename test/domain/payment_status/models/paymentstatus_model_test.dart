import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("payment_status/payment_status.json");
  PaymentStatusModelDomain paymentStatusModelDomain =
      PaymentStatusModelDomain.fromJson(jsonString);
  Status status = Status.fromJson(jsonString);
  printDebug(paymentStatusModelDomain.paymentStatus);
  test("Payment Status Model Test", () {
    ///Convert into Model
    expect(paymentStatusModelDomain.paymentStatus != null, true);

    //convert into map
    Map<String, dynamic> map = paymentStatusModelDomain.toMap();

    ///Check map conversion
    PaymentStatusModelDomain mapFromModel =
        PaymentStatusModelDomain.fromMap(map);

    expect(mapFromModel.paymentStatus != null, true);

    ///Convert to String
    String stringData = paymentStatusModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = paymentStatusModelDomain.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Payment Status Test", () {
    PaymentStatus paymentStatus = PaymentStatus.fromJson(
        paymentStatusModelDomain.paymentStatus!.toJson());
    //convert into map
    Map<String, dynamic> map = paymentStatus.toMap();
    expect(map.isNotEmpty, true);

    PaymentStatus mapFromModel = PaymentStatus.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Status test ", () {
    ///Convert into Model
    Status model = status;
    expect(model.code == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
