import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_argument.dart';

const double _kDefaultDouble = 0;
const int _kDefaultInt = 0;
const int _kDefaultLimit = 20;
const String _kDefaultServiceName = "OTA";
const String _kDefaultString = "";

class StaticPlaylistArgumentDomain {
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
  String enabledServices;

  StaticPlaylistArgumentDomain({
    this.userId,
    this.latitude,
    this.longitude,
    this.epoch,
    this.maxValue,
    required this.offset,
    required this.limit,
    this.playlistId,
    this.source,
    this.productType,
    required this.serviceName,
    required this.enabledServices,
  });

  Map<String, dynamic> toMap() => {
        if (latitude != null) "latitude": latitude,
        if (longitude != null) "longitude": longitude,
        if (epoch != null) "epoch": epoch,
        if (maxValue != null) "maxValue": maxValue,
        "offset": offset,
        "limit": limit,
        if (playlistId != null)
          "playlistId": playlistId!.surroundWithDoubleQuote(),
        if (source != null) "source": source!.surroundWithDoubleQuote(),
        if (productType != null)
          "productType": productType!.surroundWithDoubleQuote(),
        "serviceName": serviceName.surroundWithDoubleQuote(),
      };

  factory StaticPlaylistArgumentDomain.getDefaultArguments(
      {required String userId,
      required String source,
      required String id,
      required String enabledServices}) {
    return StaticPlaylistArgumentDomain(
        userId: userId,
        latitude: _kDefaultDouble,
        longitude: _kDefaultDouble,
        epoch: Helpers.getEpochTime(),
        maxValue: _kDefaultInt,
        offset: _kDefaultInt,
        limit: _kDefaultLimit,
        playlistId: id,
        source: source,
        productType: _kDefaultString,
        serviceName: _kDefaultServiceName,
        enabledServices: enabledServices);
  }

  factory StaticPlaylistArgumentDomain.getDefaultInitialArguments(
      {required int offset,
      required int limit,
      required String serviceName,
      required String enabledServices}) {
    return StaticPlaylistArgumentDomain(
        offset: offset,
        limit: limit,
        serviceName: serviceName,
        enabledServices: enabledServices);
  }

  factory StaticPlaylistArgumentDomain.fromViewArgument(
      OtaVerticalPlaylistViewArgument argument, String enabledServices) {
    return StaticPlaylistArgumentDomain(
        offset: argument.offset,
        limit: argument.limit,
        playlistId: argument.playlistId,
        productType: argument.productType,
        serviceName: argument.serviceName,
        enabledServices: enabledServices);
  }
}
