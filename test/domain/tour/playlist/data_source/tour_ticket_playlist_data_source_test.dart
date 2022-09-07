import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/repositories/tour_ticket_playlist_repository_impl.dart';
import '../../../../mocks/tour/playlist/tour_and_ticket_mock.dart';
import '../../../../modules/hotel/repositories/Internet_success_mock.dart';
import '../../../playlist/repositories/playlist_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponse = MockPlayListGraphQl();
  TourTicketPlaylistArgumentDomain argument =
      getTourTicketPlaylistDataArgumentMock();
  TourTicketPlaylistRemoteDataSourceImpl.setMock(graphQlResponse);
  TourTicketPlaylistRepository tourTicketPlaylistRepository =
      TourAndTicketPlaylistRepositoryImpl(
          remoteDataSource: TourTicketPlaylistRemoteDataSourceImpl(),
          internetInfo: InternetSuccessMock());

  test("Landing Page Data Source", () {
    TourTicketPlaylistRemoteDataSource tourAndTicketRemoteDataSource =
        TourTicketPlaylistRemoteDataSourceImpl();
    TourTicketPlaylistRemoteDataSourceImpl.setMock(graphQlResponse);
    tourAndTicketRemoteDataSource.getTourTicketPlaylistData(argument);
  });
  test(
      'Landing Page analytics Repository '
      'When calling getTourTicketPlayListData '
      'With response data', () async {
    final result =
        await tourTicketPlaylistRepository.getTourTicketPlayListData(argument);
    expect(result!.isRight, true);
  });
}
