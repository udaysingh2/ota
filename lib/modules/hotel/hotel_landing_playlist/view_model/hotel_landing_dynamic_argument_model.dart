class HotelLandingDynamicArgumentModel {
  String userId;
  double? lat;
  double? lng;
  String? epoch;
  String? serviceName;
  String playlistId;

  HotelLandingDynamicArgumentModel({
    required this.userId,
    this.lat,
    this.lng,
    this.epoch,
    required this.playlistId,
    this.serviceName,
  });
}
