import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_data_source.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_mock.dart';
import 'package:ota/domain/payment_method/repositories/payment_method_repository_impl.dart';
import 'package:ota/domain/tours/confirm_booking/data_source/tour_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/tours/confirm_booking/repositories/tour_confirm_booking_repository.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

import '../../../helper.dart';
import '../../hotel/repositories/Internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late OtaCountDownController otaCountDownController;

  group("Tour confirm booking test", () {
    setUp(() {
      debugPrint("setup tour confirm booking");
      HttpOverrides.global = null;
      otaCountDownController =
          OtaCountDownController(durationInSecond: 2, onComplete: () {});
    });
    tearDown(() {
      debugPrint("tear down tour confirm booking");
      otaCountDownController.dispose();
    });
    testWidgets('Tour confirm booking test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock);
        ToursConfirmBookingRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourConfirmBookingRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        PaymentMethodRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentMethodMockDataSourceImpl.getMockData())));
        PaymentMethodRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourConfirmBookingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton));
      });
    });

    testWidgets('Tour confirm booking test expand',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock);
        ToursConfirmBookingRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourConfirmBookingRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        PaymentMethodRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentMethodMockDataSourceImpl.getMockData())));
        PaymentMethodRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourConfirmBookingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("tourPaymentCollapseExpandKey")));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour confirm booking test failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        ToursConfirmBookingRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourConfirmBookingRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(exception: OperationException()));
        PaymentMethodRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentMethodMockDataSourceImpl.getMockData())));
        PaymentMethodRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.tourConfirmBookingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });
  });
}

TourConfirmBookingModel _getArgument(
    OtaCountDownController otaCountDownController) {
  return TourConfirmBookingModel(
      childInfo: ToursChildInfo(minAge: 2, maxAge: 12),
      argument: ConfirmBookingArgument(
          bookingType: 'tour',
          serviceId: "tour",
          bookingUrn: "urn",
          customerInfoArgument: CustomerInfoData(
              email: "abc@gmail.com",
              firstName: "john",
              lastName: "dev",
              mobileNumber: "0123456789"),
          isBookingForSomeoneElse: false,
          noOfDays: "1",
          totalPrice: 250.72),
      childTourPrice: 50.5,
      childCount: 1,
      adultCount: 2,
      cancellationPolicy: "cancel",
      adultTourPrice: 100.11,
      isAllTravellersInfoRequired: false,
      otaCountDownController: otaCountDownController);
}

var _responseMock = '''
{
	"getTourBookingConfirmation": {
		"status": {
			"code": "1000",
			"header": "Success"
		},
		"data": {
			"bookingUrn": "TR220117-AA-0006",
			"tourId": "MA2111000115",
			"cityId": "MA05110041",
			"countryId": "MA05110001",
			"bookingDate": "2022-01-18",
			"name": "Bangkok Hop on Hop off(Wangthong Garden)",
			"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/place-profile-place-name-bangkok-hop-on-hop-off-ma2111000115-general1.jpg",
			"location": "Bangkapi,Bangkok",
			"category": "City Tour",
			"noOfDays": "2",
			"startTimeAMPM": "3:00 PM",
			"promotionList": [{
					"productType": "ACTIVITY",
						"promotionCode": "FREEDELIVERY",
						"title": "Free Food Delivery",
						"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
						"web": "https://cms.robinhood.in.th/archives/2869"
					}],
			"packageDetail": {
				"name": "Bangkok Hop on Hop off(Wangthong Garden)",
				"inclusions": {
					"highlights": [{
							"key": "tourTime",
							"value": "Night tour starts at 15:00 PM"
						},
						{
							"key": "tourType",
							"value": "Group tour"
						},
						{
							"key": "guideLanguage",
							"value": "English-speaking tour guide"
						},
						{
							"key": "isNonRefund",
							"value": "can't cancel"
						}
					]
				},
				"cancellationPolicy": "can't cancel",
				"durationText": "5 hours ",
				"duration": "5"
			},
			"totalAmount": 100.0,
			"totalFees": 0.0,
			"totalTaxes": 0.0,
			"totalDiscount": 0.0,
			"participantInfo": [{
				"paxId": "string",
				"name": "string",
				"surname": "string",
				"weight": 0.0,
				"dateOfBirth": "string",
				"passportCountry": "string",
				"passportNumber": "string",
				"passportCountryIssue": "string",
				"expiryDate": "string"
			}],
			"customerInfo": {
				"email": "string",
				"firstName": "string",
				"lastName": "string",
				"phoneNumber": "string"
			}
		}
	}
}
	''';
