import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';
import 'package:ota/domain/ota_search_sort/repositories/ota_filter_sort_repository_impl.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  Map<String, dynamic> responseSuccess =
      getMockDataWithString(_successResponseMock);
  group("Filter ota page test", () {
    final filterOtaArgumentData = FilterOtaArgumentData(
      startingPrice: 25,
      rangeEndingPrice: 91305,
      starRating: {0, 1, 2, 3, 4, 5, 8, 9},
    );

    final filterOtaArgumentModel = FilterOtaArgumentModel(
      initialFilterOtaArgumentData: filterOtaArgumentData,
      onSearchClicked: (updatedFilterOtaArgumentData) {},
      sha: ["SHA Extra Plus", "SHA Plus", "SHA"],
      promotions: [
        CapsulePromotions(code: '12', name: 'Free Delivery'),
        CapsulePromotions(code: '13', name: '30% off'),
      ],
    );

    testWidgets('Filter OTA Page', (WidgetTester tester) async {
      await tester.runAsync(() async {
        OtaSearchSortRepositoryImpl.setMockInternet(InternetSuccessMock());
        OtaSearchSortRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: responseSuccess));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.filterOtaPage,
          filterOtaArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });

    testWidgets('Filter OTA Page internet failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        OtaSearchSortRepositoryImpl.setMockInternet(InternetFailureMock());
        OtaSearchSortRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: responseSuccess));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.filterOtaPage,
          filterOtaArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
      });
    });
  });
}

var _successResponseMock = """
  {
  "_typename": "Query",
  "getSortCriteriaForService": {
    "typename": "SortCriteriaResponse",
    "data": {
      "typename": "DataObject",
      "sortInfo": [
        {
          "typename": "SortInfoObject",
          "displayTitle": "Robinhood Suggestion",
          "sortSeq": 1,
          "value": "rbh_suggest"
        },
        {
          "typename": "SortInfoObject",
          "displayTitle": "Lowest Price",
          "sortSeq": 2,
          "value": "price_ascending"
        },
        {
          "typename": "SortInfoObject",
          "displayTitle": "Highest Price",
          "sortSeq": 3,
          "value": "price_descending"
        },
        {
          "typename": "SortInfoObject",
          "displayTitle": "Star Rating",
          "sortSeq": 4,
          "value": "rating_descending"
        }
      ],
      "criteria": [
        {
          "typename": "CriteriaObject",
          "displayTitle": "Price",
          "sortSeq": 1,
          "value": "criteria_price",
          "description": ""
        },
        {
          "typename": "CriteriaObject",
          "displayTitle": "Star Rating",
          "sortSeq": 2,
          "value": "criteria_star",
          "description": ""
        },
        {
          "typename": "CriteriaObject",
          "displayTitle": "SHA Standard",
          "sortSeq": 3,
          "value": "criteria_sha",
          "description": ""
        },
        {
          "typename": "CriteriaObject",
          "displayTitle": "Promotions",
          "sortSeq": 4,
          "value": "criteria_rbh_pro",
          "description": ""
        }
      ]
    },
    "status": {
      "_typename": "StatusObject",
      "code": "1000",
      "header": "Success",
      "description": null
    }
  }
}
  """;
