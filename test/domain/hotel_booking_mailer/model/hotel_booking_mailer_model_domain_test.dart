import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString =
      fixture("hotel/hotel_booking_mailer/hotel_booking_mailer_mock.json");
  HotelBookingMailerModelDomain hotelBookingMailerResultModel =
      HotelBookingMailerModelDomain.fromJson(jsonString);
  SendEmailConfirmation sendEmailConfirmation =
      SendEmailConfirmation.fromJson(jsonString);

  Status status = Status.fromJson(jsonString);

  test("Hotel Booking Mailer Models", () {
    //Convert into Model
    expect(hotelBookingMailerResultModel.sendEmailConfirmation != null, true);

    //convert into map
    Map<String, dynamic> map = hotelBookingMailerResultModel.toMap();

    ///Check map conversion
    HotelBookingMailerModelDomain mapFromModel =
        HotelBookingMailerModelDomain.fromMap(map);

    expect(mapFromModel.sendEmailConfirmation != null, true);

    ///Convert to String
    String stringData = hotelBookingMailerResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = hotelBookingMailerResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Data data = Data.fromJson(
        hotelBookingMailerResultModel.sendEmailConfirmation!.data!.toJson());
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
