import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/domain/confirm_booking/usecases/hotel_confirm_booking_usecases.dart';

class HotelConfirmBookingUseCasesImplNullMock
    extends HotelConfirmBookingUseCases {
  @override
  Future<Either<Failure, BookingConfirmationData>?> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    return Right(BookingConfirmationData(data: null, status: null));
  }
}
