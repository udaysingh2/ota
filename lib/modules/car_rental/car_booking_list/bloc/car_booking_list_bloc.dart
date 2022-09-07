import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/usecases/booking_list_use_cases.dart';
import 'package:ota/modules/car_rental/car_booking_list/view_model/car_booking_list_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';

enum CarBookingType {
  ongoingBooking,
  completeBooking,
  cancelledBooking,
}

const _serviceType = "car_key";
const _kPageSize = 20;
const _productType = "CARRENTAL";
const _cancelledBookingType = "CANCELLED";
const _completedBookingType = "COMPLETED";
const _upcomingBookingType = "UPCOMING";

class CarBookingListBloc extends Bloc<CarBookingHistoryViewModel> {
  @override
  CarBookingHistoryViewModel initDefaultValue() {
    return CarBookingHistoryViewModel(
      ongoingBookings: [],
      completedBookings: [],
      cancelledBookings: [],
    );
  }

  setInternetPopUpOpened() {
    state.isInternetFailurePopUpShown = true;
    emit(state);
  }

  BookingListUseCases bookingHistoryUseCases = BookingListUseCasesImpl();

  CarBookingType _bookingType = CarBookingType.ongoingBooking;
  CarBookingType get bookingType => _bookingType;

  updateCarBookingType(int typeCount) {
    _bookingType = typeCount == 2
        ? CarBookingType.cancelledBooking
        : typeCount == 1
            ? CarBookingType.completeBooking
            : CarBookingType.ongoingBooking;
  }

  int get getSelectedCarBookingType {
    return _bookingType == CarBookingType.cancelledBooking
        ? 2
        : _bookingType == CarBookingType.completeBooking
            ? 1
            : 0;
  }

  String get getSelectedCarBookingTypeValue {
    return _bookingType == CarBookingType.cancelledBooking
        ? _cancelledBookingType
        : _bookingType == CarBookingType.completeBooking
            ? _completedBookingType
            : _upcomingBookingType;
  }

  List<CarBookingViewModel> get selectedCarBookings {
    return _bookingType == CarBookingType.cancelledBooking
        ? state.cancelledBookings
        : _bookingType == CarBookingType.completeBooking
            ? state.completedBookings
            : state.ongoingBookings;
  }

  resetCarBookingList() {
    state.completedBookings.clear();
    state.ongoingBookings.clear();
    state.cancelledBookings.clear();
  }

  _resetCarRentalBooking() {
    switch (_bookingType) {
      case CarBookingType.ongoingBooking:
        state.ongoingBookings.clear();
        break;
      case CarBookingType.completeBooking:
        state.completedBookings.clear();
        break;
      case CarBookingType.cancelledBooking:
        state.cancelledBookings.clear();
        break;
    }
  }

  _resetPageNumber() {
    switch (_bookingType) {
      case CarBookingType.ongoingBooking:
        state.ongoingPageNumber = 0;
        break;
      case CarBookingType.completeBooking:
        state.completedPageNumber = 0;
        break;
      case CarBookingType.cancelledBooking:
        state.cancelledPageNumber = 0;
        break;
    }
  }

  int _currentPageNumber() {
    int currentNumber = 0;
    switch (_bookingType) {
      case CarBookingType.ongoingBooking:
        currentNumber = state.ongoingPageNumber;
        break;
      case CarBookingType.completeBooking:
        currentNumber = state.completedPageNumber;
        break;
      case CarBookingType.cancelledBooking:
        currentNumber = state.cancelledPageNumber;
        break;
    }
    return currentNumber;
  }

  bool isNewDataRequired(int index) {
    int currentNumber = _currentPageNumber();
    if (currentNumber * _kPageSize == (index + 1)) {
      return true;
    } else {
      return false;
    }
  }

  _updatePageNumber() {
    switch (_bookingType) {
      case CarBookingType.ongoingBooking:
        state.ongoingPageNumber++;
        break;
      case CarBookingType.completeBooking:
        state.completedPageNumber++;
        break;
      case CarBookingType.cancelledBooking:
        state.cancelledPageNumber++;
        break;
    }
  }

