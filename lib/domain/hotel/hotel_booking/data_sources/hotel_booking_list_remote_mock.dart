import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';

import 'hotel_booking_list_remote_data_source.dart';

class HotelBookingListMockDataSourceImpl
    implements HotelBookingListRemoteDataSource {
  HotelBookingListMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<HotelBookingListModelDomain> getHotelBookingListData(
      HotelBookingArgumentDomain domain) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelBookingListModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
  "getBookingSummaryV2": {
    "data": {
      "totalPageNumber": 3,
      "bookingDetails": [
        {
          "serviceType": "HOTEL",
          "sortDateTime": "2022-08-01 00:00",
          "sortPriority": 1,
          "hotel": {
            "name": "Phuket Graceland Resort and Spa",
            "totalPrice": 1958.24,
            "checkInDate": "2022-08-01",
            "checkOutDate": "2022-08-02",
            "bookingUrn": "H220429-AA-0012",
            "status": "CANCELLED",
            "bookingId": null,
            "paymentStatus": "FAILED",
            "activityStatus": "PAYMENT_FAILED"
          }
        },
        {
          "serviceType": "HOTEL",
          "sortDateTime": "2022-08-01 00:00",
          "sortPriority": 1,
          "hotel": {
            "name": "Sunsuri Phuket",
            "totalPrice": 2693.79,
            "checkInDate": "2022-08-01",
            "checkOutDate": "2022-08-02",
            "bookingUrn": "H220429-AA-0014",
            "status": "CANCELLED",
            "bookingId": null,
            "paymentStatus": "FAILED",
            "activityStatus": "PAYMENT_FAILED"
          }
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
