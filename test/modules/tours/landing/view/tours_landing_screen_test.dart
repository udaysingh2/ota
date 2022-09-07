import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';
import 'package:ota/domain/tours/landing/data_sources/tour_attractions_remote_data_source.dart';
import 'package:ota/domain/tours/landing/repositories/tour_attractions_repository_impl.dart';
import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/repositories/tour_ticket_playlist_repository_impl.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/repositories/service_card_repository_impl.dart';
import 'package:ota/domain/tours/tour_recent_playlist/data_sources/tour_recent_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/tour_recent_playlist/repositories/tour_recent_playlist_repository_impl.dart';
import 'package:ota/modules/tours/landing/view/widgets/service_cards_widget.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> tourAndTicketPlayList =
      json.decode(fixture("tour/playlist/tour_and_ticket_playlist_mock.json"));

  Map<String, dynamic> serviceCard =
      json.decode(fixture("tour/service_card/service_card_mock.json"));
  group("Tour Landing Screen", () {
    TourAttractionsRepositoryImpl.setMockInternet(InternetSuccessMock());
    TourAndTicketPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
    ServiceCardRepositoryImpl.setMockInternet(InternetSuccessMock());
    TourRecentPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
    LandingBannerRepositoryImpl.setMockInternet(InternetSuccessMock());
    TourTicketPlaylistRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: tourAndTicketPlayList));
    TourAttractionsRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
    ServiceCardRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: serviceCard));
    TourRecentPlaylistRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(_responseRecentMock)));
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(_responseBannerMock)));
    testWidgets('Tour Landing Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.toursLandingScreen,
          null,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ServiceCardsWidget));
        await Future.delayed(const Duration(microseconds: 1));
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Tour Landing failure state', (WidgetTester tester) async {
      ServiceCardRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.toursLandingScreen,
          null,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });
  });
}

var _responseMock = '''{
  "getTourServiceSuggestions": {
    "data": {
      "locationList": [
        {
          "serviceTitle": "พัทยา",
          "searchKey": "พัทยา",
          "cityId": "MA05110908",
          "countryId": "MA05110001",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/suggestion/OTAImage4.jpg"
        },
        {
          "serviceTitle": "กรุงเทพมหานคร",
          "searchKey": "กรุงเทพมหานคร",
          "cityId": "MA05110908",
          "countryId": "MA05110001",
          "imageUrl": "https://static-dev.alp-robinhood.com/ota/suggestion/OTAImage4.jpg"
        }
      ]
    },
    "status": {
      "code": "1000",
      "header": "success",
      "description": ""
    }
  }
}
''';

var _responseRecentMock = """
{
	"getTourRecentlyViewedItems": {
		"data": {
			"recentViewPlaylist": [{
					"id": "MA2111000168",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Dream World(Hello We Sell Tour & Ticket)",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"locationName": "Rangsit-Bangkok",
					"category": "Theme park",
					"type": "TICKET",
					"promotions": [{
							"productId": "MA2111000168",
							"productType": "TICKET",
							"promotionType": "OVERLAY",
							"promotionCode": "FREEDELIVERY",
							"line1": "Free delivery",
							"line2": "",
							"startDate": "2021-10-15 00:00:00",
							"endDate": "2022-10-20 23:59:00",
							"title": "ฟรีค่าส่งอาหารโรบินฮู้ด"
						},
						{
							"productId": "GLOBAL",
							"productType": "TICKET",
							"promotionType": "CAPSULE",
							"promotionCode": "228",
							"line1": "Free Food Delivery",
							"line2": "",
							"startDate": "2022-06-21 00:00:00",
							"endDate": "2022-07-30 23:59:59",
							"title": "Book now get free Robinhood food delivery fee"
						}
					]
				},
				{
					"id": "MA2110000413",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "JJ Green Market Tour(Wangthong Garden)",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"locationName": "Chatuchak,Bangkok",
					"category": "City Tour",
					"type": "TOUR",
					"promotions": [{
						"productId": "GLOBAL",
						"productType": "TOUR",
						"promotionType": "CAPSULE",
						"promotionCode": "228",
						"line1": "Free Food Delivery",
						"line2": "",
						"startDate": "2022-06-21 00:00:00",
						"endDate": "2022-07-30 23:59:59",
						"title": "Book now get free Robinhood food delivery fee"
					}]
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
""";

var _responseBannerMock = '''{
	"getBanners": {
		"data": {
			"banner": [{
					"bannerId": "1",
					"type": "GLOBAL",
					"startDate": "2021-10-29T08:44:39",
					"endDate": "2023-01-30T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "9",
					"type": "GLOBAL",
					"startDate": "2020-11-09T08:44:39",
					"endDate": "2022-02-03T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "199",
					"type": "GLOBAL",
					"startDate": "2020-11-07T20:44:39",
					"endDate": "2022-02-15T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "198",
					"type": "GLOBAL",
					"startDate": "2020-11-07T20:44:39",
					"endDate": "2022-02-15T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "201",
					"type": "GLOBAL",
					"startDate": "2020-11-07T09:44:39",
					"endDate": "2022-02-15T23:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "200",
					"type": "GLOBAL",
					"startDate": "2020-11-07T09:44:39",
					"endDate": "2022-02-15T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "111",
					"type": "GLOBAL",
					"startDate": "2020-11-07T08:44:39",
					"endDate": "2022-02-15T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "11",
					"type": "GLOBAL",
					"startDate": "2020-11-07T08:44:39",
					"endDate": "2022-02-15T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "10",
					"type": "GLOBAL",
					"startDate": "2020-11-07T08:44:39",
					"endDate": "2022-02-13T08:44:39",
					"priority": "1",
					"imageFilename": "https://robinhood/01_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				},
				{
					"bannerId": "13",
					"type": "GLOBAL",
					"startDate": "2021-05-24T08:44:39",
					"endDate": "2022-12-24T08:44:39",
					"priority": "3",
					"imageFilename": "https://www.linkpicture.com/q/banner_EN.jpg",
					"deeplinkUrl": "http://img01-deeplink",
					"deeplinkType": "EXTERNAL",
					"function": "OTA_LANDING",
					"orderSection": "1"
				}
			]
		},
		"status": {
			"code": "1000",
			"description": null,
			"header": "Success"
		}
	}
}
''';
