import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "hotel/hotel_landing_playlist/hotel_landing_dynamic_playlist.json");
  HotelLandingDynamicSingleData hotelLandingDynamicSingleData =
      HotelLandingDynamicSingleData.fromJson(json);
  GetPlaylists getPlaylists = GetPlaylists.fromJson(json);

  DynamicPlaylist dynamicPlaylist = DynamicPlaylist.fromJson(json);
  Playlist playlist = Playlist.fromJson(json);
  DynamicCardList dynamicCardList = DynamicCardList.fromJson(json);
  CapsulePromotion capsulePromotion = CapsulePromotion.fromJson(json);
  Review review = Review.fromJson(json);

  test("Hotel landing dynamic playlist data domain test ", () {
    ///Convert into Model
    HotelLandingDynamicSingleData model = hotelLandingDynamicSingleData;
    expect(model.getPlaylists != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelLandingDynamicSingleData mapFromModel =
        HotelLandingDynamicSingleData.fromMap(map);
    expect(mapFromModel.getPlaylists != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("GetPlaylists Model", () {
    ///Convert into Model
    GetPlaylists model = getPlaylists;
    expect(model.dynamicPlaylist != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetPlaylists mapFromModel = GetPlaylists.fromMap(map);
    expect(mapFromModel.dynamicPlaylist != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("DynamicPlaylist Model Data", () {
    ///Convert into Model
    DynamicPlaylist model = dynamicPlaylist;
    expect(model.playlist != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    DynamicPlaylist mapFromModel = DynamicPlaylist.fromMap(map);
    expect(mapFromModel.playlist != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Playlist Model Data", () {
    ///Convert into Model
    Playlist model = playlist;
    expect(model.cardList != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Playlist mapFromModel = Playlist.fromMap(map);
    expect(mapFromModel.cardList != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("DynamicCardList Model Data", () {
    ///Convert into Model
    DynamicCardList model = dynamicCardList;
    expect(model.name != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    DynamicCardList mapFromModel = DynamicCardList.fromMap(map);
    expect(mapFromModel.name != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("CapsulePromotion Model Data", () {
    ///Convert into Model
    CapsulePromotion model = capsulePromotion;
    expect(model.name != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CapsulePromotion mapFromModel = CapsulePromotion.fromMap(map);
    expect(mapFromModel.name != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Review Model Data", () {
    ///Convert into Model
    Review model = review;
    expect(model.description != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Review mapFromModel = Review.fromMap(map);
    expect(mapFromModel.description != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
