import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';

void main() {
  HotelStaticPlayListViewModel? playList;

  setUpAll(() {
    playList = getStaticPlayList();
  });

  group('For HotelStaticPlayListViewModel', () {
    test('Static Hotel Playlist view Model', () async {
      final data = playList?.playList;

      expect(data?[0].hotelStaticCardPlaylist.length, 1);
      expect(data?[0].hotelStaticCardPlaylist.isNotEmpty, true);
      expect(data?[0].hotelStaticCardPlaylist[0].id.isNotEmpty, true);
      expect(data?[0].hotelStaticCardPlaylist[0].id, 'MA0511000344');
      expect(data?[0].hotelStaticCardPlaylist[0].countryId.isNotEmpty, true);
      expect(data?[0].hotelStaticCardPlaylist[0].countryId, 'MA05110001');
      expect(
          data?[0].hotelStaticCardPlaylist[0].capsulePromotion.isNotEmpty, true);
    });

    test('For Argument - If data != null and HotelStaticPlayListViewModel',
        () async {
      final state = playList?.hotelStaticPlayListViewModelState;

      expect(state != null, true);

      expect(state, HotelStaticPlayListViewModelState.success);
    });
  });

  group('For HotelStaticPlayListModel', () {
    HotelStaticPlayListModel staticPlayList = getHotelStaticPlayListModel();

    test('For getPlayList - checking Null and value', () async {
      final model = HotelStaticPlayListModel.fromList(getPlayList());

      expect(model.playlistId.isNotEmpty, true);
      expect(model.playlistId, '111');
      expect(model.hotelStaticCardPlaylist.isNotEmpty, true);
      expect(model.hotelStaticCardPlaylist.length, 1);
      expect(model.hotelStaticCardPlaylist[0].id.isNotEmpty, true);
      expect(model.hotelStaticCardPlaylist[0].id, 'MA0511000344');
      expect(
          model.hotelStaticCardPlaylist[0].capsulePromotion.isNotEmpty, true);
      expect(model.hotelStaticCardPlaylist[0].capsulePromotion[0].code, '111');
    });

    test('For HotelStaticPlayListModel - checking Null and value', () async {
      final data = staticPlayList;

      expect(data.hotelStaticCardPlaylist.length, 1);
      expect(data.hotelStaticCardPlaylist.isNotEmpty, true);
      expect(data.hotelStaticCardPlaylist[0].id.isNotEmpty, true);
      expect(data.hotelStaticCardPlaylist[0].id, 'MA0511000344');
      expect(data.hotelStaticCardPlaylist[0].countryId.isNotEmpty, true);
      expect(data.hotelStaticCardPlaylist[0].countryId, 'MA05110001');
      expect(data.hotelStaticCardPlaylist[0].capsulePromotion.isNotEmpty, true);
      expect(
          data.hotelStaticCardPlaylist[0].capsulePromotion[0].name?.isNotEmpty,
          true);
      expect(data.hotelStaticCardPlaylist[0].capsulePromotion[0].name,
          'New Offer');
      expect(
          data.hotelStaticCardPlaylist[0].capsulePromotion[0].code?.isNotEmpty,
          true);
      expect(data.hotelStaticCardPlaylist[0].capsulePromotion[0].code, '007');
    });
  });

  group('For HotelStaticPlaylistCardModel Test', () {
    test('For HotelStaticPlaylistCardModel Test - checking Null and value',
        () async {
      HotelStaticPlaylistCardModel card =
          HotelStaticPlaylistCardModel.fromList(getPlayList().cardList![0]);

      expect(card.id.isNotEmpty, true);
      expect(card.id, 'MA0511000344');
      expect(card.name.isNotEmpty, true);
      expect(card.name, 'Test');
      expect(card.rating.isNotEmpty, true);
      expect(card.rating, '4.0');
      expect(card.capsulePromotion.isNotEmpty, true);
      expect(card.capsulePromotion.length, 1);
      expect(card.capsulePromotion[0].code, '111');
    });
  });
}

HotelStaticPlayListViewModel getStaticPlayList() {
  return HotelStaticPlayListViewModel(
    hotelStaticPlayListViewModelState:
        HotelStaticPlayListViewModelState.success,
    playList: [
      HotelStaticPlayListModel(
        playlistId: '',
        playlistName: '',
        hotelStaticCardPlaylist: [
          getHotelStaticPlaylistCardModel(),
        ],
      ),
    ],
  );
}

HotelStaticPlayListModel getHotelStaticPlayListModel() {
  return HotelStaticPlayListModel(
    playlistName: '',
    playlistId: '',
    hotelStaticCardPlaylist: [
      getHotelStaticPlaylistCardModel(),
    ],
  );
}

HotelStaticPlaylistCardModel getHotelStaticPlaylistCardModel() {
  return HotelStaticPlaylistCardModel(
    id: 'MA0511000344',
    name: 'Test',
    cityName: 'Abc',
    address1: 'A',
    address: 'B',
    rating: '3',
    cityId: 'MA05110041',
    countryId: 'MA05110001',
    imageUrl: '',
    locationName: 'Thailand',
    productType: 'Success',
    promotionTextLine1: '',
    promotionTextLine2: '',
    capsulePromotion: [
      Promotions(
        name: 'New Offer',
        code: '007',
      ),
    ],
  );
}

Playlist getPlayList() {
  return Playlist(
    playlistId: '111',
    playlistName: '',
    cardList: [
      CardList(
          id: 'MA0511000344',
          name: 'Test',
          cityName: 'Abc',
          address1: 'A',
          address: 'B',
          cityId: 'MA05110041',
          countryId: 'MA05110001',
          imageUrl: '',
          locationName: 'Thailand',
          productType: 'Success',
          promotionTextLine1: '',
          promotionTextLine2: '',
          capsulePromotion: [
            CapsulePromotion(
              name: 'Offer',
              code: '111',
            ),
          ],
          rating: 4,
          countryName: 'Bangkok',
          infopromotion: [],
          locationId: '',
          review: Review(),
          startPrice: 1000,
          styleName: ''),
    ],
  );
}
