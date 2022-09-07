import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';

void main() {
  test('For DynamicPlayListDataArgumentModelDomain class', () {
    DynamicPlayListDataArgumentModelDomain actual =
        DynamicPlayListDataArgumentModelDomain(
      userId: 'userId',
      lat: 0.0,
      long: 0.0,
      epoch: 'epoch',
      offset: 1,
      playlistName: 'playlistName',
      source: 'source',
      serviceName: 'serviceName',
      limit: 1,
      max: 1,
    );

    expect(actual.userId.isNotEmpty, true);
    expect(actual.lat == 0.0, true);
    expect(actual.offset, 1);
    expect(actual.playlistName, 'playlistName');
  });

  test('DynamicPlayListDataArgumentModelDomain toGraphqlPlaylistInput', () {
    final actual1 = DynamicPlayListDataArgumentModelDomain(
      userId: 'userId',
      lat: 0.0,
      long: 0.0,
      epoch: '123456',
    ).toGraphqlPlaylistInput();

    expect(actual1.isNotEmpty, true);
  });

  test('For DynamicPlayListDataArgumentModelDomain fromViewArgument', () {
    final factory = DynamicPlayListDataArgumentModelDomain.fromViewArgument(
        PlaylistViewArgument(
            userId: 'userId',
            lat: 0.0,
            lng: 0.0,
            epoch: '12345678',
            source: 'source',
            serviceName: 'serviceName'),
        1,
        1,
        1);

    expect(factory.userId.isNotEmpty, true);
    expect(factory.long, 0.0);
    expect(factory.serviceName?.isEmpty, true);

    ///getDefaultInitialArguments
    final defaultArgs =
        DynamicPlayListDataArgumentModelDomain.getDefaultInitialArguments(
            'userId');

    expect(defaultArgs.userId.isNotEmpty, true);
    expect(defaultArgs.lat, 0.0);
    expect(defaultArgs.limit, 20);
    expect(factory.serviceName?.isEmpty, true);
  });
}
