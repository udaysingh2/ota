class TourRecentPlaylistArgumentDomain {
  String serviceName;
  int offset;
  int limit;

  TourRecentPlaylistArgumentDomain({
    required this.serviceName,
    required this.offset,
    required this.limit,
  });
  factory TourRecentPlaylistArgumentDomain.getDefaultInitialArguments(
      ) {
    return TourRecentPlaylistArgumentDomain(
      offset: 0,
      limit: 20,
      serviceName: "TOUR",
    );
  }
}
