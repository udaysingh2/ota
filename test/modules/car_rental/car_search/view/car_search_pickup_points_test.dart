import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_argument_model.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  mockDynamicPlaylistPageData(
    internetInfo: InternetSuccessMock(),
  );
  CarSearchSuggestionRemoteDataSourceImpl.setMock(
      GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
  testWidgets('Car Search pickup poiints screen test ',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = getWidgetPressButtonWithProvider(
        AppRoutes.carSearchPickUpPointsScreen,
        _getArgumentData(),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CarSearchSuggestionTileWidget).first);
      await tester.pumpAndSettle();
    });
  });

  CarSearchSuggestionRemoteDataSourceImpl.setMock(
      GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
  testWidgets('Car Search pickup points screen test error',
      (WidgetTester tester) async {
    mockDynamicPlaylistPageData(
      internetInfo: InternetFailureMock(),
    );
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapperWithPressButton(
        AppRoutes.carSearchPickUpPointsScreen,
        _getArgumentData(),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });
  });
}

CarSearchArgumentModel _getArgumentData() {
  return CarSearchArgumentModel(
      carLandingBloc: CarLandingBloc(), cityId: 'ABCD', locationName: "city");
}

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
