import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("room_detail/room_detail.json");
  RoomDetail roomDetail = RoomDetail.fromJson(json);

  test("Room Details Model", () {
    ///Convert into Model
    RoomDetail model = roomDetail;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RoomDetail mapFromModel = RoomDetail.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Room Details Data Model", () {
    ///Convert into Model
    RoomDetailData? model = roomDetail.data;
    expect(model?.getRoomDetails != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    RoomDetailData mapFromModel = RoomDetailData.fromMap(map);
    expect(mapFromModel.getRoomDetails != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Room Details Model", () {
    ///Convert into Model
    GetRoomDetails? model = roomDetail.data!.getRoomDetails;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetRoomDetails mapFromModel = GetRoomDetails.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Room Details Model", () {
    ///Convert into Model
    GetRoomDetailsData? model = roomDetail.data!.getRoomDetails!.data;
    expect(model?.cancellationPolicy != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetRoomDetailsData mapFromModel = GetRoomDetailsData.fromMap(map);
    expect(mapFromModel.facilities != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Get Room Details Model", () {
    ///Convert into Model
    GetRoomDetails? model = roomDetail.data?.getRoomDetails;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetRoomDetails mapFromModel = GetRoomDetails.fromJson(jsondata);
    expect(mapFromModel.data != null, true);

    String? statusJson = roomDetail.data?.getRoomDetails?.status?.toJson();
    expect(statusJson != null, true);

    Status statusModel = Status.fromJson(statusJson ?? '');
    expect(statusModel.code != null, true);
  });

  test("Get Room Details data Model", () {
    ///Convert into Model
    GetRoomDetailsData? model =
        RoomDetail.fromJson(json).data?.getRoomDetails?.data;
    expect(model != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetRoomDetailsData mapFromModel = GetRoomDetailsData.fromJson(jsondata);
    expect(mapFromModel.mealType != null, true);
  });

  test("RoomInfo", () {
    RoomInfo getTourRecentlyViewedItems = RoomInfo.fromMap(jsonDecode(json));
    //Convert into Model
    expect(getTourRecentlyViewedItems.description != null, false);

    //convert into map
    Map<String, dynamic> map = getTourRecentlyViewedItems.toMap();

    ///Check map conversion
    RoomInfo mapFromModel = RoomInfo.fromMap(map);

    expect(mapFromModel.description != null, false);

    ///Convert to String
    String stringData = getTourRecentlyViewedItems.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("Room Details Model", () {
    ///Convert into Model
    Status? model = roomDetail.data!.getRoomDetails!.status;
    expect(model?.code != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("CancellationPolicy", () {
    CancellationPolicy getTourRecentlyViewedItems =
        CancellationPolicy.fromJson(_responseMock);
    //Convert into Model
    expect(getTourRecentlyViewedItems.cancellationStatus != null, false);

    ///convert into map
    Map<String, dynamic> map = getTourRecentlyViewedItems.toMap();

    ///Check map conversion
    CancellationPolicy mapFromModel = CancellationPolicy.fromMap(map);
    expect(mapFromModel.days != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("CancellationPolicy", () {
    HotelBenefit getTourRecentlyViewedItems =
    HotelBenefit.fromJson(_responseMock);
    //Convert into Model
    expect(getTourRecentlyViewedItems.shortDescription != null, false);

    ///convert into map
    Map<String, dynamic> map = getTourRecentlyViewedItems.toMap();

    ///Check map conversion
    HotelBenefit mapFromModel = HotelBenefit.fromMap(map);
    expect(mapFromModel.longDescription != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}

var _responseMock = '''{
		"getRoomDetails": {
			"data": {
				"mealType": "Deluxe with room only",
				"roomImage": "https://train.travflex.com/ImageData/Hotel/zayn_hotel_bangkok_(sha)-overview1.jpg",
				"roomInfo": {
							"roomImageCount": 20,
							"coverImage": "https://train.travflex.com/ImageData/Hotel/zayn_hotel_bangkok_(sha)-overview1.jpg",
							"roomFacilityInfo": "<#><li></li>",
							"description": "<p>Superiod Room Descripton</p>",
							"promoteFlag": "N",
							"dimension": "40 SQM",
							"totalRoom": "20",
							"doubleBedFlag": "Y",
							"twinBedFlag": "Y",
							"queenBedflag": "N",
							"smorkingFlag": "Y",
							"nonSmorkingFlag": "Y",
							"noWindowFlag": "N",
							"balconyFlag": "Y",
							"wifiFlag": "Y",
							"maxPaxNbr": "3"
						},
				"roomCategories": [
					{ 
						"noOfRoomsAndName":"2 x DELUXE",
						"roomName": "DELUXE",
						"roomType": "Double",
						"noOfRooms": 1
					}
				],
				"facilities": [
                    {
                        "key": "NON_SMOKING",
                        "value": "Y"
                    },
                    {
                        "key": "DIMENSION",
                        "value": "30"
                    },
                    {
                        "key": "DOUBLE_BED_FLAG",
                        "value": "Y"
                    },
                    {
                        "key": "TWIN_BED_FLAG",
                        "value": "Y"
                    },
                    {
                        "key": "QUEEN_BED_FLAG",
                        "value": "Y"
                    },
                    {
                        "key": "BALCONY_FLAG",
                        "value": "Y"
                    },
                    {
                        "key": "MAX_PAX_NBR",
                        "value": "3"
                    },
                    {
                        "key": "WIFI",
                        "value": "y"
                    },
                    {
                        "key": "NO_OF_ROOM",
                        "value": "1 x DELUXE"
                    },
                    {
                        "key": "BREAKFAST",
                        "value": "Y"
                    },
                    {
                        "key": "PAYMENT",
                        "value": "instant.payment"
                    }
                ],
				"cancellationPolicy": [
					{
						"days": 1,
						"cancellationDaysDescription": "You have to cancel 1 day(s) prior to the service date.",
						"cancellationChargeDescription": "Otherwise cancellation charge of Full Charge from Grand total will be applied.",
						"cancellationStatus": "conditional.cancellation"
					}
				],
				"roomFacilities": [
					"Tea / Coffee",
					"Minibar",
					"Workdesk",
					"Bathtub",
					"Wi-Fi",
					"TV",
					"220 Volt",
					"Babycot",
					"Radio",
					"Shower",
					"Toiletries",
					"Wired Internet",
					"24 Hrs. Room Service",
					"Non-smoking Room",
					"Air-condition",
					"IDD Phone",
					"Hairdryer"
				],
				"totalPrice": 1098.0,
				"perNightPrice": 1050.0,
				"discountPercent": 55.0,
				"nightPriceBeforeDiscount": 2786.0
			},
			"status": {
				"code": "1000",
				"header": "Success"
			}
	}
}''';
