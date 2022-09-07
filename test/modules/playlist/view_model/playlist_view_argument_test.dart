import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';

void main() {
  test(
    'Playlist View Argument Tests',
    () async {
      PlayListDataArgument playListDataArgument = PlayListDataArgument(
        userId: '1',
        epoch: '1001',
        lat: 0.0,
        long: 0.0,
      );
      PlaylistViewArgument playlistViewArgument =
          PlaylistViewArgument.fromPlaylistDataArguments(
        playListDataArgument,
        'Source',
        'Service Name',
        true,
        '12',
      );
      expect(playListDataArgument.userId, '1');
      expect(playListDataArgument.epoch, '1001');
      expect(playListDataArgument.lat, 0.0);
      expect(playListDataArgument.long, 0.0);
      expect(playlistViewArgument.source, 'Source');
      expect(playlistViewArgument.serviceName, 'Service Name');
    },
  );
}
