import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';

class PlayListViewModel {
  PlayListDataViewModel staticPlaylist;
  PlayListDataViewModel dynamicPlaylist;
  PlayListViewModelState playListViewModelState;

  PlayListViewModel({
    required this.staticPlaylist,
    required this.dynamicPlaylist,
    this.playListViewModelState = PlayListViewModelState.none,
  });
}

enum PlayListViewModelState {
  none,
  loading,
  success,
  failure,
}
