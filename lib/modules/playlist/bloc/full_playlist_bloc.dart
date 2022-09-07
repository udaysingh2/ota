import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';
import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_model.dart';

const int _kMax = 200;
const int _kDynamicPlaylistLimit = 20;
const int _kStaticPlaylistLimit = 1000;

const String _kSourceStatic = 'static';

class FullPlaylistBloc extends Bloc<PlaylistViewModel> {
  PlayListUseCases playlistUseCases = PlayListUseCasesImpl();
  @override
  initDefaultValue() {
    return PlaylistViewModel(
        playlistMap: <String, List<FullPlaylistCardViewModel>>{});
  }

  void fetchPlaylistData(
      {PlaylistViewArgument? argument, bool isPullToRefresh = false}) async {
    if (argument == null) {
      state.playlistState = PlaylistViewModelState.failure;
      emit(state);
      return;
    }
    state.playlistState = PlaylistViewModelState.loading;
    emit(state);

    Either<Failure, PlaylistResultModelDomain>? result =
        await playlistUseCases.getPlayListData(
      argument: _getPlayListDataArgument(argument),
    );

    if (result != null && result.isRight) {
      IcPlaylist? playlist = argument.source == _kSourceStatic
          ? result.right.getPlaylists?.staticPlaylist
          : result.right.getPlaylists?.dynamicPlaylist;
      if (playlist != null) {
        _updatePlaylistMapInState([playlist]);
        if (argument.serviceName.isEmpty) {
          state.selectedCategory = getAllCategories().first;
        } else {
          state.selectedCategory = argument.serviceName;
        }
        state.playlistState = PlaylistViewModelState.success;
        emit(state);
      } else {
        state.playlistState = PlaylistViewModelState.failure;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.playlistState = PlaylistViewModelState.internetFailure;
      emit(state);
    } else {
      state.playlistState = PlaylistViewModelState.failure;
      emit(state);
    }
  }

  _updatePlaylistMapInState(List<IcPlaylist> playlist) {
    if (playlist.isNotEmpty) {
      for (IcPlaylist playlistItem in playlist) {
        List<Playlist> playList = playlistItem.playlist ?? [];
        String categoryName = playlistItem.serviceName ?? '';
        for (Playlist item in playList) {
          List<FullPlaylistCardViewModel> playlistCardModelList =
              PlaylistHelper.getPlaylistCardViewModelList(item.cardList) ?? [];

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

  List<FullPlaylistCardViewModel> getPlaylistOfSelectedCategory() {
    if (state.playlistMap.containsKey(state.selectedCategory)) {
      return state.playlistMap[state.selectedCategory] ?? [];
    }
    return [];
  }

  PlayListDataArgument _getPlayListDataArgument(PlaylistViewArgument argument) {
    /// It's initial playlist load
    if (state.playlistMap.isEmpty) {
      return PlayListDataArgument.fromViewArgument(
        argument,
        _kMax,
        _getPlaylistCountOfSelectedCat(),
        argument.source == _kSourceStatic
            ? _kStaticPlaylistLimit
            : _kDynamicPlaylistLimit,
        argument.playlisId,
        serviceName: state.selectedCategory,
      );
    } else {
      /// lazy load
      return PlayListDataArgument.fromViewArgument(
        argument,
        _kMax,
        _getPlaylistCountOfSelectedCat(),
        argument.source == _kSourceStatic
            ? _kStaticPlaylistLimit
            : _kDynamicPlaylistLimit,
        argument.playlisId,
        serviceName: state.selectedCategory,
      );
    }
  }

  int _getPlaylistCountOfSelectedCat() {
    List<FullPlaylistCardViewModel>? playlist =
        state.playlistMap[state.selectedCategory];
    return playlist != null && playlist.isNotEmpty ? playlist.length : 0;
  }

  void setInternetFailurePopupShown() {
    state.isInternetFailurePopupShown = true;
  }

  void setInternetFailurePopupNotShown() {
    state.isInternetFailurePopupShown = false;
  }

  bool get isInternetFailurePopupShown => state.isInternetFailurePopupShown;
}
