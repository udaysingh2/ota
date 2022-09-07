import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';

abstract class TourTicketPlaylistRepository {
  Future<Either<Failure, TourTicketPlaylistModelDomain>?>
      getTourTicketPlayListData(TourTicketPlaylistArgumentDomain argument);
}

class TourAndTicketPlaylistRepositoryImpl
    implements TourTicketPlaylistRepository {
  TourTicketPlaylistRemoteDataSource? tourTicketRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  TourAndTicketPlaylistRepositoryImpl(
      {TourTicketPlaylistRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourTicketRemoteDataSource = TourTicketPlaylistRemoteDataSourceImpl();
    } else {
      tourTicketRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourTicketPlaylistModelDomain>?>
      getTourTicketPlayListData(argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourTicketPlaylistResult = await tourTicketRemoteDataSource
            ?.getTourTicketPlaylistData(argument);
        return Right(tourTicketPlaylistResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
