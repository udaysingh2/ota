import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';

class PlayListDataArgument {
  String userId;
  double lat;
  double long;
  String epoch;
  int? max;
  int? offset;
  int? limit;
  String? playlistName;
  String? source;
  String? serviceName;
  String? playlistId;
  PlayListDataArgument({
    required this.userId,
    required this.lat,
    required this.long,
    required this.epoch,
    this.max,
    this.offset,
    this.limit,
    this.playlistName,
    this.source,
    this.serviceName,
    this.playlistId,
  });

  factory PlayListDataArgument.fromViewArgument(PlaylistViewArgument argument,
      int max, int offset, int limit, String? playlistId,
      {String? serviceName}) {
    return PlayListDataArgument(
      userId: argument.userId,
      lat: argument.lat,
      long: argument.lng,
      epoch: argument.epoch,
      // playlistName: argument.playlistName,
      source: argument.source,
      serviceName: serviceName,
      max: max,
      offset: offset,
      limit: limit,
      playlistId: playlistId,
    );
  }

  String toGraphqlPlaylistInput() => '''{
        lat: $lat
        long: $long,
        epoch: $epoch
        ${max != null ? 'max: $max' : ''}
        ${offset != null ? 'offset: $offset' : ''}
        ${limit != null ? 'limit: $limit' : ''}
        ${source != null ? 'source: "$source"' : ''}
        ${serviceName != null ? 'serviceName: "$serviceName"' : ''}
        ${playlistId != null ? 'playlistId: "$playlistId"' : ''}
      }''';

  factory PlayListDataArgument.getDefaultInitialArguments(
      String userId, String source) {
    return PlayListDataArgument(
      userId: userId,
      lat: 0,
      long: 0,
      epoch: Helpers.getEpochTime().toString(),
      offset: 0,
      limit: 20,
      source: source,
      serviceName: "OTA",
    );
  }
}
