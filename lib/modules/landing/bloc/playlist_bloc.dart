import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';
import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_view_model.dart';

class PlayListBloc extends Bloc<PlayListViewModel> {
  PlayListUseCases playlistUseCases = PlayListUseCasesImpl();

  @override
  PlayListViewModel initDefaultValue() {
    return PlayListViewModel(staticPlaylist: PlayListDataViewModel(), dynamicPlaylist: PlayListDataViewModel());
  }

  Future<void> getPlayListData({
    required PlayListDataArgument? argument,
  }) async {
    if (argument == null) {
      state.playListViewModelState = PlayListViewModelState.failure;
      emit(state);
      return;
    }

    state.playListViewModelState = PlayListViewModelState.loading;
    emit(state);

    Either<Failure, PlaylistResultModelDomain>? result =
        (await playlistUseCases.getPlayListData(
      argument: argument,
    ));

    if (result != null && result.isRight) {
      if (result.right.getPlaylists == null) {
        state.playListViewModelState = PlayListViewModelState.success;
        emit(state);
        return;
      }

      state.playListViewModelState = PlayListViewModelState.success;
      if (result.right.getPlaylists?.staticPlaylist != null) {
        state.staticPlaylist =  PlayListDataViewModel.fromModel(
              result.right.getPlaylists!.staticPlaylist!);
      } else {
        state.staticPlaylist = PlayListDataViewModel();
      }

      if (result.right.getPlaylists?.dynamicPlaylist != null) {
        state.dynamicPlaylist = PlayListDataViewModel.fromModel(
              result.right.getPlaylists!.dynamicPlaylist!);
      } else {
        state.dynamicPlaylist = PlayListDataViewModel();
      }
      emit(state);
    } else {
      state.playListViewModelState = PlayListViewModelState.failure;
      emit(state);
    }
  }
}
