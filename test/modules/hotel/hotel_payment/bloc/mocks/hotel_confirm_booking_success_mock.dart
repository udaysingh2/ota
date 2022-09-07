import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/domain/confirm_booking/usecases/hotel_confirm_booking_usecases.dart';

class HotelConfirmBookingUseCasesImplSuccessMock
    extends HotelConfirmBookingUseCases {
  @override
  Future<Either<Failure, BookingConfirmationData>?> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    return Right(BookingConfirmationData(
        data: Data(
          status: "",
          bookingForSomeoneElse: false,
          bookingUrn: "",
          currency: "",
          customerInfo: CustomerInfo(
            customerId: "",
            firstName: "",
            lastName: "",
            membershipId: "",
          ),
          guestInfo: [
            GuestInfo(
              lastName: "",
              firstName: "",
              title: "",
            )
          ],
          hotelBookingDetails: HotelBookingDetails(),
          locale: "",
          totalAmount: 20.0,
          totalDiscount: 10.0,
          totalFees: 4.0,
          totalTaxes: 5.0,
        ),
        status: Status(
          description: "",
          code: "",
          header: "",
        )));
  }
}
