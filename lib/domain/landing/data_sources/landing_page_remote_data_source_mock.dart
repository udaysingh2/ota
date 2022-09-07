import 'package:ota/domain/landing/models/landing_models.dart';

import 'landing_page_remote_data_source.dart';

class LandingPageMockDataSourceImpl implements LandingPageRemoteDataSource {
  LandingPageMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<LandingData> getLandingPage() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return LandingData.fromJson(_responseMockNoBanner);
  }
}

var _responseMock = '''{
  "getLandingPageDetails": {
    "data": {
      "defaultCustomText": "Hello",
      "backgroundUrl": "https://static-dev.alp-robinhood.com/ota/background/image/OTA.jpg",
      "businessCards": [
        {
          "serviceText": "Hotels",
          "title": "more than 1,000",
          "description": "100,000+ Hotels",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/1.jpg",
          "largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1.jpg",
          "serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1.jpg",
          "sortSeq": "1",
          "service": "HOTEL",
          "deeplinkUrl": "https://robinhood/"
        },
        {
          "serviceText": "Flights",
          "title": "more than 1,000",
          "description": "50,000+ Flights",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/2.jpg",
          "largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/2.jpg",
          "serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/2.jpg",
          "sortSeq": "2",
          "service": "FLIGHT",
          "deeplinkUrl": "https://robinhood/"
        },
        {
          "serviceText": "Tours and Activites",
          "title": "more than 1,000",
          "description": "1,000+ Tours and Activites",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/3.jpg",
          "largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/3.jpg",
          "serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/3.jpg",
          "sortSeq": "3",
          "service": "TOUR",
          "deeplinkUrl": "https://robinhood/"
        },
        {
          "serviceText": "Car rentals",
          "title": "more than 1,000",
          "description": "20,000+ Car rentals",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/4.jpg",
          "largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/4.jpg",
          "serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/4.jpg",
          "sortSeq": "4",
          "service": "CARRENTAL",
          "deeplinkUrl": "https://robinhood/"
        },
        {
          "serviceText": "Insurances",
          "title": "more than 1,000",
          "description": "20,000+ Insurances",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/5.jpg",
          "largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/5.jpg",
          "serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/5.jpg",
          "sortSeq": "5",
          "service": "INSURANCE",
          "deeplinkUrl": "https://directuat.azurewebsites.net/RobinHood/CoverageOptionPlan"
        },
        {
          "serviceText": "Special Deals",
          "title": "more than 1,000",
          "description": "20,000+ Special Deals",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/6.jpg",
          "largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/6.jpg",
          "serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/6.jpg",
          "sortSeq": "6",
          "service": "DEALS",
          "deeplinkUrl": "https://robinhood/"
        }
      ],
      "banner": [
        {
          "bannerId": "test1111",
          "type": "GLOBAL",
          "startDate": "2021-11-01T08:44:39",
          "endDate": "2022-12-24T08:44:39",
          "priority": "0",
          "imageFilename": "https://www.linkpicture.com/q.jpg",
          "deeplinkUrl": "http://abc",
          "deeplinkType": "DEEPLINK",
          "function": "OTA_LANDING",
          "orderSection": "0"
        },
        {
          "bannerId": "1003",
          "type": "GLOBAL",
          "startDate": "2021-11-26T08:44:39",
          "endDate": "2022-06-25T08:44:39",
          "priority": "2",
          "imageFilename": "https://www.linkpicture.com/q/banner_EN.jpg",
          "deeplinkUrl": "easyApp://myProfile",
          "deeplinkType": "WEBVIEW",
          "function": "OTA_LANDING",
          "orderSection": "1"
        },
        {
          "bannerId": "100",
          "type": "GLOBAL",
          "startDate": "2021-11-26T08:44:39",
          "endDate": "2022-06-25T08:44:39",
          "priority": "2",
          "imageFilename": "https://www.linkpicture.com/q/banner_EN.jpg",
          "deeplinkUrl": "easyApp://myProfile",
          "deeplinkType": "WEBVIEW",
          "function": "OTA_LANDING",
          "orderSection": "1"
        },
        {
          "bannerId": "1009",
          "type": "GLOBAL",
          "startDate": "2021-11-26T08:44:39",
          "endDate": "2022-06-25T08:44:39",
          "priority": "2",
          "imageFilename": "https://www.linkpicture.com/q/banner_EN.jpg",
          "deeplinkUrl": "easyApp://myProfile",
          "deeplinkType": "WEBVIEW",
          "function": "OTA_LANDING",
          "orderSection": "1"
        },
        {
          "bannerId": "100002",
          "type": "GLOBAL",
          "startDate": "2021-11-26T08:44:39",
          "endDate": "2022-06-25T08:44:39",
          "priority": "2",
          "imageFilename": "https://www.linkpicture.com/q/banner_EN.jpg",
          "deeplinkUrl": "easyApp://myProfile",
          "deeplinkType": "WEBVIEW",
          "function": "OTA_LANDING",
          "orderSection": "1"
        }
      ],
      "popups": [],
      "promotions": null,
      "preferences": []
    },
    "status": {
      "code": "1000",
      "header": "Success",
      "description": "Success"
    }
  }
}
''';
var _responseMockNoBanner = '''{
	"getLandingPageDetails": {
		"data": {
			"defaultCustomText": "Hello",
			"backgroundUrl": "https://static-dev.alp-robinhood.com/ota/background/image/OTA.jpg",
			"businessCards": [{
					"serviceText": "Hotels",
					"title": "more than 1,000",
					"description": "100,000+ Hotels",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/1.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1.jpg",
					"sortSeq": "1",
					"service": "HOTEL",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"serviceText": "Flights",
					"title": "more than 1,000",
					"description": "50,000+ Flights",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/2.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/2.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/2.jpg",
					"sortSeq": "2",
					"service": "FLIGHT",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"serviceText": "Tours and Activites",
					"title": "more than 1,000",
					"description": "1,000+ Tours and Activites",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/3.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/3.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/3.jpg",
					"sortSeq": "3",
					"service": "TOUR",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"serviceText": "Car rentals",
					"title": "more than 1,000",
					"description": "20,000+ Car rentals",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/4.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/4.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/4.jpg",
					"sortSeq": "4",
					"service": "CARRENTAL",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"serviceText": "Insurances",
					"title": "more than 1,000",
					"description": "20,000+ Insurances",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/5.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/5.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/5.jpg",
					"sortSeq": "5",
					"service": "INSURANCE",
					"deeplinkUrl": "https://directuat.azurewebsites.net/RobinHood/CoverageOptionPlan"
				},
				{
					"serviceText": "Special Deals",
					"title": "more than 1,000",
					"description": "20,000+ Special Deals",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/6.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/6.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/6.jpg",
					"sortSeq": "6",
					"service": "DEALS",
					"deeplinkUrl": "https://robinhood/"
				}
			]
		
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": "Success"
		}
	}
}
''';
