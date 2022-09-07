import 'package:ota/modules/landing/view_model/static_playlist_data_view_model.dart';

class StaticPlayListViewModel {
  StaticPlayListDataViewModel staticPlaylist;
  StaticPlayListViewModelState playListViewModelState;

  StaticPlayListViewModel({
    required this.staticPlaylist,
    this.playListViewModelState = StaticPlayListViewModelState.none,
  });
}

enum StaticPlayListViewModelState {
  none,
  loading,
  success,
  failure,
}
