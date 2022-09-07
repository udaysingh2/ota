import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/repositories/car_booking_detail_repository_impl.dart';

abstract class CarBookingDetailUseCases {
  /// Call API to get the Car booking detail result Data.
  ///
  /// [Either<Failure, CarBookingDetailDomainModel>] to handle the Failure or result data.
  Future<Either<Failure, CarBookingDetailDomainModel>?>
      getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  });
}

/// CarBookingDetailUseCasesImpl will contain the CarBookingDetailUseCases implementation.
class CarBookingDetailUseCasesImpl implements CarBookingDetailUseCases {
  CarBookingDetailRepository? carBookingDetailRepository;

  /// Dependence injection via constructor
  CarBookingDetailUseCasesImpl({CarBookingDetailRepository? repository}) {
    if (repository == null) {
      carBookingDetailRepository = CarBookingDetailRepositoryImpl();
    } else {
      carBookingDetailRepository = repository;
    }
  }

  /// Call API to get the Car booking detail result Data.
  ///
  /// [Either<Failure, CarBookingDetailDomainModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarBookingDetailDomainModel>?>
      getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  }) async {
    return await carBookingDetailRepository?.getCarBookingDetailData(
      bookingId: bookingId,
      bookingUrn: bookingUrn,
      bookingType: bookingType,
    );
  }
}
