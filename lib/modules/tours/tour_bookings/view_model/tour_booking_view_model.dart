import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/modules/tours/booking_details/helper/date_check_helper.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_type.dart';

class TourBookingsHistoryViewModel {
  List<TourBookingViewModel> ongoingBookings;
  List<TourBookingViewModel> completedBookings;
  List<TourBookingViewModel> cancelledBookings;
  int ongoingPageNumber;
  int completedPageNumber;
  int cancelledPageNumber;
  TourBookingsHistoryViewModelState tourBookingsHistoryViewModelState;

  TourBookingsHistoryViewModel({
    required this.ongoingBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    this.ongoingPageNumber = 0,
    this.completedPageNumber = 0,
    this.cancelledPageNumber = 0,
    this.tourBookingsHistoryViewModelState =
        TourBookingsHistoryViewModelState.none,
  });
}

enum TourBookingsHistoryViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  failureNetwork,
  failureNetworkRefresh,
}
enum TourBookingStatus {
  bookingConfirmed,
  paymentPending,
  cancellationPending,
  bookingPending,
  bookingCancelled,
  unsuccessfulReservation,
  unsuccessfulPayment,
  bookingCompleted,
}

class TourBookingViewModel {
  String productType;
  String tourName;
  double tourTotalPrice;
  DateTime tourBookingDate;
  String tourBookingUrn;
  TourBookingStatus? tourBookingStatus;
  String startTimeAMPM;
  String paymentStatus;
  String bookingId;

  TourBookingViewModel({
    required this.productType,
    required this.tourName,
    required this.tourTotalPrice,
    required this.tourBookingDate,
    required this.tourBookingUrn,
    required this.tourBookingStatus,
    required this.startTimeAMPM,
    required this.paymentStatus,
    required this.bookingId,
  });

  factory TourBookingViewModel.fromBookingDetailsModel(
      Tour booking, String serviceType) {
    return TourBookingViewModel(
      productType: booking.subServiceType ?? serviceType,
      tourName: booking.name ?? '',
      tourTotalPrice: booking.totalPrice ?? 0.0,
      tourBookingDate:
          DateTime.tryParse(booking.bookingDate ?? '') ?? DateTime.now(),
      tourBookingUrn: booking.bookingUrn ?? '',
      tourBookingStatus: _getTourBookingStatus(booking.status ?? '',
          booking.paymentStatus, DateTime.tryParse(booking.bookingDate ?? '')),
      startTimeAMPM: booking.startTimeAmpm ?? '',
      paymentStatus: booking.paymentStatus ?? '',
      bookingId: booking.bookingId ?? '',
    );
  }

  static TourBookingStatus _getTourBookingStatus(
      String status, String? paymentStatus, DateTime? date) {
    switch (status) {
      case TourBookingType.confirmed:
        if (date != null && DateCheckHelper.checkIfTodayOrAfter(date)) {
          return TourBookingStatus.bookingConfirmed;
        } else {
          return TourBookingStatus.bookingCompleted;
        }
      case TourBookingType.paymentPending:
        return TourBookingStatus.paymentPending;
      case TourBookingType.awaitingCancellation:
        return TourBookingStatus.cancellationPending;
      case TourBookingType.pending:
        return TourBookingStatus.bookingPending;
      case TourBookingType.rejected:
        return TourBookingStatus.unsuccessfulReservation;

      case TourBookingType.cancelled:
        if (paymentStatus != null && paymentStatus == TourBookingType.failed) {
          return TourBookingStatus.unsuccessfulPayment;
        } else {
          return TourBookingStatus.bookingCancelled;
        }
      default:
        return TourBookingStatus.bookingPending;
    }
  }
}

class BookingListActivityStatus {
  static const String upcoming = "UPCOMING";
  static const String completed = "COMPLETED";
  static const String cancelled = "CANCELLED";
}
