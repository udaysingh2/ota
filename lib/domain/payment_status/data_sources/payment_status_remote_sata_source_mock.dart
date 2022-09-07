import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';

class PaymentStatusMockDataSourceImpl implements PaymentStatusRemoteDataSource {
  PaymentStatusMockDataSourceImpl();
  @override
  Future<PaymentStatusModelDomain> getPaymentStatus(String bookingUrn) async {
    await Future.delayed(const Duration(seconds: 1));
    return PaymentStatusModelDomain.fromJson(_responseMock);
  }

  @override
  Future<PaymentNewBookingUrnModelDomain> getNewBookingUrn(
      String bookingUrn) async {
    await Future.delayed(const Duration(seconds: 1));
    return PaymentNewBookingUrnModelDomain.fromJson(_responseMockNewBookingUrn);
  }

  static String getMockData() {
    return _responsePaymentInitiateV2;
  }

  static String getMockDataForPaymentStatus() {
    return _responseMock;
  }

  static String getMockDataForNewBookingUrn() {
    return _responseMockNewBookingUrn;
  }

  @override
  Future<PaymentNewCarBookingUrnModelDomain> getNewCarBookingUrn(
      String bookingUrn) async {
    await Future.delayed(const Duration(seconds: 1));
    return PaymentNewCarBookingUrnModelDomain.fromJson(
        _responseMockNewCarBookingUrn);
  }

  @override
  Future<PaymentInitiateNewModelDomain> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return PaymentInitiateNewModelDomain.fromJson(_responsePaymentInitiateV2);
  }
}

var _responseMock = '''{
    "paymentStatus": {
      "data": {
        "paymentMethod": "CARD",
        "paymentStatus": "SUCCESS",
        "paymentPhase": "TRANSACTION_INFO",
        "phaseState": "COMPLETED",
        "deeplinkUrl": null,
        "callbackUrl": null,
        "errorDescription": null,
        "isFirstOrder":true
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
}''';

var _responseMockNewBookingUrn = '''{
	"generateNewBookingUrn": {
		"data": {
			"newBookingUrn": "H20211013AA0067"
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": "Success"
		}
	}
}

''';
var _responseMockNewCarBookingUrn = '''{
	"generateNewCarBookingUrn": {
		"data": {
			"newBookingUrn": "H20211013AA0067"
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": "Success"
		}
	}
}

''';
var _responsePaymentInitiateV2 = '''
{
    "initiatePaymentV2": {
        "data": {
            "bookingUrn": "H20211020AA0171"
        },
        "status": {
            "code": "1000",
            "header": "Success",
            "description": "Success"
        }
    }
}
''';
