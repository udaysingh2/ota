import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/usecases/hotel_landing_static_room_usecases.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_static_argument_model.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';

abstract class HotelLandingPlaylistBloc extends Bloc<PlaylistViewModel> {}

class HotelLandingStaticPlaylistBloc extends HotelLandingPlaylistBloc {
  HotelLandingStaticUseCase staticUseCase = HotelLandingStaticUseCasesImpl();

  @override
  PlaylistViewModel initDefaultValue() {
    return PlaylistViewModel(playlist: List.empty(growable: true));
  }

  Future<void> pullToRefresh(HotelLandingStaticArgumentModel argument) async {
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
      HotelLandingStaticArgumentModel argument) async {
    Either<Failure, HotelLandingStaticSingleData?>? data =
        await staticUseCase.getPlaylist(HotelLandingStaticSingleDataArgument(
      playlistId: argument.playlistId ?? "",
      offset: state.offset,
      epoch: argument.epoch ?? '0',
      lat: argument.lat ?? 0,
      long: argument.lng ?? 0,
      userId: argument.userId,
    ));
    if (data?.isLeft ?? true) {
      if (data?.left is InternetFailure) {
        state.playlistState = PlaylistViewModelState.internetFailure;
      }
      return [];
    }
    if (data?.right?.getPlaylists?.staticPlaylist?.playlist?.isEmpty ?? true) {
      return [];
    }
    return List<PlaylistCardViewModel>.generate(
        data?.right?.getPlaylists?.staticPlaylist?.playlist?.first.cardList
                ?.length ??
            0, (index) {
      return PlaylistCardViewModel.fromStaticPlayList(data!
          .right!.getPlaylists!.staticPlaylist!.playlist!.first.cardList!
          .elementAt(index));
    });
  }

  Future<void> initiateApiCall(HotelLandingStaticArgumentModel argument) async {
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

  Future<void> loadNextPage(HotelLandingStaticArgumentModel argument) async {
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
