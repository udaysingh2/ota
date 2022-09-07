import '../models/car_payment_argument_model.dart';
import '../models/car_payment_model_domain.dart';
import 'car_payment_remote_data_source.dart';

class CarPaymentMockDataSourceImpl implements CarPaymentRemoteDataSource {
  CarPaymentMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<CarPaymentDomainModelData> getCarPaymentData(
      CarPaymentDomainArgumentModel argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarPaymentDomainModelData.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
		"saveCarBookingConfirmationDetails": {
			"status": {
				"code": "1000",
				"header": "Success"
			},
			"data": {
				"bookingUrn": "C220406-AA-0006",
				"pricePerDay": "699.0",
				"carRentalTotalPrice": 1699.0,
				"extrasOnlinePrice": 1000.0,
				"extrasOfflinePrice": 220.0,
				"returnExtraCharge": 0.0,
				"addOnServices": [{
					"serviceId": "13",
					"name": "string",
					"price": "1000",
					"isCompulsory": true,
					"chargeType": "string",
					"quantity": 0,
					"description": "string"
				}],
				"cancellationPolicy": [{
					"cancelDays": 999,
					"description": "<p>No Show - Non Refundable</p>",
					"message": "The policy of this product is non-refundable, After the reservation has been made and if any require of cancel booking, there will be no refund."
				}],
				"currency": "THB",
				 "isNonRefund": "Non Refundable"

			}
		}
}
''';
