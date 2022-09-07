import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_data_view_model.dart';

const String _kHotel = "OTA";

class OtaVerticalPlayListViewModel {
  Map<String, OtaVerticalPlayListDataViewModel> playlistMap;
  OtaVerticalPlayListDataViewModelState playListViewModelState;
  String selectedCategory;
  bool isInternetFailurePopupShown = false;

  OtaVerticalPlayListViewModel({
    this.selectedCategory = _kHotel,
    required this.playlistMap,
    this.playListViewModelState = OtaVerticalPlayListDataViewModelState.none,
  });
}

enum OtaVerticalPlayListDataViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
