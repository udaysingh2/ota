import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';

class DynamicPlayListDataArgumentModelDomain {
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
  DynamicPlayListDataArgumentModelDomain({
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

  factory DynamicPlayListDataArgumentModelDomain.fromViewArgument(
      PlaylistViewArgument argument, int max, int offset, int limit,
      {String? serviceName}) {
    return DynamicPlayListDataArgumentModelDomain(
      userId: argument.userId,
      lat: argument.lat,
      long: argument.lng,
      epoch: argument.epoch,
      playlistName: argument.playlistName,
      max: max,
      offset: offset,
      limit: limit,
      serviceName: serviceName ?? "",
    );
  }

  String toGraphqlPlaylistInput() => '''{
        lat: $lat
        long: $long
        epoch: $epoch
        ${max != null ? 'max: $max' : ''}
        ${offset != null ? 'offset: $offset' : ''}
        ${limit != null ? 'limit: $limit' : ''}
        ${playlistName != null ? 'playlistName: "$playlistName"' : ''}
        ${serviceName != null ? 'serviceName: "$serviceName"' : ''}
      }''';

  factory DynamicPlayListDataArgumentModelDomain.getDefaultInitialArguments(
      String userId) {
    return DynamicPlayListDataArgumentModelDomain(
      userId: userId,
      lat: 0,
      long: 0,
      epoch: Helpers.getEpochTime().toString(),
      offset: 0,
      limit: 20,
      serviceName: "",
    );
  }
}
