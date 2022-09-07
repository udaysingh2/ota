import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/repositories/tour_booking_cancellation_repository_impl.dart';

/// Interface for TourDetail use cases.
abstract class TourBookingCancellationUseCases {
  Future<Either<Failure, TourBookingDetailCancellationDomain>?>
      getTourCancellationDetail(TourBookingCancellationArgumentDomain argument);
}

class TourBookingCancellationUseCasesImpl
    implements TourBookingCancellationUseCases {
  TourBookingCancellationRepository? tourBookingCancellationRepository;

  /// Dependence injection via constructor
  TourBookingCancellationUseCasesImpl(
      {TourBookingCancellationRepository? repository}) {
    if (repository == null) {
      tourBookingCancellationRepository =
          TourBookingCancellationRepositoryImpl();
    } else {
      tourBookingCancellationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TourBookingDetailCancellationDomain>?>
      getTourCancellationDetail(
          TourBookingCancellationArgumentDomain argument) async {
    return await tourBookingCancellationRepository
        ?.getTourCancellationDetail(argument);
  }
}
