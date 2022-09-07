import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';

void main() {
  test('Tour Ticket Row Playlist ViewModel', () {
    final rowPlaylistViewModel = TourTicketRowPlaylistModel(
        imageUrl: "",
        cityId: '',
        promotionTextLine1: '',
        countryId: '',
        price: 500);
    final tourPlayListCardViewModel = TourTicketRowPlaylistViewModel(
      tourTicketPlaylist: [rowPlaylistViewModel],
    );
    expect(tourPlayListCardViewModel.tourTicketPlaylist!.length == 1, true);
    expect(tourPlayListCardViewModel.playlistState,
        TourTicketRowPlaylistViewModelState.initial);
  });
}
