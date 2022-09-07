import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

class CarBookingCancellationMockDataSourceImpl
    implements CarBookingCancellationRemoteDataSource {
  CarBookingCancellationMockDataSourceImpl();

  @override
  Future<CarBookingCancellationModelDomain> getCarBookingCancellationData(
      CarBookingCancellationArgument argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarBookingCancellationModelDomain.fromJson(_responseMock);
  }

  static String getMockData() {
    return _responseMock;
  }
}

var _responseMock = '''
{
    "status": {
        "code": "1000",
        "header": "Success"
    },
    "data": {
        "actionStatus": "success",
        "cancellationDate": "2022-04-11",
        "totalAmount": 0.0,
        "refund": {
            "reservationCancellationFee": 0.0,
            "processingFee": 0.0,
            "refundAmount": 0.0
        }
    }
}
''';
