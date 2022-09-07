import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/usecases/booking_list_use_cases.dart';

class BookingUseCasesImplSuccessMock extends BookingListUseCasesImpl {
  @override
  Future<Either<Failure, BookingListModelDomain>?> getBookingListData(
      BookingArgumentDomain argument) async {
    return Right(BookingListModelDomain(
        getBookingSummaryV2: GetBookingSummaryV2(
      data: Data(
        totalPageNumber: 10,
        bookingDetails: [],
      ),
      status: Status(),
    )));
  }
}

class BookingUseCasesImplNullMock extends BookingListUseCasesImpl {
  @override
  Future<Either<Failure, BookingListModelDomain>?> getBookingListData(
      BookingArgumentDomain argument) async {
    return Right(BookingListModelDomain(
        getBookingSummaryV2: GetBookingSummaryV2(
      data: Data(
        totalPageNumber: 10,
        bookingDetails: null,
      ),
      status: Status(),
    )));
  }
}
