import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';

import 'car_booking_mailer_remote_data_source.dart';

class CarBookingMailerMockDataSourceImpl
    implements CarBookingMailerRemoteDataSource {
  CarBookingMailerMockDataSourceImpl();
  @override
  Future<CarBookingMailerModelDomain> sendCarBookingMailer(
      CarBookingMailerArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarBookingMailerModelDomain.fromJson(_responseMock);
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
