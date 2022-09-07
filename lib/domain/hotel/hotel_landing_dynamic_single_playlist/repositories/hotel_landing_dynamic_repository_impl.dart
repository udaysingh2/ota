import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';

/// Interface for HotelDetailRepository repository.
abstract class HotelLandingDynamicRepository {
  Future<Either<Failure, HotelLandingDynamicSingleData?>> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument);
}

class HotelLandingDynamicRepositoryImpl
    implements HotelLandingDynamicRepository {
  HotelLandingDynamicDataSource? remoteDataSourceAbs;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelLandingDynamicRepositoryImpl(
      {HotelLandingDynamicDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      remoteDataSourceAbs = HotelLandingDynamicDataSourceImpl();
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
  Future<Either<Failure, HotelLandingDynamicSingleData?>> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument) async {
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
