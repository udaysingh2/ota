import 'package:ota/domain/hotel/hotel_booking_mailer/data_sources/hotel_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';

class HotelBookingMailerMockDataSourceImpl
    implements HotelBookingMailerRemoteDataSource {
  HotelBookingMailerMockDataSourceImpl();
  @override
  Future<HotelBookingMailerModelDomain> sendHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelBookingMailerModelDomain.fromJson(_responseMock);
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
