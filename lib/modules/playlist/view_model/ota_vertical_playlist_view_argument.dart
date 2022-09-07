import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';

class OtaVerticalPlaylistViewArgument {
  String? userId;
  double? latitude;
  double? longitude;
  int? epoch;
  int? maxValue;
  int offset;
  int limit;
  String? playlistId;
  String? source;
  String? productType;
  String serviceName;
  String playlistName;

  OtaVerticalPlaylistViewArgument({
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.epoch,
    required this.maxValue,
    required this.offset,
    required this.limit,
    required this.playlistId,
    required this.source,
    required this.productType,
    required this.serviceName,
    required this.playlistName,
  });

  factory OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
      StaticPlaylistArgumentDomain argument, String playlistName) {
    return OtaVerticalPlaylistViewArgument(
      userId: argument.userId,
      latitude: argument.latitude,
      longitude: argument.longitude,
      epoch: argument.epoch,
      maxValue: argument.maxValue,
      offset: argument.offset,
      limit: argument.limit,
      playlistId: argument.playlistId,
      source: argument.source,
      productType: argument.productType,
      serviceName: argument.serviceName,
      playlistName: playlistName,
    );
  }

  factory OtaVerticalPlaylistViewArgument.getDefaultInitialArguments(
      String userId, String source, String playlistName) {
    return OtaVerticalPlaylistViewArgument(
        userId: userId,
        latitude: 0,
        longitude: 0,
        epoch: Helpers.getEpochTime(),
        maxValue: 0,
        offset: 1,
        limit: 20,
        playlistId: "",
        source: source,
        productType: "",
        serviceName: "OTA",
        playlistName: playlistName);
  }
}
