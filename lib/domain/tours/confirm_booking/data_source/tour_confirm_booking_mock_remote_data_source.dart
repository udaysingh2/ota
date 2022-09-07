import 'package:ota/domain/tours/confirm_booking/data_source/tour_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';

class TourConfirmBookingMockDataSourceImpl
    implements TourConfirmBookingRemoteDataSource {
  TourConfirmBookingMockDataSourceImpl();

  @override
  Future<TourConfirmBookingModelDomain> getTourConfirmBookingData(
      ConfirmBookingArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TourConfirmBookingModelDomain.fromJson(_responseMock);
  }
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
