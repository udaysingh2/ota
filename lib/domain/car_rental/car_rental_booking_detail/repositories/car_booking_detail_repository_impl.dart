import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/data_sources/car_booking_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart';

abstract class CarBookingDetailRepository {
  /// Call API to get the Car booking detail result Data.
  ///
  /// [Either<Failure, CarBookingDetailDomainModel>] to handle the Failure or result data.
  Future<Either<Failure, CarBookingDetailDomainModel>> getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  });
}

/// CarBookingDetailRepositoryImpl will contain the CarBookingDetailRepository implementation.
class CarBookingDetailRepositoryImpl implements CarBookingDetailRepository {
  CarBookingDetailRemoteDataSource? carBookingDetailDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarBookingDetailRepositoryImpl(
      {CarBookingDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carBookingDetailDataSource = CarBookingDetailRemoteDataSourceImpl();
      // carBookingDetailDataSource = CarBookingDetailMockDataSourceImpl();
    } else {
      carBookingDetailDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Car booking detail result Data.
  ///
  /// [Either<Failure, CarBookingDetailDomainModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarBookingDetailDomainModel>> getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  }) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result =
            await carBookingDetailDataSource?.getCarBookingDetailData(
          bookingId: bookingId,
          bookingUrn: bookingUrn,
          bookingType: bookingType,
        );
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
