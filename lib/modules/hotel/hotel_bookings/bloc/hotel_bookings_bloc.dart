import 'package:async/async.dart';
import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/usecases/booking_list_use_cases.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_bookings_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';

enum BookingType {
  ongoingBooking,
  completedBooking,
  canceledBookings,
}

const _kPageSize = 20;

class HotelBookingsBloc extends Bloc<BookingsHistoryViewModel> {
  CancelableOperation? _myCancelableFuture;

  @override
  BookingsHistoryViewModel initDefaultValue() {
    return BookingsHistoryViewModel(
      ongoingBookings: [],
      completedBookings: [],
      cancelledBookings: [],
    );
  }

  BookingListUseCasesImpl bookingHistoryUseCases = BookingListUseCasesImpl();

  BookingType _bookingType = BookingType.ongoingBooking;
  BookingType get bookingType => _bookingType;

  updateBookingType(int typeCount) {
    _bookingType = typeCount == 2
        ? BookingType.canceledBookings
        : typeCount == 1
            ? BookingType.completedBooking
            : BookingType.ongoingBooking;
    emit(state);
  }

  int get getSelectedBookingType {
    return _bookingType == BookingType.canceledBookings
        ? 2
        : _bookingType == BookingType.completedBooking
            ? 1
            : 0;
  }

  String get getSelectedBookingStringType {
    return _bookingType == BookingType.canceledBookings
        ? BookingListActivityStatus.cancelled
        : _bookingType == BookingType.completedBooking
            ? BookingListActivityStatus.completed
            : BookingListActivityStatus.upcoming;
  }

  List<HotelBookingsViewModel> get selectedBookings {
    return _bookingType == BookingType.canceledBookings
        ? state.cancelledBookings
        : _bookingType == BookingType.completedBooking
            ? state.completedBookings
            : state.ongoingBookings;
  }

  resetBookingList() {
    state.completedBookings.clear();
    state.ongoingBookings.clear();
    state.cancelledBookings.clear();
  }

  void _resetHotelBooking() {
    switch (_bookingType) {
      case BookingType.ongoingBooking:
        state.ongoingBookings.clear();
        break;
      case BookingType.completedBooking:
        state.completedBookings.clear();
        break;
      case BookingType.canceledBookings:
        state.cancelledBookings.clear();
        break;
    }
  }

  resetHotelBooking() {
    switch (_bookingType) {
      case BookingType.ongoingBooking:
        state.ongoingBookings.clear();
        break;
      case BookingType.completedBooking:
        state.completedBookings.clear();
        break;
      case BookingType.canceledBookings:
        state.cancelledBookings.clear();
        break;
    }
  }

  resetPageNumber() {
    switch (_bookingType) {
      case BookingType.ongoingBooking:
        state.ongoingPageNumber = 0;
        break;
      case BookingType.completedBooking:
        state.completedPageNumber = 0;
        break;
      case BookingType.canceledBookings:
        state.cancelledPageNumber = 0;
        break;
    }
  }

  int _currentPageNumber() {
    int currentNumber = 0;
    switch (_bookingType) {
      case BookingType.ongoingBooking:
        currentNumber = state.ongoingPageNumber;
        break;
      case BookingType.completedBooking:
        currentNumber = state.completedPageNumber;
        break;
      case BookingType.canceledBookings:
        currentNumber = state.cancelledPageNumber;
        break;
    }
    return currentNumber;
  }

  bool isNewDataRequired(int index) {
    int currentNumber = _currentPageNumber();
    if ((currentNumber * _kPageSize) == (index + 1)) {
      return true;
    } else {
      return false;
    }
  }

  updatePageNumber() {
    switch (_bookingType) {
      case BookingType.ongoingBooking:
        state.ongoingPageNumber++;
        break;
      case BookingType.completedBooking:
        state.completedPageNumber++;
        break;
      case BookingType.canceledBookings:
        state.cancelledPageNumber++;
        break;
    }
  }

