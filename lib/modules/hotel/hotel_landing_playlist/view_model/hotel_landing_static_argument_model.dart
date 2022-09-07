class HotelLandingStaticArgumentModel {
  String userId;
  double? lat;
  double? lng;
  String? epoch;
  String? serviceName;
  String? playlistId;
  String playlistName;

  HotelLandingStaticArgumentModel({
    required this.userId,
    this.lat,
    this.lng,
    this.epoch,
    required this.playlistId,
    this.serviceName,
    required this.playlistName,
  });
}
