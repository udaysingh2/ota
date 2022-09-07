import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';

import '../repositories/playlist_repository_impl_success_mock.dart';

void main() {
  PlayListUseCases? playListUseCases;
  PlayListDataArgument argument = PlayListDataArgument(
      userId: "1", lat: 14.040885, long: 100.614385, epoch: "1629791595");
  setUpAll(() async {
    /// Code coverage for default implementation.
    playListUseCases = PlayListUseCasesImpl();

    /// Code coverage for mock class
    playListUseCases =
        PlayListUseCasesImpl(repository: PlayListRepositoryImplSuccessMock());
  });

  test(
      'PlayList analytics usecases '
      'When calling getPlayListData '
      'With Success response data', () async {
    /// Consent user cases impl
    final playListResult =
        await playListUseCases!.getPlayListData(argument: argument);

    /// Get model from mock data.
    final PlaylistResultModelDomain model = playListResult!.right;

    /// Condition check for playlist value null
    expect(model.getPlaylists != null, true);
  });
}
