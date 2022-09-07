import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';

class QueriesHotelBookingMailer {
  static String sendtHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument) {
    return '''mutation {
        sendEmailConfirmation(
          initiateEmailConfirmationRequest:
          {
            confirmNo: "${argument.confirmNo}",
            mail: "${argument.mailId}",
            serviceName: "${argument.serviceName}"
          }
        )
        {
          data {
            actionStatus
          }
          status {
            code
            header
            description
          }
        }
      }''';
  }
}
