import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_argument_domain.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';
import 'package:ota/domain/tours/review_reservation/repositories/tours_review_reservation_repository_impl.dart';

/// Interface for ToursReviewReservation use cases.
abstract class TourReviewReservationUseCases {
  Future<Either<Failure, TourReviewReservation>?> getToursReviewReservationData(
      TourReviewReservationArgumentDomain argument);
}

class TourReviewReservationUseCasesImpl
    implements TourReviewReservationUseCases {
  ToursReviewReservationRepository? tourReviewReservationRepository;

  /// Dependence injection via constructor
  TourReviewReservationUseCasesImpl(
      {ToursReviewReservationRepository? repository}) {
    if (repository == null) {
      tourReviewReservationRepository = ToursReviewReservationRepositoryImpl();
    } else {
      tourReviewReservationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TourReviewReservation>?> getToursReviewReservationData(
      TourReviewReservationArgumentDomain argument) async {
    return await tourReviewReservationRepository
        ?.getTourReviewReservationData(argument);
  }
}
