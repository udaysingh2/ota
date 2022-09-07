import 'package:ota/common/utils/helper.dart';

class HotelStaticPlayListArgumentModelDomain {
  String userId;
  double lat;
  double long;
  String epoch;
  int? max;
  int? offset;
  int? limit;
  String? playlistId;
  String? source;
  String? serviceName;
  HotelStaticPlayListArgumentModelDomain({
    required this.userId,
    required this.lat,
    required this.long,
    required this.epoch,
    this.max,
    this.offset,
    this.limit,
    this.playlistId,
    this.source,
    this.serviceName,
  });

  String toGraphqlPlaylistInput() => '''{
        lat: $lat
        long: $long
        ${epoch.isNotEmpty ? 'epoch: $epoch' : 'epoch: 0'}
        ${max != null ? 'max: $max' : ''}
        ${offset != null ? 'offset: $offset' : ''}
        ${limit != null ? 'limit: $limit' : ''}
        ${playlistId != null ? 'playlistId: "$playlistId"' : ''}
         ${source != null ? 'source: "$source"' : 'source: "static"'}
        ${serviceName != null ? 'serviceName: "$serviceName"' : 'serviceName: "HOTEL"'}
      }''';

  factory HotelStaticPlayListArgumentModelDomain.getDefaultInitialArguments(
      String userId) {
    return HotelStaticPlayListArgumentModelDomain(
      userId: userId,
      lat: 0,
      long: 0,
      epoch: Helpers.getEpochTime().toString(),
      offset: 0,
      limit: 20,
      source: "static",
      serviceName: "HOTEL",
    );
  }
}
