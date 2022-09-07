import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

class TourTicketPlaylistHelper {
  static List<TourTicketPlaylistModel> getTourTicketPlaylist(
      List<ListOfPlaylist>? list) {
    List<TourTicketPlaylistModel>? tourTicketPlaylist;
    if (list == null || list.isEmpty) return [];

    tourTicketPlaylist = List<TourTicketPlaylistModel>.generate(
      list.length,
      (index) {
        return TourTicketPlaylistModel.mapFromListOfPlaylist(
          list[index],
        );
      },
    );
    return tourTicketPlaylist.toList();
  }

  static List<TourTicketPlaylistModel> getTourTicketPlaylistFromRowPlaylist(
      List<TourTicketRowPlaylistModel>? list) {
    List<TourTicketPlaylistModel>? tourTicketPlaylist;
    if (list == null || list.isEmpty) return [];

    tourTicketPlaylist = List<TourTicketPlaylistModel>.generate(
      list.length,
      (index) {
        return TourTicketPlaylistModel.fromTourTicketRowPlaylist(
          list[index],
        );
      },
    );
    return tourTicketPlaylist.toList();
  }
}
