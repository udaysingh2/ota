import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

TourTicketPlaylistArgumentDomain getTourTicketPlaylistDataArgumentMock() {
  return TourTicketPlaylistArgumentDomain(
    userId: "guest",
    lat: 14.040885,
    long: 100.614385,
    offset: 0,
    limit: 20,
    playlistName: "ticket",
  );
}

TourTicketPlaylistArgument getTourTicketPlaylistArgumentMock() {
  return TourTicketPlaylistArgument(
    userId: "guest",
    lat: 14.040885,
    long: 100.614385,
    offset: 0,
    limit: 20,
    playlistName: "ticket",
    tourTicketplaylist: [
      TourTicketPlaylistModel(name: "Bangkok Temples",cityId: "MA2005000046",countryId: "MA2005000046",category: "category",
          cityName:"Thailand",id: "MA2005000046",imageUrl: "https://train.travflex.com/SightSeeing/images/350/CL002/sea_life_ocean_world_bangkok-general1.jpg",locationName: "Bangkok",
          promotionTextLine1: "promotionTextLine1",promotionTextLine2: "promotionTextLine2",startPrice: 400)
    ],
  );
}

TourTicketPlaylistModel getTourAndTicketPlaylistCardViewModelMock() {
  return TourTicketPlaylistModel(
      category: "MA2005000046",
      cityId: "MA2005000046",
      cityName: "Thailand",
      countryId: "MA2005000046",
      id: "MA2005000046",
      imageUrl:
      "https://train.travflex.com/SightSeeing/images/350/CL002/sea_life_ocean_world_bangkok-general1.jpg",
      locationName: "Bankok",
      name: "Tour and Activity",
      promotionTextLine1: "A",
      promotionTextLine2: "@",
      startPrice: 400);
}

