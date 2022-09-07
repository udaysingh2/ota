import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

class TourTicketPlaylistArgument {
  List<TourTicketPlaylistModel> tourTicketplaylist;
  String userId;
  double lat;
  double long;
  int offset;
  int limit;
  String playlistName;

  TourTicketPlaylistArgument({
    required this.userId,
    required this.lat,
    required this.long,
    required this.offset,
    required this.limit,
    required this.playlistName,
    required this.tourTicketplaylist,
  });

  factory TourTicketPlaylistArgument.from(String userId, String playlistName,
      List<TourTicketPlaylistModel> tourTicketplaylist) {
    return TourTicketPlaylistArgument(
      userId: userId,
      playlistName: playlistName,
      offset: tourTicketplaylist.length,
      limit: 20,
      long: 0,
      lat: 0,
      tourTicketplaylist: tourTicketplaylist,
    );
  }
}
