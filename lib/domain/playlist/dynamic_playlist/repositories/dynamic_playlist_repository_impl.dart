import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/playlist/dynamic_playlist/data_sources/dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';

abstract class DynamicPlaylistRepository {
  /// Call API to get the DynamicPlaylist Screen details.
  ///
  /// [hotelId] to get the DynamicPlaylist Data for users.
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, DynamicPlaylistModel>> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument);
}

/// DynamicPlaylistRepositoryImpl will contain the DynamicPlaylistRepository implementation.
class DynamicPlaylistRepositoryImpl implements DynamicPlaylistRepository {
  DynamicPlayListRemoteDataSource? dynamicPlaylistRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  DynamicPlaylistRepositoryImpl(
      {DynamicPlayListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_dynamicPlaylistRemoteDataSource != null) {
      dynamicPlaylistRemoteDataSource = _dynamicPlaylistRemoteDataSource;
    } else if (remoteDataSource == null) {
      dynamicPlaylistRemoteDataSource =
          DynamicPlayListRemoteDataSourceImpl(); 
          //  DynamicPlayListMockDataSourceImpl(); //
    } else {
      dynamicPlaylistRemoteDataSource = remoteDataSource;
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
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, DynamicPlaylistModel>> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final dynamicPlaylistResult =
            await dynamicPlaylistRemoteDataSource?.getDynamicPlayListData(argument);
        return Right(dynamicPlaylistResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

DynamicPlayListRemoteDataSource? _dynamicPlaylistRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockDynamicPlaylistPageData(
    {DynamicPlayListRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _dynamicPlaylistRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
