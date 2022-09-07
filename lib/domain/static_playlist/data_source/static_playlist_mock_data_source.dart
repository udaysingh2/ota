import 'package:ota/domain/static_playlist/data_source/static_playlist_remote_data_source.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';

class OtaStaticPlayListMockDataSourceImpl
    implements OtaStaticPlayListRemoteDataSource {
  OtaStaticPlayListMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<StaticPlayListModelDomain> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return StaticPlayListModelDomain.fromJson(_responseMock);
  }
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
