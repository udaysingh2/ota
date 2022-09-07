import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_dynamic_playlist_view_models.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_recentviewplaylist_view_model.dart';

void main() {
  HotelDynamicPlayListViewModel? argument;
  setUpAll(() {
    argument = getHotelDynamicPlayListViewModel();
  });
  group('Dynamic Hotel Playlist view Model', () {
    test('For Argument - dynamicPlaylist', () async {
      final data = argument?.dynamicPlaylist;

      expect(data != null, true);
      expect(data!.serviceName.isNotEmpty, true);
      expect(data.serviceName, 'Hotel');
      expect(data.playlist.length, 1);
    });

    test(
        'Dynamic Hotel Playlist view Model from Playlist and hotelStaticCardPlaylist',
        () async {
      final data = argument?.dynamicPlaylist;

      expect(data?.playlist[0].hotelStaticCardPlaylist.length, 1);
      expect(data?.playlist[0].hotelStaticCardPlaylist.isNotEmpty, true);
      expect(data?.playlist[0].hotelStaticCardPlaylist[0].id.isNotEmpty, true);
      expect(data?.playlist[0].hotelStaticCardPlaylist[0].id, 'MA0511000344');
      expect(data?.playlist[0].hotelStaticCardPlaylist[0].countryId.isNotEmpty,
          true);
      expect(
          data?.playlist[0].hotelStaticCardPlaylist[0].countryId, 'MA05110001');
      expect(
          data?.playlist[0].hotelStaticCardPlaylist[0].capsulePromotion.isEmpty,
          true);
    });
  });

  group('For Argument - hotelDynamicPlayListViewModelState', () {
    test('For Argument - If data != null and index enum selected index',
        () async {
      final state = argument?.hotelDynamicPlayListViewModelState;

      expect(state != null, true);
      expect(state?.index, 4);
    });

    test(
        'For Argument - If data != null and HotelDynamicPlayListViewModelState',
        () async {
      final state = argument?.hotelDynamicPlayListViewModelState;

      expect(state, HotelDynamicPlayListViewModelState.dynamicPlayListSuccess);
    });
  });

  group('For Argument - recentPlayList', () {
    test('For Argument - If data != null and recentPlayList',
            () async {
          final result = argument?.recentPlayList;

          expect(result != null, true);
          expect(result?.playListName.isEmpty, true);
          expect(result?.playList.isEmpty, true);
          expect(result?.playList.length, 0);
        });
  });
}

HotelDynamicPlayListViewModel getHotelDynamicPlayListViewModel() {
  return HotelDynamicPlayListViewModel(
    dynamicPlaylist: HotelDynamicPlayListModel(
      serviceName: 'Hotel',
      source: 'Mock',
      playlist: [
        HotelStaticPlayListModel(
          playlistId: '',
          playlistName: '',
          hotelStaticCardPlaylist: [
            HotelStaticPlaylistCardModel(
              id: 'MA0511000344',
              name: 'Test',
              cityName: 'Abc',
              address1: 'A',
              address: 'B',
              rating: '5',
              cityId: 'MA05110041',
              countryId: 'MA05110001',
              imageUrl: '',
              locationName: 'Thailand',
              productType: 'Success',
              promotionTextLine1: '',
              promotionTextLine2: '',
              capsulePromotion: [],
            ),
          ],
        ),
      ],
    ),
    hotelDynamicPlayListViewModelState:
        HotelDynamicPlayListViewModelState.dynamicPlayListSuccess,
    recentPlayList: HotelRecentPlayListViewModel(
      playListName: '',
      playList: [],
    ),
  );
}
