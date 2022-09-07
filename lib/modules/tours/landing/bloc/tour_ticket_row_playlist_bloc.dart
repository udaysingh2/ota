import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/playlist/usecases/tour_ticket_playlist_usecases.dart';
import 'package:ota/modules/tours/landing/helpers/tour_landing_helper.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';

const int _kLimit = 20;

class TourTicketRowPlaylistBloc extends Bloc<TourTicketRowPlaylistViewModel> {
  @override
  TourTicketRowPlaylistViewModel initDefaultValue() {
    return TourTicketRowPlaylistViewModel();
  }

  void getTourTicketPlaylistData(String userId, String playlistName) async {
    state.playlistState = TourTicketRowPlaylistViewModelState.loading;
    emit(state);

    TourTicketPlaylistUseCasesImpl playlistUseCasesImpl =
        TourTicketPlaylistUseCasesImpl();

    final domainArgument = TourTicketPlaylistArgumentDomain.forRowPlaylist(
        userId, playlistName, _kLimit);
    Either<Failure, TourTicketPlaylistModelDomain?>? result =
        await playlistUseCasesImpl.getTourTicketPlaylistData(domainArgument);

    if (result?.isRight ?? false) {
      TourTicketPlaylistModelDomain? playlistResult = result!.right;
      String? statusCode =
          playlistResult?.getTourAndTicketPlaylist?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.playlistState = TourTicketRowPlaylistViewModelState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.playlistState = TourTicketRowPlaylistViewModelState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        final tourTicketPlaylistModels =
            TourLandingHelper.getTourTicketPlaylist(
                playlistResult?.getTourAndTicketPlaylist?.data?.listOfPlaylist);
        state.tourTicketPlaylist = tourTicketPlaylistModels;
        state.playlistId =
            playlistResult?.getTourAndTicketPlaylist?.data?.playlistId;
        state.playlistName =
            playlistResult?.getTourAndTicketPlaylist?.data?.playlistName;
        state.playlistState = TourTicketRowPlaylistViewModelState.success;
        emit(state);
      } else {
        state.playlistState = TourTicketRowPlaylistViewModelState.failure;
        emit(state);
      }
    } else {
      state.playlistState = TourTicketRowPlaylistViewModelState.failure;
      emit(state);
    }
  }

  bool get isLoading =>
      state.playlistState == TourTicketRowPlaylistViewModelState.loading;

  bool get isFaliure =>
      state.playlistState == TourTicketRowPlaylistViewModelState.failure;

  bool get isPlaylistAvailable =>
      state.playlistState == TourTicketRowPlaylistViewModelState.success &&
      state.tourTicketPlaylist != null &&
      state.tourTicketPlaylist!.isNotEmpty;
}
