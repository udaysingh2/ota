import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_details_argument_model.dart';
import 'package:ota/domain/hotel/hotel_booking_details/repositories/hotel_booking_detail_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class HotelBookingDetailUseCases {
  Future<Either<Failure, HotelBookingDetailModelDomain>?> getBookingHotelDetail(
      HotelBookingDetailArgumentDomain argument);
}

class HotelBookingDetailUseCasesImpl implements HotelBookingDetailUseCases {
  HotelBookingDetailRepository? hotelBookingDetailRepository;

  /// Dependence injection via constructor
  HotelBookingDetailUseCasesImpl({HotelBookingDetailRepository? repository}) {
    if (repository == null) {
      hotelBookingDetailRepository = HotelBookingDetailRepositoryImpl();
    } else {
      hotelBookingDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, HotelBookingDetailModelDomain>?> getBookingHotelDetail(
      HotelBookingDetailArgumentDomain argument) async {
    return await hotelBookingDetailRepository?.getHotelBookingDetail(argument);
  }
}
