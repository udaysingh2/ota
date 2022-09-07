import 'package:ota/domain/playlist/static_playlist/data_sources/static_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';

class StaticPlayListMockDataSourceImpl
    implements StaticPlayListRemoteDataSource {
  StaticPlayListMockDataSourceImpl();

  @override
  Future<StaticPlaylistModelDomain> getStaticPlayListData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return StaticPlaylistModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = """ 
{
	"getStaticPlaylists": {
		"data": [{
			"serviceName": "hotels",
			"source": "static",
			"playList": [{
					"name": "suggest",
					"list": [{
							"hotelName": "super app hotel very long name very beautiful place_EN",
							"hotelId": "MA15061432",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110001",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "D50",
								"promotionText2": "1per"
							}
						},
						{
							"hotelName": "super app hotel 09_EN",
							"hotelId": "MA15061441",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "Dec",
								"promotionText2": "DEC"
							}
						},
						{
							"hotelName": "super app hotel 19_EN",
							"hotelId": "MA15061451",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110071",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/cape_fahn_hotel-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "Friday",
								"promotionText2": "Friday"
							}
						},
						{
							"hotelName": "super app hotel 08_EN",
							"hotelId": "MA15061440",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "SDCU",
								"promotionText2": ""
							}
						}
					]
				},
				{
					"name": "lastYear",
					"list": [{
						"hotelName": "super app hotel 01_EN",
						"hotelId": "MA15061433",
						"address": {
							"address1": null,
							"locationId": null,
							"locationName": "ชายหาดปลายทาง Beach",
							"cityId": "MA05110041",
							"cityName": "Bangkok",
							"countryId": "MA05110001",
							"countryName": null
						},
						"rating": 1,
						"review": null,
						"promotion": null,
						"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
						"adminPromotion": {
							"adminPromotionLine1": null,
							"adminPromotionLine2": null,
							"promotionText1": "D20",
							"promotionText2": "10per"
						}
					}]
				},
				{
					"name": "beginning of year",
					"list": [{
							"hotelName": "super app hotel 03_EN",
							"hotelId": "MA15061435",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "Special",
								"promotionText2": "Deal"
							}
						},
						{
							"hotelName": "super app hotel 09_EN",
							"hotelId": "MA15061441",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "Dec",
								"promotionText2": "DEC"
							}
						},
						{
							"hotelName": "super app hotel 16_EN",
							"hotelId": "MA15061448",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110050",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/veranda_resort_and_villas_hua_hin_cha_am_mgallery-general1.jpg",
							"adminPromotion": null
						}
					]
				},
				{
					"name": "Service mind",
					"list": [{
							"hotelName": "super app hotel 10_EN",
							"hotelId": "MA15061442",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "20P",
								"promotionText2": "Limit20"
							}
						},
						{
							"hotelName": "super app hotel 14_EN",
							"hotelId": "MA15061446",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "Reco",
								"promotionText2": "3up"
							}
						},
						{
							"hotelName": "super app hotel 07_EN",
							"hotelId": "MA15061439",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "RBH500",
								"promotionText2": "VIP"
							}
						},
						{
							"hotelName": "super app hotel 09_EN",
							"hotelId": "MA15061441",
							"address": {
								"address1": null,
								"locationId": null,
								"locationName": "ชายหาดปลายทาง Beach",
								"cityId": "MA05110041",
								"cityName": "Bangkok",
								"countryId": "MA05110001",
								"countryName": null
							},
							"rating": 1,
							"review": null,
							"promotion": null,
							"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
							"adminPromotion": {
								"adminPromotionLine1": null,
								"adminPromotionLine2": null,
								"promotionText1": "Dec",
								"promotionText2": "DEC"
							}
						}
					]
				},
				{
					"name": "Good view",
					"list": [{
						"hotelName": "super app hotel 18_EN",
						"hotelId": "MA15061450",
						"address": {
							"address1": null,
							"locationId": null,
							"locationName": "ชายหาดปลายทาง Beach",
							"cityId": "MA05110067",
							"cityName": "Bangkok",
							"countryId": "MA05110001",
							"countryName": null
						},
						"rating": 1,
						"review": null,
						"promotion": null,
						"image": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
						"adminPromotion": {
							"adminPromotionLine1": null,
							"adminPromotionLine2": null,
							"promotionText1": "JFK",
							"promotionText2": "scb1000"
						}
					}]
				},
				{
					"name": "Mid year sale 50%",
					"list": [{
						"hotelName": "super app hotel 09_EN",
						"hotelId": "MA15061441",
						"address": {
							"address1": null,
							"locationId": null,
							"locationName": "ชายหาดปลายทาง Beach",
							"cityId": "MA05110041",
							"cityName": "Bangkok",
							"countryId": "MA05110001",
							"countryName": null
						},
						"rating": 1,
						"review": null,
						"promotion": null,
						"image": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
						"adminPromotion": {
							"adminPromotionLine1": null,
							"adminPromotionLine2": null,
							"promotionText1": "Dec",
							"promotionText2": "DEC"
						}
					}]
				}
			]
		}],
		"status": {
			"header": "Success",
			"code": "1000",
			"description": null,
			"errors": null
		}
	}
}
""";
