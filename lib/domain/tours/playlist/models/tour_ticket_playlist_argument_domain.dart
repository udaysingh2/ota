import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';

class TourTicketPlaylistArgumentDomain {
  String userId;
  String playlistName;
  double lat;
  double long;
  int offset;
  int limit;

  TourTicketPlaylistArgumentDomain({
    required this.userId,
    required this.lat,
    required this.long,
    required this.offset,
    required this.limit,
    required this.playlistName,
  });

  factory TourTicketPlaylistArgumentDomain.forRowPlaylist(
      String userId, String playlistName, int limit) {
    return TourTicketPlaylistArgumentDomain(
      userId: userId,
      playlistName: playlistName,
      offset: 0,
      limit: limit,
      long: 0,
      lat: 0,
    );
  }

  factory TourTicketPlaylistArgumentDomain.fromArgument(
      TourTicketPlaylistArgument argument) {
    return TourTicketPlaylistArgumentDomain(
      userId: argument.userId,
      playlistName: argument.playlistName,
      offset: argument.offset,
      limit: argument.limit,
      long: argument.long,
      lat: argument.lat,
    );
  }
}
