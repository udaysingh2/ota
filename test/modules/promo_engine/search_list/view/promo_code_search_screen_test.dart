import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_remote_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/repositories/apply_promo_repository_impl.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotiom_remote_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/repositories/public_promotion_repository_impl.dart';
import 'package:ota/modules/promo_engine/search_list/view/widgets/promo_code_tile_widget.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Promo search screen test", () {
    Map<String, dynamic> applyPromo = getMockDataWithString(
        fixture("promo_engine/apply_promo_code_mock.json"));
    Map<String, dynamic> response1899 =
        getMockDataWithString(_responseMock1899);
    Map<String, dynamic> response1999 =
        getMockDataWithString(_responseMock1999);
    Map<String, dynamic> response3023 =
        getMockDataWithString(_responseMock3023);
    Map<String, dynamic> response3024 =
        getMockDataWithString(_responseMock3024);
    Map<String, dynamic> response3025 =
        getMockDataWithString(_responseMock3025);
    Map<String, dynamic> response3033 =
        getMockDataWithString(_responseMock3033);
    Map<String, dynamic> response3034 =
        getMockDataWithString(_responseMock3034);
    Map<String, dynamic> response3054 =
        getMockDataWithString(_responseMock3054);

    Map<String, dynamic> searchSuggestionsData =
        getMockDataWithString(_promoResponseMock);

    PublicPromotionArgument publicPromotionArgumentModel =
        PublicPromotionArgument(
      applicationKey: "HOTEL",
      bookingUrn: "H220706-AA-0414",
      merchantId: "MA0511000294",
    );

    PublicPromotionArgument publicPromotionCarArgumentModel =
        PublicPromotionArgument(
      applicationKey: "CARRENTAL",
      bookingUrn: "H220706-AA-0414",
      merchantId: "MA0511000294",
    );

    PublicPromotionArgument publicPromotionTourArgumentModel =
        PublicPromotionArgument(
      applicationKey: "TOUR",
      bookingUrn: "H220706-AA-0414",
      merchantId: "MA0511000294",
    );

    testWidgets('Promo search screen and apply promo success test ',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: applyPromo));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Promo search screen promo item click',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byType(PromoCodeTileWidget).first);
      });
    });

    testWidgets('Promo search screen no internet', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetFailureMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
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

    testWidgets('Apply promo failure1899 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response1899));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure1999 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response1999));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3023 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3023));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3024 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3024));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3025 HOTEL', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3025));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3025 CALRENTAL',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3025));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.promoCodeSearchScreen, publicPromotionCarArgumentModel);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3025 TOUR', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3025));
        Widget widget = getMaterialWrapperWithPressButton(
            AppRoutes.promoCodeSearchScreen, publicPromotionTourArgumentModel);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3033 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3033));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3034 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3034));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo failure3054 ', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3054));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });

    testWidgets('Apply promo no internet', (WidgetTester tester) async {
      await tester.runAsync(() async {
        PublicPromotionRepositoryImpl.setMockInternet(InternetSuccessMock());
        PublicPromotionRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: searchSuggestionsData));
        ApplyPromoRepositoryImpl.setMockInternet(InternetFailureMock());
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoCodeSearchScreen,
          publicPromotionArgumentModel,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        try {
          await tester.pumpAndSettle();
        } catch (err) {
          printDebug({err});
        }
        await tester.tap(find.byKey(const Key("key_apply_promo")).first);
      });
    });
  });
}

var _responseMock1899 = '''{
	"applyPromoCode": {
		"status": {
			"code": "1899",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock1999 = '''{
	"applyPromoCode": {
		"status": {
			"code": "1999",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock3023 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3023",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock3024 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3024",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock3025 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3025",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock3033 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3033",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock3034 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3034",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var _responseMock3054 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3054",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

String _promoResponseMock = '''
 {
    "getAvailablePublicPromotions": {
      "status": {
        "code": "1000",
        "header": "",
        "description": "Success"
      },
      "data": {
        "promotionList": [
          {
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          },{
            "promotionId": 1,
            "promotionName": "RBH Special",
            "shortDescription": "ส่วนลดมูลค่า 50 บาท",
            "discount": 50,
            "maximumDiscount": 100,
            "discountType": "PERCENT",
            "discountFor": "ORDER",
            "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
            "promotionType": "PUBLIC",
            "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
            "voucherCode": "RBH50",
            "promotionCode": "RBH50",
            "startDate": "2020-07-24T08:44:39.000Z",
            "endDate": "2020-07-24T08:44:39.000Z",
            "applicationKey": "HOTEL"
          }
        ],
        "pagination": {
          "currentPage": 0,
          "pageSize": 20,
          "hasNextPage": true,
          "hasPreviousPage": false
        }
      }
    }
  }
''';
