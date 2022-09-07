import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/managed_booking/data_sources/booking_list_remote_data_source.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';

/// Interface for BookingListRepository repository.
abstract class BookingListRepository {
  /// Call API to get the BookingList screen.
  ///
  /// [userId] to get the BookingList Data for users.
  /// [Either<Failure, BookingListModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, BookingListModelDomain>> getBookingListData(
      BookingArgumentDomain argument);
}

/// BookingListRepositoryImpl will contain the BookingListRepository implementation.
class BookingListRepositoryImpl implements BookingListRepository {
  BookingListRemoteDataSource? bookingListRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  BookingListRepositoryImpl(
      {BookingListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      bookingListRemoteDataSource = BookingListRemoteDataSourceImpl();
    } else {
      bookingListRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the BookingList Screen details.
  ///
  /// [userId] to get the BookingList Data for users.
  /// [Either<Failure, BookingListModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, BookingListModelDomain>> getBookingListData(
      BookingArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final bookingListResult =
            await bookingListRemoteDataSource?.getBookingListData(argument);
        return Right(bookingListResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
