import 'package:ota/common/utils/helper.dart';

class HotelDynamicPlayListDataArgumentModelDomain {
  String userId;
  double lat;
  double long;
  String epoch;
  int? offset;
  int? limit;
  String? serviceName;
  HotelDynamicPlayListDataArgumentModelDomain({
    required this.userId,
    required this.lat,
    required this.long,
    required this.epoch,
    this.offset,
    this.limit,
    this.serviceName,
  });

  String toGraphqlDynamicPlaylistInput() => '''{
        lat: $lat
        long: $long
        ${epoch.isNotEmpty ? 'epoch: $epoch' : 'epoch: 0'}
        ${offset != null ? 'offset: $offset' : ''}
        ${limit != null ? 'limit: $limit' : ''}
       ${serviceName != null ? 'serviceName: "$serviceName"' : 'serviceName: "HOTEL"'}
      }''';

  factory HotelDynamicPlayListDataArgumentModelDomain.getDefaultInitialArguments(
      String userId) {
    return HotelDynamicPlayListDataArgumentModelDomain(
      userId: userId,
      lat: 0,
      long: 0,
      epoch: Helpers.getEpochTime().toString(),
      offset: 0,
      limit: 20,
      serviceName: "HOTEL",
    );
  }
}
