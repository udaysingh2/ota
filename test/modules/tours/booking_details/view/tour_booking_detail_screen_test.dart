import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/tours/tour_booking_detail/data_sources/tour_booking_details_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_detail/repositories/tour_booking_details_repository_impl.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_detail_argument.dart';

import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> map = jsonDecode(getTourMockData1());
  Map<String, dynamic> map2 = jsonDecode(getTourMockData2());
  TourBookingDetailArgument tourBookingDetailArgument =
      TourBookingDetailArgument(
    bookingUrn: "bookingUrn",
    bookingId: "bookingUrn",
    bookingType: 'Tour',
  );
  Widget widget = MaterialApp(
    routes: AppRoutes.getRoutes(),
    supportedLocales: [
      Locale(
        LanguageCodes.english.code,
        LanguageCodes.english.countryCode,
      ),
      Locale(
        LanguageCodes.thai.code,
        LanguageCodes.thai.countryCode,
      ),
    ],
    localizationsDelegates: const [
      Localization.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Kanit',
    ),
    localeResolutionCallback: (locale, supportedLocales) {
      return supportedLocales.elementAt(0);
    },
    home: Scaffold(
      body: Builder(builder: (context) {
        return TextButton(
          child: const Text("press"),
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.tourBookingDetailScreen,
            arguments: tourBookingDetailArgument,
          ),
        );
      }),
    ),
  );

  group("Tour Booking Details Screen", () {
    testWidgets('Tour Booking Details Widget With Success',
        (WidgetTester tester) async {
      TourBookingDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
      TourBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: map,
        ),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("btn")));
        await tester.pump();
      });
    });
    testWidgets('Tour Booking Details Widget With Canceled',
        (WidgetTester tester) async {
      TourBookingDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
      TourBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: map2,
        ),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour Booking Details Widget With Failure',
        (WidgetTester tester) async {
      TourBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: null,
          exception: OperationException(),
        ),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await Future.delayed(const Duration(seconds: 3));
        await tester.pumpAndSettle();
      });
    });
  });
}

String getTourMockData1() {
  return _responseMock1;
}

