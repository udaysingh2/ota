import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/data_soruces/hotel_detail_interest_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';

///Interface for HotelBookingMailerRepository repository
abstract class HotelDetailInterestRepository {
  Future<Either<Failure, HotelDetailInterestData>> getDetailInterest(
      HotelDetailInterestDataArgument argument);
}

class HotelDetailInterestRepositoryImpl
    implements HotelDetailInterestRepository {
  HotelDetailInterestRemoteDataSource? hotelBookingMailerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelDetailInterestRepositoryImpl(
      {HotelDetailInterestRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelBookingMailerRemoteDataSource =
          HotelDetailInterestRemoteDataSourceImpl();
      // hotelBookingMailerRemoteDataSource = HotelDetailInterestMock();
    } else {
      hotelBookingMailerRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, HotelDetailInterestData>> getDetailInterest(
      HotelDetailInterestDataArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelResult = await hotelBookingMailerRemoteDataSource
            ?.getHotelDetailInterestData(argument);
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
