import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart'
    as hotel_dynamic_playlist;
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/modules/hotel/hotel_landing/helpers/hotel_landing_helper.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';

void main() {
  group('HotelLandingHelper class ==> getHotelRecommendationViewModel method',
      () {
    test('If location list is Null then getHotelRecommendationViewModel method',
        () {
      final actual = HotelLandingHelper.getHotelRecommendationViewModel(null);

      expect(actual == null, true);
    });

    group('To check location data index wise', () {
      test(
          'If location list has data then check for "ZERO INDEX" getHotelRecommendationViewModel method',
          () {
        final actual =
            HotelLandingHelper.getHotelRecommendationViewModel(getLocations());

        expect(actual?.isNotEmpty, true);
        expect(actual?.length, 2);
        expect(actual?[0].playlistId != null, true);
        expect(actual?[0].playlistId, '111');
        expect(actual?[0].hotelId != null, true);
        expect(actual?[0].hotelId, 'MA0511000344');
        expect(actual?[0].cityId != null, true);
        expect(actual?[0].cityId, 'MA05110041');
        expect(actual?[0].countryId != null, true);
        expect(actual?[0].countryId, 'MA05110001');
        expect(actual?[0].imageUrl != null, true);
        expect(actual?[0].imageUrl, 'test_url');
        expect(actual?[0].searchKey, 'hotel1');
      });

      test(
          'If location list has data then check for "ONE INDEX" getHotelRecommendationViewModel method',
          () {
        final actual =
            HotelLandingHelper.getHotelRecommendationViewModel(getLocations());

        expect(actual?[1].playlistId.isEmpty, true);
        expect(actual?[1].hotelId != null, true);
        expect(actual?[1].hotelId, 'MA0511000345');
        expect(actual?[1].searchKey != null, true);
        expect(actual?[1].searchKey, 'hotel2');
        expect(actual?[1].cityId.isNotEmpty, true);
        expect(actual?[1].countryId.isNotEmpty, true);
        expect(actual?[1].imageUrl?.isEmpty, true);
      });
    });
  });

  group('HotelLandingHelper class --> getCapsulePromotionList method', () {
    test('If Promotions list is "EMPTY" then getCapsulePromotionList method',
        () async {
      final actual = HotelLandingHelper.getCapsulePromotionList([]);

      expect(actual.isEmpty, true);
      expect(actual.length, 0);
    });

    test('If Promotions list contains Data then getCapsulePromotionList method',
        () async {
      final actual =
          HotelLandingHelper.getCapsulePromotionList(getCapsulePromotion());

      expect(actual.isNotEmpty, true);
      expect(actual.length, 2);

      ///If ZERO INDEX has NULL and Empty data then
      expect(actual[0].name?.isEmpty, true);
      expect(actual[0].code?.isEmpty, true);
      expect(!(actual[0].code == null), true);

      ///If ONE INDEX has data then
      expect(actual[1].name?.isNotEmpty, true);
      expect(actual[1].name, 'offer');
      expect(actual[1].code?.isNotEmpty, true);
      expect(actual[1].code, '111');
    });
  });

  group('For HotelLandingHelper class ==> updateStarRating()', () {
    test(
        'If updateStarRating() method contains EMPTY OR Null in parameter then',
        () async {
      final actual = HotelLandingHelper.updateStarRating(null);

      expect(actual.isNotEmpty, true);

      ///To prevent from NULL or EMPTY (default rating set 1)
      expect(actual, '1');
    });

    test('If updateStarRating() method contains valid rating in parameter then',
        () async {
      final actual = HotelLandingHelper.updateStarRating('3.5');

      expect(actual.isNotEmpty, true);
      expect(actual, '3.5');
    });

    test(
        'If updateStarRating() method contains greater than 5 rating in parameter then',
        () async {
      final actual = HotelLandingHelper.updateStarRating('10');

      expect(actual.isNotEmpty, true);

      ///default rating set to 5 through function because rating in param is 10
      expect(actual, '5');
    });
  });

  group('For getHotelStaticPlaylist() method then ', () {
    test('If getHotelStaticPlaylist() contains EMPTY card list then ', () {
      final actual = HotelLandingHelper.getHotelStaticPlaylist([]);

      expect(actual.isEmpty, true);
      expect(actual.length, 0);
    });

    test('If getHotelStaticPlaylist() contains valid card list data then ', () {
      final actual = HotelLandingHelper.getHotelStaticPlaylist(getCardList());

      expect(actual.isNotEmpty, true);
      expect(actual.length, 1);
      expect(actual[0].id.isNotEmpty, true);
      expect(actual[0].id, 'MA0511000344');
      expect(actual[0].name.isNotEmpty, true);
      expect(actual[0].name, 'Test');
      expect(actual[0].address, 'address One');
      expect(actual[0].address1, 'address Two');
      expect(actual[0].rating, '5');
      expect(actual[0].rating.isNotEmpty, true);
      expect(actual[0].capsulePromotion.isNotEmpty, true);
      expect(actual[0].capsulePromotion.length, 2);
    });
  });

  test('For HotelLandingHelper class ==> getAmenitiesList() method', () {
    final actual =
        HotelLandingHelper.getAmenitiesList(getPromotion(), [], false);

    expect(actual.isNotEmpty, true);
    expect(actual.length, 2);
    expect(actual[0].isNotEmpty, true);
    expect(actual[0], 'Y');
    expect(actual[1].isNotEmpty, true);
    expect(actual[0], 'Y');
  });

  test(
      'For HotelLandingHelper class ==> getDynamicCapsulePromotionList() method',
      () {
    final actual = HotelLandingHelper.getDynamicCapsulePromotionList(
        getDynamicPromotion());

    expect(actual.isNotEmpty, true);
    expect(actual.length, 2);

    ///For 0 index
    expect(actual[0].code?.isNotEmpty, true);
    expect(actual[0].code, 'BREAKFAST');
    expect(actual[0].name, 'N');

    ///For 1 index
    expect(actual[1].code?.isNotEmpty, true);
    expect(actual[1].code, 'WIFI');
    expect(actual[1].name, 'Y');
  });

  test('For HotelLandingHelper class ==> getDynamicPlaylist() method', () {
    final actual = HotelLandingHelper.getDynamicPlaylist(getDynamicCardList());

    expect(actual.isNotEmpty, true);
    expect(actual.length, 1);
    expect(actual[0].id.isNotEmpty, true);
    expect(actual[0].id, 'MA0511000344');
    expect(actual[0].name.isNotEmpty, true);
    expect(actual[0].name, 'Hotel Sun Rise');
    expect(actual[0].rating, '4.0');
    expect(actual[0].capsulePromotion.isEmpty, true);
    expect(actual[0].capsulePromotion.length, 0);
  });

  test('For HotelLandingHelper class ==> getdynamicPlayList() method', () {
    final actual = HotelLandingHelper.getdynamicPlayList(getDynamicPlayList());

    expect(actual.isNotEmpty, true);
    expect(actual.length, 1);
    expect(actual[0].playlistId.isNotEmpty, true);
    expect(actual[0].playlistId, '111');
    expect(actual[0].playlistName.isNotEmpty, true);
    expect(actual[0].playlistName, 'horizontal PlayList');

    ///For cardList
    expect(actual[0].hotelStaticCardPlaylist.isNotEmpty, true);
    expect(actual[0].hotelStaticCardPlaylist.length, 1);
    expect(actual[0].hotelStaticCardPlaylist[0].id.isNotEmpty, true);
    expect(actual[0].hotelStaticCardPlaylist[0].id, 'MA0511000344');
    expect(actual[0].hotelStaticCardPlaylist[0].rating, '5');

    ///For capsulePromotionList
    expect(
        actual[0].hotelStaticCardPlaylist[0].capsulePromotion.isNotEmpty, true);
    expect(actual[0].hotelStaticCardPlaylist[0].capsulePromotion.length, 1);
    expect(
        actual[0]
            .hotelStaticCardPlaylist[0]
            .capsulePromotion[0]
            .name
            ?.isNotEmpty,
        true);
    expect(
        actual[0].hotelStaticCardPlaylist[0].capsulePromotion[0].name, 'WIFI');
  });

  test('For HotelLandingHelper class ==> getHotelRecentPromotionList() method',
      () {
    final actual = HotelLandingHelper.getHotelRecentPromotionList(
        getDynamicPromotionList());

    expect(actual.isNotEmpty, true);
    expect(actual.length, 2);
    expect(actual[0].promotionCode.isNotEmpty, true);
    expect(actual[0].promotionCode, 'promo');
    expect(actual[0].productId.isNotEmpty, true);
    expect(actual[0].productId, 'THAI001');
    expect(actual[0].productType, 'productType');
    expect(actual[0].promotionType, 'CAPSULE');
    expect(actual[0].line1, 'line1');
    expect(actual[0].line2, 'line2');
  });

  group('For HotelLandingHelper class ==> ', () {
    test('If promotionType == CAPSULE then getRecentAmenityList() method', () {
      final actual =
          HotelLandingHelper.getRecentAmenityList(getDynamicPromotionList());

      expect(actual.isNotEmpty, true);
      expect(actual.length, 1);
      expect(actual[0].isNotEmpty, true);

      ///line1 char count length is 5
      expect(actual[0].length, 5);
      expect(actual[0], 'line1');
    });

    test(
        'If promotionType == OVERLAY then return line1 value in getAdminPromotionLine1() method',
        () {
      final actual =
          HotelLandingHelper.getAdminPromotionLine1(getDynamicPromotionList());

      expect(actual.isNotEmpty, true);

      ///line1 char count length is 7
      expect(actual.length, 7);
      expect(actual, 'line111');
    });

    test(
        'If promotionType == OVERLAY then return line2 value in getAdminPromotionLine2() method',
        () {
      final actual =
          HotelLandingHelper.getAdminPromotionLine2(getDynamicPromotionList());

      expect(actual.isNotEmpty, true);

      ///line222 char count length is 7
      expect(actual.length, 7);
      expect(actual, 'line222');
    });
  });
}

