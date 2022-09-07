import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

class HotelBookingCancellationMockDataSourceImpl
    implements HotelBookingCancellationRemoteDataSource {
  HotelBookingCancellationMockDataSourceImpl();

  @override
  Future<HotelBookingCancellationModelDomain> getHotelBookingCancellationData(
      HotelBookingCancellationArgument argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelBookingCancellationModelDomain.fromJson(_responseMock);
  }

  static String getMockData() {
    return _responseMock;
  }
}

var _responseMock = '''{
  "data": {
    "actionStatus": "success",
    "cancellationDate": "2021-12-01",
    "totalAmount": 2387.9,
    "refund": {
      "reservationCancellationFee": 112.3,
      "processingFee": 134.8,
      "refundAmount": 2140.8
    }
  },
  "status": {
    "code": "1000",
    "header": "success"
  }
}''';
