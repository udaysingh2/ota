import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/static_playlist/data_source/static_playlist_remote_data_source.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/repositories/static_playlist_repository_impl.dart';
import 'package:ota/modules/playlist/view/widgets/hotel_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/tour_ticket_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_argument.dart';

import '../../../helper.dart';
import '../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("OTA vertical static playlist test ", () {
    testWidgets('OTA vertical static playlist case1',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
        OtaStaticPlayListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: getMockDataWithString(_responseMock)));

        final argument =
            OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
                StaticPlaylistArgumentDomain.getDefaultArguments(
                    userId: "1234567",
                    source: "static",
                    id: "id",
                    enabledServices: "hotel_key, tour_key"),
                "recent");

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaVerticalPlaylistScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("ota_button")).last);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(HotelStaticPlaylistCard));
        await tester.pump();
      });
    });
    testWidgets('OTA vertical static playlist case 2',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
        OtaStaticPlayListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: getMockDataWithString(_responseMock1)));

        final argument =
            OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
                StaticPlaylistArgumentDomain.getDefaultArguments(
                    userId: "1234567",
                    source: "static",
                    id: "id",
                    enabledServices: "hotel_key, tour_key"),
                "recent");

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaVerticalPlaylistScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("ota_button")).last);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TourTicketStaticPlaylistCard).first);
        await tester.pump();
      });
    });
    testWidgets('OTA vertical static playlist case 3',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
        OtaStaticPlayListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: getMockDataWithString(_responseMock2)));

        final argument =
            OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
                StaticPlaylistArgumentDomain.getDefaultArguments(
                    userId: "1234567",
                    source: "static",
                    id: "id",
                    enabledServices: "hotel_key, tour_key"),
                "recent");

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaVerticalPlaylistScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("ota_button")).last);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TourTicketStaticPlaylistCard).first);
        await tester.pump();
      });
    });
    testWidgets('OTA vertical static playlist error',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
        OtaStaticPlayListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(exception: OperationException()));

        final argument =
            OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
                StaticPlaylistArgumentDomain.getDefaultArguments(
                    userId: "1234567",
                    source: "static",
                    id: "id",
                    enabledServices: "hotel_key, tour_key"),
                "recent");

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaVerticalPlaylistScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
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
var _responseMock1 = '''
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
						"playlistId": "111",
						"playlistName": "ฺBest Seller",
						"cardList": [
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
var _responseMock2 = '''
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
						"playlistId": "111",
						"playlistName": "ฺBest Seller",
						"cardList": [
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
