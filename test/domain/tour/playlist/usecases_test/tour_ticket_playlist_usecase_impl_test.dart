import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/playlist/usecases/tour_ticket_playlist_usecases.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_mock.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_repository_impl_success_mock.dart';

void main() {
  TourTicketPlaylistUseCases? playListUseCases;
  TourTicketPlaylistArgumentDomain argument =
      getTourTicketPlaylistDataArgumentMock();
  setUpAll(() async {
    /// Code coverage for default implementation.
    playListUseCases = TourTicketPlaylistUseCasesImpl();

    /// Code coverage for mock class
    playListUseCases = TourTicketPlaylistUseCasesImpl(
        repository: TourAndTicketPlaylistRepositoryImplSuccessMock());
  });

  test(
      'PlayList analytics usecases '
      'When calling getTourAndTicketPlayListData '
      'With Success response data', () async {
    /// Consent user cases impl
    final playListResult =
        await playListUseCases!.getTourTicketPlaylistData(argument);

    /// Get model from mock data.
    final TourTicketPlaylistModelDomain? model = playListResult!.right;

    /// Condition check for playlist value null
    expect(model!.getTourAndTicketPlaylist != null, true);
  });
}
