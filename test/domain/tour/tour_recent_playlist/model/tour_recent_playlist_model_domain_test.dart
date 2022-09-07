import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/tour_recent_playlist/data_sources/tour_recent_playlist_remote_source_mock.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';

void main() {
  TourRecentPlaylistModelDomain staticPlaylistModel =
      TourRecentPlaylistModelDomain.fromJson(
          TourRecentPlaylistMockDataSourceImpl.getMockData());

  test("Static Playlist Models", () {
    //Convert into Model
    expect(staticPlaylistModel.getTourRecentlyViewedItems != null, true);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    TourRecentPlaylistModelDomain mapFromModel =
        TourRecentPlaylistModelDomain.fromMap(map);

    expect(mapFromModel.getTourRecentlyViewedItems != null, true);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetTourRecentlyViewedItems", () {
    GetTourRecentlyViewedItems getTourRecentlyViewedItems =
        GetTourRecentlyViewedItems.fromJson(staticPlaylistModel.toJson());
    //Convert into Model
    expect(getTourRecentlyViewedItems.data != null, false);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    GetTourRecentlyViewedItems mapFromModel =
        GetTourRecentlyViewedItems.fromMap(map);

    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Data", () {
    Data getTourRecentlyViewedItems =
        Data.fromJson(staticPlaylistModel.toJson());
    //Convert into Model
    expect(getTourRecentlyViewedItems.recentViewPlaylist != null, false);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);

    expect(mapFromModel.recentViewPlaylist != null, false);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("RecentViewPlaylist", () {
    RecentViewPlaylist getTourRecentlyViewedItems =
        RecentViewPlaylist.fromJson(staticPlaylistModel.toJson());
    //Convert into Model
    expect(getTourRecentlyViewedItems.name != null, false);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    RecentViewPlaylist mapFromModel = RecentViewPlaylist.fromMap(map);

    expect(mapFromModel.name != null, false);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Promotions", () {
    Promotions getTourRecentlyViewedItems =
        Promotions.fromJson(staticPlaylistModel.toJson());
    //Convert into Model
    expect(getTourRecentlyViewedItems.title != null, false);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    Promotions mapFromModel = Promotions.fromMap(map);

    expect(mapFromModel.title != null, false);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Status", () {
    Status getTourRecentlyViewedItems =
        Status.fromJson(staticPlaylistModel.toJson());
    //Convert into Model
    expect(getTourRecentlyViewedItems.description != null, false);

    //convert into map
    Map<String, dynamic> map = staticPlaylistModel.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);

    expect(mapFromModel.description != null, false);

    ///Convert to String
    String stringData = staticPlaylistModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = staticPlaylistModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
