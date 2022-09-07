import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture("hotel_playlist/hotel_static_playlist.json");
  HotelStaticPlayListModelDomain response =
      HotelStaticPlayListModelDomain.fromJson(json);

  test("hotel static playlist Result Model Domain", () async {
    ///Convert into Model
    HotelStaticPlayListModelDomain model = response;
    expect(model.getPlaylists != null, true);
    expect(model.getPlaylists?.staticPlaylist != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Convert to json
    String json = model.toJson();
    expect(json.isNotEmpty, true);

    ///Check map conversion
    HotelStaticPlayListModelDomain mapFromModel =
        HotelStaticPlayListModelDomain.fromMap(map);
    expect(mapFromModel.getPlaylists != null, true);
    expect(mapFromModel.getPlaylists?.staticPlaylist != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test("hotel static playlist Result Model Domain", () {
    ///Convert into Model
    HotelStaticPlayListModelDomain model = response;
    expect(model.getPlaylists?.staticPlaylist?.playlist != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Convert to json
    String json = model.toJson();
    expect(json.isNotEmpty, true);

    ///Check map conversion
    HotelStaticPlayListModelDomain mapFromModel =
        HotelStaticPlayListModelDomain.fromMap(map);
    expect(mapFromModel.getPlaylists?.staticPlaylist?.playlist != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
