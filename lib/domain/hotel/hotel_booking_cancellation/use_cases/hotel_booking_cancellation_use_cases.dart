import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/repositories/hotel_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

abstract class HotelBookingCancellationUseCases {
  Future<Either<Failure, HotelBookingCancellationModelDomain>?>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument);
}

class HotelBookingCancellationUseCasesImpl
    implements HotelBookingCancellationUseCases {
  HotelBookingCancellationRepository? hotelBookingCancellationRepository;

  HotelBookingCancellationUseCasesImpl(
      {HotelBookingCancellationRepository? repository}) {
    if (repository == null) {
      hotelBookingCancellationRepository =
          HotelBookingCancellationRepositoryImpl();
    } else {
      hotelBookingCancellationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, HotelBookingCancellationModelDomain>?>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument) async {
    return await hotelBookingCancellationRepository
        ?.getHotelBookingCancellationData(argument);
  }
}
