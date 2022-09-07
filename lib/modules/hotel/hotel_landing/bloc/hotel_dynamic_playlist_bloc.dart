import 'package:either_dart/either.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/usecases/hotel_dynamic_playlist_usecase.dart';
import 'package:ota/modules/hotel/hotel_landing/helpers/hotel_landing_helper.dart';

import '../../../../common/network/failures.dart';
import '../../../../core_components/bloc/bloc.dart';
import '../../../../domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import '../../../../domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import '../view_model/hotel_dynamic_playlist_view_models.dart';
import '../view_model/hotel_recentviewplaylist_view_model.dart';

class HotelDynamicPlaylistBloc extends Bloc<HotelDynamicPlayListViewModel> {
  HotelDynamicPlaylistUseCases playlistUseCases =
      HotelDynamicPlaylistUseCasesImpl();

  @override
  HotelDynamicPlayListViewModel initDefaultValue() {
    return HotelDynamicPlayListViewModel();
  }

  bool checkIfRecentPlayListExists(HotelDynamicPlayListModelDomainData? data) {
    if (data == null) return false;
    if (data.getRecentViewPlaylist?.recentViewPlaylist == null) {
      return false;
    }
    if (data.getRecentViewPlaylist!.recentViewPlaylist!.isEmpty) {
      return false;
    }
    return true;
  }

  bool checkIfDynamicPlaylistExists(HotelDynamicPlayListModelDomainData? data) {
    if (data == null) return false;
    if (data.getRecentViewPlaylist?.dynamicPlaylist?.playlist == null) {
      return false;
    }
    if (data.getRecentViewPlaylist!.dynamicPlaylist!.playlist!.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> getDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain argument) async {
    state.hotelDynamicPlayListViewModelState =
        HotelDynamicPlayListViewModelState.loading;
    emit(state);

    Either<Failure, HotelDynamicPlayListModelDomainData>? result =
        await playlistUseCases.getDynamicPlayListData(argument: argument);

    if (result != null && result.isRight) {
      HotelDynamicPlayListModelDomainData? getPlayListdata = result.right;

      if (checkIfRecentPlayListExists(getPlayListdata)) {
        state.recentPlayList = HotelRecentPlayListViewModel(
            playListName: getPlayListdata.getRecentViewPlaylist?.listType ?? '',
            playList: List<HotelRecentPlayListModel>.generate(
                getPlayListdata.getRecentViewPlaylist!.recentViewPlaylist!
                    .length, (index) {
              return HotelRecentPlayListModel.fromList(getPlayListdata
                  .getRecentViewPlaylist!.recentViewPlaylist![index]);
            }));

        state.hotelDynamicPlayListViewModelState =
            HotelDynamicPlayListViewModelState.recentPlayListSuccess;
        emit(state);
      } else if (checkIfDynamicPlaylistExists(getPlayListdata)) {
        state.dynamicPlaylist = HotelDynamicPlayListModel(
            serviceName: getPlayListdata
                    .getRecentViewPlaylist!.dynamicPlaylist!.serviceName ??
                '',
            source: getPlayListdata
                    .getRecentViewPlaylist!.dynamicPlaylist!.source ??
                '',
            playlist: HotelLandingHelper.getdynamicPlayList(getPlayListdata
                    .getRecentViewPlaylist!.dynamicPlaylist!.playlist ??
                []));

        state.hotelDynamicPlayListViewModelState =
            HotelDynamicPlayListViewModelState.dynamicPlayListSuccess;
        emit(state);
      } else {
        state.hotelDynamicPlayListViewModelState =
            HotelDynamicPlayListViewModelState.failure;
        emit(state);
      }
    } else {
      state.hotelDynamicPlayListViewModelState =
          HotelDynamicPlayListViewModelState.failure;
      emit(state);
    }
  }
}
