import 'package:ota/core/app_config.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/status_type_const.dart';

class BookingsHistoryViewModel {
  List<HotelBookingsViewModel> ongoingBookings;
  List<HotelBookingsViewModel> completedBookings;
  List<HotelBookingsViewModel> cancelledBookings;
  int ongoingPageNumber;
  int completedPageNumber;
  int cancelledPageNumber;
  int prevSelectedIndex;
  ActivityStatus prevSelectedActivityStatus;
  BookingHistoryViewModelState bookingHistoryViewModelState;
  bool isInternetFailurePopUpShown = false;

  BookingsHistoryViewModel({
    required this.ongoingBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    this.ongoingPageNumber = 0,
    this.completedPageNumber = 0,
    this.cancelledPageNumber = 0,
    this.prevSelectedIndex = 0,
    this.prevSelectedActivityStatus = ActivityStatus.none,
    this.bookingHistoryViewModelState = BookingHistoryViewModelState.none,
  });
}

enum BookingHistoryViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  failureNetwork,
  failureNetworkRefresh,
}

class HotelBookingsViewModel {
  String hotelName;
  double totalPrice;
  DateTime checkInDate;
  DateTime checkOutDate;
  String bookingUrn;
  String bookingId;
  HotelBookingStatus? bookingStatus;
  String? hotelPaymentStatus;
  ActivityStatus activityStatus;

  HotelBookingsViewModel({
    required this.hotelName,
    required this.totalPrice,
    required this.checkInDate,
    required this.checkOutDate,
    required this.bookingUrn,
    required this.bookingId,
    required this.bookingStatus,
    required this.hotelPaymentStatus,
    required this.activityStatus,
  });

  factory HotelBookingsViewModel.fromModel(BookingDetail bookingDetail) {
    return HotelBookingsViewModel(
      hotelName: bookingDetail.hotel?.name ?? '',
      totalPrice: bookingDetail.hotel?.totalPrice ?? 0,
      checkInDate: DateTime.tryParse(bookingDetail.hotel?.checkInDate ?? '') ??
          DateTime.now()
              .add(Duration(days: AppConfig().configModel.checkInDeltaHotel)),
      checkOutDate:
          DateTime.tryParse(bookingDetail.hotel?.checkOutDate ?? '') ??
              DateTime.now().add(
                  Duration(days: AppConfig().configModel.checkOutDeltaHotel)),
      bookingUrn: bookingDetail.hotel?.bookingUrn ?? '',
      bookingId: bookingDetail.hotel?.bookingId ?? '',
      bookingStatus: _getHotelBookingStatus(bookingDetail.hotel?.status ?? ''),
      hotelPaymentStatus: bookingDetail.hotel?.status ?? '',
      activityStatus:
          _getActivityStatus(bookingDetail.hotel?.activityStatus ?? ''),
    );
  }

  static HotelBookingStatus _getHotelBookingStatus(String status) {
    switch (status) {
      case "CONFIRMED":
        return HotelBookingStatus.bookingConfirmed;
      case "CANCELLED":
        return HotelBookingStatus.bookingCancelled;
      default:
        return HotelBookingStatus.bookingPending;
    }
  }

  static ActivityStatus _getActivityStatus(String? activityStatus) {
    switch (activityStatus) {
      case ActivityStatusType.success:
        return ActivityStatus.bookingSuccess;
      case ActivityStatusType.checkedOut:
        return ActivityStatus.completed;
      case ActivityStatusType.userCancelled:
        return ActivityStatus.userCancelled;
      case ActivityStatusType.paymentFailed:
        return ActivityStatus.paymentFailed;
      case ActivityStatusType.hotelRejected:
        return ActivityStatus.hotelRejected;
      case ActivityStatusType.paymentPending:
        return ActivityStatus.paymentPending;
      case ActivityStatusType.awaitingCancellation:
        return ActivityStatus.awaitingCancellation;
      case ActivityStatusType.awaitingConfirmation:
        return ActivityStatus.awaitingConfirmation;
      default:
        return ActivityStatus.none;
    }
  }
}

enum HotelPaymentStatus { initiated, failed, confirmed, voidType }
