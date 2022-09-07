import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/managed_booking/data_sources/booking_list_remote_data_source.dart';
import 'package:ota/domain/managed_booking/repositories/booking_list_repository_impl.dart';

import '../../helper.dart';
import '../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("OTA booking test ", () {
    testWidgets('OTA booking test case hotel', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRepositoryImpl.setMockInternet(InternetSuccessMock());
        BookingListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: getMockDataWithString(_responseMockH)));

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaBookingListScreen,
          "hotel_key",
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        // await tester.tap(find.byType(HotelBookingTile));
        await tester.pump();
      });
    });
    testWidgets('OTA booking test case2', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRepositoryImpl.setMockInternet(InternetSuccessMock());
        BookingListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: getMockDataWithString(_responseMockT)));

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaBookingListScreen,
          "tour_key",
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        // await tester.tap(find.byType(TourBookingTile).first);
        await tester.pump();
      });
    });

    testWidgets('OTA booking test case3', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRepositoryImpl.setMockInternet(InternetSuccessMock());
        BookingListRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: getMockDataWithString(_responseMockT)));

        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.otaBookingListScreen,
          "tour_key",
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        // await tester.tap(find.byType(TourBookingTile).last);
        await tester.pump();
      });
    });
//TODO fix test case
    // testWidgets('OTA booking test case4', (WidgetTester tester) async {
    //   await tester.runAsync(() async {
    //     Widget widget = getWidgetPressButtonWithProvider(
    //       AppRoutes.otaBookingListScreen,
    //       "car_key",
    //     );
    //     await tester.pumpWidget(widget);
    //     await tester.pumpAndSettle();
    //     await tester.tap(find.text("press"));
    //     await tester.pumpAndSettle();
    //   });
    // });
  });
}

String _responseMockH = '''{
 	"getBookingSummaryV2": {
 		"data": {
 			"totalPageNumber": 1,
 			"bookingDetails": [{
 					"serviceType": "HOTEL",
 					"sortDateTime": "2022-07-01T00:00:00",
 					"sortPriority": 1,
 					"hotel": {
 						"name": "Pavilions Phuket",
 						"totalPrice": 3522.87,
 						"checkInDate": "2022-03-01",
 						"checkOutDate": "2022-07-01",
 						"bookingUrn": "H220429-AA-0085",
 						"status": "CONFIRMED",
 						"bookingId": "B2CMMA220422177",
 						"paymentStatus": "CONFIRMED",
 						"activityStatus": "SUCCESS"
 					},
 					"tour": null,
 					"car": null,
 					"flight": null
 				},
 				{
 					"serviceType": "HOTEL",
 					"sortDateTime": "2022-07-02T00:00:00",
 					"sortPriority": 1,
 					"hotel": {
 						"name": "Phuket Graceland Resort and Spa",
 						"totalPrice": 1958.24,
 						"checkInDate": "2022-05-01",
 						"checkOutDate": "2022-07-02",
 						"bookingUrn": "H220429-AA-0042",
 						"status": "PAYMENT_PENDING",
 						"bookingId": null,
 						"paymentStatus": "INITIATED",
 						"activityStatus": "PAYMENT_PENDING"
 					},
 					"tour": null,
 					"car": null,
 					"flight": null
 				}
 			]
 		},
 		"status": {
 			"code": "1000",
 			"header": "Success",
 			"description": null
 		}
 	}
 }''';
String _responseMockT = '''{
    "getOtaBookingSummary": {
      "data": {
        "bookingHistory": {
          "upcomingBooking": [
            {
              "serviceType": "TOUR",
              "name": "Wat Arun",
              "totalPrice": 2.0,
              "bookingDate": "2022-03-10",
              "bookingUrn": "TR220309-AA-0001",
              "status": "CONFIRMED",
              "startTimeAMPM": "08:00 น",
              "paymentStatus": null,
              "bookingId": "B2CMMA220315530"
            },
            {
              "serviceType": "TICKET",
              "name": "บัตรเข้าเมืองหิมะ ทุกสัญชาติ (ต้องซื้อบัตรเข้าสวนสนุกก่อน)",
              "totalPrice": 150.0,
              "bookingDate": "2022-03-18",
              "bookingUrn": "TT220302-AA-0005",
              "status": "CONFIRMED",
              "startTimeAMPM": "09:00 น",
              "paymentStatus": "CONFIRMED",
              "bookingId": "B2CMMA220311171"
            }
          ],
          "completedBooking": [
            {
              "serviceType": "TOUR",
              "name": "Wat Arun",
              "totalPrice": 150.0,
              "bookingDate": "2022-03-04",
              "bookingUrn": "TR220303-AA-0029",
              "status": "CONFIRMED",
              "startTimeAMPM": "08:00 น",
              "paymentStatus": "CONFIRMED",
              "bookingId": "B2CMMA220312133"
            },
            {
              "serviceType": "TOUR",
              "name": "Wat Arun",
              "totalPrice": 2.0,
              "bookingDate": "2022-03-03",
              "bookingUrn": "TR220303-AA-0018",
              "status": "CONFIRMED",
              "startTimeAMPM": "08:00 น",
              "paymentStatus": "CONFIRMED",
              "bookingId": "B2CMMA220312041"
            },
            {
              "serviceType": "TICKET",
              "name": "บัตรเข้าเมืองหิมะ ทุกสัญชาติ (ต้องซื้อบัตรเข้าสวนสนุกก่อน)",
              "totalPrice": 150.0,
              "bookingDate": "2022-03-02",
              "bookingUrn": "TT220302-AA-0004",
              "status": "CONFIRMED",
              "startTimeAMPM": "09:00 น",
              "paymentStatus": "CONFIRMED",
              "bookingId": "B2CMMA220312017"
            }
          ],
          "cancelledBooking": [
            {
              "serviceType": "TOUR",
              "name": "สวนสนุกดรีมเวิลด์(Hello We Sell Tour & Ticket)",
              "totalPrice": 150.0,
              "bookingDate": "2022-03-04",
              "bookingUrn": "TT220302-AA-0008",
              "status": "CANCELLED",
              "startTimeAMPM": "09:00 น",
              "paymentStatus": "CONFIRMED",
              "bookingId": null
            }
          ]
        }
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
  }''';
