import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_argument_domain.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_model_domain.dart';
import 'package:ota/domain/ota_booking_mailer/repositories/ota_booking_mailer_repository_impl.dart';

/// Interface for OtaDetail use cases.
abstract class OtaBookingMailerUseCases {
  Future<Either<Failure, OtaBookingMailerModelDomain>?> sendBookingOtaMailer(
      OtaBookingMailerArgumentDomain argument);
}

class OtaBookingMailerUseCasesImpl implements OtaBookingMailerUseCases {
  OtaBookingMailerRepository? otaBookingMailerRepository;

  /// Dependence injection via constructor
  OtaBookingMailerUseCasesImpl({OtaBookingMailerRepository? repository}) {
    if (repository == null) {
      otaBookingMailerRepository = OtaBookingMailerRepositoryImpl();
    } else {
      otaBookingMailerRepository = repository;
    }
  }

  @override
  Future<Either<Failure, OtaBookingMailerModelDomain>?> sendBookingOtaMailer(
      OtaBookingMailerArgumentDomain argument) async {
    return await otaBookingMailerRepository?.sendOtaBookingMailer(argument);
  }
}
