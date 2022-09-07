class HotelBookingArgumentDomain {
  final String serviceType;
  final String activityType;
  final int limit;
  final int pageNo;

  HotelBookingArgumentDomain({
    required this.serviceType,
    required this.activityType,
    required this.limit,
    required this.pageNo,
  });
}
