import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';

class SearchMockDataSourceImpl implements SearchRemoteDataSource {
  SearchMockDataSourceImpl();

  static String getSuggestionMockData() {
    return _responseMock;
  }

  static String getRecommendationMockData() {
    return _recommendationResponseMock;
  }

  static String getHotelRecommendationMMockData() {
    return _recommendationHotelResponseMock;
  }

  @override
  Future<SearchSuggestionModel> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return SearchSuggestionModel.fromJson(_responseMock);
  }

  @override
  Future<SearchRecommendationModel> getSearchRecommendationData(
      SearchServiceType serviceType) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return SearchRecommendationModel.fromJson(_recommendationResponseMock);
  }

  @override
  Future<HotelRecommendationModelDomain> getHotelSearchRecommendationData(
      HotelRecommendationArgDomain recommendationArgument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return HotelRecommendationModelDomain.fromJson(
        _recommendationHotelResponseMock);
  }
}

String _recommendationResponseMock = '''{
		"getSearchRecommendation": {
			"data": {
				"recommendationKey": "recommendation.hotel.key",
				"recommendations": [{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061430",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://th.bing.com/th/id/OIP.Ix6XjMbuCvoq3EQNgJoyEQHaFj?pid=ImgDet&rs=1"
					},
					{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061431",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061432",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061433",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061434",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061435",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061436",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061437",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061438",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061431",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061439",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061440",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					}
				],
         "searchHistory": [
          {
            "keyword": "Bangkok Story",
            "checkInDate": "2022-03-01",
            "checkOutDate": "2022-03-02",
            "hotelId": "",
            "cityId": "MA05110041",
            "countryId": null,
            "locationId": "MA05110008"
          },
          {
            "keyword": "Bangrak",
            "checkInDate": "2022-03-01",
            "checkOutDate": "2022-03-02",
            "hotelId": "",
            "cityId": "MA05110041",
            "countryId": null,
            "locationId": "MA08030079"
          }
        ]
			},
			"status": {
				"code": "1000",
				"header": "",
				"description": "success"
			}
		}
	}''';

String _recommendationHotelResponseMock = '''{
		"getHotelSearchRecommendation": {
			"data": {
				"recommendationKey": "recommendation.hotel.key",
				"recommendations": [{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061430",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://th.bing.com/th/id/OIP.Ix6XjMbuCvoq3EQNgJoyEQHaFj?pid=ImgDet&rs=1"
					},
					{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061431",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061432",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": null,
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061433",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061434",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061435",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061436",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061437",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061438",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061431",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061439",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					},
					{
						"playlistId": "111",
						"serviceTitle": "แชงกรีลา กรุงเทพฯ",
						"hotelId": "MA15061440",
						"cityId": "MA05110041",
						"countryId": "MA05110001",
						"imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
					}
				],
         "searchHistory": [
          {
            "keyword": "Bangkok Story",
            "checkInDate": "2022-03-01",
            "checkOutDate": "2022-03-02",
            "hotelId": "",
            "cityId": "MA05110041",
            "countryId": null,
            "locationId": "MA05110008"
          },
          {
            "keyword": "Bangrak",
            "checkInDate": "2022-03-01",
            "checkOutDate": "2022-03-02",
            "hotelId": "",
            "cityId": "MA05110041",
            "countryId": null,
            "locationId": "MA08030079"
          }
        ]
			},
			"status": {
				"code": "1000",
				"header": "",
				"description": "success"
			}
		}
	}''';

String _responseMock = '''{
  "getSearchSuggestion": {
    "data": {
      "suggestions": [
        {
          "hotelId": "MA15062148",
          "hotelName": "Money Motel",
          "cityId": "MA05110041",
          "cityName": "พัทยา - ชลบุรี",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA15062148MA05110908",
          "filterName": "Money Motel"
        },
        {
          "hotelId": "MA19120437",
          "hotelName": "Monsan",
          "cityId": "MA05110041",
          "cityName": "เชียงใหม่",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA19120437MA05110001",
          "filterName": "Monsan"
        },
        {
          "hotelId": "MA0201233399",
          "hotelName": "Money",
          "cityId": "MA05110001",
          "cityName": "เชียงใหม่",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA0201233399MA05110001",
          "filterName": "Money"
        },
        {
          "hotelId": "MA1912002555",
          "hotelName": "Montana Hotel",
          "cityId": "MA05110070",
          "cityName": "สงขลา",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA1912002555MA05110070",
          "filterName": "Montana Hotel"
        },
        {
          "hotelId": "MA2009000002",
          "hotelName": "Monmai Resort",
          "cityId": "MA05110001",
          "cityName": "เชียงใหม่",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA2009000002MA05110001",
          "filterName": "Monmai Resort"
        },
        {
          "hotelId": "MA2008000090",
          "hotelName": "Monotel Aonang",
          "cityId": "MA05110062",
          "cityName": "กระบี่",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA2008000090MA05110062",
          "filterName": "Monotel Aonang"
        },
        {
          "hotelId": "MA1912002715",
          "hotelName": "Mon Madam",
          "cityId": "MA05110002",
          "cityName": "เชียงราย",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "",
          "locationName": null,
          "level": 2,
          "searchid": "MA1912002715MA05110002",
          "filterName": "Mon Madam"
        },
        {
          "hotelId": "",
          "hotelName": null,
          "cityId": "MA05110067",
          "cityName": "ภูเก็ต",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "MA06100143",
          "locationName": "Montri Road",
          "level": 3,
          "searchid": "MA06100143MA05110067",
          "filterName": "Montri Road"
        },
        {
          "hotelId": "",
          "hotelName": null,
          "cityId": "MA05110071",
          "cityName": "เกาะสมุย สุราษฎร์ธานี",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "MA06040018",
          "locationName": "Choeng Mon Beach",
          "level": 3,
          "searchid": "MA06040018MA05110071",
          "filterName": "Choeng Mon Beach"
        },
        {
          "hotelId": "",
          "hotelName": null,
          "cityId": "MA05110001",
          "cityName": "เชียงใหม่",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "MA08070051",
          "locationName": "Morakot Road",
          "level": 3,
          "searchid": "MA08070051MA05110001",
          "filterName": "Morakot Road"
        },
        {
          "hotelId": "",
          "hotelName": null,
          "cityId": "MA05110075",
          "cityName": "เกาะช้าง, ตราด",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "MA06100157",
          "locationName": "Kai Mook Beach",
          "level": 3,
          "searchid": "MA06100157MA05110075",
          "filterName": "Kai Mook Beach"
        },
        {
          "hotelId": "",
          "hotelName": null,
          "cityId": "MA05110072",
          "cityName": "ตรัง",
          "countryId": "MA05110001",
          "countryName": "ประเทศไทย",
          "locationId": "MA06100046",
          "locationName": "Koh Mook Island",
          "level": 3,
          "searchid": "MA06100046MA05110072",
          "filterName": "Koh Mook Island"
        }
      ]
    }
  }
}''';
