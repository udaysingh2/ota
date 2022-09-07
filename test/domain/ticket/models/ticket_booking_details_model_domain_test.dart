import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';

void main() {
  String jsonString = _responseMock1;

  TicketBookingDetailModelDomain ticketBookingModelDomain =
      TicketBookingDetailModelDomain.fromJson(jsonString);
  test("Ticket Method Domain Model Test 1", () {
    String stringData = ticketBookingModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = ticketBookingModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model Test 2", () {
    OtaBookingDetails getTicketBooking = OtaBookingDetails.fromJson(jsonString);
    Map<String, dynamic> map = getTicketBooking.toMap();

    OtaBookingDetails mapFromModel = OtaBookingDetails.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model data Test 3", () {
    Data getData = Data.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Data mapFromDataModel = Data.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model TicketBookingDetailPromotionList Test", () {
    TicketBookingDetailPromotionList getData =
        TicketBookingDetailPromotionList.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    TicketBookingDetailPromotionList mapFromDataModel =
        TicketBookingDetailPromotionList.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model TicketBookingDetail Test1", () {
    TicketBookingDetail getData = TicketBookingDetail.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    TicketBookingDetail mapFromDataModel = TicketBookingDetail.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model TicketBookingDetail Test2", () {
    TicketBookingDetail getData = TicketBookingDetail.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    TicketBookingDetail mapFromDataModel = TicketBookingDetail.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model Information Test3", () {
    Information getData = Information.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    Information mapFromDataModel = Information.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model PackageDetail Test4", () {
    PackageDetail getData = PackageDetail.fromJson(jsonString);
    Map<String, dynamic> dataMap = getData.toMap();
    PackageDetail mapFromDataModel = PackageDetail.fromMap(dataMap);

    String stringData = mapFromDataModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromDataModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}

var _responseMock1 = """
 {
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
      "promotion": {
							"promotionId": 3,
							"promotionName": "RBH Order Flat Special",
							"shortDescription": "ส่วนลดมูลค่า 50 บาท",
							"discount": 20.0,
							"maximumDiscount": 20,
							"discountType": "FLAT",
							"discountFor": "ORDER",
							"promotionLink": "scbeasy://payments/creditcard/review/id/4567",
							"promotionType": "DYNAMIC",
							"iconUrl": "scbeasy://payments/creditcard/review/id/4567",
							"voucherCode": "RBH50",
							"promotionCode": "RBH50",
							"startDate": "2020-07-24T08:44:39.000Z",
							"endDate": "2020-07-24T08:44:39.000Z",
							"applicationKey": "TOUR_AND_TICKET"
						},
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
				   "promotionList": [
        {
          "productType": "CARRENTAL",
          "promotionCode": "FREEDELIVERY",
          "title": "Free Food Delivery",
          "description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
          "web": "https://www.tourismthailand.org/home"
        }
      ],
      	"priceDetails": {
							"effectiveDiscount": 0.0,
							"orderPrice": 2.0,
							"addonPrice": 0.0,
							"billingAmount": 2.0
						},
				"providerName": "Hello We Sell Tour & Ticket",
				"supplierContact": "02 577 8666",
				"paymentStatus": "CONFIRMED",
				"netPrice": 150.0,
				"totalPrice": 150.0,
				"discount": 0.0,
				"bookingCancellable":true,
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
""";
