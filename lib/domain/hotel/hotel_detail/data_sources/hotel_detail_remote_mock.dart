import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';

import 'hotel_detail_remote_data_source.dart';

class HotelDetailMockDataSourceImpl implements HotelDetailRemoteDataSource {
  HotelDetailMockDataSourceImpl();
  @override
  Future<HotelDetailModelDomain> getHotelDetail(
      HotelDetailDataArgument argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelDetailModelDomain.fromJson(_responseMock);
  }

  @override
  Future<DeleteFavoriteModelDomain> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    await Future.delayed(const Duration(seconds: 1));
    return DeleteFavoriteModelDomain.fromJson(_deleteFavMock);
  }

  @override
  Future<IsFavoritesDomain> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    await Future.delayed(const Duration(seconds: 1));
    return IsFavoritesDomain.fromJson(_checkFavMock);
  }

  @override
  Future<AddFavoriteModelDomain> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    await Future.delayed(const Duration(seconds: 1));
    return AddFavoriteModelDomain.fromJson(_addFavMock);
  }
}

var _responseMock = """
{
	"getHotelDetails": {
		"data": {
			"id": "MA15063622",
			"name": "Asia Garden Phuket Hotel (SHA Plus)",
			"rating": "2",
			"freefoodDelivery": false,
			"ratingCount": 9.5,
			"ratingText": "Superb",
			"location": "Nai Yang Beach, Phuket",
			"address": "178/1, Nanai Road, 83150, Phuket, Thailand",
			"isFavourite": null,
			"images": {
				"baseUri": "https://trbhmanage.travflex.com/ImageData/Hotel/",
				"cover": "asia_garden_phuket_hotel_(sha_plus)-general1.jpg",
				"galleryCount": 10,
				"gallery": [
					"asia_garden_phuket_hotel_(sha_plus)-overview1.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-general3.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-facility1.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-room4.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-room1.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-general2.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-room2.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-general1.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-overview2.jpg",
					"asia_garden_phuket_hotel_(sha_plus)-room3.jpg"
				]
			},
			"facilities": {
				"list": [],
				"main": [{
						"key": "SWIM",
						"value": "0"
					},
					{
						"key": "WIFI",
						"value": "0"
					},
					{
						"key": "RESTAURANTS",
						"value": "0"
					},
					{
						"key": "ROOM_SRV",
						"value": "0"
					},
					{
						"key": "FITNESS",
						"value": "0"
					},
					{
						"key": "LAUNDRY",
						"value": "0"
					},
					{
						"key": "SPA",
						"value": "0"
					},
					{
						"key": "PARKING",
						"value": "0"
					}
				]
			},
			"rooms": [{
				"roomName": "Bungalow double",
				"supplierId": "NONE",
				"roomInfo": {
					"roomImageCount": 1,
					"coverImage": null,
					"roomFacilityInfo": "",
					"description": "The advantage of a monolithic sprayed structure is that it does not require a deep foundation. In addition, houses of this type do not have a roof as such, and, therefore, do not require the cost of its manufacture. A house created using this technology is so light that it can be built on the roof of an existing building. Dome form of construction (no corners) allows you to save up to 30% on heating and air conditioning of the room.",
					"promoteFlag": "N",
					"dimension": "",
					"totalRoom": "10",
					"doubleBedFlag": "Y",
					"twinBedFlag": "N",
					"queenBedflag": "N",
					"smorkingFlag": "N",
					"nonSmorkingFlag": "Y",
					"noWindowFlag": "N",
					"balconyFlag": "Y",
					"wifiFlag": "Y",
					"maxPaxNbr": "2",
					"roomFacilities": [{
							"code": "MA20120028",
							"name": "Shower"
						},
						{
							"code": "MA05080049",
							"name": "Water"
						},
						{
							"code": "MA20120023",
							"name": "Make up mirror"
						},
						{
							"code": "MA20120024",
							"name": "Microwave"
						},
						{
							"code": "MA05080110",
							"name": "Wi-Fi"
						},
						{
							"code": "MA20120040",
							"name": "Wired Internet"
						},
						{
							"code": "MA05080140",
							"name": "Alarm Clock"
						},
						{
							"code": "MA20120014",
							"name": "Fridge"
						},
						{
							"code": "MA05080101",
							"name": "Fruit Basket"
						},
						{
							"code": "MA05080001",
							"name": "24 Hrs. Room Service"
						},
						{
							"code": "MA05080002",
							"name": "220 Volt"
						},
						{
							"code": "MA05080139",
							"name": "Bath Robe"
						},
						{
							"code": "MA05080073",
							"name": "Radio"
						},
						{
							"code": "MA20120005",
							"name": "Bathtub"
						},
						{
							"code": "MA05080009",
							"name": "Non-smoking Room"
						},
						{
							"code": "MA05080029",
							"name": "Balcony"
						},
						{
							"code": "MA05080114",
							"name": "Air-condition"
						},
						{
							"code": "MA05080106",
							"name": "Hairdryer"
						},
						{
							"code": "MA05080020",
							"name": "Kitchen"
						},
						{
							"code": "MA05080041",
							"name": "Minibar"
						},
						{
							"code": "MA20120038",
							"name": "Toiletries"
						},
						{
							"code": "MA20120031",
							"name": "Slippers"
						},
						{
							"code": "MA05080061",
							"name": "Workdesk"
						},
						{
							"code": "MA05080038",
							"name": "TV"
						},
						{
							"code": "MA20120039",
							"name": "Washing Machine"
						},
						{
							"code": "MA05080027",
							"name": "Tea / Coffee"
						},
						{
							"code": "MA20120012",
							"name": "Electric Kettle"
						},
						{
							"code": "MA20120026",
							"name": "Plug Adaptor"
						}
					]
				},
				"facility": [{
						"key": "NON_SMOKING",
						"value": "Y"
					},
					{
						"key": "DOUBLE_BED_FLAG",
						"value": "Y"
					},
					{
						"key": "BALCONY_FLAG",
						"value": "Y"
					},
					{
						"key": "MAX_PAX_NBR",
						"value": "2"
					},
					{
						"key": "WIFI",
						"value": "Y"
					},
					{
						"key": "SWIM",
						"value": "0"
					},
					{
						"key": "RESTAURANTS",
						"value": "0"
					},
					{
						"key": "ROOM_SRV",
						"value": "0"
					},
					{
						"key": "FITNESS",
						"value": "0"
					},
					{
						"key": "LAUNDRY",
						"value": "0"
					},
					{
						"key": "SPA",
						"value": "0"
					},
					{
						"key": "PARKING",
						"value": "0"
					},
					{
						"key": "NO_OF_ROOMS_AND_NAME",
						"value": "1 x BUNGALOW"
					},
					{
						"key": "NO_OF_ROOMS_AND_NAME",
						"value": "1 x BUNGALOW"
					}
				],
				"details": [{
						"roomCode": "MA06030347",
						"roomOfferName": "Bungalow with breakfast",
						"roomType": "Double",
						"nightPrice": 600,
						"noOfRoomsAndName": "1 x BUNGALOW",
						"nightPriceBeforeDiscount": 70000.45,
						"discountPercent": 99,
						"totalPrice": 600,
						"supplierName": "",
						"supplierId": "NONE",
						"supplier": "CL213",
						"roomOffer": {
							"breakfast": 1,
							"payNow": "Instant payment",
							"cancellationPolicy": "Free cancellation by hotel's cancellation policy applies"
						},
						"hotelBenefits": [{
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						}]
					},
					{
						"roomCode": "MA06030347",
						"roomOfferName": "Bungalow with room only",
						"roomType": "Double",
						"nightPrice": 50000.66,
						"noOfRoomsAndName": "1 x BUNGALOW",
						"nightPriceBeforeDiscount": 70000.45,
						"discountPercent": 29,
						"totalPrice": 50000.66,
						"supplierName": "",
						"supplierId": "NONE",
						"supplier": "CL213",
						"roomOffer": {
							"breakfast": 0,
							"payNow": "Instant payment",
							"cancellationPolicy": "Free cancellation by hotel's cancellation policy applies"
						},
						"hotelBenefits": [{
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						}]
					}
				]
			}]
		},
		"status": {
			"code": "1000",
			"header": "Success"
		},
		"metadata": null
	}
}
""";

var _addFavMock = """{
	"data": {
		"addFavorite": {
			"status": {
				"code": "1000",
				"header": "success",
				"description": ""
			}
		}
	}
}""";

var _checkFavMock = """{
	"checkFavorites": {
		"data": {
			"isFavorite": false
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}""";

var _deleteFavMock = """{
  "deleteFavorite": {
    "status": {
      "code": "1000",
      "header": "Information Not Available",
      "description": null
    }
  }
}""";
