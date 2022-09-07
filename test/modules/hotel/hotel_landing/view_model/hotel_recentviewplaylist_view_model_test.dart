import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_recentviewplaylist_view_model.dart';

void main() {
  test('For HotelRecentPlayListViewModel', () async {
    HotelRecentPlayListViewModel model = getHotelRecentPlayListViewModel();

    expect(model.playListName.isNotEmpty, true);
    expect(model.playListName, 'Hotel');
    expect(model.playList.isNotEmpty, true);
    expect(model.playList.length, 1);
    expect(model.playList[0].hotelId.isNotEmpty, true);
    expect(model.playList[0].hotelId, 'MA0511000344');
    expect(model.playList[0].hotelName, 'Hotel Thailand');
    expect(model.playList[0].countryId, 'MA05110001');
    expect(model.playList[0].ammenitiesList.isNotEmpty, true);
    expect(model.playList[0].ammenitiesList.length, 2);
    expect(model.playList[0].ammenitiesList[1], 'BREAKFAST');
  });

  test('For HotelRecentPlayListViewModel factory', () async {
    final actual =
        HotelRecentPlayListViewModel.fromList(getGetRecentViewPlaylist());
    expect(actual.playListName.isEmpty, true);
  });

  group('For factory Methods', () {
    test('For HotelRecentPromotionList.fromList() factory', () async {
      final actual = HotelRecentPromotionList.fromList(getPromotionList());

      expect(actual.productId.isEmpty, true);
      expect(actual.productType.isNotEmpty, true);
      expect(actual.productType, 'hotel');
      expect(actual.promotionType.isNotEmpty, true);
      expect(actual.promotionType, 'offer');
      expect(actual.promotionCode.isNotEmpty, true);
      expect(actual.promotionCode, 'off123');
      expect(actual.line1.isEmpty, true);
    });

    test('For HotelRecentPromotionList.getDefault() factory', () async {
      final actual = HotelRecentPromotionList.getDefault();

      expect(actual.productId.isEmpty, true);
      expect(actual.productType.isEmpty, true);
      expect(actual.promotionType.isEmpty, true);
      expect(actual.promotionCode.isEmpty, true);
      expect(actual.line1.isEmpty, true);
      expect(actual.line2.isEmpty, true);
    });
  });

  group('For HotelRecentPlayListModel Class', () {
    test('For HotelRecentPlayListModel', () async {
      final actual = getHotelRecentPlayListViewModel().playList;

      expect(actual.isNotEmpty, true);
      expect(actual.length, 1);
      expect(actual[0].hotelId.isNotEmpty, true);
      expect(actual[0].hotelId, 'MA0511000344');
      expect(actual[0].hotelName, 'Hotel Thailand');
      expect(actual[0].rating, '5');
      expect(actual[0].countryId, 'MA05110001');
      expect(actual[0].ammenitiesList.isNotEmpty, true);
      expect(actual[0].ammenitiesList.length, 2);
      expect(actual[0].ammenitiesList[0], 'WIFI');
      expect(actual[0].promotionList.isNotEmpty, true);
      expect(actual[0].promotionList.length, 1);
    });

    test('For HotelRecentPlayListModel.getDefault() factory', () async {
      final actual = HotelRecentPlayListModel.fromList(getRecentViewPlaylist());

      expect(actual.hotelId.isNotEmpty, true);
      expect(actual.hotelId, 'MA0511000344');
      expect(actual.hotelName.isNotEmpty, true);
      expect(actual.hotelName, 'Hotel Thailand');
      expect(actual.rating, '5');
      expect(actual.countryId, 'MA05110001');
      expect(actual.adminPromotionLine1.isEmpty, true);
      expect(actual.ammenitiesList.isEmpty, true);
      expect(actual.ammenitiesList.length, 0);
      expect(actual.promotionList.isNotEmpty, true);
      expect(actual.promotionList.length, 1);
      expect(actual.promotionList[0].productId.isNotEmpty, true);
    });
  });
}

HotelRecentPlayListViewModel getHotelRecentPlayListViewModel() {
  return HotelRecentPlayListViewModel(
    playListName: 'Hotel',
    playList: [
      HotelRecentPlayListModel(
        hotelId: 'MA0511000344',
        hotelName: 'Hotel Thailand',
        rating: '5',
        cityId: 'MA05110041',
        countryId: 'MA05110001',
        image: '',
        locationName: 'Thailand',
        adminPromotionLine1: '',
        adminPromotionLine2: '',
        ammenitiesList: ['WIFI', 'BREAKFAST'],
        promotionList: [
          HotelRecentPromotionList(
            productId: '',
            productType: '',
            promotionCode: '',
            promotionType: '',
            line1: '',
            line2: '',
          ),
        ],
      ),
    ],
  );
}

GetRecentViewPlaylist getGetRecentViewPlaylist() {
  return GetRecentViewPlaylist(listType: '');
}

RecentViewPlaylist getRecentViewPlaylist() {
  return RecentViewPlaylist(
      hotelId: 'MA0511000344',
      hotelName: 'Hotel Thailand',
      rating: 5,
      cityId: 'MA05110041',
      countryId: 'MA05110001',
      image: '',
      locationName: 'Thailand',
      promotionList: [
        getPromotionList(),
      ]);
}

PromotionList getPromotionList() {
  return PromotionList(
    productId: '111',
    name: 'new',
    productType: 'hotel',
    promotionType: 'offer',
    promotionCode: 'off123',
    line1: '',
    line2: '',
  );
}
