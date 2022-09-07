import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';
import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_view_model.dart';

class DynamicPlayListBloc extends Bloc<PlayListViewModel> {
  PlayListUseCasesImpl playlistUseCases = PlayListUseCasesImpl();

  @override
  PlayListViewModel initDefaultValue() {
    return PlayListViewModel(staticPlaylist: PlayListDataViewModel(), dynamicPlaylist: PlayListDataViewModel());
  }

  Future<void> getDynamicPlayListData({
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
      GetPlaylists? getDynamicPlaylists = result.right.getPlaylists;
      if (getDynamicPlaylists == null) {
        state.playListViewModelState = PlayListViewModelState.failure;
        emit(state);
        return;
      }

      if (getDynamicPlaylists.dynamicPlaylist != null) {
        state.playListViewModelState = PlayListViewModelState.success;
          state.dynamicPlaylist = PlayListDataViewModel.fromModel(
                getDynamicPlaylists.dynamicPlaylist!);
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
