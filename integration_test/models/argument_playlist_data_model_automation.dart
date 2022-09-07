import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';

class PlayListDataArgumentAutomation {
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
  PlayListDataArgumentAutomation({
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
  });

  factory PlayListDataArgumentAutomation.fromViewArgument(
      PlaylistViewArgument argument, int max, int offset, int limit,
      {String? serviceName}) {
    return PlayListDataArgumentAutomation(
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
    );
  }

  String toGraphqlPlaylistInput() => '''{
        userId: "$userId"
        lat: $lat
        long: $long,
        epoch: $epoch
        ${max != null ? 'max: $max' : ''}
        ${offset != null ? 'offset: $offset' : ''}
        ${limit != null ? 'limit: $limit' : ''}
        ${source != null ? 'source: "$source"' : ''}
        ${serviceName != null ? 'serviceName: "$serviceName"' : ''}
        ${playlistName != null ? 'playlistName: "$playlistName"' : ''}
      }''';
}
