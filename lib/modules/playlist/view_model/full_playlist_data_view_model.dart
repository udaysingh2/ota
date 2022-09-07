import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';

class FullPlayListDataViewModel {
  final String name;
  final String source;
  final String serviceName;
  final List<FullPlaylistCardViewModel> cardList;

  FullPlayListDataViewModel(
      {this.name = "", this.source = "", this.serviceName = "", this.cardList = const []});

  factory FullPlayListDataViewModel.fromModel(IcPlaylist icPlaylist, Playlist playList) {
    return FullPlayListDataViewModel(
      source: icPlaylist.source ?? '',
      serviceName: icPlaylist.serviceName ?? '',
      cardList: List<FullPlaylistCardViewModel>.generate(playList.cardList!.length,
              (index) {
            return FullPlaylistCardViewModel.fromList(playList.cardList![index]);
          }),
    );
  }

}
