import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/repositories/hotel_booking_list_repository_impl.dart';

/// Interface for HotelBookingList use cases.
abstract class HotelBookingListUseCases {
  /// Call API to get the HotelBookingList Screen details.
  ///
  /// [userId] to get the HotelBookingList Data for users.
  /// [Either<Failure, HotelBookingListModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, HotelBookingListModelDomain>?> getHotelBookingListData(
      HotelBookingArgumentDomain argument);
}

/// HotelBookingListUseCasesImpl will contain the HotelBookingListUseCases implementation.
class HotelBookingListUseCasesImpl implements HotelBookingListUseCases {
  HotelBookingListRepository? hotelBookingListRepository;

  /// Dependence injection via constructor
  HotelBookingListUseCasesImpl({HotelBookingListRepository? repository}) {
    if (repository == null) {
      hotelBookingListRepository = HotelBookingListRepositoryImpl();
    } else {
      hotelBookingListRepository = repository;
    }
  }

  /// Call API to get the HotelBookingList Screen Details details.
  ///
  /// [userId] to get the HotelBookingList Data for users.
  /// [Either<Failure, HotelBookingListModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, HotelBookingListModelDomain>?> getHotelBookingListData(
      HotelBookingArgumentDomain argument) async {
    return await hotelBookingListRepository?.getHotelBookingListData(argument);
  }
}
