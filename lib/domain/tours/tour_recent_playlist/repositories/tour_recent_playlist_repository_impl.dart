import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/tour_recent_playlist/data_sources/tour_recent_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_argument_model.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';

///Interface for TourBookingDetailRepository repository
abstract class TourRecentPlaylistRepository {
  Future<Either<Failure, TourRecentPlaylistModelDomain>> getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument);
}

class TourRecentPlaylistRepositoryImpl implements TourRecentPlaylistRepository {
  TourRecentPlaylistRemoteDataSource? tourRecentPlaylistRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourRecentPlaylistRepositoryImpl(
      {TourRecentPlaylistRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourRecentPlaylistRemoteDataSource =
          TourRecentPlaylistRemoteDataSourceImpl();
      // tourBookingDetailRemoteDataSource = TourBookingDetailMockDataSourceImpl();
    } else {
      tourRecentPlaylistRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourRecentPlaylistModelDomain>> getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourResult = await tourRecentPlaylistRemoteDataSource
            ?.getTourRecentPlaylist(argument);
        return Right(tourResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
