import 'package:async/async.dart';
import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/usecases/booking_list_use_cases.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';

enum TourBookingType {
  ongoingBooking,
  completeBooking,
  cancelledBooking,
}

const _kPageSize = 20;

class TourBookingsBloc extends Bloc<TourBookingsHistoryViewModel> {
  CancelableOperation? _myCancelableFuture;
  @override
  TourBookingsHistoryViewModel initDefaultValue() {
    return TourBookingsHistoryViewModel(
      ongoingBookings: [],
      completedBookings: [],
      cancelledBookings: [],
    );
  }

  BookingListUseCases bookingHistoryUseCases = BookingListUseCasesImpl();

  TourBookingType _bookingType = TourBookingType.ongoingBooking;

  updateTourBookingType(int typeCount) {
    _bookingType = typeCount == 2
        ? TourBookingType.cancelledBooking
        : typeCount == 1
            ? TourBookingType.completeBooking
            : TourBookingType.ongoingBooking;
    emit(state);
  }

  int get getSelectedTourBookingType {
    return _bookingType == TourBookingType.cancelledBooking
        ? 2
        : _bookingType == TourBookingType.completeBooking
            ? 1
            : 0;
  }

  List<TourBookingViewModel> get selectedTourBookings {
    return _bookingType == TourBookingType.cancelledBooking
        ? state.cancelledBookings
        : _bookingType == TourBookingType.completeBooking
            ? state.completedBookings
            : state.ongoingBookings;
  }

  resetTourBookingList() {
    state.completedBookings.clear();
    state.ongoingBookings.clear();
    state.cancelledBookings.clear();
  }

  resetTourBooking() {
    switch (_bookingType) {
      case TourBookingType.ongoingBooking:
        state.ongoingBookings.clear();
        break;
      case TourBookingType.completeBooking:
        state.completedBookings.clear();
        break;
      case TourBookingType.cancelledBooking:
        state.cancelledBookings.clear();
        break;
    }
  }

  resetPageNumber() {
    switch (_bookingType) {
      case TourBookingType.ongoingBooking:
        state.ongoingPageNumber = 0;
        break;
      case TourBookingType.completeBooking:
        state.completedPageNumber = 0;
        break;
      case TourBookingType.cancelledBooking:
        state.cancelledPageNumber = 0;
        break;
    }
  }

  int currentPageNumber() {
    int currentNumber = 0;
    switch (_bookingType) {
      case TourBookingType.ongoingBooking:
        currentNumber = state.ongoingPageNumber;
        break;
      case TourBookingType.completeBooking:
        currentNumber = state.completedPageNumber;
        break;
      case TourBookingType.cancelledBooking:
        currentNumber = state.cancelledPageNumber;
        break;
    }
    return currentNumber;
  }

  bool isNewDataRequired(int index) {
    int currentNumber = currentPageNumber();
    if ((currentNumber * _kPageSize) == (index + 1)) {
      return true;
    } else {
      return false;
    }
  }

  updatePageNumber() {
    switch (_bookingType) {
      case TourBookingType.ongoingBooking:
        state.ongoingPageNumber++;
        break;
      case TourBookingType.completeBooking:
        state.completedPageNumber++;
        break;
      case TourBookingType.cancelledBooking:
        state.cancelledPageNumber++;
        break;
    }
  }

  List<TourBookingViewModel> getCurrentBooking() {
    List<TourBookingViewModel> bookingData = [];
    switch (_bookingType) {
      case TourBookingType.ongoingBooking:
        bookingData = state.ongoingBookings;
        break;
      case TourBookingType.completeBooking:
        bookingData = state.completedBookings;
        break;
      case TourBookingType.cancelledBooking:
        bookingData = state.cancelledBookings;
        break;
    }
    return bookingData;
  }

  void emitSuccess() async {
    bool isInternetConnected = await _isInternetConnected();
    if (isInternetConnected) {
      state.tourBookingsHistoryViewModelState =
          TourBookingsHistoryViewModelState.success;
      emit(state);
    } else {
      state.tourBookingsHistoryViewModelState =
          TourBookingsHistoryViewModelState.failureNetworkRefresh;
      emit(state);
    }
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  Future<void> getTourBookingHistoryData(
      {bool pullToRefresh = true, required String type}) async {
    if (pullToRefresh) {
      resetPageNumber();
      state.tourBookingsHistoryViewModelState =
          TourBookingsHistoryViewModelState.pullDownLoading;
      emit(state);
    }
    if (!pullToRefresh && getCurrentBooking().isEmpty) {
      resetPageNumber();
      state.tourBookingsHistoryViewModelState =
          TourBookingsHistoryViewModelState.loading;
      emit(state);
    }
    updatePageNumber();
    if (type != 'tour_key') {
      state.tourBookingsHistoryViewModelState =
          TourBookingsHistoryViewModelState.success;
      emit(state);
      return;
    }
    BookingArgumentDomain argument = BookingArgumentDomain(
        pageNo: (currentPageNumber() - 1),
        limit: _kPageSize,
        activityType: _getActivityStatus(getSelectedTourBookingType),
        serviceType: OtaServiceType.tour);

    await _myCancelableFuture?.cancel();

    _myCancelableFuture = CancelableOperation.fromFuture(
      bookingHistoryUseCases.getBookingListData(argument),
    );

    Either<Failure, BookingListModelDomain>? result =
        await _myCancelableFuture?.value;

    if (result != null && result.isRight) {
      if (result.right.getBookingSummaryV2 != null) {
        if (pullToRefresh) {
          resetTourBooking();
        }
        List<BookingDetail> bookingData =
            result.right.getBookingSummaryV2?.data?.bookingDetails ?? [];
        switch (_bookingType) {
          case TourBookingType.ongoingBooking:
            state.ongoingBookings
                .addAll(_getTourBookingsViewModel(bookingData));
            break;
          case TourBookingType.completeBooking:
            state.completedBookings
                .addAll(_getTourBookingsViewModel(bookingData));
            break;
          case TourBookingType.cancelledBooking:
            state.cancelledBookings
                .addAll(_getTourBookingsViewModel(bookingData));
            break;
        }
        state.tourBookingsHistoryViewModelState =
            TourBookingsHistoryViewModelState.success;
        emit(state);
        return;
      } else {
        state.tourBookingsHistoryViewModelState =
            TourBookingsHistoryViewModelState.failure;
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        if (getCurrentBooking().isEmpty) {
          state.tourBookingsHistoryViewModelState =
              TourBookingsHistoryViewModelState.failureNetwork;
          emit(state);
        } else {
          state.tourBookingsHistoryViewModelState =
              TourBookingsHistoryViewModelState.failureNetworkRefresh;
          emit(state);
        }
      } else {
        state.tourBookingsHistoryViewModelState =
            TourBookingsHistoryViewModelState.failure;
        emit(state);
      }
    }
  }

  List<TourBookingViewModel> _getTourBookingsViewModel(
      List<BookingDetail> bookingModel) {
    List<TourBookingViewModel> bookingList = [];
    for (BookingDetail model in bookingModel) {
      if (model.serviceType == OtaServiceType.tour && model.tour != null) {
        bookingList.add(TourBookingViewModel.fromBookingDetailsModel(
            model.tour!, model.serviceType!));
      }
    }
    return bookingList;
  }

  String _getActivityStatus(int type) {
    if (type == 2) {
      return BookingListActivityStatus.cancelled;
    } else if (type == 1) {
      return BookingListActivityStatus.completed;
    } else {
      return BookingListActivityStatus.upcoming;
    }
  }
}
