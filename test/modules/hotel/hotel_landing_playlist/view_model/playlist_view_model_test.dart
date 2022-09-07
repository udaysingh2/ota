import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart'
    as utc_dynamic;
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart'
    as utc_static;
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';

void main() {
  test('For PlaylistViewModel class', () {
    final actual = PlaylistViewModel(
      playlist: [
        getCardViewModel(),
      ],
      offset: 1,
      selectedCategory: '',
      playlistState: PlaylistViewModelState.none,
    );

    expect(actual.playlistState, PlaylistViewModelState.none);
    expect(actual.playlist.isNotEmpty, true);
  });

  test('For PlaylistCardViewModel class ==> fromStaticPlayList', () {
    final actual =
        PlaylistCardViewModel.fromStaticPlayList(getStaticCardList());

    expect(actual.countryId.isNotEmpty, true);

    final actual1 = PlaylistCardViewModel.updateStarRating(0);
    expect(actual1, '1');

    final actual2 = PlaylistCardViewModel.updateStarRating(6);
    expect(actual2, '5');

    final actual3 = PlaylistCardViewModel.updateStarRating(3);
    expect(actual3, '3');
  });

  test('For PlaylistCardViewModel class ==> fromStaticPlayList', () {
    final actual =
        PlaylistCardViewModel.fromDynamicPlayList(getDynamicCardList());

    expect(actual.countryId.isNotEmpty, true);

    final actual1 = PlaylistCardViewModel.updateStarRating(0);
    expect(actual1, '1');

    final actual2 = PlaylistCardViewModel.updateStarRating(6);
    expect(actual2, '5');

    final actual3 = PlaylistCardViewModel.updateStarRating(3);
    expect(actual3, '3');
  });
}

PlaylistCardViewModel getCardViewModel() => PlaylistCardViewModel(
      addressText: "AddressText",
      cityId: "cityId",
      countryId: "countryId",
      discountValue: "2",
      hotelId: "hotelId",
      hotelName: "hotelName",
      image: "image",
      offerValue: "2",
      promotionText1: "p1",
      promotionText2: "p2",
      rating: "4",
      reviewText: "review",
      reviewTitle: "revtitle",
      locationName: "locationName",
      aminities: ["amini1", "amini2"],
      score: "5",
    );

utc_static.StaticCardList getStaticCardList() {
  return utc_static.StaticCardList(
    countryId: 'countryId',
    capsulePromotion: [
      utc_static.CapsulePromotion(
        name: '',
        code: '',
      ),
    ],
  );
}

utc_dynamic.DynamicCardList getDynamicCardList() {
  return utc_dynamic.DynamicCardList(
    countryId: 'countryId',
    capsulePromotion: [
      utc_dynamic.CapsulePromotion(
        name: '',
        code: '',
      ),
    ],
  );
}
