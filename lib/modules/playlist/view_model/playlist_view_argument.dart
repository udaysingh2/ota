import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';

class PlaylistViewArgument {
  String userId;
  double lat;
  double lng;
  String epoch;
  String? playlistName;
  String source;
  String serviceName;
  bool isStatic;
  String? playlisId;

  PlaylistViewArgument({
    required this.userId,
    required this.lat,
    required this.lng,
    required this.epoch,
    this.playlistName,
    required this.source,
    required this.serviceName,
    this.isStatic = false,
    this.playlisId,
  });

  factory PlaylistViewArgument.fromPlaylistDataArguments(
    PlayListDataArgument? argument,
    String source,
    String serviceName,
    bool isStatic,
    String? playlistId,
  ) {
    return PlaylistViewArgument(
      userId: argument?.userId ?? '',
      lat: argument?.lat ?? 0,
      lng: argument?.long ?? 0,
      epoch: argument?.epoch ?? '',
      source: source,
      serviceName: serviceName,
      isStatic: isStatic,
      playlisId: playlistId,
    );
  }

  factory PlaylistViewArgument.getDefaultStaticArguments(String userId) {
    return PlaylistViewArgument(
      userId: userId,
      lat: 0,
      lng: 0,
      epoch: Helpers.getEpochTime().toString(),
      source: 'static',
      serviceName: '',
    );
  }
}
