import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("hotel_detail_interest/hotel_detail_interest.json");
  HotelDetailInterestData hotelDetailInterestData =
      HotelDetailInterestData.fromJson(json);

  HotelList hotelList = HotelList.fromJson(json);
  CapsulePromotion capsulePromotion = CapsulePromotion.fromJson(json);
  Address address = Address.fromJson(json);
  AdminPromotion adminPromotion = AdminPromotion.fromJson(json);
  Review review = Review.fromJson(json);
  Status status = Status.fromJson(json);

  test("BookingData Model", () {
    ///Convert into Model
    HotelDetailInterestData model = hotelDetailInterestData;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelDetailInterestData mapFromModel = HotelDetailInterestData.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    HotelDetailInterestData modelFromJson =
        HotelDetailInterestData.fromJson(jsonData);
    expect(modelFromJson.data != null, true);
  });

  test("Hotel Detail Interest Data", () {
    ///Convert into Model
    HotelDetailInterestDataData? model = hotelDetailInterestData.data;
    expect(model?.getHotelsYouMayLike != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    HotelDetailInterestDataData mapFromModel =
        HotelDetailInterestDataData.fromMap(map);
    expect(mapFromModel.getHotelsYouMayLike != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    HotelDetailInterestDataData modelFromJson =
        HotelDetailInterestDataData.fromJson(jsondata);
    expect(modelFromJson.getHotelsYouMayLike != null, true);
  });

  test("Get Hotels You May Like", () {
    ///Convert into Model
    GetHotelsYouMayLike? model =
        hotelDetailInterestData.data?.getHotelsYouMayLike;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetHotelsYouMayLike mapFromModel = GetHotelsYouMayLike.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetHotelsYouMayLike modelFromJson = GetHotelsYouMayLike.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });

  test("Get Hotels You May Like Data", () {
    ///Convert into Model
    GetHotelsYouMayLikeData? model =
        hotelDetailInterestData.data?.getHotelsYouMayLike?.data;
    expect(model?.hotelList != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetHotelsYouMayLikeData mapFromModel = GetHotelsYouMayLikeData.fromMap(map);
    expect(mapFromModel.hotelList != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetHotelsYouMayLikeData modelFromJson =
        GetHotelsYouMayLikeData.fromJson(jsondata);
    expect(modelFromJson.hotelList != null, true);
  });

  test("Hotel list test ", () {
    ///Convert into Model
    HotelList model = hotelList;
    expect(model.address == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelList mapFromModel = HotelList.fromMap(map);
    expect(mapFromModel.address == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Capsule Promotion test ", () {
    ///Convert into Model
    CapsulePromotion model = capsulePromotion;
    expect(model.code == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CapsulePromotion mapFromModel = CapsulePromotion.fromMap(map);
    expect(mapFromModel.code == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Address test ", () {
    ///Convert into Model
    Address model = address;
    expect(model.address == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Address mapFromModel = Address.fromMap(map);
    expect(mapFromModel.address == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Admin Promotion test ", () {
    ///Convert into Model
    AdminPromotion model = adminPromotion;
    expect(model.promotionText1 == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    AdminPromotion mapFromModel = AdminPromotion.fromMap(map);
    expect(mapFromModel.promotionText1 == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Review test ", () {
    ///Convert into Model
    Review model = review;
    expect(model.description == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Review mapFromModel = Review.fromMap(map);
    expect(mapFromModel.description == null, true);

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
}
