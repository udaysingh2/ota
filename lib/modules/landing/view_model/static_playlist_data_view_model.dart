import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/view_model/landing_static_playlist_card_view_model.dart';

class StaticPlayListDataViewModel {
  final String? serviceName;
  final List<OtaLandingStaticPlayListModel> playList;

  StaticPlayListDataViewModel({this.serviceName, this.playList = const []});

  factory StaticPlayListDataViewModel.fromModel(OtaStaticCardListData data) {
    return StaticPlayListDataViewModel(
      serviceName: data.serviceName,
      playList: List<OtaLandingStaticPlayListModel>.generate(
          data.playlist!.length, (index) {
        return OtaLandingStaticPlayListModel.fromList(data.playlist![index]);
      }),
    );
  }
}

class OtaLandingStaticPlayListModel {
  String? playlistId;
  String? playlistName;
  List<LandingStaticPlayListCardViewModel>? cardList;

  OtaLandingStaticPlayListModel({
    this.playlistId,
    this.playlistName,
    this.cardList,
  });

  factory OtaLandingStaticPlayListModel.fromList(OtaStaticPlaylist list) {
    return OtaLandingStaticPlayListModel(
      playlistId: list.playlistId,
      playlistName: list.playlistName,
      cardList: List<LandingStaticPlayListCardViewModel>.generate(
          list.cardList!.length, (index) {
        return LandingStaticPlayListCardViewModel.fromCardList(
            list.cardList![index]);
      }),
    );
  }
}
