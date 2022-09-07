import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';

/// Interface for HotelBookingListRepository repository.
abstract class HotelBookingListRepository {
  /// Call API to get the HotelBookingList screen.
  ///
  /// [userId] to get the HotelBookingList Data for users.
  /// [Either<Failure, HotelBookingListModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, HotelBookingListModelDomain>> getHotelBookingListData(
      HotelBookingArgumentDomain argument);
}

/// HotelBookingListRepositoryImpl will contain the HotelBookingListRepository implementation.
class HotelBookingListRepositoryImpl implements HotelBookingListRepository {
  HotelBookingListRemoteDataSource? hotelBookingListRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelBookingListRepositoryImpl(
      {HotelBookingListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelBookingListRemoteDataSource = HotelBookingListRemoteDataSourceImpl();
    } else {
      hotelBookingListRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the HotelBookingList Screen details.
  ///
  /// [userId] to get the HotelBookingList Data for users.
  /// [Either<Failure, HotelBookingListModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, HotelBookingListModelDomain>> getHotelBookingListData(
      HotelBookingArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelBookingListResult = await hotelBookingListRemoteDataSource
            ?.getHotelBookingListData(argument);
        return Right(hotelBookingListResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
