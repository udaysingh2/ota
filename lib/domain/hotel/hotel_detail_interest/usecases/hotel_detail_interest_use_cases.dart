import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/repositories/hotel_detail_interest_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class HotelDetailInterestUseCases {
  Future<Either<Failure, HotelDetailInterestData>?> getHotelDetailInterest(
      HotelDetailInterestDataArgument argument);
}

class HotelDetailInterestUseCasesImpl implements HotelDetailInterestUseCases {
  HotelDetailInterestRepository? hotelBookingMailerRepository;

  /// Dependence injection via constructor
  HotelDetailInterestUseCasesImpl({HotelDetailInterestRepository? repository}) {
    if (repository == null) {
      hotelBookingMailerRepository = HotelDetailInterestRepositoryImpl();
    } else {
      hotelBookingMailerRepository = repository;
    }
  }

  @override
  Future<Either<Failure, HotelDetailInterestData>?> getHotelDetailInterest(
      HotelDetailInterestDataArgument argument) async {
    return await hotelBookingMailerRepository?.getDetailInterest(argument);
  }
}
