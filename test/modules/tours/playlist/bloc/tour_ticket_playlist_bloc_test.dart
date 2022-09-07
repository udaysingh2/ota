import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/playlist/repositories/tour_ticket_playlist_repository_impl.dart';
import 'package:ota/domain/tours/playlist/usecases/tour_ticket_playlist_usecases.dart';
import 'package:ota/modules/tours/playlist/bloc/tour_ticket_playlist_bloc.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

import '../../../../mocks/tour/playlist/tour_and_ticket_mock.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_remote_data_source_impl_mock.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_repository_impl_success_mock.dart';
import '../../../hotel/repositories/Internet_failure_mock.dart';

void main() {
  TourTicketPlaylistBloc bloc = TourTicketPlaylistBloc();
  TourTicketPlaylistArgument playlistViewArgument =
      getTourTicketPlaylistArgumentMock();

  test("Full playlist Bloc with mocked repository with null data pass", () {
    bloc.playListUseCasesImpl = TourTicketPlaylistUseCasesImpl(
        repository: TourAndTicketPlaylistRepositoryImplSuccessMock());
    bloc.getTourAndTicketPlaylist(playlistViewArgument);
    expect(bloc.state.pageState, TourTicketPlaylistScreenPageState.loading);
  });
  test("Full playlist Bloc with mocked repository with Internet Failure", () {
    bloc.playListUseCasesImpl = TourTicketPlaylistUseCasesImpl(
      repository: TourAndTicketPlaylistRepositoryImpl(
          remoteDataSource: TourTicketPlaylistRemoteDataSourceImplSuccessMock(),
          internetInfo: InternetFailureMock()),
    );
    bloc.getTourAndTicketPlaylist(playlistViewArgument);
    expect(bloc.state.pageState, TourTicketPlaylistScreenPageState.loading);
  });

  test("Full playlist Bloc with null argument", () {
    bloc.getTourAndTicketPlaylist(null);
    expect(bloc.state.pageState, TourTicketPlaylistScreenPageState.failure);
  });

  test("Full playlist Bloc with mocked repository and playlist data", () {
    bloc.playListUseCasesImpl = TourTicketPlaylistUseCasesImpl(
        repository: TourAndTicketPlaylistRepositoryImpl());
    bloc.getTourAndTicketPlaylist(playlistViewArgument);
    expect(bloc.state.pageState, TourTicketPlaylistScreenPageState.loading);
    expect(bloc.state.tourTicketPlaylist!.isNotEmpty, true);
  });
}
