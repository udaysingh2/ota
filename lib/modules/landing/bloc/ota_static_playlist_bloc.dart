import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/static_playlist/usecases/static_playlist_usecases.dart';
import 'package:ota/modules/landing/view_model/static_playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/static_playlist_view_model.dart';

class OtaStaticPlayListBloc extends Bloc<StaticPlayListViewModel> {
  OtaStaticPlaylistUseCases playlistUseCases = OtaStaticPlaylistUseCasesImpl();

  @override
  StaticPlayListViewModel initDefaultValue() {
    return StaticPlayListViewModel(
        staticPlaylist: StaticPlayListDataViewModel());
  }

  Future<void> getPlayListData({
    required StaticPlaylistArgumentDomain? argument,
  }) async {
    state.playListViewModelState = StaticPlayListViewModelState.loading;
    emit(state);

    Either<Failure, StaticPlayListModelDomain>? result =
        await playlistUseCases.getOtaStaticPlaylist(argument!);

    if (result != null && result.isRight) {
      OtaStaticCardListData? staticCardListData =
          result.right.getPlaylists!.data;
      if (staticCardListData != null &&
          staticCardListData.serviceName != null &&
          staticCardListData.playlist != null &&
          staticCardListData.playlist!.isNotEmpty) {
        state.staticPlaylist =
            StaticPlayListDataViewModel.fromModel(staticCardListData);
        state.playListViewModelState = StaticPlayListViewModelState.success;
      } else {
        state.playListViewModelState = StaticPlayListViewModelState.failure;
      }
      emit(state);
    } else {
      state.playListViewModelState = StaticPlayListViewModelState.failure;
      emit(state);
    }
  }
}
