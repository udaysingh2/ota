import 'package:ota/domain/ota_booking_mailer/data_sources/ota_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_argument_domain.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_model_domain.dart';

class OtaBookingMailerMockDataSourceImpl
    implements OtaBookingMailerRemoteDataSource {
  OtaBookingMailerMockDataSourceImpl();
  @override
  Future<OtaBookingMailerModelDomain> sendOtaBookingMailer(
      OtaBookingMailerArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return OtaBookingMailerModelDomain.fromJson(_responseMock);
  }

  static String getMockData() {
    return _responseMock;
  }
}

var _responseMock = """{
    "sendEmailConfirmation": {
      "data": {
        "actionStatus": "success"
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
  }""";
