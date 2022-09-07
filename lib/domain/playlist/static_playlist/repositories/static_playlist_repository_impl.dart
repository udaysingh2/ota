import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/playlist/static_playlist/data_sources/static_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';

abstract class StaticPlaylistRepository {
  /// Call API to get the StaticPlaylist Screen details.
  ///
  /// [hotelId] to get the StaticPlaylist Data for users.
  /// [Either<Failure, StaticPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, StaticPlaylistModelDomain>> getStaticPlayListData();
}

/// StaticPlaylistRepositoryImpl will contain the StaticPlaylistRepository implementation.
class StaticPlaylistRepositoryImpl implements StaticPlaylistRepository {
  StaticPlayListRemoteDataSource? staticPlaylistRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  StaticPlaylistRepositoryImpl(
      {StaticPlayListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_staticPlaylistRemoteDataSource != null) {
      staticPlaylistRemoteDataSource = _staticPlaylistRemoteDataSource;
    } else if (remoteDataSource == null) {
      staticPlaylistRemoteDataSource =
          StaticPlayListRemoteDataSourceImpl();
          // StaticPlayListMockDataSourceImpl();
    } else {
      staticPlaylistRemoteDataSource = remoteDataSource;
    }

    if (_internetConnectionInfo != null) {
      internetConnectionInfo = _internetConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Playlist Screen details.
  ///
  /// [hotelId] to get the Playlist Data for users.
  /// [Either<Failure, StaticPlaylistModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, StaticPlaylistModelDomain>> getStaticPlayListData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final staticPlaylistResult =
            await staticPlaylistRemoteDataSource?.getStaticPlayListData();
        return Right(staticPlaylistResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

StaticPlayListRemoteDataSource? _staticPlaylistRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockStaticPlaylistPageData(
    {StaticPlayListRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _staticPlaylistRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
