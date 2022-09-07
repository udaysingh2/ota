import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

import '../../../../mocks/tour/playlist/tour_and_ticket_mock.dart';

void main() {
  test("Tour and Ticket Playlist View Model Test", () {
    TourTicketPlaylistModel jsonPlaylistViewModel =
        getTourAndTicketPlaylistCardViewModelMock();
    expect(jsonPlaylistViewModel.cityName, 'Thailand');
    expect(jsonPlaylistViewModel.cityId, 'MA2005000046');
  });
}
