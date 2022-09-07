import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString =
      fixture("tour/playlist/tour_and_ticket_playlist_mock.json");
  TourTicketPlaylistModelDomain playlistResultModel =
      TourTicketPlaylistModelDomain.fromJson(jsonString);
  test("Tour Ticket Playlist Model", () {
    ///Convert into Model
    expect(playlistResultModel.getTourAndTicketPlaylist != null, true);

    //convert into map
    Map<String, dynamic> map = playlistResultModel.toMap();

    ///Check map conversion
    TourTicketPlaylistModelDomain mapFromModel =
        TourTicketPlaylistModelDomain.fromMap(map);

    expect(mapFromModel.getTourAndTicketPlaylist != null, true);

    ///Convert to String
    String stringData = playlistResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = playlistResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("getPlaylists", () {
    GetTourAndTicketPlaylist getPlaylists = GetTourAndTicketPlaylist.fromJson(
        playlistResultModel.getTourAndTicketPlaylist!.toJson());
    //convert into map
    Map<String, dynamic> map = getPlaylists.toMap();
    expect(map.isNotEmpty, true);

    GetTourAndTicketPlaylist mapFromModel =
        GetTourAndTicketPlaylist.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