  List<CarBookingViewModel> getCurrentBooking() {
    List<CarBookingViewModel> bookingData = [];
    switch (_bookingType) {
      case CarBookingType.ongoingBooking:
        bookingData = state.ongoingBookings;
        break;
      case CarBookingType.completeBooking:
        bookingData = state.completedBookings;
        break;
      case CarBookingType.cancelledBooking:
        bookingData = state.cancelledBookings;
        break;
    }
    return bookingData;
  }

  void emitSuccess() async {
    bool isInternetConnected = await _isInternetConnected();
    if (isInternetConnected) {
      state.carBookingsHistoryViewModelState =
          CarBookingsHistoryViewModelState.success;
      emit(state);
    } else {
      state.carBookingsHistoryViewModelState =
          CarBookingsHistoryViewModelState.failureNetworkRefresh;
      emit(state);
    }
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  Future<void> getCarBookingHistoryData(
      {bool pullToRefresh = true, required String type}) async {
    if (pullToRefresh) {
      state.isInternetFailurePopUpShown = false;

      _resetPageNumber();
      state.carBookingsHistoryViewModelState =
          CarBookingsHistoryViewModelState.pullDownLoading;
      emit(state);
    }
    if (!pullToRefresh && getCurrentBooking().isEmpty) {
      _resetPageNumber();
      state.carBookingsHistoryViewModelState =
          CarBookingsHistoryViewModelState.loading;
      emit(state);
    }
    if (type != _serviceType) {
      state.carBookingsHistoryViewModelState =
          CarBookingsHistoryViewModelState.success;
      state.isInternetFailurePopUpShown = false;
      emit(state);
      return;
    }
    BookingArgumentDomain argument = BookingArgumentDomain(
      pageNo: _currentPageNumber(),
      limit: _kPageSize,
      activityType: getSelectedCarBookingTypeValue,
      serviceType: _productType,
    );
    Either<Failure, BookingListModelDomain>? result =
        (await bookingHistoryUseCases.getBookingListData(argument));

    if (result != null && result.isRight) {
      if (result.right.getBookingSummaryV2 != null) {
        if (pullToRefresh) {
          _resetCarRentalBooking();
        }
        List<BookingDetail> list =
            result.right.getBookingSummaryV2?.data?.bookingDetails ?? [];

        switch (_bookingType) {
          case CarBookingType.ongoingBooking:
            List<BookingDetail> upcomingBooking = list;
            state.ongoingBookings
                .addAll(_getCarBookingsViewModel(upcomingBooking));
            break;
          case CarBookingType.completeBooking:
            List<BookingDetail> completedBooking = list;
            state.completedBookings
                .addAll(_getCarBookingsViewModel(completedBooking));
            break;
          case CarBookingType.cancelledBooking:
            List<BookingDetail> cancelledBooking = list;
            state.cancelledBookings
                .addAll(_getCarBookingsViewModel(cancelledBooking));
            break;
        }
        _updatePageNumber();
        state.isInternetFailurePopUpShown = false;
        state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.success;

        emit(state);
        return;
      } else {
        state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.failure;
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        if (getCurrentBooking().isEmpty) {
          state.carBookingsHistoryViewModelState =
              CarBookingsHistoryViewModelState.failureNetwork;
          emit(state);
        } else {
          state.carBookingsHistoryViewModelState =
              CarBookingsHistoryViewModelState.failureNetworkRefresh;
          emit(state);
        }
      } else {
        state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.failure;
        emit(state);
      }
    }
  }

  List<CarBookingViewModel> _getCarBookingsViewModel(
      List<BookingDetail> bookingModel) {
    List<CarBookingViewModel> bookingList = [];
    for (BookingDetail model in bookingModel) {
      if (model.serviceType == OtaServiceType.carRental && model.car != null) {
        bookingList.add(CarBookingViewModel.fromModel(model));
      }
    }
    return bookingList;
  }
}
