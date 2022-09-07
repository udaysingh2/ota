class TicketBookingCancellationArgumentViewModel {
  String? cancellationPolicyList;
  final String confirmNo;
  final String bookingUrn;
  final String bookingStatus;
  final String? bookingDate;
  final String? confirmationDate;
  TicketBookingCancellationArgumentViewModel({
    this.cancellationPolicyList,
    required this.confirmNo,
    required this.bookingUrn,
    required this.bookingStatus,
    required this.bookingDate,
    required this.confirmationDate,
  });
}
