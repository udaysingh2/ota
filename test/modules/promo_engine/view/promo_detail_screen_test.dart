import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_remote_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/repositories/apply_promo_repository_impl.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/data_sources/remove_promo_code_remote_data_sources.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/repositories/remove_promo_code_repository_impl.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

import '../../../helper.dart';
import '../../../mocks/fixture_reader.dart';
import '../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> applyPromo =
      json.decode(fixture("promo_engine/apply_promo_code_mock.json"));
  Map<String, dynamic> removePromo =
      json.decode(fixture("promo_engine/remove_promo_code_mock.json"));
  Map<String, dynamic> response1899 = jsonDecode(getMock1899());
  Map<String, dynamic> response1999 = jsonDecode(getMock1999());
  Map<String, dynamic> response3023 = jsonDecode(getMock3023());
  Map<String, dynamic> response3024 = jsonDecode(getMock3024());
  Map<String, dynamic> response3025 = jsonDecode(getMock3025());
  Map<String, dynamic> response3033 = jsonDecode(getMock3033());
  Map<String, dynamic> response3034 = jsonDecode(getMock3034());
  Map<String, dynamic> response3054 = jsonDecode(getMock3054());
  PromoCodeData argument = PromoCodeData(
      bookingUrn: "TR220117-AA-0006",
      applicationKey: "TOUR",
      isPromotionApplied: false,
      merchantId: "merchantId",
      promotion: PublicPromotion(
          applicationKey: "TOUR",
          promotionCode: "FREEDELIVERY",
          discount: 100.00,
          discountFor: "ORDER",
          discountType: "PERCENT",
          endDate: DateTime.now().add(const Duration(days: 1)),
          promotionId: 12,
          promotionLink: "scbeasy://payments/creditcard/review/id/4567",
          promotionName: "RBH Special",
          promotionType: "PUBLIC",
          shortDescription: "ส่วนลดมูลค่า 50 บาท",
          startDate: DateTime.now(),
          voucherCode: "RBH50",
          iconUrl: "scbeasy://payments/creditcard/review/id/4567",
          maximumDiscount: 200.00),
      priceViewModel: PromoPriceViewModel(
          addonPrice: 200.00,
          billingAmount: 320.00,
          effectiveDiscount: 80.00,
          orderPrice: 200.00,
          totalAmount: 400.00));

  PromoCodeData argument1 = PromoCodeData(
      bookingUrn: "TR220117-AA-0006",
      applicationKey: "TOUR",
      isPromotionApplied: true,
      merchantId: "merchantId",
      promotion: PublicPromotion(
          applicationKey: "TOUR",
          promotionCode: "FREEDELIVERY",
          discount: 100.00,
          discountFor: "ORDER",
          discountType: "PERCENT",
          endDate: DateTime.now().add(const Duration(days: 1)),
          promotionId: 12,
          promotionLink: "scbeasy://payments/creditcard/review/id/4567",
          promotionName: "RBH Special",
          promotionType: "PUBLIC",
          shortDescription: "ส่วนลดมูลค่า 50 บาท",
          startDate: DateTime.now(),
          voucherCode: "RBH50",
          iconUrl: "scbeasy://payments/creditcard/review/id/4567",
          maximumDiscount: 200.00),
      priceViewModel: PromoPriceViewModel(
          addonPrice: 200.00,
          billingAmount: 320.00,
          effectiveDiscount: 80.00,
          orderPrice: 200.00,
          totalAmount: 400.00));

  group("Promo Detail Screen", () {
    testWidgets('Promo Detail Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: applyPromo));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        RemovePromoCodeRepositoryImpl.setMockInternet(InternetSuccessMock());
        RemovePromoCodeRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: removePromo));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument1,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(exception: OperationException()));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure1999',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response1999));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure1899',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response1899));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure3023',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3023));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure3024',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3024));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure3025',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3025));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure3033',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3033));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure3034',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3034));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with failure3054',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetSuccessMock());
        ApplyPromoRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: response3054));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
    testWidgets('Promo Detail Screen with internet failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ApplyPromoRepositoryImpl.setMockInternet(InternetFailureMock());
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.promoDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("KeyPromoButton")));
      });
    });
  });
}

String getMock1899() {
  return responseMock1899;
}

String getMock1999() {
  return responseMock1999;
}

String getMock3023() {
  return responseMock3023;
}

String getMock3024() {
  return responseMock3024;
}

String getMock3025() {
  return responseMock3025;
}

String getMock3033() {
  return responseMock3033;
}

String getMock3034() {
  return responseMock3034;
}

String getMock3054() {
  return responseMock3054;
}

var responseMock1899 = '''{
	"applyPromoCode": {
		"status": {
			"code": "1899",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock1999 = '''{
	"applyPromoCode": {
		"status": {
			"code": "1999",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3023 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3023",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3024 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3024",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3025 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3025",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3033 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3033",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3034 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3034",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3054 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3054",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';
