import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/playlist_remote_datasource_impl_failure_mock.dart';
import '../repositories/playlist_remote_datasource_impl_moc.dart';

void main() {
  PlayListRepository? playlistRepositoryServerException;
  PlayListRepository? playListRepositoryMock;
  PlayListRepository? playListRepositoryInternetFailure;
  PlayListDataArgument argument = PlayListDataArgument(
      userId: "1", lat: 14.040885, long: 100.614385, epoch: "1629791595");

  setUpAll(() async {
    /// Code coverage for default implementation.
    playListRepositoryMock = PlayListRepositoryImpl();

    /// Code coverage for mock class
    playListRepositoryMock = PlayListRepositoryImpl(
        remoteDataSource: PlayListRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    playlistRepositoryServerException = PlayListRepositoryImpl(
        remoteDataSource: PlayListRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    playListRepositoryInternetFailure = PlayListRepositoryImpl(
        remoteDataSource: PlayListRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Playlist analytics Repository '
      'When calling getPlayListResultModelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await playListRepositoryMock!.getPlayListData(argument);

    /// Get model from mock data.
    final PlaylistResultModelDomain model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getPlaylists != null, true);
  });

  test(
      'PlayList analytics Repository '
      'When calling getPlayListData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult =
        await playListRepositoryInternetFailure!.getPlayListData(argument);

    expect(consentResult.isLeft, true);
  });

  test(
      'PlayList analytics Repository '
      'When calling getPlayListData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final playlistResult =
        await playlistRepositoryServerException!.getPlayListData(argument);

    expect(playlistResult.isLeft, true);
  });
}
