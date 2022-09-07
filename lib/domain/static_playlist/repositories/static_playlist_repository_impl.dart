import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/static_playlist/data_source/static_playlist_remote_data_source.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';

/// Interface for HotelServiceRepository repository.
abstract class OtaStaticPlaylistRepository {
  /// Call API to get the Static list on landing Screen.
  ///
  /// [staticPlaylistArgumentData] to get the Static list on landing Screen.
  /// [Either<Failure, StaticPlayListModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, StaticPlayListModelDomain>> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain staticPlaylistArgumentData);
}

/// OtaStaticPlaylistRepositoryImpl will contain the OtaStaticPlaylistRepository implementation.
class OtaStaticPlaylistRepositoryImpl implements OtaStaticPlaylistRepository {
  OtaStaticPlayListRemoteDataSource? otaStaticPlaylistRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  OtaStaticPlaylistRepositoryImpl(
      {OtaStaticPlayListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      otaStaticPlaylistRemoteDataSource =
          OtaStaticPlayListRemoteDataSourceImpl();
    } else {
      otaStaticPlaylistRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Static list on landing Screen.
  ///
  /// [serviceDataArgument] to get the Static list on landing Screen.
  /// [Either<Failure, StaticPlayListModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, StaticPlayListModelDomain>> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain staticPlaylistArgumentData) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final staticPlaylistServiceResult =
            await otaStaticPlaylistRemoteDataSource
                ?.getOtaStaticPlaylist(staticPlaylistArgumentData);
        return Right(staticPlaylistServiceResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
