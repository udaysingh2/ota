import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';

class TicketBookingCancellationMockDataSourceImpl
    implements TicketBookingCancellationRemoteDataSource {
  TicketBookingCancellationMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<TicketBookingDetailCancellationDomain> getTicketCancellationDetail(
      TicketBookingCancellationArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return TicketBookingDetailCancellationDomain.fromJson(_responseMock);
  }
}

var _responseMock = """
{
	"getTicketBookingReject": {
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
