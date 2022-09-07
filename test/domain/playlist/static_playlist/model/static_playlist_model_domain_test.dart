import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("playlist/static_playlist_model_domain.json");
  StaticPlaylistModelDomain staticPlaylistModel =
      StaticPlaylistModelDomain.fromJson(jsonString);

  test("Static Playlist Models", () {
    //Convert into Model
    expect(staticPlaylistModel.getStaticPlaylists != null, true);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    StaticPlaylistModelDomain mapFromModel =
        StaticPlaylistModelDomain.fromMap(map);

    expect(mapFromModel.getStaticPlaylists != null, true);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Datum data = Datum.fromJson(staticPlaylistModel.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Datum mapFromModel = Datum.fromMap(map);
    expect(mapFromModel.playList != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Review", () {
    Review data = Review.fromJson(staticPlaylistModel.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Review mapFromModel = Review.fromMap(map);
    expect(mapFromModel.description != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Promotion", () {
    Promotion data = Promotion.fromJson(staticPlaylistModel.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Promotion mapFromModel = Promotion.fromMap(map);
    expect(mapFromModel.promotionText != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
