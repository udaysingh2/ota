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
import 'package:ota/domain/tickets/confirm_booking/data_source/ticket_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/tickets/confirm_booking/repositories/ticket_confirm_booking_repository.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_view_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late OtaCountDownController otaCountDownController;
  setUpAll(() {
    debugPrint("setup ticket confirm booking");
    HttpOverrides.global = null;
    otaCountDownController =
        OtaCountDownController(durationInSecond: 2, onComplete: () {});
  });
  tearDownAll(() {
    debugPrint("tear down ticket confirm booking");
    otaCountDownController.dispose();
  });
  group("Ticket confirm booking test", () {
    testWidgets('Ticket confirm booking test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock);
        TicketConfirmBookingRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TicketConfirmBookingRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        PaymentMethodRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentMethodMockDataSourceImpl.getMockData())));
        PaymentMethodRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketConfirmBookingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaTextButton));
      });
    });

    testWidgets('Ticket confirm booking test expand',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Map<String, dynamic> fullData = getMockDataWithString(_responseMock);
        TicketConfirmBookingRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TicketConfirmBookingRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        PaymentMethodRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentMethodMockDataSourceImpl.getMockData())));
        PaymentMethodRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketConfirmBookingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester
            .tap(find.byKey(const Key("ticketPaymentCollapseExpandKey")));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Ticket confirm booking test failure',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        TicketConfirmBookingRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TicketConfirmBookingRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(exception: OperationException()));
        PaymentMethodRemoteDataSourceImpl.setMock(GraphQlResponseMock(
            result: getMockDataWithString(
                PaymentMethodMockDataSourceImpl.getMockData())));
        PaymentMethodRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketConfirmBookingScreen,
          _getArgument(
            otaCountDownController,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });
  });
}

TicketConfirmBookingArgumentModel _getArgument(
    OtaCountDownController otaCountDownController) {
  return TicketConfirmBookingArgumentModel(
      otaCountDownController: otaCountDownController,
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
        totalPrice: 250.72,
        isAdditionalGuestAvailable: false,
        additionalNeedText: "asdf",
        pickupArgument: Pickup(name: "john", id: "123"),
        guestInfoList: [
          GuestInfo(name: "John", surname: "Honay"),
          GuestInfo(name: "James", surname: "Honay")
        ],
      ));
}

var _responseMock = '''{
	"getTicketBookingConfirmation": {
	"status": {
			"code": "1000",
			"header": "Success"
		},
		"data": {
			"bookingUrn": "TT220120-AA-0026",
			"ticketId": "MA2111000168",
			"cityId": "MA05110041",
			"countryId": "MA05110001",
			"bookingDate": "2022-01-22",
			"name": "Dream World(Hello We Sell Tour & Ticket)",
			"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
			"location": "Rangsit-Bangkok",
			"category": "Rangsit-Bangkok",
      "startTimeAMPM": "09:00 AM",
      "promotionList": [{
					"productType": "ACTIVITY",
						"promotionCode": "FREEDELIVERY",
						"title": "Free Food Delivery",
						"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
						"web": "https://cms.robinhood.in.th/archives/2869"
					}],
			"packageDetail": {
				"name": "Dream World(Hello We Sell Tour & Ticket)",
				"inclusions": {
					"highlights": [{
							"key": "ticketTime",
							"value": "Full day tour starts at 09:00 AM"
						},
						{
							"key": "isNonRefund",
							"value": "Refundable"
						}
					],
					"all": "<div>ราคารวมถึง</div><div>ค่าผ่านประตู</div><div>เล่นเครื่องเล่นได้ไม่จำกัดรอบ รวมถึงเมืองหิมะ, โกคาร์ต, เรือถีบ, และเรือบั๊ม</div><div><br></div>"
				},
				"cancellationPolicy": "You have to cancel 2 day(s) prior to the service date., Otherwise cancellation charge of Full Charge from Grand total will be applied.-Booking Cancel after 18-Jan-2022, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
				"ticketTypes": [{
						"paxId": "MA21110020",
						"name": "เด็ก 4-11 ปี",
						"price": 50,
						"noOfTickets": 1
					},
					{
						"paxId": "MA21110021",
						"name": "ผู้ใหญ่",
						"price": 100,
						"noOfTickets": 1
					}
				],
				"duration": "8",
				"durationText": "8 hours "
			},
			"totalAmount": 100.5,
			"totalFees": 0,
			"totalTaxes": 0,
			"totalDiscount": 0,
			"noOfDays": "1",
			"customerInfo": {
				"firstName": "fName",
				"lastName": "lName",
				"email": "c-email",
				"phoneNumber": "phn"
			},
			"participantInfo": [{
					"paxId": "MA21110021",
					"name": "ผู้ใหญ่",
					"surname": "ผู้ใหญ่",
					"weight": "80 Kg",
					"dateOfBirth": "1988-01-22",
					"passportCountry": "Tailand",
					"passportNumber": "123456789",
					"passportCountryIssue": "Tailand",
					"expiryDate": "2026-01-08"
				},
				{
					"paxId": "MA21110020",
					"name": "ผู้ใหญ่",
					"surname": "เด็ก 4-11 ปี",
					"weight": "20 Kg",
					"dateOfBirth": "2000-01-22",
					"passportCountry": "Tailand",
					"passportNumber": "12345678473",
					"passportCountryIssue": "Tailand",
					"expiryDate": "2026-01-08"
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
