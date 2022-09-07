import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/playlist/view_model/vertical_static_playlist_card_view_model.dart';

class OtaVerticalPlayListDataViewModel {
  final String? serviceName;
  List<OtaVerticalStaticPlayListModel> playList;

  OtaVerticalPlayListDataViewModel(
      {this.serviceName, this.playList = const []});

  factory OtaVerticalPlayListDataViewModel.fromModel(
      OtaStaticCardListData data) {
    return OtaVerticalPlayListDataViewModel(
      serviceName: data.serviceName,
      playList: List<OtaVerticalStaticPlayListModel>.generate(
          data.playlist!.length, (index) {
        return OtaVerticalStaticPlayListModel.fromList(data.playlist![index]);
      }),
    );
  }
}

class OtaVerticalStaticPlayListModel {
  String? playlistId;
  String? playlistName;
  List<VerticalStaticPlayListCardViewModel> verticalCardList;

  OtaVerticalStaticPlayListModel({
    this.playlistId,
    this.playlistName,
    this.verticalCardList = const [],
  });

  factory OtaVerticalStaticPlayListModel.fromList(OtaStaticPlaylist list) {
    return OtaVerticalStaticPlayListModel(
      playlistId: list.playlistId,
      playlistName: list.playlistName,
      verticalCardList: List<VerticalStaticPlayListCardViewModel>.generate(
          list.cardList!.length, (index) {
        return VerticalStaticPlayListCardViewModel.fromCardList(
            list.cardList![index]);
      }),
    );
  }
}
