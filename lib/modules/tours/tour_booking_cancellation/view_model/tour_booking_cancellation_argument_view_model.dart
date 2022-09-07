class TourBookingCancellationArgumentViewModel {
  String? cancellationPolicyList;
  final String confirmNo;
  final String bookingUrn;
  final String bookingStatus;
  final String? confirmationDate;
  final String? bookingDate;
  TourBookingCancellationArgumentViewModel({
    this.cancellationPolicyList,
    required this.confirmNo,
    required this.bookingUrn,
    required this.bookingStatus,
    required this.confirmationDate,
    required this.bookingDate,
  });
}
