import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';

/// Interface for HotelDetailRepository repository.
abstract class HotelLandingStaticRepository {
  Future<Either<Failure, HotelLandingStaticSingleData?>> getPlaylist(
      HotelLandingStaticSingleDataArgument argument);
}

class HotelLandingStaticRepositoryImpl implements HotelLandingStaticRepository {
  HotelLandingStaticDataSource? remoteDataSourceAbs;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelLandingStaticRepositoryImpl(
      {HotelLandingStaticDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      remoteDataSourceAbs = HotelLandingStaticDataSourceImpl();
    } else {
      remoteDataSourceAbs = remoteDataSource;
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
  Future<Either<Failure, HotelLandingStaticSingleData?>> getPlaylist(
      HotelLandingStaticSingleDataArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final roomResult = await remoteDataSourceAbs?.getPlaylist(argument);
        return Right(roomResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
