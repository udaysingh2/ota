import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/repositories/car_booking_mailer_repository_impl.dart';

/// Interface for CarDetail use cases.
abstract class CarBookingMailerUseCases {
  Future<Either<Failure, CarBookingMailerModelDomain>?> sendBookingCarMailer(
      CarBookingMailerArgumentDomain argument);
}

class CarBookingMailerUseCasesImpl implements CarBookingMailerUseCases {
  CarBookingMailerRepository? carBookingMailerRepository;

  /// Dependence injection via constructor
  CarBookingMailerUseCasesImpl({CarBookingMailerRepository? repository}) {
    if (repository == null) {
      carBookingMailerRepository = CarBookingMailerRepositoryImpl();
    } else {
      carBookingMailerRepository = repository;
    }
  }

  @override
  Future<Either<Failure, CarBookingMailerModelDomain>?> sendBookingCarMailer(
      CarBookingMailerArgumentDomain argument) async {
    return await carBookingMailerRepository?.sendCarBookingMailer(argument);
  }
}
