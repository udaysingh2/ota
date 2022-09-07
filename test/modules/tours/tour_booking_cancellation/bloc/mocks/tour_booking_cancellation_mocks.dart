import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/common/network/failures.dart';
import 'package:either_dart/src/either.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/use_cases/tour_booking_cancellation_usecases.dart';

class TourBookingCancellationSuccessMock
    extends TourBookingCancellationUseCases {
  @override
  Future<Either<Failure, TourBookingDetailCancellationDomain>?>
      getTourCancellationDetail(
          TourBookingCancellationArgumentDomain argument) async {
    return Right(
      TourBookingDetailCancellationDomain(
        getTourBookingReject: GetTourBookingReject(
          data: Data(
            totalAmount: 1000.0,
            actionStatus: 'success',
            cancellationDate: '06-05-2022',
            refund: Refund(
              processingFee: 100.0,
              reservationCancellationFee: 100.0,
              refundAmount: 800.0,
            ),
          ),
          status: Status(
            code: '1000',
            header: '',
          ),
        ),
      ),
    );
  }
}

class TourBookingCancellationDataNullMock
    extends TourBookingCancellationUseCases {
  @override
  Future<Either<Failure, TourBookingDetailCancellationDomain>?>
      getTourCancellationDetail(
          TourBookingCancellationArgumentDomain argument) async {
    return Right(
      TourBookingDetailCancellationDomain(getTourBookingReject: null),
    );
  }
}

class TourBookingCancellationFailureMock
    extends TourBookingCancellationUseCases {
  @override
  Future<Either<Failure, TourBookingDetailCancellationDomain>?>
      getTourCancellationDetail(
          TourBookingCancellationArgumentDomain argument) async {
    return Left(InternetFailure());
  }
}
