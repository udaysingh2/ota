import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_detail/repositories/tour_booking_details_repository_impl.dart';

/// Interface for TourDetail use cases.
abstract class TourBookingDetailUseCases {
  Future<Either<Failure, TourBookingDetailModelDomain>?> getBookingTourDetail(
      TourBookingDetailArgumentDomain argument);
}

class TourBookingDetailUseCasesImpl implements TourBookingDetailUseCases {
  TourBookingDetailRepository? tourBookingDetailRepository;

  /// Dependence injection via constructor
  TourBookingDetailUseCasesImpl({TourBookingDetailRepository? repository}) {
    if (repository == null) {
      tourBookingDetailRepository = TourBookingDetailRepositoryImpl();
    } else {
      tourBookingDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TourBookingDetailModelDomain>?> getBookingTourDetail(
      TourBookingDetailArgumentDomain argument) async {
    return await tourBookingDetailRepository?.getTourBookingDetail(argument);
  }
}
