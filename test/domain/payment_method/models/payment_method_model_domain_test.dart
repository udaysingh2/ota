import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("payment_method/payment_method.json");
  String json1 = fixture("payment_method/payment_method_result_model.json");

  PaymentMethodModelDomain paymentMethodModelDomain =
      PaymentMethodModelDomain.fromJson(jsonString);
  printDebug(paymentMethodModelDomain.getCustomerPaymentMethodDetails);
  test("Payment Method Domain Model Test", () {
    String stringData = paymentMethodModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = paymentMethodModelDomain.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Payment domain model Test", () {
    GetCustomerPaymentMethodDetails getCustomerPaymentMethodDetails =
        GetCustomerPaymentMethodDetails.fromJson(json1);
    Map<String, dynamic> map = getCustomerPaymentMethodDetails.toMap();

    GetCustomerPaymentMethodDetails mapFromModel =
        GetCustomerPaymentMethodDetails.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Payment domain method model test", () {
    Data data = Data.fromJson(json1);

    String stringData = data.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = data.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Payment domain method model test", () {
    PaymentList paymentList = PaymentList.fromJson(json1);

    String stringData = paymentList.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = paymentList.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("Payment domain method model test", () {
    Status status = Status.fromJson(json1);

    String stringData = status.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = status.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
