import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/search_filter/data_sources/tour_search_filter_remote_data_source.dart';
import 'package:ota/domain/tours/search_filter/repository/tour_search_filter_repository_impl.dart';
import 'package:ota/domain/tours/search_result/data_sources/tour_search_result_remote_data_source.dart';
import 'package:ota/domain/tours/search_result/repository/tour_search_result_repository_impl.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';
import 'package:ota/modules/tours/tour_search/results/view/widgets/ota_search_no_result_with_refresh.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';

import '../../../helper.dart';
import '../../hotel/repositories/Internet_success_mock.dart';

void main() {
  group("Tour search result test ", () {
    testWidgets('Tour search result test tour', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_tourResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "tour",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );
        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TourTicketPlaylistCard).first);
      });
    });

    testWidgets('Tour search result test ticket', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_ticketResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "ticket",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );
        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(TourTicketPlaylistCard).first);
      });
    });

    testWidgets('Tour search result test ticket filter',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_ticketResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "ticket",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );
        Map<String, dynamic> fullData1 =
            getMockDataWithString(_tourResponseMock1);

        TourSearchFilterRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchFilterRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData1));

        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.drag(
            find.byType(OtaRefreshIndicator), const Offset(0, 500));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("filterKey")));
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour search result test ticket filter case2',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_ticketResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "tour",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );

        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("dateFilterKey")));
        await tester.pumpAndSettle();
        await tester.tap(find.text("OK"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour search result test ticket filter case2',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_ticketResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "ticket",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );

        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("dateFilterKey")));
        await tester.pumpAndSettle();
        await tester.tap(find.text("Reset"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour search result test ticket case2',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_ticketResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "ticket",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );
        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("ota_button")).first);
        await tester.pump();
      });
    });

    testWidgets('Tour search result test tour case1',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_ticketResponseMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "tour",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );
        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("ota_button")).last);
        await tester.pump();
      });
    });

    testWidgets('Tour search result test tour with empty data',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> emptyData = getMockDataWithString(_emptyStateMock);
        TourSearchResultArgumentModel tourSearchArgumentModel =
            TourSearchResultArgumentModel(
          playlistName: "tour",
          countryId: 'MA05110001',
          cityId: "MA05110041",
        );
        TourSearchResultRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchResultRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: emptyData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchResultScreen,
          tourSearchArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.drag(
            find.byType(OtaSearchNoResultRefresh), const Offset(0, 500));
        await tester.pumpAndSettle();
      });
    });
  });
}

var _tourResponseMock = '''
{
  "getTourAndTicketSearchResult": {
    "data": {
      "location": "ภูเก็ต",
      "tourAndTicketActivityList": [
        {
          "id": "MA2110000373",
          "name": "เกาะพีพี1",
          "styleName": "'สวนสนุก",
          "locationName": "Ko Phi Phi",
          "cityId": "MA05110062",
          "cityName": "ภูเก็ต",
          "countryId": "MA05110001",
          "countryName": "ไทย",
          "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
          "startPrice": 300.0,
          "promotionText_line1": "โปรโมชัน_1",
          "promotionText_line2": "โปรโมชัน_2"
        },
        {
          "id": "MA2110000388",
          "name": "เกาะพีพี2",
          "styleName": "'สวนสนุก",
          "locationName": "Ko Phi Phi",
          "cityId": "MA05110062",
          "cityName": "ภูเก็ต",
          "countryId": "MA05110001",
          "countryName": "ไทย",
          "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000375-general1.jpg",
          "startPrice": 1884.0,
          "promotionText_line1": "โปรโมชัน_1",
          "promotionText_line2": "โปรโมชัน_2"
        }
      ]
    },
    "status": {
      "code": "1000",
      "header": "Success",
      "description": ""
    }
  }
}
''';

var _ticketResponseMock = '''
{
  "getTourAndTicketSearchResult": {
    "data": {
      "location": "ภูเก็ต",
      "tourAndTicketActivityList": [
        {
          "id": "MA2110000373",
          "name": "เกาะพีพี1",
          "styleName": "'สวนสนุก",
          "locationName": "Ko Phi Phi",
          "cityId": "MA05110062",
          "cityName": "ภูเก็ต",
          "countryId": "MA05110001",
          "countryName": "ไทย",
          "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
          "startPrice": 300.0,
          "promotionText_line1": "โปรโมชัน_1",
          "promotionText_line2": "โปรโมชัน_2"
        },
        {
          "id": "MA2110000388",
          "name": "เกาะพีพี2",
          "styleName": "'สวนสนุก",
          "locationName": "Ko Phi Phi",
          "cityId": "MA05110062",
          "cityName": "ภูเก็ต",
          "countryId": "MA05110001",
          "countryName": "ไทย",
          "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000375-general1.jpg",
          "startPrice": 1884.0,
          "promotionText_line1": "โปรโมชัน_1",
          "promotionText_line2": "โปรโมชัน_2"
        }
      ]
    },
    "status": {
      "code": "1000",
      "header": "Success",
      "description": ""
    }
  }
}
''';

var _emptyStateMock = '''
{
  "getTourAndTicketSearchResult": {
    "data": {
      "location": "ภูเก็ต",
      "tourAndTicketActivityList": [
      ]
    },
    "status": {
      "code": "1000",
      "header": "Success",
      "description": ""
    }
  }
}
''';

var _tourResponseMock1 = '''
{
	"getSortCriteriaForService": {
		"data": {
			"sortInfo": [{
					"displayTitle": "Robinhood suggestion",
					"sortSeq": 1,
					"value": "rbh_suggest"
				},
				{
					"displayTitle": "Popular",
					"sortSeq": 2,
					"value": "rbh_popular"
				},
				{
					"displayTitle": "Low price to high price",
					"sortSeq": 3,
					"value": "price_ascending"
				},
				{
					"displayTitle": "High price to Low price",
					"sortSeq": 4,
					"value": "price_descending"
				}
			],
			"criteria": [{
					"displayTitle": "Price",
					"sortSeq": 1,
					"value": "criteria_price",
					"description": null
				},
				{
					"displayTitle": "Ticket Style",
					"sortSeq": 2,
					"value": "criteria_style",
					"description": " Can select more than 1 item."
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
