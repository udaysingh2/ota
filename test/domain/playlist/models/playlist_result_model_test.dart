import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("playlist/playlist_result_model.json");
  String json1 = fixture("playlist/ic_playlist_result.json");
  PlaylistResultModelDomain playlistResultModel =
  PlaylistResultModelDomain.fromJson(jsonString);
  test("Playlist Model", () {
    ///Convert into Model
    expect(playlistResultModel.getPlaylists != null, true);

    ///Convert to String
    String stringData = playlistResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = playlistResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("getPlaylists", () {
    GetPlaylists getPlaylists =
    GetPlaylists.fromJson(playlistResultModel.getPlaylists!.toJson());
    //convert into map
    Map<String, dynamic> map = getPlaylists.toMap();
    expect(map.isNotEmpty, true);

    GetPlaylists mapFromModel = GetPlaylists.fromMap(map);
    expect(mapFromModel.dynamicPlaylist != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("IC Playlist", () {
    IcPlaylist icPlaylist = IcPlaylist.fromJson(json1);

    //convert into map
    Map<String, dynamic> map = icPlaylist.toMap();
    IcPlaylist mapFromModel = IcPlaylist.fromMap(map);
    expect(mapFromModel.playlist!.isNotEmpty, true);

    ///Convert to String
    String stringData = icPlaylist.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = icPlaylist.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
