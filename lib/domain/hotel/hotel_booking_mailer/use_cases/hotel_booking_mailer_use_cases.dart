import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/repositories/hotel_booking_mailer_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class HotelBookingMailerUseCases {
  Future<Either<Failure, HotelBookingMailerModelDomain>?>
      sendBookingHotelMailer(HotelBookingMailerArgumentDomain argument);
}

class HotelBookingMailerUseCasesImpl implements HotelBookingMailerUseCases {
  HotelBookingMailerRepository? hotelBookingMailerRepository;

  /// Dependence injection via constructor
  HotelBookingMailerUseCasesImpl({HotelBookingMailerRepository? repository}) {
    if (repository == null) {
      hotelBookingMailerRepository = HotelBookingMailerRepositoryImpl();
    } else {
      hotelBookingMailerRepository = repository;
    }
  }

  @override
  Future<Either<Failure, HotelBookingMailerModelDomain>?>
      sendBookingHotelMailer(HotelBookingMailerArgumentDomain argument) async {
    return await hotelBookingMailerRepository?.sendHotelBookingMailer(argument);
  }
}
