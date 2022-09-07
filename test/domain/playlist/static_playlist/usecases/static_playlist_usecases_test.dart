import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/static_playlist/data_sources/static_playlist_mock_data_source.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/playlist/static_playlist/repositories/static_playlist_repository_impl.dart';
import 'package:ota/domain/playlist/static_playlist/usecases/static_playlist_usecase.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  StaticPlaylistUseCases? staticPlaylistUseCases;

  setUpAll(() async {
    staticPlaylistUseCases = StaticPlaylistUseCasesImpl(
        repository: StaticPlaylistRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: StaticPlayListMockDataSourceImpl()));
  });
  test('Static Playlist UseCases ', () async {
    /// Consent user cases impl
    final staticPlaylistResult =
        await staticPlaylistUseCases!.getStaticPlayListData();

    /// Get model from mock data.
    final StaticPlaylistModelDomain? model = staticPlaylistResult?.right;

    expect(model!.getStaticPlaylists == null, false);
  });
}
