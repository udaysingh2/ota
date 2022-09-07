import 'package:ota/domain/tickets/review_reservation/data_source/ticket_review_reservation_remote_data_source.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_argument_domain.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';

class TicketReviewReservationMockDataSourceImpl
    implements TicketReviewReservationRemoteDataSource {
  TicketReviewReservationMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<TicketReviewReservation> getTicketReviewReservationData(
      TicketReviewReservationArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TicketReviewReservation.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
	"getTicketBookingInitiateDetails": {
		"data": {
			"bookingUrn": "TT211230-AA-0009",
			"totalPrice": 1000.20,
			"ticketName": " บัตรเข้าสวนสนุกดรีมเวิลด์ (Dream World)(Hello We Sell Tour & Ticket)",
			"ticketImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
			"promotionList": [{
				"productType": "TICKET",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"ticketDetails": {
				"id": "MA2111000168",
				"name": " บัตรเข้าสวนสนุกดรีมเวิลด์ (Dream World)(Hello We Sell Tour & Ticket)",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
				"location": "Rangsit-Bangkok",
				"category": "Theme park",
				"information": {
					"description": "<div>โยนความเครียดทิ้งไป แล้วมาสนุกกับความบันเทิงมีชีวิตชีวาที่สวนสนุกดรีมเวิลด์ (Dream World) สวนสวรรค์ที่อยู่ใกล้กรุงเทพฯ แค่เอื้อม</div><div>พบกับช่วงเวลาถ่ายรูปสุดพิเศษที่จุดถ่ายรูปทั้ง 3 ตกแต่งภูมิทัศน์แตกต่างกัน ได้แก่ โซน 7 สิ่งมหัศจรรย์ โซนเลิฟการ์เดน โซนโฟโตเปีย</div><div>ทดสอบความกล้ากับ 3 เครื่องเล่นสุดหวาดเสียวตัวท็อปของสวนสนุก ได้แก่ ไวกิ้ง รถไฟเหาะ และเฮอร์ริเคน</div><div>พบกับหลากหลายความสนุกและการแสดงอันน่าตื่นตาตื่นใจมากมายที่รอต้อนรับผู้เยี่ยมชมทุกวัย</div><div><br></div><div><br></div><div>เหมาะสำหรับ: ประสบการณ์ที่น่าตื่นเต้นแบบสุดขีด, พวกรักอิสระ, ครอบครัวที่รักสนุก</div>",
					"conditions": "<ul><li>เปลี่ยนเวลาใหม่ไม่ได้, ไม่สามารถขอคืนเงินได้<br></li><li>การจองนี้ไม่สามารถขอคืนเงินได้ เมื่อการจองได้รับการยืนยันแล้ว นโยบายการยกเลิกการจองจะมีผลบังคับใช้</li><li>ระยะเวลาใช้งานใบยืนยันการจองนี้ไม่สามารถเปลี่ยนแปลงได้</li></ul>",
					"howToUse": "<div>การแลกรับบัตร<br></div><div>ทำการจองอย่างน้อย 1 วันล่วงหน้า</div><div><br></div><div>จำเป็นต้องจองไปก่อน</div><div><br></div><div>คุณจำเป็นต้องจองไปก่อนอย่างน้อย 1 วันก่อนเข้าใช้บริการ คุณสามารถตรวจสอบข้อมูลติดต่อของผู้ให้บริการในใบจองหรือในหน้าการจองของฉันได้</div><div><br></div><div><br></div><div>จำเป็นต้องแลกบัตร</div><div><br></div><div>ไม่ต้องใช้บัตรพิมพ์กระดาษ</div><div><br></div><div>วิธีการแลกรับบัตร</div><div>อนุญาตให้ใช้ใบยืนยันการจองอิเล็กทรอนิกส์ผ่านประตูได้</div><div>แสดงหรือสแกนใบยืนยันการจองจาก Traveloka บนโทรศัพท์มือถือของคุณที่ห้องจำหน่ายบัตร หรือบริเวณประตูทางเข้า กรุณาปรับความสว่างหน้าจอโทรศัพท์มือถือก่อนสแกนคิวอาร์โค้ดบนใบยืนยันการจองของคุณ</div><div>อนุญาตให้ใช้ใบยืนยันการจองจาก Traveloka เท่านั้น ใบเสร็จชำระเงินหรือหลักฐานการชำระเงินจะไม่สามารถใช้เข้าสถานที่ได้</div><div>เวลาเปิดทำการอาจเปลี่ยนแปลงได้ ตรวจสอบเวลาเปิดทำการล่าสุด ตารางเวลากิจกรรม และคำถามที่พบบ่อยกับผู้ดำเนินการจัดทัวร์ / กิจกรรม / สถานที่ ก่อนถึงวันที่ท่านจอง</div>",
					"providerName": "Hello We Sell Tour & Ticket ",
					"openTime": "09.00",
					"closeTime": "18.00"
				},
				"packages": [{
					"name": "บัตรเข้าเมืองหิมะ ทุกสัญชาติ (ต้องซื้อบัตรเข้าสวนสนุกก่อน) PaxType",
					"options": "บัตรเข้าเมืองหิมะ ทุกสัญชาติ (ต้องซื้อบัตรเข้าสวนสนุกก่อน) PaxType",
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
					"exclusions": "<div>ราคาไม่รวมถึง</div><div>เกมคาร์นิวัล</div><div>ค่าใช้จ่ายส่วนตัวอื่น</div>",
					"conditions": "",
					"schedule": "<div>ตารางการแสดง</div><div>การแสดงฮอลลีวู้ด แอ็คชั่น</div><div>ระยะเวลา: 25 นาที</div><div>วันจันทร์-วันอาทิตย์:</div><div>13:00 น.</div><div><br></div><div>ขบวนพาเหรดคัลเลอร์ ออฟ เดอะเวิลด์ (วันเสาร์, วันอาทิตย์ และวันหยุดนักขัตฤกษ์)</div><div>15:00 น.</div><div><br></div>",
					"meetingPoint": "",
					"shuttle": "",
					"cancellationPolicy": "You have to cancel 2 day(s) prior to the service date., Otherwise cancellation charge of Full Charge from Grand total will be applied.-Booking Cancel after 28-Dec-2021, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					},
					"ticketTypes": [{
							"paxId": "MA01010001",
							"name": "CHILD",
							"price": 300.22,
							"noOfTickets": 2,
							"minimum": 0,
							"available": 300
						},
						{
							"paxId": "MA01010002",
							"name": "ADULT",
							"price": 904.12,
							"noOfTickets": 3,
							"minimum": 0,
							"available": 300
						},
						{
							"paxId": "MA01010003",
							"name": "VIP",
							"price": 1211.5,
							"noOfTickets": 1,
							"minimum": 0,
							"available": 300
						}
					],
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "MA21110305",
					"rateKey": "TUEyMTExMDAwMDQw",
					"durationText": "8 hours ",
					"duration": null,
					"zoneId": "MA21110028",
					"requireInfo": {
						"weight": true,
						"allName": true,
						"guestName": true,
						"passportId": true,
						"dateOfBirth": true,
						"passportCountry": true,
						"passportValidDate": true,
						"passportCountryIssue": true
					}
				}]
			}
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
	''';
