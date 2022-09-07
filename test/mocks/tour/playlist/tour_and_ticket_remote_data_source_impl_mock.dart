import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

class TourTicketPlaylistRemoteDataSourceImplSuccessMock
    implements TourTicketPlaylistRemoteDataSource {
  @override
  Future<TourTicketPlaylistModelDomain> getTourTicketPlaylistData(
      TourTicketPlaylistArgumentDomain argument) async {
    String json = fixture("tour/playlist/tour_and_ticket_playlist_mock.json");

    ///Convert into Model
    TourTicketPlaylistModelDomain model =
        TourTicketPlaylistModelDomain.fromJson(json);
    return model;
  }
}
