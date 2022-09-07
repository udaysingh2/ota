import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';

import 'booking_list_remote_data_source.dart';

class BookingListMockDataSourceImpl implements BookingListRemoteDataSource {
  BookingListMockDataSourceImpl();

  static String getMockData(String serviceType) {
    switch (serviceType) {
      case OtaServiceType.hotel:
        return _responseMockHotel;
      case OtaServiceType.tour:
        return _responseMockTour;
      case OtaServiceType.carRental:
        return _responseMockCar;
      case OtaServiceType.flight:
        return _responseMockFlight;
      default:
        return _responseMockHotel;
    }
  }

  @override
  Future<BookingListModelDomain> getBookingListData(
      BookingArgumentDomain domain) async {
    await Future.delayed(const Duration(seconds: 1));
    switch (domain.serviceType) {
      case OtaServiceType.hotel:
        return BookingListModelDomain.fromJson(_responseMockHotel);
      case OtaServiceType.tour:
        return BookingListModelDomain.fromJson(_responseMockTour);
      case OtaServiceType.carRental:
        return BookingListModelDomain.fromJson(_responseMockCar);
      case OtaServiceType.flight:
        return BookingListModelDomain.fromJson(_responseMockFlight);
      default:
        return BookingListModelDomain.fromJson(_responseMockHotel);
    }
  }
}

String _responseMockHotel = ''' {
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

String _responseMockFlight = ''' {
 	"getBookingSummaryV2": {
 		"data": {
 			"totalPageNumber": 1,
 			"bookingDetails": [{
 				"serviceType": "FLIGHT",
 				"sortDateTime": "2022-05-03T11:00:00",
 				"sortPriority": 4,
 				"hotel": null,
 				"tour": null,
 				"car": null,
 				"flight": {
 					"reservationId": "aaaaa",
 					"bookingUrn": "aaa-bbb-ccc",
 					"bookingStatus": "Confirmed",
 					"activityStatus": "AWAITING_RESERVATION",
 					"totalAmount": 100,
 					"journeyType": 1,
 					"departureDetails": {
 						"arrCode": "CNX",
 						"depCode": "HKT",
 						"depDate": "2022-04-01",
 						"arrDate": "2022-04-05",
 						"numOfStops": 0,
 						"airwaysCode": "PG",
 						"routeInfo": [{
 							"airwaysName": "Bangkok Airways",
 							"flightLogo": "URL",
 							"depDate": "2022-04-01",
 							"arrDate": "2022-04-05"
 						}]
 					},
 					"returnDetails": {
 						"arrCode": "CNX",
 						"depCode": "HKT",
 						"depDate": "2022-04-01",
 						"arrDate": "2022-04-05",
 						"numOfStops": 0,
 						"airwaysCode": "BGA",
 						"routeInfo": [{
 							"airwaysName": "Bangkok Airways",
 							"flightLogo": "URL",
 							"depDate": "2022-04-01",
 							"arrDate": "2022-04-05"
 						}]
 					}
 				}
 			}]
 		},
 		"status": {
 			"code": "1000",
 			"header": "Success",
 			"description": null
 		}
 	}
 }''';

String _responseMockCar = '''{
	"getBookingSummaryV2": {
		"data": {
			"totalPageNumber": 3,
			"bookingDetails": [{
					"serviceType": "CARRENTAL",
					"sortDateTime": "2022-05-03T11:00:00",
					"sortPriority": 3,
					"hotel": null,
					"tour": null,
					"car": {
						"name": "MG ZS",
						"totalPrice": 2800,
						"supplierName": "ILO Supplier by Cindy",
						"bookingUrn": "C220501-AA-0012",
						"status": "Completed",
						"bookingSummaryStatus": "COMPLETED",
						"pickupDateTime": "2022-05-03T11:00:00",
						"returnDateTime": "2022-05-04T11:00:00",
						"bookingId": "B2CMMA220522297"
					},
					"flight": null
				},
				{
					"serviceType": "CARRENTAL",
					"sortDateTime": "2022-05-04T11:00:00",
					"sortPriority": 3,
					"hotel": null,
					"tour": null,
					"car": {
						"name": "เอ็มจี ซีเอส",
						"totalPrice": 2800,
						"supplierName": "ILO Supplier by Cindy",
						"bookingUrn": "C220502-AA-0013",
						"status": "จองสำเร็จ",
						"bookingSummaryStatus": "CONFIRMED",
						"pickupDateTime": "2022-05-04T11:00:00",
						"returnDateTime": "2022-05-05T11:00:00",
						"bookingId": "B2CMMA220522341"
					},
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

String _responseMockTour = '''{
	"getBookingSummaryV2": {
		"data": {
			"totalPageNumber": 3,
			"bookingDetails": [{
					"serviceType": "TOUR",
					"sortDateTime": "2022-03-10 00:00",
					"sortPriority": 2,
					"hotel": null,
					"tour": {
						"subServiceType": "TOUR",
						"name": "Wat Arun",
						"totalPrice": 1958.24,
						"startTimeAMPM": "09:00 AM",
						"bookingUrn": "TR220309-AA-0001",
						"status": "CONFIRMED",
						"bookingDate": "2022-03-10",
						"bookingId": "B2CMMA220315530",
						"paymentStatus": "CONFIRMED",
						"activityStatus": "CONFIRMED"
					},
					"car": null,
					"flight": null
				},
				{
					"serviceType": "TOUR",
					"sortDateTime": "2022-08-01 00:00",
					"sortPriority": 2,
					"hotel": null,
					"tour": {
						"subServiceType": "TICKET",
						"name": "Wat Arun",
						"totalPrice": 1958.24,
						"startTimeAMPM": "09:00 AM",
						"bookingUrn": "TT220302-AA-0005",
						"status": "CONFIRMED",
						"bookingDate": "2022-03-10",
						"bookingId": "B2CMMA220311171",
						"paymentStatus": "CONFIRMED",
						"activityStatus": "CONFIRMED"
					},
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
