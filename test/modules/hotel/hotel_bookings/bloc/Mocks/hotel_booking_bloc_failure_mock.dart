import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/usecases/booking_list_use_cases.dart';

class BookingUseCasesImplFailureMock extends BookingListUseCasesImpl {
  @override
  Future<Either<Failure, BookingListModelDomain>?> getBookingListData(
      BookingArgumentDomain args) async {
    return Left(InternetFailure());
  }
}
