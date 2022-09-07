import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';

const String _kHotel = "OTA";

class PlaylistViewModel {
  Map<String, List<FullPlaylistCardViewModel>> playlistMap;
  String selectedCategory;
  PlaylistViewModelState playlistState;
  bool isInternetFailurePopupShown = false;
  PlaylistViewModel({
    required this.playlistMap,
    this.selectedCategory = _kHotel,
    this.playlistState = PlaylistViewModelState.none,
  });
}

enum PlaylistViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  internetFailure,
}
