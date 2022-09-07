import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tour_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';

class TourBookingCancellationMockDataSourceImpl
    implements TourBookingCancellationRemoteDataSource {
  TourBookingCancellationMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<TourBookingDetailCancellationDomain> getTourCancellationDetail(
      TourBookingCancellationArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TourBookingDetailCancellationDomain.fromJson(_responseMock);
  }
}

var _responseMock = """
{
	"getTourBookingReject": {
		"data": {
			"actionStatus": "success",
			"cancellationDate": null,
			"totalAmount": null,
			"refund": null
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
""";
