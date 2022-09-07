import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_recommendation_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_history_tile_widget.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_landing/data_source/car_landing_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_landing/data_source/car_landing_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/repositories/car_search_history_repository.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_input_widget.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    HttpOverrides.global = null;
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider_macos');
    channel.setMockMethodCallHandler((call) async {
      return ".";
    });
  });
  testWidgets('Car Search suggestion screen test ',
      (WidgetTester tester) async {
    CarLandingBloc bloc = CarLandingBloc();
    mockDynamicPlaylistPageData(
        internetInfo: InternetSuccessMock(),
        remoteDataSource: CarSearchSuggestionMockDataSourceImpl());
    CarSearchHistoryRepositoryImpl.setMockInternet(InternetSuccessMock());
    CarSearchSuggestionRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
    CarLandingRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarLandingMockDataSourceImpl.getMockData())));
    CarSearchHistoryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(_searchHistoryResponseMock)));
    RecommendedLocationRepositoryImpl.setMockInternet(InternetSuccessMock());
    RecommendedLocationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(fullData)));
    bloc.clearRecentSearches("serviceType", "dataSearchType");
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.carSearchSuggestionScreen, [
        bloc,
        true,
        false,
      ]);
      await tester.pumpWidget(widget);
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
      await tester.tap(find.text("press"));
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
      await tester.enterText(find.byType(CarSearchInputWidget), 'Bangok');
      await tester.tap(find.byType(OtaSearchHistoryTileWidget));
      try {
        await tester.pump();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  });

  testWidgets('Car Search suggestion screen test case1',
      (WidgetTester tester) async {
    CarLandingBloc bloc = CarLandingBloc();
    mockDynamicPlaylistPageData(
        internetInfo: InternetSuccessMock(),
        remoteDataSource: CarSearchSuggestionMockDataSourceImpl());
    CarSearchHistoryRepositoryImpl.setMockInternet(InternetSuccessMock());
    CarSearchSuggestionRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
    CarLandingRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarLandingMockDataSourceImpl.getMockData())));
    CarSearchHistoryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(_searchHistoryResponseMock)));
    RecommendedLocationRepositoryImpl.setMockInternet(InternetSuccessMock());
    RecommendedLocationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(fullData)));
    bloc.clearRecentSearches("serviceType", "dataSearchType");
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.carSearchSuggestionScreen, [
        bloc,
        true,
        false,
      ]);
      await tester.pumpWidget(widget);
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
      await tester.tap(find.text("press"));
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
      await tester.enterText(find.byType(CarSearchInputWidget), 'Bangok');
      await tester.tap(find.byType(OtaRecommendationTileWidget));
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  });

  testWidgets('Car Search suggestion screen test failure ',
      (WidgetTester tester) async {
    CarLandingBloc bloc = CarLandingBloc();
    mockDynamicPlaylistPageData(
        internetInfo: InternetFailureMock(),
        remoteDataSource: CarSearchSuggestionMockDataSourceImpl());
    CarSearchHistoryRepositoryImpl.setMockInternet(InternetSuccessMock());
    CarSearchSuggestionRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
    CarLandingRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: jsonDecode(CarLandingMockDataSourceImpl.getMockData())));
    CarSearchHistoryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(_searchHistoryResponseMock)));
    RecommendedLocationRepositoryImpl.setMockInternet(InternetSuccessMock());
    RecommendedLocationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(fullData)));
    bloc.clearRecentSearches("serviceType", "dataSearchType");
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.carSearchSuggestionScreen, [
        bloc,
        true,
        false,
      ]);
      await tester.pumpWidget(widget);
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
      await tester.tap(find.text("press"));
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
      await tester.enterText(find.byType(CarSearchInputWidget), 'Bangok');
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  });
}

String fullData = '''{
  "getRecommendedLocation": {
    "data": {
      "locationList": [
        {
          "playlistId": "123",
          "searchKey": "Banklangna Homestay",
          "serviceTitle": "Shangri La Bangkok",
          "hotelId": "MA15061431",
          "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "countryId": "MA05110001",
          "cityId": "MA05110041"
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
''';
String _searchHistoryResponseMock = '''
  {
    "getCarRentalRecentSearches": {
      "data": {
        "searchHistory": [
          {
            "carRental": {
              "carRecentSearchList": [
                {
                  "dataSearchType": "AUTOCOMPLETE",
                  "cityId": "MA05110",
                  "countryId": "Austria",
                  "locationId": "1111999",
                  "createdDate": "2022-04-26T14:08:52.465",
                  "updatedDate": "2022-04-26T14:08:52.465",
                  "searchKey": "xlocation5"
                }
              ]
            }
          }
        ]
      },
      "status": {
        "code": "1000",
        "header": "Success"
      }
    }
}
  ''';
var _responseMock = """ 
{
  "getDataScienceAutoCompleteSearch": {
    "status": {
      "code": "1000",
      "header": "Success"
    },
    "data": {
      "suggestions": {
        "tour": [
          {
            "type":null,
            "keyword": "Phuket Racha Island Snorkeling Tour",
            "id": "MA2111000117",
            "cityId": "MA05110067",
            "countryId": "MA05110001",
            "locationName": null
          }
        ],
        "ticket": [
          { 
            "type": null,
            "keyword": "Phuket Aquarium",
            "id": "MA2110000377",
            "locationName": null,
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          },
          {
            "type": null,
            "keyword": "Phuket Thai Hua Museum",
            "id": "MA2111000034",
            "locationName": null,
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          }
        ],
        "city": [
          {
            "keyword": "Phuket",
            "cityId": "MA05110067",
            "cityName": "Phuket",
            "countryId": "MA05110001"
          },
          {
            "keyword": "Pak Phun",
            "cityId": "MA05110068",
            "cityName": "Pak Phun",
            "countryId": "MA05110001"
          }
        ],
        "cityLocation": [
          {
            "type": "city",
            "keyword": "Phuket",
            "id": null,
            "locationName": "Phuket",
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          },
          {
            "type": "location",
            "keyword": "Phuket International Airport",
            "id": "MA21120004",
            "locationName": "Phuket International Airport",
            "cityId": "MA05110067",
            "countryId": "MA05110001"
          }
        ],
        "location": [
          {
          "type": null,
            "keyword": "Phuket International Airport",
            "id": "MA21120004",
            "cityId": "MA05110067",
            "countryId": "MA05110001",
            "locationName": "Phuket International Airport"
          },
          {
          "type": null,
            "keyword": "Pakchong",
            "id": "MA08030094",
            "cityId": "MA05110027",
            "countryId": "MA05110001",
            "locationName": "Pakchong"
          },
          {
          "type": null,
            "keyword": "Adelphi Grande Sukhumvit",
            "id": "MA21120006",
            "cityId": "MA05110041",
            "countryId": "MA05110001",
            "locationName": "Adelphi Grande Sukhumvit"
          }
        ]
      }
    }
  }
}
  
 """;
