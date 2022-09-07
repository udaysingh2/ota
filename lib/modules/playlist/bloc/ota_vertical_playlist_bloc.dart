import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/static_playlist/usecases/static_playlist_usecases.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_data_view_model.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_model.dart';

class OtaVerticalPlaylistBloc extends Bloc<OtaVerticalPlayListViewModel> {
  OtaStaticPlaylistUseCases playlistUseCases = OtaStaticPlaylistUseCasesImpl();
  String category = "";

  @override
  initDefaultValue() {
    return OtaVerticalPlayListViewModel(playlistMap: {});
  }

  void fetchPlaylistData({
    OtaVerticalPlaylistViewArgument? argument,
    required bool isForceFetch,
  }) async {
    if (argument == null) {
      state.playListViewModelState =
          OtaVerticalPlayListDataViewModelState.failure;
      emit(state);
      return;
    }
    if (isForceFetch) {
      state.playListViewModelState =
          OtaVerticalPlayListDataViewModelState.loading;
      emit(state);
    }

    Either<Failure, StaticPlayListModelDomain>? result =
        await playlistUseCases.getOtaStaticPlaylist(
      _getPlayListDataArgument(argument),
    );

    if (result != null && result.isRight) {
      OtaStaticCardListData? data = result.right.getPlaylists!.data;
      if (data != null && data.playlist != null) {
        final otaVerticalPlayListDataViewModel =
            OtaVerticalPlayListDataViewModel.fromModel(data);
        if (isPlaylistDataAvailable(getCategory) && category == getCategory) {
          if (otaVerticalPlayListDataViewModel.playList.isNotEmpty) {
            state.playlistMap[getCategory]?.playList.first.verticalCardList
                .addAll(otaVerticalPlayListDataViewModel
                    .playList.first.verticalCardList);
          }
          state.playListViewModelState =
              OtaVerticalPlayListDataViewModelState.success;
          state.isInternetFailurePopupShown = false;
        } else if (otaVerticalPlayListDataViewModel.playList.isNotEmpty) {
          state.playlistMap[getCategory] = otaVerticalPlayListDataViewModel;
          state.playListViewModelState =
              OtaVerticalPlayListDataViewModelState.success;
          state.isInternetFailurePopupShown = false;
        } else {
          state.playListViewModelState =
              OtaVerticalPlayListDataViewModelState.failure;
        }
      } else {
        state.playListViewModelState =
            OtaVerticalPlayListDataViewModelState.failure;
      }
      category = state.selectedCategory;
    } else {
      if (result?.left is InternetFailure) {
        state.isInternetFailurePopupShown = false;
        state.playListViewModelState =
            OtaVerticalPlayListDataViewModelState.internetFailure;
      } else {
        state.playListViewModelState =
            OtaVerticalPlayListDataViewModelState.failure;
      }
    }

    emit(state);
  }

  bool isPlaylistDataAvailable(String categoryName) {
    return state.playlistMap.isNotEmpty &&
        state.playlistMap.containsKey(categoryName) &&
        state.playlistMap[categoryName] != null &&
        state.playlistMap[categoryName]!.playList.isNotEmpty;
  }

  bool get anySuggestions =>
      state.playlistMap[getCategory]?.playList.isNotEmpty ?? false;

  void setSelectedCategory(String selectedCategory) {
    state.selectedCategory = selectedCategory;
    emit(state);
  }

  String get getCategory => state.selectedCategory;

  int getSelectedCatIndex(BuildContext context) {
    List<String> categories = getAllCategories(context);
    int index = categories.indexOf(state.selectedCategory);
    return index >= 0 && index < categories.length ? index : 0;
  }

  List<String> getAllCategories(BuildContext context) {
    return PlaylistHelper.getCategoryName(context);
  }

  StaticPlaylistArgumentDomain _getPlayListDataArgument(
      OtaVerticalPlaylistViewArgument argument) {
    /// It's initial playlist load
    if (state.playlistMap[getCategory]?.playList.isEmpty ?? true) {
      return StaticPlaylistArgumentDomain.fromViewArgument(
          argument, AppConfig().configModel.otaSearchServicesEnabled);
    } else {
      /// lazy load
      return StaticPlaylistArgumentDomain.fromViewArgument(
          argument, AppConfig().configModel.otaSearchServicesEnabled);
    }
  }

  void setInternetPopupShown() {
    state.isInternetFailurePopupShown = true;
  }

  void emitSuccess() async {
    bool isInternetConnected = await _isInternetConnected();
    if (isInternetConnected) {
      state.playListViewModelState =
          OtaVerticalPlayListDataViewModelState.success;
      emit(state);
    } else {
      state.playListViewModelState =
          OtaVerticalPlayListDataViewModelState.internetFailure;
      emit(state);
    }
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  bool get isLoading =>
      state.playListViewModelState ==
      OtaVerticalPlayListDataViewModelState.loading;

  bool get isInternetFailurePopupShown => state.isInternetFailurePopupShown;
}
