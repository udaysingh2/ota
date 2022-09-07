import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/usecases/hotel_static_playlist_usecase.dart';
import 'package:ota/modules/hotel/hotel_landing/helpers/hotel_landing_helper.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';

class HotelPlaylistBloc extends Bloc<HotelStaticPlayListViewModel> {
  HotelStaticPlaylistUseCases playlistUseCases =
      HotelStaticPlaylistUseCasesImpl();

  @override
  HotelStaticPlayListViewModel initDefaultValue() {
    return HotelStaticPlayListViewModel(playList: []);
  }

  Future<void> getPlayListData(
      HotelStaticPlayListArgumentModelDomain? argument) async {
    if (argument == null) {
      state.hotelStaticPlayListViewModelState =
          HotelStaticPlayListViewModelState.failure;
      emit(state);
      return;
    }
    state.hotelStaticPlayListViewModelState =
        HotelStaticPlayListViewModelState.loading;
    emit(state);

    Either<Failure, HotelStaticPlayListModelDomain>? result =
        await playlistUseCases.getHotelStaticPlayListData(argument: argument);
    if (result != null && result.isRight) {
      HotelStaticPlayListModelDomain getStaticPlaylists = result.right;
      if (getStaticPlaylists.getPlaylists?.staticPlaylist?.playlist != null) {
        state.playList = List<HotelStaticPlayListModel>.generate(
            getStaticPlaylists.getPlaylists!.staticPlaylist!.playlist!.length,
            (index) {
          return HotelStaticPlayListModel(
              playlistId: getStaticPlaylists.getPlaylists!.staticPlaylist!
                      .playlist![index].playlistId ??
                  '',
              playlistName: getStaticPlaylists.getPlaylists!.staticPlaylist!
                      .playlist![index].playlistName ??
                  '',
              hotelStaticCardPlaylist:
                  HotelLandingHelper.getHotelStaticPlaylist(getStaticPlaylists
                          .getPlaylists!
                          .staticPlaylist!
                          .playlist![index]
                          .cardList ??
                      []));
        });
        state.hotelStaticPlayListViewModelState =
            HotelStaticPlayListViewModelState.success;
        emit(state);
      } else {
        state.hotelStaticPlayListViewModelState =
            HotelStaticPlayListViewModelState.failure;
        emit(state);
      }
    } else {
      state.hotelStaticPlayListViewModelState =
          HotelStaticPlayListViewModelState.failure;
      emit(state);
    }
  }
}
