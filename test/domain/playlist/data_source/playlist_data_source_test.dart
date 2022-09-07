import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/playlist/data_sources/playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/playlist_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList = MockPlayListGraphQl();
  PlayListDataArgument argument = PlayListDataArgument(
      userId: "1", lat: 14.040885, long: 100.614385, epoch: "1629791595");
  PlayListRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  PlayListRepository playListRepository = PlayListRepositoryImpl(
      remoteDataSource: PlayListRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Landing Page Data Source", () {
    PlayListRemoteDataSource galleryRemoteDataSource =
        PlayListRemoteDataSourceImpl();
    PlayListRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
    galleryRemoteDataSource.getPlayListData(argument);
  });
  test(
      'Landing Page analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await playListRepository.getPlayListData(argument);

    expect(consentResult.isRight, true);
  });
}
