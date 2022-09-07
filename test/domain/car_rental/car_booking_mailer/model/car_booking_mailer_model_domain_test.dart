import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("carRental/car_booking_mailer_mock.json");
  CarBookingMailerModelDomain carBookingMailerResultModel =
      CarBookingMailerModelDomain.fromJson(jsonString);
  SendEmailConfirmation sendEmailConfirmation =
      SendEmailConfirmation.fromJson(jsonString);

  Status status = Status.fromJson(jsonString);

  test("Car Booking Mailer Models", () {
    //Convert into Model
    expect(carBookingMailerResultModel.sendEmailConfirmation != null, true);

    //convert into map
    Map<String, dynamic> map = carBookingMailerResultModel.toMap();

    ///Check map conversion
    CarBookingMailerModelDomain mapFromModel =
        CarBookingMailerModelDomain.fromMap(map);

    expect(mapFromModel.sendEmailConfirmation != null, true);

    ///Convert to String
    String stringData = carBookingMailerResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = carBookingMailerResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Data data = Data.fromJson(
        carBookingMailerResultModel.sendEmailConfirmation!.data!.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.actionStatus != null, true);

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

  test("Email Confirmation test ", () {
    ///Convert into Model
    SendEmailConfirmation model = sendEmailConfirmation;
    expect(model.data == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    SendEmailConfirmation mapFromModel = SendEmailConfirmation.fromMap(map);
    expect(mapFromModel.data == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
