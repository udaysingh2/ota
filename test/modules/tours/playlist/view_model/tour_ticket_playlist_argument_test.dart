import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

void main() {
  test('Tour And Ticket playlist argument', () async {
    TourTicketPlaylistModel tourTicketPlaylistModel = TourTicketPlaylistModel(
      id: "MA2005000046",
      cityId: "MA05110041",
      countryId: "MA05110001",
      imageUrl:
          "https://train.travflex.com/SightSeeing/images/350/CL002/sea_life_ocean_world_bangkok-general1.jpg",
      name: "Sea Life Ocean World Bangkok",
      locationName: "NONE",
      cityName: "Bangkok",
      category: "Tourist",
      startPrice: 800.5,
      promotionTextLine1: "@",
      promotionTextLine2: "RBH",
    );
    final tourAndTicketPlaylist = TourTicketPlaylistArgument.from(
        "userId", "ticket", [tourTicketPlaylistModel]);
    expect(tourAndTicketPlaylist.playlistName, "ticket");
    expect(tourAndTicketPlaylist.limit, 20);
  });
}
