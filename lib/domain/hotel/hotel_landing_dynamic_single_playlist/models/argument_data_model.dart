class HotelLandingDynamicSingleDataArgument {
  HotelLandingDynamicSingleDataArgument(
      {this.offset = 1,
      this.limit = 20,
      this.epoch = "0",
      this.lat = 0,
      this.long = 0,
      this.max = 200,
      required this.userId,
      required this.playlistId,
      this.serviceName = "HOTEL"});

  final String serviceName;
  final int offset;
  final int limit;
  final int max;
  final double lat;
  final double long;
  final String epoch;
  final String userId;
  final String playlistId;
}
