import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';

class QueriesCarBookingMailer {
  static String sendCarBookingMailer(CarBookingMailerArgumentDomain argument) {
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
