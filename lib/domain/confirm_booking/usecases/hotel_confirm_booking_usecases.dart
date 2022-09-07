import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/domain/confirm_booking/repositories/hotel_confirm_booking_repository_impl.dart';

/// Interface for HotelConfirmBooking use cases.
abstract class HotelConfirmBookingUseCases {
  Future<Either<Failure, BookingConfirmationData>?> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument);
}

class HotelConfirmBookingUseCasesImpl implements HotelConfirmBookingUseCases {
  HotelConfirmBookingRepository? hotelConfirmBookingRepository;

  /// Dependence injection via constructor
  HotelConfirmBookingUseCasesImpl({HotelConfirmBookingRepository? repository}) {
    if (repository == null) {
      hotelConfirmBookingRepository = HotelConfirmBookingRepositoryImpl();
    } else {
      hotelConfirmBookingRepository = repository;
    }
  }

  @override
  Future<Either<Failure, BookingConfirmationData>?> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    return await hotelConfirmBookingRepository
        ?.getHotelConfirmBooking(argument);
  }
}
