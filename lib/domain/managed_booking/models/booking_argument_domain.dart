class BookingArgumentDomain {
  final String serviceType;
  final String activityType;
  final int limit;
  final int pageNo;

  BookingArgumentDomain({
    required this.serviceType,
    required this.activityType,
    required this.limit,
    required this.pageNo,
  });
}
