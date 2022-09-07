import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/use_cases/hotel_booking_cancellation_use_cases.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

class HotelBookingCancellationSuccessMock
    extends HotelBookingCancellationUseCases {
  @override
  Future<Either<Failure, HotelBookingCancellationModelDomain>?>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument) async {
    return Right(
      HotelBookingCancellationModelDomain(
        data: HotelBookingCancellationDataDomain(
          totalAmount: 1000.0,
          actionStatus: 'CANCELLED',
          cancellationDate: Helpers().parseDateTime('06-05-2022'),
          refund: Refund(
            processingFee: 100.0,
            reservationCancellationFee: 100.0,
            refundAmount: 800.0,
          ),
        ),
      ),
    );
  }
}

class HotelBookingCancellationDataNullMock
    extends HotelBookingCancellationUseCases {
  @override
  Future<Either<Failure, HotelBookingCancellationModelDomain>?>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument) async {
    return Right(
      HotelBookingCancellationModelDomain(
        data: null,
      ),
    );
  }
}

class HotelBookingCancellationFailureMock
    extends HotelBookingCancellationUseCases {
  @override
  Future<Either<Failure, HotelBookingCancellationModelDomain>?>
      getHotelBookingCancellationData(
          HotelBookingCancellationArgument argument) async {
    return Left(
      InternetFailure(),
    );
  }
}