var _responseMock1 = """
{
	"otaBookingDetailsV2": {
		"status": {
			"code": "1000",
			"header": "Success"
		},
		"data": {
			"bookingStatus": "CONFIRMED",
			"activityStatus": "SUCCESS",
			"bookingUrn": "TR220302-AA-0005",
			"bookingId": "B2CMMA220210007",
			"orderId": "220300272",
			"bookingType": "TOUR",
			"tourBookingDetail": {
				"name": "Wat Arun",
				"imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/wat-arun.jpg",
				"category": "CULTURAL",
				"location": "Yaowaraj,Bangkok",
				"packageDetail": {
					"packageName": "Wat Arun(Holiday by RBH)",
					"inclusions": {
						"highlights": [{
								"key": "tourTime",
								"value": "Full day tour starts at 08:00 AM"
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
								"value": "Refundable"
							}
						],
						"all": "<div>(Activity rate /Service Include)(data/activitys/tours/includeDescription)</div><ul class=><li class=><span class=>English speaking guide</span></li><li class=><span class=>Chao Phraya Express Boat </span></li><li class=><span class=>Visit to the Flower Market and lotus folding</span></li><li class=><span class=>Tuk-tuk ride in Bangkok</span></li><li class=><span class=>Drinking water</span></li><li class=><span class=>Streetfood dinner in Chinatown</span></li></ul>"
					},
					"cancellationPolicy": "Booking Cancel after 07-Jun-2019, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
					"durationText": "10 hours",
					"exclusions": "<div>(Activity rate /Service  Exclude)(data/activitys/tours/excludeDescription)</div><ul class=><li class=><span class=>Foot massage (30 minutes)</span></li></ul>",
					"conditions": "<div>(Activity rate /Condition)(data/activitys/tours/condition)</div><ul class=fPmet><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Confirmation will be received at time of booking</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Not wheelchair accessible</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Near public transportation</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Infants must sit on laps</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Most travelers can participate</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>This tour/activity will have a maximum of 15 travelers</span></li></ul>",
					"shuttle": "<div>(Activity rate /How To Use)(data/activitys/tours/howToUseDescription)</div><p>Pickup at Hotel Lobby</p>",
					"meetingPoint": "<div>(Activity rate /Meeting Point)(data/activitys/tours/meetingPoint)</div><p>Hotel Lobby</p>",
					"schedule": "<div>(Activity rate /Itinerarys Description)</div><ul><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Saphan Taksin, Yan Nawa, Sathon, Bangkok 10120, Thailand Tour starts every day 6 PM at BTS Saphan Taksin station (Sky train) exit 2</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Rambuttri Alley, Soi Rambuttri, Khwaeng Talat Yot, Khet Phra Nakhon, Krung Thep Maha Nakhon 10200, Thailand After this relaxing foot massage at Rambuttri Road, we finish the evening with a drink in one of the bars before the guide will assist you finding a taxi (taxi fee not included) back to your hotel.</span></li></ul>",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					}
				},
				"information": {
          "description": "<div>Bangkok is one of the most cosmopolitan, contrasting and compelling cities in the world known for its vibrant street-life and the smiling, welcoming people who live there.</div>",
          "conditions": "<div><div>Confirmation will be received at time of booking</div><div>Not wheelchair accessible</div><div>Ticket - 1 Day Pass (Valid from the time of first use)</div></div>",
          "howToUse": "<div>Using Siam Hop's App the passenger will be able to keep track of bus movements by GPS, thereby avoiding having to waste time waiting for the next bus to rejoin the tour. Furthermore, the GPS is designed so that there is no confusion or hassles finding the Bus Stop's location.</div>"
        },
				"price": {
					"adultPrice": 1.0,
					"childPrice": 0.0
				},
				"bookingDate": "2022-03-24",
        "confirmationDate": "2022-03-25 18:09:09",
				"cancellationDate": "",
				"cancellationCharge": 0.0,
				"cancellationReason": "",
				"totalRefundAmount": 0.0,
				"noOfDays": "1",
				"child": 0,
				"adults": 1,
				"participantInfo": [{
					"name": "ผู้ใหญ่",
					"surname": "ผู้ใหญ่",
					"weight": "80 Kg",
					"dateOfBirth": "1988-01-22",
					"passportCountry": "Thailand",
					"passportNumber": "123456789",
					"passportCountryIssue": "Tailand",
					"expiryDate": "2026-01-08"
				}],
				"providerName": "Hello We Sell Tour & Ticket",
				"supplierContact": "02 577 8666",
				"paymentStatus": "CONFIRMED",
				"netPrice": 2.0,
				"totalPrice": 2.0,
				"discount": 0.0,
				"paymentDetails": {
					"paymentMethod": "CARD",
					"cardType": "VISA/MASTER",
					"cardNo": "123456",
					"nickName": "Mycard"
				},
				"tourId": "MA2111000070",
				"countryId": "MA05110001",
				"cityId": "MA05110041"
			}
		}
	}
}
""";
String getTourMockData2() {
  return _responseMock2;
}

