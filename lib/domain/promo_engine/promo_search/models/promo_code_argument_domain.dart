class PromoCodeArgumentDomain {
  final String applicationKey;
  String? voucherCode;
  String? bookingUrn;

  PromoCodeArgumentDomain({
    required this.applicationKey,
    this.voucherCode,
    this.bookingUrn,
  });

  factory PromoCodeArgumentDomain.fromViewArgument(
      String applicationKey, String voucherCode, String bookingUrn) {
    return PromoCodeArgumentDomain(
        applicationKey: applicationKey,
        voucherCode: voucherCode,
        bookingUrn: bookingUrn);
  }
}
