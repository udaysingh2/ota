class ActivityStatusType {
  static const String success = "SUCCESS";
  static const String checkedOut = "CHECKEDOUT";
  static const String userCancelled = "USER_CANCELLED";
  static const String paymentFailed = "PAYMENT_FAILED";
  static const String hotelRejected = "HOTEL_REJECTED";
  static const String paymentPending = "PAYMENT_PENDING";
  static const String awaitingCancellation = "AWAITING_CANCELLATION";
  static const String awaitingConfirmation = "AWAITING_RESERVATION";
}

class BookingStatusType {
  static const String confirmed = "CONFIRMED";
  static const String cancelled = "CANCELLED";
  static const String pending = "PENDING";
}

class PaymentStatusType {
  static const String failed = "FAILED";
  static const String initiated = "INITIATED";
  static const String confirmed = "CONFIRMED";
  static const String voidType = "VOID";
}
