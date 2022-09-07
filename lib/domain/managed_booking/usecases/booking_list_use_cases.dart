import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/repositories/booking_list_repository_impl.dart';

/// Interface for BookingList use cases.
abstract class BookingListUseCases {
  /// Call API to get the BookingList Screen details.
  ///
  /// [userId] to get the BookingList Data for users.
  /// [Either<Failure, BookingListModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, BookingListModelDomain>?> getBookingListData(
      BookingArgumentDomain argument);
}

/// BookingListUseCasesImpl will contain the BookingListUseCases implementation.
class BookingListUseCasesImpl implements BookingListUseCases {
  BookingListRepository? bookingListRepository;

  /// Dependence injection via constructor
  BookingListUseCasesImpl({BookingListRepository? repository}) {
    if (repository == null) {
      bookingListRepository = BookingListRepositoryImpl();
    } else {
      bookingListRepository = repository;
    }
  }

  /// Call API to get the BookingList Screen Details details.
  ///
  /// [userId] to get the BookingList Data for users.
  /// [Either<Failure, BookingListModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, BookingListModelDomain>?> getBookingListData(
      BookingArgumentDomain argument) async {
    return await bookingListRepository?.getBookingListData(argument);
  }
}
