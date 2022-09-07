import 'package:ota/domain/tickets/details/data_source/ticket_details_remote_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';

class TicketDetailsMockDataSourceImpl implements TicketDetailsRemoteDataSource {
  TicketDetailsMockDataSourceImpl();
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
}

var _responseMock = '''
{
		"getTicketDetails": {
			"data": {
				"ticket": {
					"id": "MA2110000413",
					"name": "(Place Profile / Place Name) (data/place/name)JJ Green Market Tour",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"location": "NONE-Bangkok",
					"category": "NONE",
					"information": {
						"description": "<span>(</span>Place Profile / <span>General ) (data/place/description)</span><div>Every weekend, thousands of tourists make their way up to this Northern Bangkok suburb to get lost in an enormous maze of shops at the Chatuchak Weekend Market. Home to almost 10,000 vendors, you’ll find everything from vintage sneakers to comic books and Thai handicrafts being sold here. You name it, Chatuchak probably sells it. The market is a great place to pick up souvenirs, but be sure to bargain for a good price. After a day of shopping and strolling around, the lush green lanes of Chatuchak Park are a welcome relief.</div>",
						"conditions": "<div><span>(</span><span>Place Profile / </span><span>Condition</span><span>)(</span><span>data/place/condition</span><span>)</span></div>Chatuchak Market has been open every weekend",
						"howToUse": "(Place Profile/ <span>How To Use)(data/place/howtouse)</span><div>Chatuchak Weekend Market is a big shopping area. Have many tings to see. If you go alone you may get lost. I come here very often so i will be the best guide for you8iy</div>",
						"providerName": "Hello We Sell Tour & Tour",
						"openTime": "10.00",
						"closeTime": "15.00"
					},
					"packages": [
						{
							"name": "(Activity Name) (data/activitys/activity/name)JJ Green Market Tour SIC 08.00",
							"options": "",
							"inclusions": {
								"highlights": [
									{
										"key": "tourTime",
										"value": "08.00 AM"
									},
									{
										"key": "tourType",
										"value": "SIC"
									},
									{
										"key": "guideLanguage",
										"value": "Thai"
									},
									{
										"key": "isNonRefund",
										"value": "true"
									}
								],
								"all": "<div>(Activity rate /Service Include)(data/activitys/tours/includeDescription)</div><ul class=fPmet><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>English speaking guide</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Chao Phraya Express Boat </span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Visit to the Flower Market and lotus folding</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Tuk-tuk ride in Bangkok</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Drinking water</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Streetfood dinner in Chinatown</span></li></ul>"
							},
							"exclusions": "<div>(Activity raten /Service  Exclude)(data/activitys/tours/excludeDescription)</div><ul class=fPmet><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Foot massage (30 minutes)</span></li></ul>",
							"conditions": "<div>(Activity rate /Condition)(data/activitys/tours/condition)</div><ul class=fPmet><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Confirmation will be received at time of booking</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Not wheelchair accessible</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Near public transportation</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Infants must sit on laps</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Most travelers can participate</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>This tour/activity will have a maximum of 15 travelers</span></li></ul>",
							"schedule": "<div><span>(Activity rate /</span><span>Itinerarys Description</span><span>)</span><br></div><ul><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Saphan Taksin, Yan Nawa, Sathon, Bangkok 10120, ThailandTour starts every day 6 PM at BTS Saphan Taksin station (Sky train) exit 2</span></li><li class=djRgg _d _c><span class=WlYyy diXIH dDKKM>Rambuttri Alley, Soi Rambuttri, Khwaeng Talat Yot, Khet Phra Nakhon, Krung Thep Maha Nakhon 10200, ThailandAfter this relaxing foot massage at Rambuttri Road, we finish the evening with a drink in one of the bars before the guide will assist you finding a taxi (taxi fee not included) back to your hotel.</span></li></ul>",
							"meetingPoint": "<div>(Activity rate /Meeting Point)(data/activitys/tours/meetingPoint)</div><p>Hotel Lobby</p>",
							"cancellationPolicy": "You have to cancel 10 day(s) prior to the service date., Otherwise 50 % cancellation charge for the entire stay will be applied.",
							"shuttle": "<div>(Activity rate /How To Use)(data/activitys/tours/howToUseDescription)</div><p>Pickup at Hotel Lobby</p>",
							"adultPrice": 900.13,
							"childPrice": 300.22,
							"childInfo": {
								"minAge": 3,
								"maxAge": 8
							},
							"currency": "THB",
							"refCode": "CL213",
							"serviceId": "",
							"rateKey": "TUEyMTEwMDAwMzcz",
							"availableSeats": 4,
							"minimumSeats": 1
						}
					]
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
