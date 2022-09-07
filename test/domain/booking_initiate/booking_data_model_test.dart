import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';

import '../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("booking/booking_initiate.json");
  final String json1 = fixture("booking/cancellation_policy_list.json");
  BookingData bookingData = BookingData.fromJson(json);
  Facility facility = Facility.fromJson(json);
  RoomCategory roomCategory = RoomCategory.fromJson(json);
  Status status = Status.fromJson(json);
  Data data = Data.fromJson(json);
  RoomDetails roomDetails = RoomDetails.fromJson(json);

  test("BookingData Model", () {
    ///Convert into Model
    BookingData model = bookingData;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    BookingData mapFromModel = BookingData.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("RoomDetails test ", () {
    ///Convert into Model
    RoomDetails model = roomDetails;
    expect(model.cancellationPolicy == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RoomDetails mapFromModel = RoomDetails.fromMap(map);
    expect(mapFromModel.cancellationPolicy == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Cancellation Policy Model", () {
    ///Convert into Model
    List<CancellationPolicy>? model =
        bookingData.data?.roomDetails?.cancellationPolicy;
    expect(model?.first.cancellationChargeDescription != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.first.toMap();

    ///Check map conversion
    CancellationPolicy mapFromModel = CancellationPolicy.fromMap(map);
    expect(mapFromModel.cancellationChargeDescription != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("Cancellation Policy Model", () {
    CancellationPolicy cancellationPolicy = CancellationPolicy.fromJson(json1);

    //convert into map
    Map<String, dynamic> map = cancellationPolicy.toMap();
    CancellationPolicy mapFromModel = CancellationPolicy.fromMap(map);
    expect(mapFromModel.cancellationChargeDescription != null, false);

    ///Convert to String
    String stringData = cancellationPolicy.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = cancellationPolicy.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("HotelBenefit", () {
    HotelBenefit cancellationPolicy = HotelBenefit.fromJson(json1);

    //convert into map
    Map<String, dynamic> map = cancellationPolicy.toMap();
    HotelBenefit mapFromModel = HotelBenefit.fromMap(map);
    expect(mapFromModel.shortDescription != null, false);

    ///Convert to String
    String stringData = cancellationPolicy.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = cancellationPolicy.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Facility test ", () {
    ///Convert into Model
    Facility model = facility;
    expect(model.key == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Facility mapFromModel = Facility.fromMap(map);
    expect(mapFromModel.key == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("PromotionList", () {
    PromotionList promotionList = PromotionList.fromMap(jsonDecode(json));

    ///convert into map
    Map<String, dynamic> map = promotionList.toMap();

    ///Check map conversion
    PromotionList mapFromModel = PromotionList.fromMap(map);
    expect(mapFromModel.title == null, true);

    ///Convert to String
    String stringData = promotionList.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("RoomCategory test ", () {
    ///Convert into Model
    RoomCategory model = roomCategory;
    expect(model.noOfRooms == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RoomCategory mapFromModel = RoomCategory.fromMap(map);
    expect(mapFromModel.noOfRooms == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
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

  test("Data test ", () {
    ///Convert into Model
    Data model = data;
    expect(model.bookingUrn == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.bookingUrn == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
