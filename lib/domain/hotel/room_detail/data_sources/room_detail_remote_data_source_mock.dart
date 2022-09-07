import 'package:ota/domain/hotel/room_detail/data_sources/room_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

class RoomDetailMockDataSourceImpl implements RoomDetailRemoteDataSource {
  RoomDetailMockDataSourceImpl();

  @override
  Future<RoomDetailData> getRoomDetail(RoomDetailDataArgument argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return RoomDetailData.fromJson(_responseMock);
  }
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
