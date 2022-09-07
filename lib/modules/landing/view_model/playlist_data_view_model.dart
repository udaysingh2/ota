import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/modules/landing/view_model/playlist_card_view_model.dart';

class PlayListDataViewModel {
  final String name;
  final String source;
  final String serviceName;
  final List<OtaLandingPlayListModel> playList;

  PlayListDataViewModel(
      {this.name = "",
      this.source = "",
      this.serviceName = "",
      this.playList = const []});

  factory PlayListDataViewModel.fromModel(IcPlaylist icPlaylist) {
    return PlayListDataViewModel(
      source: icPlaylist.source ?? '',
      serviceName: icPlaylist.serviceName ?? '',
      playList: List<OtaLandingPlayListModel>.generate(
          icPlaylist.playlist?.length ?? 0, (index) {
        return OtaLandingPlayListModel.fromList(icPlaylist.playlist![index]);
      }),
    );
  }
}

class OtaLandingPlayListModel {
  String playlistId;
  String playlistName;
  List<PlaylistCardViewModel> cardList;

  OtaLandingPlayListModel({
    this.playlistId = "",
    this.playlistName = "",
    this.cardList = const [],
  });

  factory OtaLandingPlayListModel.fromList(Playlist list) {
    return OtaLandingPlayListModel(
      playlistId: list.playlistId ?? '',
      playlistName: list.playlistName ?? '',
      cardList:
          List<PlaylistCardViewModel>.generate(list.cardList!.length, (index) {
        return PlaylistCardViewModel.fromOtaLandingList(list.cardList![index]);
      }),
    );
  }
}
