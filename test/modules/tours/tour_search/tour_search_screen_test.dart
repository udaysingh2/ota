import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_history_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/search/data_source/tour_save_search_history_remote_data_source.dart';
import 'package:ota/domain/tours/search/data_source/tour_search_remote_data_source.dart';
import 'package:ota/domain/tours/search/data_source/tour_search_suggestions_remote_data_source.dart';
import 'package:ota/domain/tours/search/repositories/tour_save_search_history_repository_impl.dart';
import 'package:ota/domain/tours/search/repositories/tour_search_repository_impl.dart';
import 'package:ota/domain/tours/search/repositories/tour_search_suggestions_repository_impl.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_argument_model.dart';

import '../../../helper.dart';
import '../../hotel/repositories/Internet_success_mock.dart';

void main() {
  group("Tour search screen test", () {
    testWidgets('Tour search screen test suggestion',
        (WidgetTester tester) async {
      const MethodChannel('plugins.flutter.io/path_provider')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        printDebug({methodCall.method});
        return ".";
        // set initial values here if desired
      });
      const channel = MethodChannel('com.tekartik.sqflite');
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return ".";
      });
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock);
        Map<String, dynamic> searchSuggestionsData =
            getMockDataWithString(_searchSuggestionsResponseMock);
        Map<String, dynamic> saveSearchHistoryData =
            getMockDataWithString(_saveSearchHistoryResponseMock);
        TourSearchArgumentModel tourSearchArgumentModel =
            TourSearchArgumentModel(attractionList: [
          TourAttractionModel(
            countryId: 'MA05110001',
            cityId: "MA05110041",
            searchKey: "Bangkok",
            serviceTitle: "tour",
          )
        ]);
        TourSearchRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchSuggestionsRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSaveSearchHistoryRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSearchRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        TourSearchSuggestionsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        TourSaveSearchHistoryRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: saveSearchHistoryData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(TextField));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(OtaSearchHistoryTileWidget).first);
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });

    testWidgets('Tour Search Suggestions Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock1);
        Map<String, dynamic> searchSuggestionsData =
            getMockDataWithString(_searchSuggestionsResponseMock);
        Map<String, dynamic> saveSearchHistoryData =
            getMockDataWithString(_saveSearchHistoryResponseMock);
        TourSearchArgumentModel tourSearchArgumentModel =
            TourSearchArgumentModel(attractionList: [
          TourAttractionModel(
            countryId: 'MA05110001',
            cityId: "MA05110041",
            searchKey: "Bangkok",
            serviceTitle: "tour",
          )
        ]);
        TourSearchRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchSuggestionsRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSaveSearchHistoryRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSearchRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        TourSearchSuggestionsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        TourSaveSearchHistoryRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: saveSearchHistoryData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(TextField));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(OtaSearchHistoryTileWidget).first);
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });

    testWidgets('Tour Search Suggestions Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock1);
        Map<String, dynamic> searchSuggestionsData =
            getMockDataWithString(_searchSuggestionsResponseMock);
        Map<String, dynamic> saveSearchHistoryData =
            getMockDataWithString(_saveSearchHistoryResponseMock);
        TourSearchArgumentModel tourSearchArgumentModel =
            TourSearchArgumentModel(attractionList: [
          TourAttractionModel(
            countryId: 'MA05110001',
            cityId: "MA05110041",
            searchKey: "Bangkok",
            serviceTitle: "tour",
          )
        ]);
        TourSearchRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchSuggestionsRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSaveSearchHistoryRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSearchRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        TourSearchSuggestionsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        TourSaveSearchHistoryRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: saveSearchHistoryData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.enterText(find.byType(OtaSearchInputWidget), 'ban');
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await Future.delayed(const Duration(seconds: 2));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find
            .byKey(const Key("tour_search_suggestion_tile_widget_key"))
            .first);
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });
    testWidgets('Tour Search Suggestions Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock2);
        Map<String, dynamic> searchSuggestionsData =
            getMockDataWithString(_searchSuggestionsResponseMock);
        Map<String, dynamic> saveSearchHistoryData =
            getMockDataWithString(_saveSearchHistoryResponseMock);
        TourSearchArgumentModel tourSearchArgumentModel =
            TourSearchArgumentModel(attractionList: [
          TourAttractionModel(
            countryId: 'MA05110001',
            cityId: "MA05110041",
            searchKey: "Bangkok",
            serviceTitle: "tour",
          )
        ]);
        TourSearchRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchSuggestionsRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSaveSearchHistoryRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourSearchRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        TourSearchSuggestionsRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        TourSaveSearchHistoryRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: saveSearchHistoryData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(TextField));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(OtaSearchHistoryTileWidget).first);
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });
  });
}

var _responseMock = '''
{
    "getTourAndTicketRecentSearches": {
      "data": {
      "searchHistory": [
      {
        "serviceType": "TOUR",
        "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2110000413",
        "locationName": ""
      },
      {
        "serviceType": "TICKET",
        "keyword": "Dream World(Hello We Sell Tour & Ticket)",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2111000168",
        "locationName": ""
      }
      ,
      {
        "serviceType": "LOCATION",
        "keyword": "Rangsit-Bangkok",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2110000413",
        "locationName": "locationName"
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

var _responseMock1 = '''
{
    "getTourAndTicketRecentSearches": {
      "data": {
      "searchHistory": [
      {
        "serviceType": "TICKET",
        "keyword": "Dream World(Hello We Sell Tour & Ticket)",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2111000168",
        "locationName": ""
      }
      ,
      {
        "serviceType": "LOCATION",
        "keyword": "Rangsit-Bangkok",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2110000413",
        "locationName": "locationName"
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

var _responseMock2 = '''
{
    "getTourAndTicketRecentSearches": {
      "data": {
      "searchHistory": [
      {
        "serviceType": "LOCATION",
        "keyword": "Rangsit-Bangkok",
        "countryId": "MA05110001",
        "cityId": "MA05110041",
        "placeId": "MA2110000413",
        "locationName": "locationName"
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

String _saveSearchHistoryResponseMock = '''
  {
    "saveRecentTourAndTicketSearchHistory": {
      "status": {
        "code": "1000",
        "header": "success",
        "description": "success"
      }
    }
  }
  ''';
String _searchSuggestionsResponseMock = '''
  {
    "getDataScienceAutoCompleteSearch": {
      "data": {
        "suggestions": {
          "tour": [
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Bangkok Hop on Hop off(Wangthong Garden)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "ticket": [
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            },
            {
              "keyword": "Dream World(Hello We Sell Tour & Ticket)",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": ""
            }
          ],
          "cityLocation": [
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            },
            {
              "keyword": "Rangsit-Bangkok",
              "countryId": "MA05110001",
              "cityId": "MA05110041",
              "id": "MA2110000413",
              "locationName": "locationName"
            }
          ]
        }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": ""
      }
    }
  }
  ''';
