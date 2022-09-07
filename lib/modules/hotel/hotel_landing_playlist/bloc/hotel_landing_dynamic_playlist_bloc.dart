import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/usecases/hotel_landing_dynamic_room_usecases.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/bloc/hotel_landing_static_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_dynamic_argument_model.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';

class HotelLandingDynamicPlaylistBloc extends HotelLandingPlaylistBloc {
  HotelLandingDynamicUseCase dynamicUseCase = HotelLandingDynamicUseCasesImpl();

  @override
  PlaylistViewModel initDefaultValue() {
    return PlaylistViewModel(playlist: List.empty(growable: true));
  }

  Future<void> pullToRefresh(HotelLandingDynamicArgumentModel argument) async {
    state.offset = 0;
    state.playlist.clear();
    if (state.playlistState == PlaylistViewModelState.loading) {
      return;
    }
    state.playlistState = PlaylistViewModelState.loading;
    emit(state);
    state.playlist = await getPlayList(argument);
    if (state.playlist.isNotEmpty) {
      state.offset += state.playlist.length;
    }
    if (state.playlist.isEmpty) {
      if (state.playlistState != PlaylistViewModelState.internetFailure) {
        state.playlistState = PlaylistViewModelState.failure;
      }
      emit(state);
    } else {
      state.playlistState = PlaylistViewModelState.success;
      emit(state);
    }
  }

  Future<List<PlaylistCardViewModel>> getPlayList(
      HotelLandingDynamicArgumentModel argument) async {
    Either<Failure, HotelLandingDynamicSingleData?>? data =
        await dynamicUseCase.getPlaylist(HotelLandingDynamicSingleDataArgument(
      userId: argument.userId,
      epoch: argument.epoch ?? "0",
      lat: argument.lat ?? 0,
      long: argument.lng ?? 0,
      offset: state.offset,
      playlistId: argument.playlistId,
    ));
    if (data?.isLeft ?? true) {
      if (data?.left is InternetFailure) {
        state.playlistState = PlaylistViewModelState.internetFailure;
      }
      return [];
    }
    if (data?.right?.getPlaylists?.dynamicPlaylist?.playlist?.isEmpty ?? true) {
      return [];
    }

    return List<PlaylistCardViewModel>.generate(
        data?.right?.getPlaylists?.dynamicPlaylist?.playlist?.first.cardList
                ?.length ??
            0, (index) {
      return PlaylistCardViewModel.fromDynamicPlayList(data!
          .right!.getPlaylists!.dynamicPlaylist!.playlist!.first.cardList!
          .elementAt(index));
    });
  }

  Future<void> initiateApiCall(
      HotelLandingDynamicArgumentModel argument) async {
    state.offset = 0;
    state.playlist.clear();
    if (state.playlistState == PlaylistViewModelState.loading) {
      return;
    }
    state.playlistState = PlaylistViewModelState.loading;
    emit(state);
    state.playlist = await getPlayList(argument);
    if (state.playlist.isNotEmpty) {
      state.offset += state.playlist.length;
    }
    if (state.playlist.isEmpty) {
      if (state.playlistState != PlaylistViewModelState.internetFailure) {
        state.playlistState = PlaylistViewModelState.failure;
      }
      emit(state);
    } else {
      state.playlistState = PlaylistViewModelState.success;
      emit(state);
    }
  }

  Future<void> loadNextPage(HotelLandingDynamicArgumentModel argument) async {
    if (state.playlist.isEmpty) {
      return;
    }
    if (state.playlistState == PlaylistViewModelState.loading) {
      return;
    }
    state.playlistState = PlaylistViewModelState.loading;
    emit(state);
    List<PlaylistCardViewModel> data = await getPlayList(argument);
    if (data.isNotEmpty) {
      state.offset += state.playlist.length;

      state.playlist.addAll(data);
    }
    state.playlistState = PlaylistViewModelState.success;
    emit(state);
  }
}
