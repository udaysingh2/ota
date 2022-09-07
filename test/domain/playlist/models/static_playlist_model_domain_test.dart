import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';

void main() {
  StaticPlayListModelDomain staticPlaylistModel =
      StaticPlayListModelDomain.fromJson(_responseMock);
  GetPlaylists getPlaylists =
      GetPlaylists.fromJson(staticPlaylistModel.toJson());
  OtaStaticCardListData otaStaticCardListData =
      OtaStaticCardListData.fromJson(getPlaylists.toJson());
  OtaStaticPlaylist otaStaticPlaylist =
      OtaStaticPlaylist.fromJson(otaStaticCardListData.toJson());
  OtaStaticCardList otaStaticCardList =
      OtaStaticCardList.fromJson(otaStaticPlaylist.toJson());
  HotelCard hotelCard = HotelCard.fromJson(hotel);
  CardCapsulePromotion cardCapsulePromotion =
      CardCapsulePromotion.fromJson(_responseMock);
  InfoPromotion infoPromotion = InfoPromotion.fromJson(hotelCard.toJson());
  CarCard carCard = CarCard.fromJson(car);
  TourCard tourCard = TourCard.fromJson(tour);

  test("Static Playlist Models", () {
    //Convert into Model
    expect(staticPlaylistModel.getPlaylists != null, true);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    StaticPlayListModelDomain mapFromModel =
        StaticPlayListModelDomain.fromMap(map);

    expect(mapFromModel.getPlaylists != null, true);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Datum data = Datum.fromJson(staticPlaylistModel.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Datum mapFromModel = Datum.fromMap(map);
    expect(mapFromModel.type != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetPlaylists", () {
    //convert into map
    Map<String, dynamic> map = getPlaylists.toMap();
    expect(map.isNotEmpty, true);

    GetPlaylists mapFromModel = GetPlaylists.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("OtaStaticCardListData", () {
    //convert into map
    Map<String, dynamic> map = otaStaticCardListData.toMap();
    expect(map.isNotEmpty, true);

    OtaStaticCardListData mapFromModel = OtaStaticCardListData.fromMap(map);
    expect(mapFromModel.serviceName != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("OtaStaticPlaylist", () {
    //convert into map
    Map<String, dynamic> map = otaStaticPlaylist.toMap();
    expect(map.isNotEmpty, true);

    OtaStaticPlaylist mapFromModel = OtaStaticPlaylist.fromMap(map);
    expect(mapFromModel.cardList != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("OtaStaticCardList", () {
    //convert into map
    Map<String, dynamic> map = otaStaticCardList.toMap();
    expect(map.isNotEmpty, true);

    OtaStaticCardList mapFromModel = OtaStaticCardList.fromMap(map);
    expect(mapFromModel.hotel != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("HotelCard", () {
    //convert into map
    Map<String, dynamic> map = hotelCard.toMap();
    expect(map.isNotEmpty, true);

    HotelCard mapFromModel = HotelCard.fromMap(map);
    expect(mapFromModel.name != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("tourCard", () {
    //convert into map
    Map<String, dynamic> map = tourCard.toMap();
    expect(map.isNotEmpty, true);

    TourCard mapFromModel = TourCard.fromMap(map);
    expect(mapFromModel.name != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("carCard", () {
    //convert into map
    Map<String, dynamic> map = carCard.toMap();
    expect(map.isNotEmpty, true);

    CarCard mapFromModel = CarCard.fromMap(map);
    expect(mapFromModel.name != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("cardCapsulePromotion", () {
    //convert into map
    Map<String, dynamic> map = cardCapsulePromotion.toMap();
    expect(map.isNotEmpty, true);

    CardCapsulePromotion mapFromModel = CardCapsulePromotion.fromMap(map);
    expect(mapFromModel.name != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("infoPromotion", () {
    //convert into map
    Map<String, dynamic> map = infoPromotion.toMap();
    expect(map.isNotEmpty, true);

    InfoPromotion mapFromModel = InfoPromotion.fromMap(map);
    expect(mapFromModel.promotionText != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}

var _responseMock = '''
  {
		"getPlaylists_v2": {
			"status": {
				"code": "1000",
				"header": "Success"
			},
			"data": {
				"serviceName": "OTA",
				"language": "EN",
				"playlist": [
					{
						"playlistId": "1",
						"playlistName": "suggestion",
						"cardList": [
							{
								"productType": "HOTEL",
								"hotel": {
									"id": "MA0511000294",
									"name": "Bangkok Lotus Sukhumvit",
									"locationName": "sukhumvit",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [],
									"rating": 3,
									"infopromotion": [],
									"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/bangkok_lotus_sukhumvit-general1.jpg",
									"startPrice": 0
								}
							}
						]
					},
					{
						"playlistId": "111",
						"playlistName": "ฺBest Seller",
						"cardList": [
							{
								"productType": "HOTEL",
								"hotel": {
									"id": "MA1012120002",
									"name": "Grand Four Wings Convention",
									"locationName": "",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [
										{
											"name": "Free Food Delivery",
											"code": "FREE01"
										}
									],
									"rating": 5,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
									"startPrice": 0
								}
							},
							{
								"productType": "HOTEL",
								"hotel": {
									"id": "MA1012120002",
									"name": "Grand Four Wings Convention",
									"locationName": "",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [
										{
											"name": "Free SPA",
											"code": "FREE01"
										}
									],
									"rating": 5,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
									"startPrice": 0
								}
							},
							{
								"productType": "HOTEL",
								"hotel": {
									"id": "MA1012120002",
									"name": "Grand Four Wings Convention",
									"locationName": "",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [
										{
											"name": "Free Food Delivery",
											"code": "FREE01"
										}
									],
									"rating": 5,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
									"startPrice": 0
								}
							},
							{
								"productType": "HOTEL",
								"hotel": {
									"id": "MA1012120002",
									"name": "Grand Four Wings Convention",
									"locationName": "",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [
										{
											"name": "Free Food Delivery",
											"code": "FREE01"
										}
									],
									"rating": 5,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
									"startPrice": 0
								}
							},
							{
								"productType": "HOTEL",
								"hotel": {
									"id": "MA1012120002",
									"name": "Grand Four Wings Convention",
									"locationName": "",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [
										{
											"name": "Free Food Delivery",
											"code": "FREE01"
										}
									],
									"rating": 5,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
									"startPrice": 0
								}
							},
							{
								"productType": "TOUR",
								"tour": {
									"id": "MA2107000004",
									"name": "Flow House Bangkok",
									"locationName": "Sukhumvit",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [],
									"rating": 0,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/flow-house-bangkok-general1.jpg",
									"styleName": "NONE",
									"startPrice": 1200,
									"promotionText_line1": "none",
									"promotionText_line2": "none"
								}
							},
							{
								"productType": "CAR",
								"carrental": {
									"id": "MA2107000004",
									"name": "Flow House Bangkok",
									"locationName": "Sukhumvit",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [],
									"rating": 1,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/flow-house-bangkok-general1.jpg",
									"styleName": "NONE",
									"startPrice": 1200,
									"promotionText_line1": "none",
									"promotionText_line2": "none",
									"craftType": "30",
                  "pickupLocationId": "MA028107839914",
                  "returnLocationId": "MA08030095"
								}
							},
							{
								"productType": "TICKET",
								"ticket": {
									"id": "MA2005000046",
									"name": "Sea Life Ocean World Bangkok",
									"locationName": "NONE",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [],
									"rating": 0,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/sea_life_ocean_world_bangkok-general1.jpg",
									"styleName": "NONE",
									"startPrice": 800,
									"promotionText_line1": "none",
									"promotionText_line2": "none"
								}
							}
						]
					}
				]
			}
		}
}
  ''';

var hotel = '''
{
									"id": "MA1012120002",
									"name": "Grand Four Wings Convention",
									"locationName": "",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [
										{
											"name": "Free Food Delivery",
											"code": "FREE01"
										}
									],
									"rating": 5,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
									"startPrice": 0
								}
''';

var car = '''
{
									"id": "MA2107000004",
									"name": "Flow House Bangkok",
									"locationName": "Sukhumvit",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [],
									"rating": 1,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/flow-house-bangkok-general1.jpg",
									"styleName": "NONE",
									"startPrice": 1200,
									"promotionText_line1": "none",
									"promotionText_line2": "none",
									"craftType": "30",
                  "pickupLocationId": "MA028107839914",
                  "returnLocationId": "MA08030095"
								}
''';
var tour = '''
 {
									"id": "MA2107000004",
									"name": "Flow House Bangkok",
									"locationName": "Sukhumvit",
									"cityId": "MA05110041",
									"cityName": "Bangkok",
									"countryId": "MA05110001",
									"capsulePromotion": [],
									"rating": 0,
									"infopromotion": [],
									"imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/flow-house-bangkok-general1.jpg",
									"styleName": "NONE",
									"startPrice": 1200,
									"promotionText_line1": "none",
									"promotionText_line2": "none"
								}
''';
