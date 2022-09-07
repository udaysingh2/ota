import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/playlist/repositories/tour_ticket_playlist_repository_impl.dart';

import '../../fixture_reader.dart';

class TourAndTicketPlaylistRepositoryImplSuccessMock
    implements TourAndTicketPlaylistRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  TourTicketPlaylistRemoteDataSource? tourTicketRemoteDataSource;

  @override
  Future<Either<Failure, TourTicketPlaylistModelDomain>?>
      getTourTicketPlayListData(
          TourTicketPlaylistArgumentDomain argument) async {
    String json = fixture("tour/playlist/tour_and_ticket_playlist_mock.json");

    ///Convert into Model
    TourTicketPlaylistModelDomain model =
        TourTicketPlaylistModelDomain.fromJson(json);
    return Right(model);
  }
}
