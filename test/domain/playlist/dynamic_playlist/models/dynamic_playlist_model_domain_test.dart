import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("playlist/dynamic_playlist_result_model.json");
  DynamicPlaylistModel dynamicPlaylistModel =
      DynamicPlaylistModel.fromJson(jsonString);
  test("Playlist Model", () {
    ///Convert into Model
    expect(dynamicPlaylistModel.getDynamicPlaylists != null, true);

    ///Convert to String
    String stringData = dynamicPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = dynamicPlaylistModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("get Dynamic Playlists", () {
    GetDynamicPlaylists getDynamicPlaylists =
        GetDynamicPlaylists.fromJson(jsonString);
    //convert into map
    Map<String, dynamic> map = getDynamicPlaylists.toMap();
    expect(map.isNotEmpty, true);

    GetDynamicPlaylists mapFromModel = GetDynamicPlaylists.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Datum", () {
    Datum datum = Datum.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = datum.toMap();
    Datum mapFromModel = Datum.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = datum.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("ListElement", () {
    ListElement listElement = ListElement.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = listElement.toMap();
    ListElement mapFromModel = ListElement.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Review", () {
    Review review = Review.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = review.toMap();
    Review mapFromModel = Review.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Promotion", () {
    Promotion promotion = Promotion.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = promotion.toMap();
    Promotion mapFromModel = Promotion.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Address", () {
    Address address = Address.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = address.toMap();
    Address mapFromModel = Address.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("AdminPromotion", () {
    AdminPromotion adminPromotion = AdminPromotion.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = adminPromotion.toMap();
    AdminPromotion mapFromModel = AdminPromotion.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Status", () {
    Status status = Status.fromJson(jsonString);

    //convert into map
    Map<String, dynamic> map = status.toMap();
    Status mapFromModel = Status.fromMap(map);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
