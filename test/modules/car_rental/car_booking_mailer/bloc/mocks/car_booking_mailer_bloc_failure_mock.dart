import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/use_cases/car_booking_mailer_use_cases.dart';

class CarBookingMailerUseCasesFailureMock extends CarBookingMailerUseCases {
  @override
  Future<Either<Failure, CarBookingMailerModelDomain>?> sendBookingCarMailer(
      CarBookingMailerArgumentDomain argument) async {
    return Left(InternetFailure());
  }
}
