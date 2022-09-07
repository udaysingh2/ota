import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/search_filter/data_sources/tour_search_filter_remote_data_source.dart';
import 'package:ota/domain/tours/search_filter/repository/tour_search_filter_repository_impl.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

import '../../../../../helper.dart';
import '../../../../hotel/repositories/Internet_success_mock.dart';

List<String> styleList1 = [
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2",
  "style",
  "style1",
  "style2"
];
List<String> styleList2 = [
  "style",
  "style1",
  "style2",
];
double minPrice = 100.0;
double maxPrice = 999.0;
void main() {
  group("Ticket Filter Search Screen test ", () {
    testWidgets('Ticket Filter search result', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_tourResponseMock);
        TourSearchFilterArgument filterArgument = TourSearchFilterArgument(
            serviceType: TourSearchServiceType.tour,
            filterData: TourFilterDataViewModel(
                maxPrice: maxPrice, minPrice: minPrice, styleList: styleList1));
        TourSearchFilterRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchFilterRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchFilterScreen,
          filterArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).first);
        await tester.pump();
        await tester.tap(find.byType(OtaTextButton).last);
        await tester.pump();
      });
    });
    testWidgets('Ticket Filter search result', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData =
            getMockDataWithString(_tourResponseMock);
        TourSearchFilterArgument filterArgument = TourSearchFilterArgument(
            serviceType: TourSearchServiceType.tickets,
            filterData: TourFilterDataViewModel(
                maxPrice: maxPrice, minPrice: minPrice, styleList: styleList2));
        TourSearchFilterRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchFilterRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchFilterScreen,
          filterArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton).last);
        await tester.pump();
      });
    });
    testWidgets('Tour search result Failure Screen',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        TourSearchFilterArgument filterArgument = TourSearchFilterArgument(
            serviceType: TourSearchServiceType.tickets,
            filterData: TourFilterDataViewModel(
                maxPrice: maxPrice, minPrice: minPrice, styleList: []));
        TourSearchFilterRepositoryImpl.setMockInternet(InternetSuccessMock());
        TourSearchFilterRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(exception: OperationException()));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourSearchFilterScreen,
          filterArgument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
}

var _tourResponseMock = '''
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
