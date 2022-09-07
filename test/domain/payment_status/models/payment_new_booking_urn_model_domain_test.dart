import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("payment_status/payment_new_booking_urn.json");
  String json1 = fixture("payment_status/payment_new_booking_data.json");

  PaymentNewBookingUrnModelDomain paymentNewBookingUrnModelDomain =
      PaymentNewBookingUrnModelDomain.fromJson(jsonString);
  Status status = Status.fromJson(jsonString);
  printDebug(paymentNewBookingUrnModelDomain.generateNewBookingUrn);
  test("Payment New Booking Urn model Test", () {
    expect(paymentNewBookingUrnModelDomain.generateNewBookingUrn != null, true);

    Map<String, dynamic> map = paymentNewBookingUrnModelDomain.toMap();
    PaymentNewBookingUrnModelDomain mapFromModel =
        PaymentNewBookingUrnModelDomain.fromMap(map);

    expect(mapFromModel.generateNewBookingUrn != null, true);

    String stringData = paymentNewBookingUrnModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = paymentNewBookingUrnModelDomain.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Getting New Booking Urn Test", () {
    GenerateNewBookingUrn generateNewBookingUrn =
        GenerateNewBookingUrn.fromJson(
            paymentNewBookingUrnModelDomain.generateNewBookingUrn!.toJson());

    Map<String, dynamic> map = generateNewBookingUrn.toMap();
    expect(map.isNotEmpty, true);

    GenerateNewBookingUrn mapFromModel = GenerateNewBookingUrn.fromMap(map);
    expect(mapFromModel.data != null, true);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("New booking Urn data test", () {
    Data data = Data.fromJson(json1);

    Map<String, dynamic> map = data.toMap();
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.newBookingUrn != null, true);

    String stringData = data.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = data.toJson();
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
