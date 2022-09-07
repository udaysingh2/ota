import 'hotel_playlist_view_model.dart';
import 'hotel_recentviewplaylist_view_model.dart';

class HotelDynamicPlayListViewModel {
  HotelRecentPlayListViewModel? recentPlayList;
  HotelDynamicPlayListViewModelState hotelDynamicPlayListViewModelState;
  HotelDynamicPlayListModel? dynamicPlaylist;

  HotelDynamicPlayListViewModel(
      {this.recentPlayList,
      this.dynamicPlaylist,
      this.hotelDynamicPlayListViewModelState =
          HotelDynamicPlayListViewModelState.none});
}

class HotelDynamicPlayListModel {
  String serviceName;
  String source;
  List<HotelStaticPlayListModel> playlist;
  HotelDynamicPlayListModel({
    this.serviceName = '',
    this.source = '',
    this.playlist = const [],
  });
}

enum HotelDynamicPlayListViewModelState {
  none,
  loading,
  pullDownLoading,
  recentPlayListSuccess,
  dynamicPlayListSuccess,
  failure,
}
