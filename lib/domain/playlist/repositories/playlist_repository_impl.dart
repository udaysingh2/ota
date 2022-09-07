import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/playlist/data_sources/playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';

abstract class PlayListRepository {
  /// Call API to get the PlayList Screen details.
  ///
  /// [hotelId] to get the PlayList Data for users.
  /// [Either<Failure, PlaylistResultModel>] to handle the Failure or result data.
  Future<Either<Failure, PlaylistResultModelDomain>> getPlayListData(
      PlayListDataArgument argument);
}

/// PlayListRepositoryImpl will contain the PlayListRepository implementation.
class PlayListRepositoryImpl implements PlayListRepository {
  PlayListRemoteDataSource? playListRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  PlayListRepositoryImpl(
      {PlayListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_playListRemoteDataSource != null) {
      playListRemoteDataSource = _playListRemoteDataSource;
    } else if (remoteDataSource == null) {
      playListRemoteDataSource =
          PlayListRemoteDataSourceImpl(); // PlayListMockDataSourceImpl(); //
    } else {
      playListRemoteDataSource = remoteDataSource;
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
  /// [Either<Failure, PlaylistResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PlaylistResultModelDomain>> getPlayListData(
      PlayListDataArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final playListResult =
            await playListRemoteDataSource?.getPlayListData(argument);
        return Right(playListResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

PlayListRemoteDataSource? _playListRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockPlayListPageData(
    {PlayListRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _playListRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
