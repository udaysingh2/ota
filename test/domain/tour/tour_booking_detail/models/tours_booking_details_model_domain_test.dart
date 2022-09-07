import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("tour/tour_bookings/tour_booking_details.json");

  TourBookingDetailModelDomain tourBookingModelDomain =
      TourBookingDetailModelDomain.fromJson(jsonString);
  test("Tour Method Domain Model Test", () {
    String stringData = tourBookingModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourBookingModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model Test", () {
    OtaBookingDetails getTourBooking = OtaBookingDetails.fromJson(jsonString);
    Map<String, dynamic> map = getTourBooking.toMap();

    OtaBookingDetails mapFromModel = OtaBookingDetails.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model data Test", () {
    Data getData = Data.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Data mapFromDataModel = Data.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model TourBookingDetailPromotionList Test", () {
    TourBookingDetailPromotionList getData =
        TourBookingDetailPromotionList.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    TourBookingDetailPromotionList mapFromDataModel =
        TourBookingDetailPromotionList.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model TourBookingDetail Test", () {
    TourBookingDetail getData = TourBookingDetail.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    TourBookingDetail mapFromDataModel = TourBookingDetail.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model TourBookingDetail Test", () {
    TourBookingDetail getData = TourBookingDetail.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    TourBookingDetail mapFromDataModel = TourBookingDetail.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model Information Test", () {
    Information getData = Information.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Information mapFromDataModel = Information.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model PackageDetail Test", () {
    PackageDetail getData = PackageDetail.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    PackageDetail mapFromDataModel = PackageDetail.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Tour domain model ParticipantInfo Test", () {
    ParticipantInfo getData = ParticipantInfo.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    ParticipantInfo mapFromDataModel = ParticipantInfo.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model PaymentDetails Test", () {
    PaymentDetails getData = PaymentDetails.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    PaymentDetails mapFromDataModel = PaymentDetails.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model Price Test", () {
    Price getData = Price.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Price mapFromDataModel = Price.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model Inclusions Test", () {
    Inclusions getData = Inclusions.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Inclusions mapFromDataModel = Inclusions.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model Highlight Test", () {
    Highlight getData = Highlight.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Highlight mapFromDataModel = Highlight.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Tour domain model ChildInfo Test", () {
    ChildInfo getData = ChildInfo.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    ChildInfo mapFromDataModel = ChildInfo.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model PriceDetails Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("tour/tour_bookings/tour_booking_details.json"));
    PriceDetails getData = PriceDetails.fromJson(jsonMap);
    Map<String, dynamic> dataMap = getData.toJson();

    expect(dataMap.isNotEmpty, true);
  });
  test("Tour domain model Promotion Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("tour/tour_bookings/tour_booking_details.json"));
    Promotion getData = Promotion.fromJson(jsonMap);
    Map<String, dynamic> dataMap = getData.toJson();

    expect(dataMap.isNotEmpty, true);
  });
  test("Tour domain model Status Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("tour/tour_bookings/tour_booking_details.json"));
    Status getData = Status.fromMap(jsonMap);
    Map<String, dynamic> dataMap = getData.toMap();

    expect(dataMap.isNotEmpty, true);
  });
}