List<LocationList>? getLocations() {
  return [
    LocationList(
      playlistId: '111',
      hotelId: 'MA0511000344',
      cityId: 'MA05110041',
      countryId: 'MA05110001',
      imageUrl: 'test_url',
      searchKey: 'hotel1',
      serviceTitle: 'location1',
    ),
    LocationList(
      playlistId: null,
      hotelId: 'MA0511000345',
      cityId: 'MA05110042',
      countryId: 'MA05110002',
      imageUrl: null,
      searchKey: 'hotel2',
      serviceTitle: 'location2',
    ),
  ];
}

List<CapsulePromotion> getCapsulePromotion() {
  return [
    CapsulePromotion(
      name: '',
      code: null,
    ),
    CapsulePromotion(
      name: 'offer',
      code: '111',
    ),
  ];
}

List<CardList> getCardList() {
  return [
    CardList(
      id: 'MA0511000344',
      name: 'Test',
      cityName: 'Abc',
      address: 'address One',
      address1: 'address Two',
      rating: 7,
      cityId: 'MA05110041',
      countryId: 'MA05110001',
      imageUrl: '',
      locationName: 'Thailand',
      productType: 'Success',
      promotionTextLine1: '',
      promotionTextLine2: '',
      countryName: 'Thailand',
      locationId: '',
      review: Review(),
      startPrice: 1000,
      styleName: '',
      infopromotion: [],
      capsulePromotion: getCapsulePromotion(),
    ),
  ];
}

