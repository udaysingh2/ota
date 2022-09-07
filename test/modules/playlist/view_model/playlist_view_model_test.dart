import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_model.dart';

void main() {
  test("Playlist View Model Test", () {
    PlaylistViewModel jsonPlaylistViewModel = PlaylistViewModel(
      playlistMap: {
        'key': [
          FullPlaylistCardViewModel.fromList(
            CardList(
              id: 'Hotel Id',
              name: 'Hotel Name',
              review: Review(
                numReview: 1,
                score: 1,
              ),
            ),
          )
        ]
      },
    );
    expect(jsonPlaylistViewModel.playlistMap['key']?.first.hotelId, 'Hotel Id');
    expect(jsonPlaylistViewModel.playlistMap['key']?.first.headerText,
        'Hotel Name');
    expect(jsonPlaylistViewModel.playlistMap['key']?.first.reviewText, '1');
    expect(jsonPlaylistViewModel.playlistMap['key']?.first.ratingText, '1');
    expect(jsonPlaylistViewModel.playlistMap['key']?.length, 1);
  });
}
