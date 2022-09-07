import 'package:ota/domain/tours/search_result/data_sources/tour_search_result_remote_data_source.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

class TourSearchResultMockDataSourceImpl
    implements TourSearchResultRemoteDataSource {
  TourSearchResultMockDataSourceImpl();
  @override
  Future<TourSearchResultModelDomain> getTourSearchResultData(
      TourSearchResultArgumentDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return TourSearchResultModelDomain.fromJson(
      argument.playlistName == PlaylistType.tour.value
          ? _tourResponseMock
          : _ticketResponseMock,
    );
  }
}

var _tourResponseMock = '''
{

	"getTourAndTicketSearchResult": {
		"data": {
			"location": "ภูเก็ต",
			"tourAndTicketActivityList": [{
					"id": "MA2111000168",
					"name": "Dream World Theme Park Tickets (Dream World)",
					"styleName": "theme park",
					"locationName": "Rangsit",
					"cityId": "MA05110041",
					"cityName": "Bangkok",
					"countryId": "MA05110001",
					"countryName": "Thailand",
					"imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
					"startPrice": 300,
					"promotionText_line1": "50% off",
					"promotionText_line2": "",
          "capsulePromotion": [
			  {
			  "name": "Free Food Delivery",
			  "code": "FREE01"
			  }
			  ]
				},
				{
					"id": "MA2110000388",
					"name": "Let's Relax Spa - Ginza Thonglor",
					"styleName": "tourist attraction",
					"locationName": "Jatujak",
					"cityId": "MA05110041",
					"cityName": "Bangkok",
					"countryId": "MA05110001",
					"countryName": "Thailand",
					"imageUrl": "https://image.jpg",
					"startPrice": 350,
					"promotionText_line1": "15% off",
					"promotionText_line2": "",
          "capsulePromotion": [
			  {
			  "name": "Free Food Delivery",
			  "code": "FREE01"
			  }
			  ]
				}
			],
			"filter": {
				"minPrice": 0,
				"maxPrice": 30000,
				"styleName": [
					"theme park",
					"tourist attraction"
				]
			}
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
''';

var _ticketResponseMock = '''
{

	"getTourAndTicketSearchResult": {
		"data": {
			"location": "ภูเก็ต",
			"tourAndTicketActivityList": [{
					"id": "MA2111000168",
					"name": "Dream World Theme Park Tickets (Dream World)",
					"styleName": "theme park",
					"locationName": "Rangsit",
					"cityId": "MA05110041",
					"cityName": "Bangkok",
					"countryId": "MA05110001",
					"countryName": "Thailand",
					"imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
					"startPrice": 300,
					"promotionText_line1": "50% off",
					"promotionText_line2": "",
          "capsulePromotion": [
			  {
			  "name": "Free Food Delivery",
			  "code": "FREE01"
			  }
			  ]
				},
				{
					"id": "MA2110000388",
					"name": "Let's Relax Spa - Ginza Thonglor",
					"styleName": "tourist attraction",
					"locationName": "Jatujak",
					"cityId": "MA05110041",
					"cityName": "Bangkok",
					"countryId": "MA05110001",
					"countryName": "Thailand",
					"imageUrl": "https://image.jpg",
					"startPrice": 350,
					"promotionText_line1": "15% off",
					"promotionText_line2": "",
          "capsulePromotion": [
			  {
			  "name": "Free Food Delivery",
			  "code": "FREE01"
			  }
			  ]
				}
			],
			"filter": {
				"minPrice": 0,
				"maxPrice": 30000,
				"styleName": [
					"theme park",
					"tourist attraction"
				]
			}
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
''';
