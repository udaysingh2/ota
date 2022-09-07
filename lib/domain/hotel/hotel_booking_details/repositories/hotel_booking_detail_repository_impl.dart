import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_booking_details/data_sources/hotel_booking_details_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_details_argument_model.dart';

///Interface for HotelBookingDetailRepository repository
abstract class HotelBookingDetailRepository {
  Future<Either<Failure, HotelBookingDetailModelDomain>> getHotelBookingDetail(
      HotelBookingDetailArgumentDomain argument);
}

class HotelBookingDetailRepositoryImpl implements HotelBookingDetailRepository {
  HotelBookingDetailRemoteDataSource? hotelBookingDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelBookingDetailRepositoryImpl(
      {HotelBookingDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelBookingDetailRemoteDataSource =
          HotelBookingDetailRemoteDataSourceImpl();
    } else {
      hotelBookingDetailRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, HotelBookingDetailModelDomain>> getHotelBookingDetail(
      HotelBookingDetailArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelResult = await hotelBookingDetailRemoteDataSource
            ?.getHotelBookingDetail(argument);
        return Right(hotelResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
