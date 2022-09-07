import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("hotel_playlist/hotel_dynamic_playlist.json");
  HotelDynamicPlayListModelDomain hotelDynamicPlayListModelDomain =
      HotelDynamicPlayListModelDomain.fromJson(json);

  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    HotelDynamicPlayListModelDomain model = hotelDynamicPlayListModelDomain;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelDynamicPlayListModelDomain mapFromModel =
        HotelDynamicPlayListModelDomain.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    HotelDynamicPlayListModelDomainData? model =
        hotelDynamicPlayListModelDomain.data;
    expect(model?.getRecentViewPlaylist != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    HotelDynamicPlayListModelDomainData mapFromModel =
        HotelDynamicPlayListModelDomainData.fromMap(map);
    expect(mapFromModel.getRecentViewPlaylist != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    HotelDynamicPlayListModelDomainData modelFromJson =
        HotelDynamicPlayListModelDomainData.fromJson(jsondata);
    expect(modelFromJson.getRecentViewPlaylist != null, true);
  });
  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    GetRecentViewPlaylist? model =
        hotelDynamicPlayListModelDomain.data?.getRecentViewPlaylist;
    expect(model?.dynamicPlaylist != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetRecentViewPlaylist mapFromModel = GetRecentViewPlaylist.fromMap(map);
    expect(mapFromModel.dynamicPlaylist != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetRecentViewPlaylist modelFromJson =
        GetRecentViewPlaylist.fromJson(jsondata);
    expect(modelFromJson.dynamicPlaylist != null, true);
  });
  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    DynamicPlaylist? model = hotelDynamicPlayListModelDomain
        .data?.getRecentViewPlaylist?.dynamicPlaylist;
    expect(model?.playlist != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    DynamicPlaylist mapFromModel = DynamicPlaylist.fromMap(map);
    expect(mapFromModel.playlist != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    DynamicPlaylist modelFromJson = DynamicPlaylist.fromJson(jsondata);
    expect(modelFromJson.playlist != null, true);
  });
  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    Playlist? model = hotelDynamicPlayListModelDomain
        .data?.getRecentViewPlaylist?.dynamicPlaylist?.playlist?.first;
    expect(model?.playlistName != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Playlist mapFromModel = Playlist.fromMap(map);
    expect(mapFromModel.playlistName != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    Playlist modelFromJson = Playlist.fromJson(jsondata);
    expect(modelFromJson.playlistName?.isNotEmpty, true);
  });
  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    CardList? model = hotelDynamicPlayListModelDomain
        .data
        ?.getRecentViewPlaylist
        ?.dynamicPlaylist
        ?.playlist
        ?.first
        .cardList
        ?.first;
    expect(model?.name != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    CardList mapFromModel = CardList.fromMap(map);
    expect(mapFromModel.name != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    CardList modelFromJson = CardList.fromJson(jsondata);
    expect(modelFromJson.name?.isNotEmpty, true);
  });
  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    CapsulePromotion? model = hotelDynamicPlayListModelDomain
        .data
        ?.getRecentViewPlaylist
        ?.dynamicPlaylist
        ?.playlist
        ?.first
        .cardList
        ?.first
        .capsulePromotion
        ?.first;
    expect(model?.name != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    CapsulePromotion mapFromModel = CapsulePromotion.fromMap(map);
    expect(mapFromModel.name != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    CapsulePromotion modelFromJson = CapsulePromotion.fromJson(jsondata);
    expect(modelFromJson.name?.isNotEmpty, true);
  });

  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    RecentViewPlaylist? model = hotelDynamicPlayListModelDomain
        .data?.getRecentViewPlaylist?.recentViewPlaylist?.first;
    expect(model?.hotelName != null, false);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    RecentViewPlaylist mapFromModel = RecentViewPlaylist.fromMap(map);
    expect(mapFromModel.hotelName != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("hotel dynamic playlist Result Model Domain", () {
    ///Convert into Model
    PromotionList? model = hotelDynamicPlayListModelDomain.data
        ?.getRecentViewPlaylist?.recentViewPlaylist?.first.promotionList?.first;
    expect(model?.line1 != null, true);

    // ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    PromotionList mapFromModel = PromotionList.fromMap(map);
    expect(mapFromModel.line1 != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    PromotionList modelFromJson = PromotionList.fromJson(jsondata);
    expect(modelFromJson.line1?.isNotEmpty, true);
  });
}
