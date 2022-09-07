import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';

PlaylistViewArgument getPlaylistViewArgumentMock() {
  return PlaylistViewArgument(
    userId: '1',
    epoch: '1001',
    lat: 0.0,
    lng: 0.0,
    playlistName: 'Playlist Name',
    source: 'dynamic',
    serviceName: 'hotels',
  );
}

FullPlaylistCardViewModel getPlaylistCardViewModelMock() {
  return FullPlaylistCardViewModel(
    ratingText: '1',
    imageUrl: 'Image',
    ratingTitle: 'Review Title',
    headerText: 'Hotel Name',
    offerPercent: 'Offer Value',
    discount: 'Discount Value',
    hotelId: 'Hotel Id',
    addressText: 'Address Text',
    score: 'Score',
    reviewText: 'Review Text',
  );
}
