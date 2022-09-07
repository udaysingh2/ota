import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("car_reservation/car_reservation.json");
  CarReservationScreenDomainData carReservationScreenDomainData =
      CarReservationScreenDomainData.fromJson(json);

  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    CarReservationScreenDomainData model = carReservationScreenDomainData;
    expect(model.getCarInitiateBookingResponse != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CarReservationScreenDomainData mapFromModel =
        CarReservationScreenDomainData.fromMap(map);
    expect(mapFromModel.getCarInitiateBookingResponse != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    GetCarInitiateBookingResponse? model =
        carReservationScreenDomainData.getCarInitiateBookingResponse;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetCarInitiateBookingResponse mapFromModel =
        GetCarInitiateBookingResponse.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetCarInitiateBookingResponse modelFromJson =
        GetCarInitiateBookingResponse.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    GetCarInitiateBookingResponseData? model =
        carReservationScreenDomainData.getCarInitiateBookingResponse?.data;
    expect(model?.car != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetCarInitiateBookingResponseData mapFromModel = GetCarInitiateBookingResponseData.fromMap(map);
    expect(mapFromModel.car != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetCarInitiateBookingResponseData modelFromJson = GetCarInitiateBookingResponseData.fromJson(jsondata);
    expect(modelFromJson.car != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    Car? model =
        carReservationScreenDomainData.getCarInitiateBookingResponse?.data?.car;
    expect(model?.bagLargeNbr != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Car mapFromModel = Car.fromMap(map);
    expect(mapFromModel.bagLargeNbr != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    Car modelFromJson = Car.fromJson(jsondata);
    expect(modelFromJson.bagLargeNbr != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    PickupCounter? model = carReservationScreenDomainData
        .getCarInitiateBookingResponse?.data?.pickupCounter;
    expect(model?.id != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    PickupCounter mapFromModel = PickupCounter.fromMap(map);
    expect(mapFromModel.id != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    PickupCounter modelFromJson = PickupCounter.fromJson(jsondata);
    expect(modelFromJson.id != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    RatePerDays? model = carReservationScreenDomainData
        .getCarInitiateBookingResponse?.data?.ratePerDays;
    expect(model?.totalDays != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    RatePerDays mapFromModel = RatePerDays.fromMap(map);
    expect(mapFromModel.totalDays != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    RatePerDays modelFromJson = RatePerDays.fromJson(jsondata);
    expect(modelFromJson.totalDays != null, true);
  });
}
