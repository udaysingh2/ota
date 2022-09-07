import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/repositories/reservation_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class ReservationRoomUseCase {
  Future<Either<Failure, BookingData?>?> getRoomDetail(
      ReservationDataArgument argument);
}

class ReservationRoomUseCasesImpl implements ReservationRoomUseCase {
  ReservationRepository? roomDetailRepository;

  /// Dependence injection via constructor
  ReservationRoomUseCasesImpl({ReservationRepository? repository}) {
    if (repository == null) {
      roomDetailRepository = ReservationRepositoryImpl();
    } else {
      roomDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, BookingData?>?> getRoomDetail(
      ReservationDataArgument argument) async {
    return await roomDetailRepository?.getRoomDetail(argument);
  }
}
