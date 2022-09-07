import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/playlist/repositories/tour_ticket_playlist_repository_impl.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_mock.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_remote_data_source_failure_mock.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_remote_data_source_impl_mock.dart';
import '../../../../modules/hotel/repositories/Internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/Internet_success_mock.dart';

void main() {
  TourTicketPlaylistRepository? playlistRepositoryServerException;
  TourTicketPlaylistRepository? playListRepositoryMock;
  TourTicketPlaylistRepository? playListRepositoryInternetFailure;
  TourTicketPlaylistArgumentDomain argument =
      getTourTicketPlaylistDataArgumentMock();

  setUpAll(() async {
    /// Code coverage for default implementation.
    playListRepositoryMock = TourAndTicketPlaylistRepositoryImpl();

    /// Code coverage for mock class
    playListRepositoryMock = TourAndTicketPlaylistRepositoryImpl(
        remoteDataSource: TourTicketPlaylistRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    playlistRepositoryServerException = TourAndTicketPlaylistRepositoryImpl(
        remoteDataSource: TourAndTicketPlayListRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    playListRepositoryInternetFailure = TourAndTicketPlaylistRepositoryImpl(
        remoteDataSource: TourTicketPlaylistRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Playlist analytics Repository '
      'When calling getTourAndTicketPlayListData '
      'With Success response data', () async {
    /// Consent user cases impl
    final tourTicketPlaylistResult =
        await playListRepositoryMock!.getTourTicketPlayListData(argument);

    /// Get model from mock data.
    final TourTicketPlaylistModelDomain model = tourTicketPlaylistResult!.right;

    /// Condition check for hotel value null
    expect(model.getTourAndTicketPlaylist != null, true);
  });

  test(
      'PlayList analytics Repository '
      'When calling getTourAndTicketPlayListData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await playListRepositoryInternetFailure!
        .getTourTicketPlayListData(argument);

    expect(consentResult!.isLeft, true);
  });

  test(
      'PlayList analytics Repository '
      'When calling getTourAndTicketPlayListData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final playlistResult = await playlistRepositoryServerException!
        .getTourTicketPlayListData(argument);

    expect(playlistResult!.isLeft, true);
  });
}
