import 'package:ota/domain/tickets/details/data_source/ticket_details_remote_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';

class TicketDetailsMockDataSource implements TicketDetailsRemoteDataSource {
  TicketDetailsMockDataSource();
  @override
  Future<TicketDetail> getTicketDetails(
      TicketDetailArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TicketDetail.fromJson(_responseMock);
  }

  @override
  Future<TicketDetail> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TicketDetail.fromJson(_responseMock);
  }

  final _responseMock = '''
{
	"getTicketDetails": {
		"data": {
			"promotionList": [{

				"productType": "TICKET",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"ticket": {
				"id": "MA2111000168",
				"name": "Dream World",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
				"location": "Rangsit",
				"category": "NONE",
				"information": {
					"description": "<div>Throw away the stress Come and enjoy the lively entertainment at Dream World, a paradise park near Bangkok. Just reach</div><div>Experience the special photo moments at 3 photo spots decorated in different landscapes, namely Zone 7 Wonders. Love Garden Zone Photopia Zone</div><div>Test your courage with 3 of the theme park's top thrilling rides: Vikings, Roller Coasters and Hurricanes</div><div>Encounter a variety of fun and exciting rides. Exciting shows await visitors of all ages. Freedom lovers, fun-loving families</br>",
					"conditions": "<ul><li>Non-refundable, non-refundable<br></li><li>This booking is non-refundable. Once the booking is confirmed Cancellation policy will apply.</li><li>The validity period of this voucher cannot be changed</li></ul>.",
					"howToUse": "<div>Ticket redemption<br></div><div>Book at least 1 day in advance</div><div><br></div><div>Booking required</div> <div><br></div><div>You need to book at least 1 day in advance. You can check the provider's contact information on the booking form or on the My Booking page.</div><div><br></div><div><br></div><div>Requires redemption. Tickets</div><div><br></div><div>No paper printed cards needed</div><div><br></div><div>How to redeem tickets</div> <div>Gate e-vouchers are allowed.</div><div>Show or scan the Traveloka voucher on your mobile phone at the ticket office. or around the entrance door Please adjust the brightness of your mobile phone screen before scanning the QR code on your voucher.</div><div>Only Traveloka vouchers are allowed. Payment receipts or proof of payment will not be accepted. Can be used to enter the location</div><div>Operating hours are subject to change. Check the latest opening hours. activity schedule and Frequently Asked Questions with ticket/activity/location operators before your booked date.</div>",
					"providerName": "Hello We Sell ticket & Ticket",
					"openTime": "09.00",
					"closeTime": "18.00"
				},
				"packages": [{
					"name": "Snow Town Admission Tickets (all nationalities)",
					"options": "",
					"inclusions": {
						"highlights": [{
								"key": "ticketTime",
								"value": "08.00 AM"
							},
							{
								"key": "isNonRefund",
								"value": "true"
							}
						],
						"all": "<div>Price includes</div><div>Admission fee</div><div>Unlimited rides. including snow towns, go-karts, pedal boats, and bumper boats.</div><div><br></div>"
					},
					"exclusions": "<div>Price does not include</div><div>Carnaval games</div><div>Other personal expenses</div>",
					"conditions": "",
					"schedule": "<div><span>(Activity rate /</span><span>Itinerarys Description</span><span>)</span><br></div><ul><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Saphan Taksin, Yan Nawa, Sathon, Bangkok 10120, Thailandticket starts every day 6 PM at BTS Saphan Taksin station (Sky train) exit 2</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Rambuttri Alley, Soi Rambuttri, Khwaeng Talat Yot, Khet Phra Nakhon, Krung Thep Maha Nakhon 10200, ThailandAfter this relaxing foot massage at Rambuttri Road, we finish the evening with a drink in one of the bars before the guide will assist you finding a taxi (taxi fee not included) back to your hotel.</span></li></ul>",
					"meetingPoint": "",
					"cancellationPolicy": "You have to cancel 10 day(s) prior to the service date., Otherwise 50 % cancellation charge for the entire stay will be applied.",
					"shuttle": "<div>(Activity rate /How To Use)(data/activitys/tickets/howToUseDescription)</div><p>Pickup at Hotel Lobby</p>",
					"childInfo": {
						"minAge": 3,
						"maxAge": 8,
						"description": "<div>Children under 90 cm in height can enjoy free rides. If sitting in the same seat as an adult</div><div>If the customer wants to use the shuttle service to the amusement park Please contact Dream World. **This service has an additional cost.</div>"
					},
					"ticketTypes": [{
							"paxId": "MA01010001",
							"name": "CHILD",
							"price": 300.22,
							"minimum": 1,
							"available": 4
						},
						{
							"paxId": "MA01010002",
							"name": "ADULT",
							"price": 904.12,
							"minimum": 1,
							"available": 6
						},
						{
							"paxId": "MA01010003",
							"name": "VIP",
							"price": 1211.5,
							"minimum": 1,
							"available": 2
						}
					],
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "",
					"serviceType": "PaxType",
					"timeOfDay": "AM",
					"startTime": "10:00",
					"availableSeats": 4,
					"minimumSeats": 1,
					"rateKey": "TUEyMTEwMDAwMzcz",
					"durationText": "4 hours",
					"duration": "8",
					"zoneId": "MA21110048",
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
			"header": "success",
			"description": ""
		}
	}
}
	''';
}
