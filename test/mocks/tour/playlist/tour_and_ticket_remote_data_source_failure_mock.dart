import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

class TourAndTicketPlayListRemoteDataSourceFailureMock
    implements TourTicketPlaylistRemoteDataSource {
  @override
  Future<TourTicketPlaylistModelDomain> getTourTicketPlaylistData(
      TourTicketPlaylistArgumentDomain argument) {
    throw exp.ServerException(null);
  }
}
