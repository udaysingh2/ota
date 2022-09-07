import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/playlist/usecases/tour_ticket_playlist_usecases.dart';
import 'package:ota/modules/tours/playlist/helpers/tour_ticket_playlist_helper.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

class TourTicketPlaylistBloc extends Bloc<TourTicketPlaylistViewModel> {
  TourTicketPlaylistUseCasesImpl playListUseCasesImpl =
      TourTicketPlaylistUseCasesImpl();
  @override
  TourTicketPlaylistViewModel initDefaultValue() {
    return TourTicketPlaylistViewModel(
        pageState: TourTicketPlaylistScreenPageState.initial);
  }

  void initData(TourTicketPlaylistArgument? argument) {
    if (argument != null && argument.tourTicketplaylist.isNotEmpty) {
      state.tourTicketPlaylist = argument.tourTicketplaylist;
      state.pageState = TourTicketPlaylistScreenPageState.loading;
      emit(state);
    }
  }

  Future<void> getTourAndTicketPlaylist(
      TourTicketPlaylistArgument? argument) async {
    if (argument == null) {
      _emitFailure();
      return;
    }

    state.pageState = TourTicketPlaylistScreenPageState.loading;
    emit(state);

    final domainArgument =
        TourTicketPlaylistArgumentDomain.fromArgument(argument);

    Either<Failure, TourTicketPlaylistModelDomain?>? result =
        await playListUseCasesImpl.getTourTicketPlaylistData(domainArgument);
    if (result?.isRight ?? false) {
      TourTicketPlaylistModelDomain? playlistResult = result!.right;
      String? statusCode =
          playlistResult?.getTourAndTicketPlaylist?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.pageState = TourTicketPlaylistScreenPageState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.pageState = TourTicketPlaylistScreenPageState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        List<TourTicketPlaylistModel>? tourTicketPlaylistModels =
            TourTicketPlaylistHelper.getTourTicketPlaylist(
                playlistResult?.getTourAndTicketPlaylist?.data?.listOfPlaylist);

        _isPlaylistNotNullEmpty
            ? state.tourTicketPlaylist!.addAll(tourTicketPlaylistModels)
            : state.tourTicketPlaylist = tourTicketPlaylistModels;
        state.playlistId =
            playlistResult?.getTourAndTicketPlaylist?.data?.playlistId;
        state.playlistName =
            playlistResult?.getTourAndTicketPlaylist?.data?.playlistName;
        state.pageState = TourTicketPlaylistScreenPageState.success;
        emit(state);
      } else {
        _emitFailure();
      }
    } else if (result?.left is InternetFailure) {
      state.pageState = TourTicketPlaylistScreenPageState.internetFailure;
      emit(state);
      return;
    } else {
      _emitFailure();
    }
  }

  void _emitFailure() {
    state.pageState = TourTicketPlaylistScreenPageState.failure;
    emit(state);
  }

  bool get _isPlaylistNotNullEmpty =>
      state.tourTicketPlaylist != null && state.tourTicketPlaylist!.isNotEmpty;

  int get playlistSize =>
      state.tourTicketPlaylist != null ? state.tourTicketPlaylist!.length : 0;

  bool get isLoading =>
      state.pageState == TourTicketPlaylistScreenPageState.loading &&
      playlistSize == 0;

  bool get isSuccess =>
      state.pageState == TourTicketPlaylistScreenPageState.success;

  bool get isFailure =>
      state.pageState == TourTicketPlaylistScreenPageState.failure ||
      state.pageState == TourTicketPlaylistScreenPageState.failure1899 ||
      state.pageState == TourTicketPlaylistScreenPageState.failure1999 ||
      state.pageState == TourTicketPlaylistScreenPageState.internetFailure;
}
