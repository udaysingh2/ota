import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/use_cases/car_booking_mailer_use_cases.dart';

class CarBookingMailerUseCasesSuccessMock extends CarBookingMailerUseCases {
  @override
  Future<Either<Failure, CarBookingMailerModelDomain>?> sendBookingCarMailer(
      CarBookingMailerArgumentDomain argument) async {
    return Right(CarBookingMailerModelDomain(
        sendEmailConfirmation: SendEmailConfirmation(
            data: Data(actionStatus: ""), status: Status())));
  }
}
