import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/use_cases/hotel_booking_mailer_use_cases.dart';

class HotelBookingMailerUseCasesSuccessMock extends HotelBookingMailerUseCases {
  @override
  Future<Either<Failure, HotelBookingMailerModelDomain>?>
      sendBookingHotelMailer(HotelBookingMailerArgumentDomain argument) async {
    return Right(HotelBookingMailerModelDomain(
        sendEmailConfirmation: SendEmailConfirmation(
            data: Data(actionStatus: ""), status: Status())));
  }
}
