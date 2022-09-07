import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/playlist/static_playlist/usecases/static_playlist_usecase.dart';
import 'package:ota/modules/playlist/helpers/static_playlist_helper.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/statis_playlist_view_model.dart';

class FullStaticPlayListBloc extends Bloc<StaticPlaylistViewModel> {
  StaticPlaylistUseCases playlistUseCases = StaticPlaylistUseCasesImpl();

  @override
  StaticPlaylistViewModel initDefaultValue() {
    return StaticPlaylistViewModel(
        playlistMap: <String, List<StaticPlaylistCardViewModel>>{});
  }

  Future<void> getPlayListData({
    required PlaylistViewArgument? argument,
  }) async {
    state.playlistState = StaticPlaylistViewModelState.loading;
    emit(state);

    if (argument == null) {
      state.playlistState = StaticPlaylistViewModelState.failure;
      emit(state);
      return;
    }

    Either<Failure, StaticPlaylistModelDomain>? result =
        await playlistUseCases.getStaticPlayListData();

    if (result != null && result.isRight) {
      List<Datum>? getStaticPlaylists = result.right.getStaticPlaylists?.data;
      if (getStaticPlaylists != null && getStaticPlaylists.isNotEmpty) {
        _updatePlaylistMapInState(getStaticPlaylists);
        if (argument.serviceName.isEmpty) {
          state.selectedCategory = getAllCategories().first;
        } else {
          state.selectedCategory = argument.serviceName;
        }
        state.playlistState = StaticPlaylistViewModelState.success;
        emit(state);
      } else {
        state.playlistState = StaticPlaylistViewModelState.failure;
      }
      emit(state);
    } else {
      state.playlistState = StaticPlaylistViewModelState.failure;
      emit(state);
    }
  }

  _updatePlaylistMapInState(List<Datum> playlist) {
    if (playlist.isNotEmpty) {
      for (Datum playlistItem in playlist) {
        List<PlayList> playList = playlistItem.playList ?? [];
        String categoryName = playlistItem.serviceName ?? '';
        for (PlayList item in playList) {
          List<StaticPlaylistCardViewModel> playlistCardModelList =
              StaticPlaylistHelper.getPlaylistCardViewModelList(item.list) ??
                  [];

          /// Skip if categoryName (serviceName) or its playlist (list) are empty
          if (categoryName.isNotEmpty && playlistCardModelList.isNotEmpty) {
            if (!state.playlistMap.containsKey(categoryName)) {
              state.playlistMap[categoryName] = playlistCardModelList;
            } else {
              state.playlistMap[categoryName]?.addAll(playlistCardModelList);
            }
          }
        }
      }
    }
  }

  setSelectedCategory(String selectedCategory) {
    state.selectedCategory = selectedCategory;
    emit(state);
  }

  int getSelectedCatIndex() {
    List<String> categories = getAllCategories();
    int index = categories.indexOf(state.selectedCategory);
    return index >= 0 && index < categories.length ? index : 0;
  }

  List<String> getAllCategories() {
    return state.playlistMap.keys.toList();
  }

  List<StaticPlaylistCardViewModel> getPlaylistOfSelectedCategory() {
    if (state.playlistMap.containsKey(state.selectedCategory)) {
      return state.playlistMap[state.selectedCategory] ?? [];
    }
    return [];
  }
}
