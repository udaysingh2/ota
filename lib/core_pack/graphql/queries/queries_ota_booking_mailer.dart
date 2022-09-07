import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_argument_domain.dart';

class QueriesOtaBookingMailer {
  static String sendBookingMailer(OtaBookingMailerArgumentDomain argument) {
    return '''
        mutation {
      otaSendEmailConfirmation(
        initiateEmailConfirmationRequest: 
        { 
         confirmNo: "${argument.confirmNo}",
         mail: "${argument.mailId}",
         bookingType: "${argument.bookingType}"
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
