import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';

class ReservationMockDataSourceImpl implements ReservationDataSource {
  ReservationMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<BookingData> getRoomDetail(ReservationDataArgument argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return BookingData.fromJson(_responseMock);
  }
}

var _responseMock = '''{
"initiateBookingV2" : {
	"status": {
		"code": "1000",
		"header": "Success"
	},
	"data": {
		"hotelName": "String",
		"hotelImage": "String",
		"bookingUrn": "String",
		"roomDetails": {
			"rateKey": "String",
			"supplier": "String",
			"mealType": "String",
			"roomImage": "String",
			"roomCategories": [{
				"roomName": "DELUXE BALCONY ROOM",
				"roomType": "Double",
				"noOfRooms": 1
			}],
			"facilities": [{
					"key": "WIFI",
					"value": "free.wifi"
				},
				{
					"key": "BREAKFAST",
					"value": null
				},
				{
					"key": "PAYMENT",
					"value": "instant.payment"
				}
			],
			"cancellationPolicy": [{
				"days": 1,
				"cancellationDaysDescription": "String",
				"cancellationChargeDescription": "String",
				"cancellationStatus": "String"
			}],
			"totalPrice": 13,
			"perNightPrice": 10,
			"numberOfNights": "String"
		}
	}
	}
}''';
