import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/playlist/view_model/statis_playlist_view_model.dart';

const int _kDefaultStarRating = 1;
const int _kMaxStarRating = 5;

class StaticPlaylistHelper {
  static List<StaticPlaylistCardViewModel>? getPlaylistCardViewModelList(
      List<ListElement>? list) {
    List<StaticPlaylistCardViewModel>? playlistCardViewModelList;
    if (list == null || list.isEmpty) return playlistCardViewModelList;

    playlistCardViewModelList = List<StaticPlaylistCardViewModel>.generate(
      list.length,
      (index) => StaticPlaylistCardViewModel.fromListElement(list[index]),
    );
    return playlistCardViewModelList;
  }

  static String updateStarRating(double rating) {
    if (rating <= _kDefaultStarRating) {
      return _kDefaultStarRating.toString();
    } else if (rating >= _kMaxStarRating) {
      return _kMaxStarRating.toString();
    } else {
      return rating.toString();
    }
  }
}
