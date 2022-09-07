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
import 'package:ota/domain/tickets/ticket_booking_details/data_sources/ticket_booking_details_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_details/repositories/ticket_booking_details_repository_impl.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';

import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> map = jsonDecode(getMockData1());
  Map<String, dynamic> map2 = jsonDecode(getMockData2());
  TicketBookingDetailArgument ticketBookingDetailArgument =
      TicketBookingDetailArgument(
    bookingUrn: "bookingUrn",
    bookingId: "bookingUrn",
    bookingType: 'Ticket',
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
            AppRoutes.ticketBookingDetailScreen,
            arguments: ticketBookingDetailArgument,
          ),
        );
      }),
    ),
  );

  group("Ticket Booking Details Screen", () {
    testWidgets('Tour Booking Details Widget With Success',
        (WidgetTester tester) async {
      TicketBookingDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
      TicketBookingDetailRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(
          result: map,
        ),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("btn")));
        await tester.pump();
      });
    });

    testWidgets('Tour Booking Details Widget with canceled Status',
        (WidgetTester tester) async {
      TicketBookingDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
      TicketBookingDetailRemoteDataSourceImpl.setMock(
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

    testWidgets('Ticket Booking Details Widget With Failure',
        (WidgetTester tester) async {
      TicketBookingDetailRemoteDataSourceImpl.setMock(
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

String getMockData1() {
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
			"bookingUrn": "TT220302-AA-0005",
			"bookingId": "B2CMMA210885560",
			"orderId": "220300272",
			"bookingType": "TICKET",
			"ticketBookingDetail": {
				"name": "Wat Arun",
				"imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/wat-arun.jpg",
				"category": "CULTURAL",
				"location": "Yaowaraj,Bangkok",
				"packageDetail": {
					"packageName": "Wat Arun(Holiday by RBH)",
					"inclusions": {
						"highlights": [{
								"key": "ticketTime",
								"value": "ทัวร์เต็มวัน เริ่ม 09:00 น"
							},
							{
								"key": "isNonRefund",
								"value": "ขอรับเงินคืนได้หากยกเลิก"
							}
						],
						"all": "<p>We provide appropriate attire for each treatment, which can are pajamas for Thai Massages, and disposable underwear for Oil-based Massages.</p>"
					},
					"cancellationPolicy": "Booking Cancel after 07-Jun-2019, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
					"durationText": "10 hours ",
					"exclusions": "<p>gratuity payment</p>",
					"conditions": "<p>We respectfully request that all visitors must keep noise to a minimum. Do not bring children and leave them unattended, to avoid discomfort to other spa goers. Please refrain from bringing cellular phones and other electronic devices within the vicinity of the spa treatment room. Be reminded that you are in a professional spa therapy operations and so do not expect anything other than therapeutic or spa services.</p>",
					"shuttle": "<p>The spa opens from 10:00 to 24:00 hours a day.We accept the last booking at no later than 22:00 hours.</p>",
					"meetingPoint": "",
					"schedule": "<p>Please check-in at the spa reception at least 10 minutes prior to your scheduled appointment and coordinate with the reception staff, to orient you with your treatment all the way and to maximize treatment time.</p>"
				},
				"ticketTypes": [{
						"paxId": "MA21110020",
						"name": "เด็ก 4-11 ปี",
						"price": 50.0,
						"noOfTickets": 1
					},
					{
						"paxId": "MA21110021",
						"name": "ผู้ใหญ่",
						"price": 100.0,
						"noOfTickets": 1
					}
				],
				"information": {
          "description": "<p>สวนสนุกดรีมเวิลด์ โลกแห่งความสุขสนุกทั้งครอบครัว<br />“ดรีมเวิลด์” เป็นสวนสนุกและสถานที่พักผ่อนที่รวบรวมความบันเทิงนานาชนิดเข้าไว้ด้วยกัน มีเนื้อที่ทั้งสิ้นประมาณ 160 ไร่ตั้งอยู่ที่ กม.7 รังสิตนครนายก (คลอง3)</p><p>“ดรีมเวิลด์” เกิดขึ้นจากความคิดริเริ่มของ“ตระกูลกิติพราภรณ์” ซึ่งในขณะนั้นได้ดำเนินธุรกิจเกี่ยวกับสวนสนุกคือ สวนสนุกแดนเนรมิต</p>",
          "conditions": "<p>เปลี่ยนเวลาใหม่ไม่ได้, ไม่สามารถขอคืนเงินได้</p><p>การจองนี้ไม่สามารถขอคืนเงินได้ เมื่อการจองได้รับการยืนยันแล้ว นโยบายการยกเลิกการจองจะมีผลบังคับใช้</p><p>ระยะเวลาใช้งานใบยืนยันการจองนี้ไม่สามารถเปลี่ยนแปลงได้</p>",
          "howToUse": "<p>การแลกรับบัตร<br />ทำการจองอย่างน้อย 1 วันล่วงหน้า</p><p>จำเป็นต้องจองไปก่อน<br />คุณจำเป็นต้องจองไปก่อนอย่างน้อย 1 วันก่อนเข้าใช้บริการ คุณสามารถตรวจสอบข้อมูลติดต่อของผู้ให้บริการในใบจองหรือในหน้าการจองของฉันได้</p><p>จำเป็นต้องแลกบัตร<br />ไม่ต้องใช้บัตรพิมพ์กระดาษ</p><p>วิธีการแลกรับบัตร<br />อนุญาตให้ใช้ใบยืนยันการจองอิเล็กทรอนิกส์ผ่านประตูได้<br />แสดงหรือสแกนใบยืนยันการจองจาก Traveloka บนโทรศัพท์มือถือของคุณที่ห้องจำหน่ายบัตร หรือบริเวณประตูทางเข้า กรุณาปรับความสว่างหน้าจอโทรศัพท์มือถือก่อนสแกนคิวอาร์โค้ดบนใบยืนยันการจองของคุณ<br />อนุญาตให้ใช้ใบยืนยันการจองจาก Traveloka เท่านั้น ใบเสร็จชำระเงินหรือหลักฐานการชำระเงินจะไม่สามารถใช้เข้าสถานที่ได้<br />เวลาเปิดทำการอาจเปลี่ยนแปลงได้ ตรวจสอบเวลาเปิดทำการล่าสุด ตารางเวลากิจกรรม และคำถามที่พบบ่อยกับผู้ดำเนินการจัดทัวร์ / กิจกรรม / สถานที่ ก่อนถึงวันที่ท่านจอง</p>"
        },
				"bookingDate": "2022-03-02",
        "confirmationDate": "2022-03-03 18:07:09",
				"cancellationDate": "",
				"cancellationCharge": 0.0,
				"cancellationReason": "",
				"totalRefundAmount": 0.0,
				"noOfDays": "1",
				"participantInfo": [{
					"name": "ผู้ใหญ่",
					"surname": "ผู้ใหญ่",
					"weight": "80 Kg",
					"dateOfBirth": "1988-01-22",
					"passportCountry": "Tailand",
					"passportNumber": "123456789",
					"passportCountryIssue": "Tailand",
					"expiryDate": "2026-01-08"
				}],
				"providerName": "Hello We Sell Tour & Ticket",
				"supplierContact": "02 577 8666",
				"paymentStatus": "CONFIRMED",
				"netPrice": 150.0,
				"totalPrice": 150.0,
				"discount": 0.0,
				"bookingCancellable":true,
				"payment": [
                          {
                            "amount": "104.00",
                            "cardNickName": "test",
                            "cardNo": "***5454",
                            "cardType": "UNIONPAY",
                            "type": "CARD",
                            "name": "Credit Card"
                          },
                          {
                            "amount": "16304.00",
                            "cardNickName": null,
                            "cardNo": null,
                            "cardType": null,
                            "type": "VA",
                            "name": "Wallet"
                          }
                        ],
				"ticketId": "MA2111000168",
				"cityId": "MA05110041",
				"countryId": "MA05110001"
			}
		}
	}
}
""";

String getMockData2() {
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
			"bookingUrn": "TT220302-AA-0005",
			"bookingId": "B2CMMA210885560",
			"orderId": "220300272",
			"bookingType": "TICKET",
			"ticketBookingDetail": {
				"name": "Wat Arun",
				"imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/wat-arun.jpg",
				"category": "CULTURAL",
				"location": "Yaowaraj,Bangkok",
				"packageDetail": {
					"packageName": "Wat Arun(Holiday by RBH)",
					"inclusions": {
						"highlights": [{
								"key": "ticketTime",
								"value": "ทัวร์เต็มวัน เริ่ม 09:00 น"
							},
							{
								"key": "isNonRefund",
								"value": "ขอรับเงินคืนได้หากยกเลิก"
							}
						],
						"all": "<p>We provide appropriate attire for each treatment, which can are pajamas for Thai Massages, and disposable underwear for Oil-based Massages.</p>"
					},
					"cancellationPolicy": "Booking Cancel after 07-Jun-2019, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
					"durationText": "10 hours ",
					"exclusions": "<p>gratuity payment</p>",
					"conditions": "<p>We respectfully request that all visitors must keep noise to a minimum. Do not bring children and leave them unattended, to avoid discomfort to other spa goers. Please refrain from bringing cellular phones and other electronic devices within the vicinity of the spa treatment room. Be reminded that you are in a professional spa therapy operations and so do not expect anything other than therapeutic or spa services.</p>",
					"shuttle": "<p>The spa opens from 10:00 to 24:00 hours a day.We accept the last booking at no later than 22:00 hours.</p>",
					"meetingPoint": "ผู้ใหญ่",
					"schedule": "<p>Please check-in at the spa reception at least 10 minutes prior to your scheduled appointment and coordinate with the reception staff, to orient you with your treatment all the way and to maximize treatment time.</p>"
				},
				"ticketTypes": [{
						"paxId": "MA21110020",
						"name": "เด็ก 4-11 ปี",
						"price": 50.0,
						"noOfTickets": 1
					},
					{
						"paxId": "MA21110021",
						"name": "ผู้ใหญ่",
						"price": 100.0,
						"noOfTickets": 1
					}
				],
				"information": {
          "description": "<p>สวนสนุกดรีมเวิลด์ โลกแห่งความสุขสนุกทั้งครอบครัว<br />“ดรีมเวิลด์” เป็นสวนสนุกและสถานที่พักผ่อนที่รวบรวมความบันเทิงนานาชนิดเข้าไว้ด้วยกัน มีเนื้อที่ทั้งสิ้นประมาณ 160 ไร่ตั้งอยู่ที่ กม.7 รังสิตนครนายก (คลอง3)</p><p>“ดรีมเวิลด์” เกิดขึ้นจากความคิดริเริ่มของ“ตระกูลกิติพราภรณ์” ซึ่งในขณะนั้นได้ดำเนินธุรกิจเกี่ยวกับสวนสนุกคือ สวนสนุกแดนเนรมิต</p>",
          "conditions": "<p>เปลี่ยนเวลาใหม่ไม่ได้, ไม่สามารถขอคืนเงินได้</p><p>การจองนี้ไม่สามารถขอคืนเงินได้ เมื่อการจองได้รับการยืนยันแล้ว นโยบายการยกเลิกการจองจะมีผลบังคับใช้</p><p>ระยะเวลาใช้งานใบยืนยันการจองนี้ไม่สามารถเปลี่ยนแปลงได้</p>",
          "howToUse": "<p>การแลกรับบัตร<br />ทำการจองอย่างน้อย 1 วันล่วงหน้า</p><p>จำเป็นต้องจองไปก่อน<br />คุณจำเป็นต้องจองไปก่อนอย่างน้อย 1 วันก่อนเข้าใช้บริการ คุณสามารถตรวจสอบข้อมูลติดต่อของผู้ให้บริการในใบจองหรือในหน้าการจองของฉันได้</p><p>จำเป็นต้องแลกบัตร<br />ไม่ต้องใช้บัตรพิมพ์กระดาษ</p><p>วิธีการแลกรับบัตร<br />อนุญาตให้ใช้ใบยืนยันการจองอิเล็กทรอนิกส์ผ่านประตูได้<br />แสดงหรือสแกนใบยืนยันการจองจาก Traveloka บนโทรศัพท์มือถือของคุณที่ห้องจำหน่ายบัตร หรือบริเวณประตูทางเข้า กรุณาปรับความสว่างหน้าจอโทรศัพท์มือถือก่อนสแกนคิวอาร์โค้ดบนใบยืนยันการจองของคุณ<br />อนุญาตให้ใช้ใบยืนยันการจองจาก Traveloka เท่านั้น ใบเสร็จชำระเงินหรือหลักฐานการชำระเงินจะไม่สามารถใช้เข้าสถานที่ได้<br />เวลาเปิดทำการอาจเปลี่ยนแปลงได้ ตรวจสอบเวลาเปิดทำการล่าสุด ตารางเวลากิจกรรม และคำถามที่พบบ่อยกับผู้ดำเนินการจัดทัวร์ / กิจกรรม / สถานที่ ก่อนถึงวันที่ท่านจอง</p>"
        },
				"bookingDate": "2022-03-02",
        "confirmationDate": "2022-03-03 18:09:09",
				"cancellationDate": "",
				"cancellationCharge": 0.0,
				"cancellationReason": "",
				"totalRefundAmount": 0.0,
				"noOfDays": "1",
				"participantInfo": [{
					"name": "ผู้ใหญ่",
					"surname": "ผู้ใหญ่",
					"weight": "80 Kg",
					"dateOfBirth": "1988-01-22",
					"passportCountry": "Tailand",
					"passportNumber": "123456789",
					"passportCountryIssue": "Tailand",
					"expiryDate": "2026-01-08"
				}],
				"providerName": "Hello We Sell Tour & Ticket",
				"supplierContact": "02 577 8666",
				"paymentStatus": "CONFIRMED",
				"netPrice": 150.0,
				"totalPrice": 150.0,
				"discount": 0.0,
				"paymentDetails": {
					"paymentMethod": "card/SCB Easy",
					"cardType": "VISA/MASTER",
					"cardNo": "123456",
					"cardNickName": "Mycard"
				},
				"ticketId": "MA2111000168",
				"cityId": "MA05110041",
				"countryId": "MA05110001"
			}
		}
	}
}
""";
