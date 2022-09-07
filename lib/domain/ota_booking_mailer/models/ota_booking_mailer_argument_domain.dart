class OtaBookingMailerArgumentDomain {
  final String confirmNo;
  final String mailId;
  final String? bookingUrn;
  final String bookingType;
  OtaBookingMailerArgumentDomain({
    required this.confirmNo,
    required this.mailId,
    required this.bookingType,
    this.bookingUrn,
  });
}