  List<HotelBookingsViewModel> getCurrentBooking() {
    List<HotelBookingsViewModel> bookingData = [];
    switch (_bookingType) {
      case BookingType.ongoingBooking:
        bookingData = state.ongoingBookings;
        break;
      case BookingType.completedBooking:
        bookingData = state.completedBookings;
        break;
      case BookingType.canceledBookings:
        bookingData = state.cancelledBookings;
        break;
    }
    return bookingData;
  }

  void emitSuccess() async {
    bool isInternetConnected = await _isInternetConnected();
    if (isInternetConnected) {
      state.bookingHistoryViewModelState = BookingHistoryViewModelState.success;
      emit(state);
    } else {
      state.bookingHistoryViewModelState =
          BookingHistoryViewModelState.failureNetworkRefresh;
      emit(state);
    }
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  Future<void> getBookingHistoryData(
      {bool pullToRefresh = true, required String type}) async {
    if (pullToRefresh) {
      state.isInternetFailurePopUpShown = false;
      resetPageNumber();
      state.bookingHistoryViewModelState =
          BookingHistoryViewModelState.pullDownLoading;
      emit(state);
    }

    if (!pullToRefresh && getCurrentBooking().isEmpty) {
      resetPageNumber();
      state.bookingHistoryViewModelState = BookingHistoryViewModelState.loading;
      emit(state);
    }
    updatePageNumber();
    if (type != 'hotel_key') {
      state.isInternetFailurePopUpShown = false;
      state.bookingHistoryViewModelState = BookingHistoryViewModelState.success;
      emit(state);
      return;
    }

    BookingArgumentDomain argument = BookingArgumentDomain(
      serviceType: OtaServiceType.hotel,
      activityType: getSelectedBookingStringType,
      limit: _kPageSize,
      pageNo: _currentPageNumber() - 1,
    );

    await _myCancelableFuture?.cancel();

    _myCancelableFuture = CancelableOperation.fromFuture(
      bookingHistoryUseCases.getBookingListData(argument),
    );
    Either<Failure, BookingListModelDomain>? result =
        await _myCancelableFuture?.value;

    if (result != null && result.isRight) {
      if (result.right.getBookingSummaryV2 != null) {
        if (pullToRefresh) {
          _resetHotelBooking();
        }

        switch (_bookingType) {
          case BookingType.ongoingBooking:
            List<BookingDetail> bookingData =
                result.right.getBookingSummaryV2?.data?.bookingDetails ?? [];
            state.ongoingBookings
                .addAll(_getHotelBookingsViewModel(bookingData));
            break;
          case BookingType.completedBooking:
            List<BookingDetail> bookingData =
                result.right.getBookingSummaryV2?.data?.bookingDetails ?? [];
            state.completedBookings
                .addAll(_getHotelBookingsViewModel(bookingData));
            break;
          case BookingType.canceledBookings:
            List<BookingDetail> bookingData =
                result.right.getBookingSummaryV2?.data?.bookingDetails ?? [];
            state.cancelledBookings
                .addAll(_getHotelBookingsViewModel(bookingData));
            break;
        }
        state.isInternetFailurePopUpShown = false;
        state.bookingHistoryViewModelState =
            BookingHistoryViewModelState.success;
        emit(state);
        return;
      } else {
        state.bookingHistoryViewModelState =
            BookingHistoryViewModelState.failure;
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        if (getCurrentBooking().isEmpty) {
          state.bookingHistoryViewModelState =
              BookingHistoryViewModelState.failureNetwork;
          emit(state);
        } else {
          state.bookingHistoryViewModelState =
              BookingHistoryViewModelState.failureNetworkRefresh;
          emit(state);
        }
      } else {
        state.bookingHistoryViewModelState =
            BookingHistoryViewModelState.failure;
        emit(state);
      }
    }
  }

  List<HotelBookingsViewModel> _getHotelBookingsViewModel(
      List<BookingDetail> bookingModel) {
    return bookingModel
        .map((e) => HotelBookingsViewModel.fromModel(e))
        .toList();
  }

  setInternetPopUpOpened() {
    state.isInternetFailurePopUpShown = true;
    emit(state);
  }
}
