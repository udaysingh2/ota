import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';
import 'package:ota/domain/tours/confirm_booking/repositories/tour_confirm_booking_repository.dart';

/// Interface for ToursReviewReservation use cases.
abstract class TourConfirmBookingUseCases {
  Future<Either<Failure, TourConfirmBookingModelDomain>?>
      getTourConfirmBookingData(ConfirmBookingArgumentDomain argument);
}

class TourConfirmBookingUseCasesImpl implements TourConfirmBookingUseCases {
  ToursConfirmBookingRepository? toursConfirmBookingRepository;

  /// Dependence injection via constructor
  TourConfirmBookingUseCasesImpl({ToursConfirmBookingRepository? repository}) {
    if (repository == null) {
      toursConfirmBookingRepository = ToursConfirmBookingRepositoryImpl();
    } else {
      toursConfirmBookingRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TourConfirmBookingModelDomain>?>
      getTourConfirmBookingData(ConfirmBookingArgumentDomain argument) async {
    return await toursConfirmBookingRepository
        ?.getTourConfirmBookingData(argument);
  }
}