var _responseMock2 = """
{
	"otaBookingDetails": {
		"status": {
			"code": "1000",
			"header": "Success"
		},
		"data": {
			"bookingStatus": "CANCELLED",
			"activityStatus": "SUCCESS",
			"bookingUrn": "TR220302-AA-0005",
			"bookingId": "B2CMMA220210007",
			"orderId": "220300272",
			"bookingType": "TOUR",
			"tourBookingDetail": {
				"name": "Wat Arun",
				"imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/wat-arun.jpg",
				"category": "CULTURAL",
				"location": "Yaowaraj,Bangkok",
				"packageDetail": {
					"packageName": "Wat Arun(Holiday by RBH)",
					"inclusions": {
						"highlights": [{
								"key": "tourTime",
								"value": "Full day tour starts at 08:00 AM"
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
								"value": "Refundable"
							}
						],
						"all": "<div>(Activity rate /Service Include)(data/activitys/tours/includeDescription)</div><ul class=><li class=><span class=>English speaking guide</span></li><li class=><span class=>Chao Phraya Express Boat </span></li><li class=><span class=>Visit to the Flower Market and lotus folding</span></li><li class=><span class=>Tuk-tuk ride in Bangkok</span></li><li class=><span class=>Drinking water</span></li><li class=><span class=>Streetfood dinner in Chinatown</span></li></ul>"
					},
					"cancellationPolicy": "Booking Cancel after 07-Jun-2019, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
					"durationText": "10 hours",
					"exclusions": "<div>(Activity rate /Service  Exclude)(data/activitys/tours/excludeDescription)</div><ul class=><li class=><span class=>Foot massage (30 minutes)</span></li></ul>",
					"conditions": "<div>(Activity rate /Condition)(data/activitys/tours/condition)</div><ul class=fPmet><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Confirmation will be received at time of booking</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Not wheelchair accessible</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Near public transportation</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Infants must sit on laps</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Most travelers can participate</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>This tour/activity will have a maximum of 15 travelers</span></li></ul>",
					"shuttle": "<div>(Activity rate /How To Use)(data/activitys/tours/howToUseDescription)</div><p>Pickup at Hotel Lobby</p>",
					"meetingPoint": "<div>(Activity rate /Meeting Point)(data/activitys/tours/meetingPoint)</div><p>Hotel Lobby</p>",
					"schedule": "<div>(Activity rate /Itinerarys Description)</div><ul><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Saphan Taksin, Yan Nawa, Sathon, Bangkok 10120, Thailand Tour starts every day 6 PM at BTS Saphan Taksin station (Sky train) exit 2</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Rambuttri Alley, Soi Rambuttri, Khwaeng Talat Yot, Khet Phra Nakhon, Krung Thep Maha Nakhon 10200, Thailand After this relaxing foot massage at Rambuttri Road, we finish the evening with a drink in one of the bars before the guide will assist you finding a taxi (taxi fee not included) back to your hotel.</span></li></ul>",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					}
				},
				"information": {
          "description": "<div>Bangkok is one of the most cosmopolitan, contrasting and compelling cities in the world known for its vibrant street-life and the smiling, welcoming people who live there.</div>",
          "conditions": "<div><div>Confirmation will be received at time of booking</div><div>Not wheelchair accessible</div><div>Ticket - 1 Day Pass (Valid from the time of first use)</div></div>",
          "howToUse": "<div>Using Siam Hop's App the passenger will be able to keep track of bus movements by GPS, thereby avoiding having to waste time waiting for the next bus to rejoin the tour. Furthermore, the GPS is designed so that there is no confusion or hassles finding the Bus Stop's location.</div>"
        },
				"price": {
					"adultPrice": 1.0,
					"childPrice": 0.0
				},
				"bookingDate": "2022-03-27",
        "confirmationDate": "2022-03-25 18:09:09",
				"cancellationDate": "",
				"cancellationCharge": 0.0,
				"cancellationReason": "",
				"totalRefundAmount": 0.0,
				"noOfDays": "1",
				"child": 0,
				"adults": 1,
				"participantInfo": [{
					"name": "ผู้ใหญ่",
					"surname": "ผู้ใหญ่",
					"weight": "80 Kg",
					"dateOfBirth": "1988-01-22",
					"passportCountry": "Thailand",
					"passportNumber": "123456789",
					"passportCountryIssue": "Tailand",
					"expiryDate": "2026-01-08"
				}],
				"providerName": "Hello We Sell Tour & Ticket",
				"supplierContact": "02 577 8666",
				"paymentStatus": "CONFIRMED",
				"netPrice": 2.0,
				"totalPrice": 2.0,
				"discount": 0.0,
				"paymentDetails": {
					"paymentMethod": "CARD",
					"cardType": "VISA/MASTER",
					"cardNo": "123456",
					"nickName": "Mycard"
				},
				"tourId": "MA2111000070",
				"countryId": "MA05110001",
				"cityId": "MA05110041"
			}
		}
	}
}
""";
