import 'package:ota/domain/tours/review_reservation/data_sources/tours_review_reservation_remote_data_source.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_argument_domain.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';

class TourReviewReservationMockDataSourceImpl
    implements TourReviewReservationRemoteDataSource {
  TourReviewReservationMockDataSourceImpl();
  @override
  Future<TourReviewReservation> getTourReviewReservationData(
      TourReviewReservationArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TourReviewReservation.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
	"getTourBookingInitiate": {
		"data": {
			"bookingUrn": "TR220103-AA-0024",
			"tourName": "Dog Cafe 112(April Tour)",
			"tourImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
			"promotionList": [{

				"productType": "ACTIVITY",
				"promotionCode": "FREEDELIVERY",
				"title": "Free Food Delivery",
				"description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
				"web": "https://cms.robinhood.in.th/archives/2869"
			}],
			"tourDetails": {
				"id": "MA2111000068",
				"name": "Dog Cafe 112(April Tour)",
				"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dog-cafe-112.jpg",
				"category": "Nightlife",
				"location": "Larn Luang,Cha-am, Phetchaburi",
				"information": {
					"description": "Welcome to Dog Cafe 112",
					"conditions": "",
					"howToUse": "",
					"providerName": "April Tour",
					"openTime": "08:00",
					"closeTime": "18:00"
				},
				"packages": [{
					"name": "Dog Cafe 112 SIC",
					"options": "Dog Cafe 112 SIC",
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
								"value": null
							}
						],
						"all": ""
					},
					"exclusions": "",
					"schedule": "",
					"meetingPoint": "",
					"conditions": "",
					"cancellationPolicy": "",
					"shuttle": "",
					"adultPrice": 200,
					"childPrice": 100,
					"adultPaxId": "MA01010001",
					"childPaxId": "MA01010002",
					"childInfo": {
						"minAge": 0,
						"maxAge": 0
					},
					"currency": "THB",
					"refCode": "CL213",
					"serviceId": "MA21110100",
					"rateKey": "TUEyMTEyMDAwMDAz",
					"availableSeats": 200,
					"minimumSeats": 2,
					"serviceType": "SIC",
					"durationText": "",
					"duration": "0",
					"zoneId": "MA21110009",
					"requireInfo": {
						"weight": false,
						"allName": false,
						"guestName": false,
						"passportId": false,
						"dateOfBirth": false,
						"passportCountry": false,
						"passportValidDate": false,
						"passportCountryIssue": false
					}
				}]
			}
		},
		"status": {
			"code": "1000",
			"header": "Success"
		}
	}
}
	''';