List<Promotions> getPromotion() {
  return [
    Promotions(
      code: 'WIFI',
      name: 'Y',
    ),
    Promotions(
      code: 'BREAKFAST',
      name: 'Y',
    ),
  ];
}

List<hotel_dynamic_playlist.CapsulePromotion> getDynamicPromotion() {
  return [
    hotel_dynamic_playlist.CapsulePromotion(
      code: 'BREAKFAST',
      name: 'N',
    ),
    hotel_dynamic_playlist.CapsulePromotion(
      code: 'WIFI',
      name: 'Y',
    ),
  ];
}

List<hotel_dynamic_playlist.CardList> getDynamicCardList() {
  return [
    hotel_dynamic_playlist.CardList(
      id: 'MA0511000344',
      name: 'Hotel Sun Rise',
      cityName: 'Abc',
      address: 'address One',
      rating: 4,
      cityId: 'MA05110041',
      countryId: 'MA05110001',
      imageUrl: '',
      locationName: 'Thailand',
      productType: 'Success',
      countryName: 'Thailand',
      locationId: '',
      startPrice: 1000,
      styleName: '',
      infopromotion: [],
      review: null,
      capsulePromotion: [],
    ),
  ];
}

List<hotel_dynamic_playlist.Playlist> getDynamicPlayList() {
  return [
    hotel_dynamic_playlist.Playlist(
      playlistId: '111',
      playlistName: 'horizontal PlayList',
      cardList: [
        hotel_dynamic_playlist.CardList(
            id: 'MA0511000344',
            name: 'Test',
            cityName: 'Abc',
            address: 'address One',
            rating: 7,
            cityId: 'MA05110041',
            countryId: 'MA05110001',
            imageUrl: '',
            locationName: 'Thailand',
            productType: 'Success',
            countryName: 'Thailand',
            locationId: '',
            startPrice: 1000,
            styleName: '',
            infopromotion: [],
            review: hotel_dynamic_playlist.Review(
              score: 10,
              numReview: 2,
              description: '',
            ),
            capsulePromotion: [
              hotel_dynamic_playlist.CapsulePromotion(
                name: 'WIFI',
                code: 'Y',
              ),
            ]),
      ],
    ),
  ];
}

List<hotel_dynamic_playlist.PromotionList> getDynamicPromotionList() {
  return [
    hotel_dynamic_playlist.PromotionList(
      promotionCode: 'promo',
      productId: 'THAI001',
      productType: 'productType',
      promotionType: 'CAPSULE',
      line1: 'line1',
      line2: 'line2',
      name: 'name',
    ),
    hotel_dynamic_playlist.PromotionList(
      promotionCode: 'promo',
      productId: 'THAI001',
      productType: 'productType',
      promotionType: 'OVERLAY',
      line1: 'line111',
      line2: 'line222',
      name: 'name',
    ),
  ];
}
