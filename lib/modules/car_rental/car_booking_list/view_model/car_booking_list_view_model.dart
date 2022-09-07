import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';

class CarBookingHistoryViewModel {
  List<CarBookingViewModel> ongoingBookings;
  List<CarBookingViewModel> completedBookings;
  List<CarBookingViewModel> cancelledBookings;
  int ongoingPageNumber;
  int completedPageNumber;
  int cancelledPageNumber;
  CarBookingsHistoryViewModelState carBookingsHistoryViewModelState;
  bool isInternetFailurePopUpShown = false;

  CarBookingHistoryViewModel({
    required this.ongoingBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    this.ongoingPageNumber = 0,
    this.completedPageNumber = 0,
    this.cancelledPageNumber = 0,
    this.carBookingsHistoryViewModelState =
        CarBookingsHistoryViewModelState.none,
  });
}

enum CarBookingsHistoryViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  failureNetwork,
  failureNetworkRefresh,
}

class CarBookingViewModel {
  String productType;
  String carName;
  double carTotalPrice;
  String carSupplierName;
  String carBookingUrn;
  String carBookingStatus;
  DateTime pickupDateTime;
  DateTime returnDateTime;
  String bookingId;
  CarBookingListStatus bookingStatus;
  double returnExtraCharge;

  CarBookingViewModel({
    required this.productType,
    required this.carName,
    required this.carTotalPrice,
    required this.carSupplierName,
    required this.carBookingUrn,
    required this.carBookingStatus,
    required this.pickupDateTime,
    required this.returnDateTime,
    required this.bookingId,
    required this.bookingStatus,
    required this.returnExtraCharge,
  });

  factory CarBookingViewModel.fromModel(BookingDetail booking) {
    return CarBookingViewModel(
      productType: booking.serviceType ?? '',
      carName: booking.car?.name ?? '',
      carTotalPrice: booking.car?.totalPrice ?? 0.0,
      carSupplierName: booking.car?.supplierName ?? '',
      carBookingUrn: booking.car?.bookingUrn ?? '',
      carBookingStatus: booking.car?.status ?? '',
      pickupDateTime: booking.car?.pickupDateTime ?? DateTime.now(),
      returnDateTime: booking.car?.returnDateTime ?? DateTime.now(),
      bookingId: booking.car?.bookingId ?? '',
      bookingStatus: booking.car?.status == null
          ? CarBookingListStatus.confirmed
          : (booking.car?.status)!.getCarBookingListStatus,
      returnExtraCharge: booking.car?.returnExtraCharge ?? 0.0,
    );
  }
}

enum CarBookingListStatus {
  awatingConfirmation,
  paymentPending,
  awatingCancellation,
  confirmed,
  completed,
  cancelled,
  paymentFaield,
  rejected,
}

extension _CarBookingStatusStringExtension on String {
  CarBookingListStatus get getCarBookingListStatus {
    switch (this) {
      case "AWAITING_CONFIRMATION":
        return CarBookingListStatus.awatingConfirmation;
      case "PAYMENT_PENDING":
        return CarBookingListStatus.paymentPending;
      case "AWAITING_CANCELLATION":
        return CarBookingListStatus.awatingCancellation;
      case "CONFIRMED":
        return CarBookingListStatus.confirmed;
      case "COMPLETED":
        return CarBookingListStatus.completed;
      case "CANCELLED":
        return CarBookingListStatus.cancelled;
      case "PAYMENT_FAILED":
        return CarBookingListStatus.paymentFaield;
      case "REJECTED":
        return CarBookingListStatus.rejected;
      default:
        return CarBookingListStatus.confirmed;
    }
  }
}
