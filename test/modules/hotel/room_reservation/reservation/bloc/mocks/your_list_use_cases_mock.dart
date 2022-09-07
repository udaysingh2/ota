import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/usecases/reservation_room_usecases.dart';

class YourListUseCasesSuccessMock extends ReservationRoomUseCase {
  @override
  Future<Either<Failure, BookingData?>?> getRoomDetail(
      ReservationDataArgument argument) async {
    return Right(
      BookingData(
        data: Data(
          hotelName: 'hotelName',
          bookingUrn: 'bookingUrn',
          hotelImage: 'hotelImage',
          roomDetails: RoomDetails(
            supplier: 'supplier',
            cancellationPolicy: [
              CancellationPolicy(),
            ],
            facilities: [
              Facility(),
            ],
            mealType: 'mealType',
            numberOfNights: 'numberOfNights',
            perNightPrice: 1000.0,
            rateKey: 'rateKey',
            roomCategories: [
              RoomCategory(
                roomType: '',
                roomName: '',
                noOfRooms: 1,
              ),
            ],
            roomImage: 'roomImage',
            totalPrice: 2000.0,
          ),
        ),
      ),
    );
  }
}

class YourListUseCasesFailureMock extends ReservationRoomUseCase {
  @override
  Future<Either<Failure, BookingData?>?> getRoomDetail(
      ReservationDataArgument argument) async {
    return Left(
      InternetFailure(),
    );
  }
}
