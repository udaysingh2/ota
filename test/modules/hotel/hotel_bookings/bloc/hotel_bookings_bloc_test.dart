import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/modules/hotel/hotel_bookings/bloc/hotel_bookings_bloc.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_bookings_view_model.dart';

void main() {
  HotelBookingsBloc bloc = HotelBookingsBloc();
  BookingType bookingType = BookingType.ongoingBooking;

  BookingsHistoryViewModel model = BookingsHistoryViewModel(
      ongoingBookings: [],
      completedBookings: [],
      cancelledBookings: [],
      bookingHistoryViewModelState:
          BookingHistoryViewModelState.pullDownLoading);

  test('For HotelBookingsBloc class ==> initDefaultValue()', () {
    bloc.initDefaultValue();

    expect(bloc.initDefaultValue().ongoingBookings.isEmpty, true);
    expect(bloc.initDefaultValue().completedBookings.isEmpty, true);
    expect(bloc.initDefaultValue().cancelledBookings.isEmpty, true);
  });

  test('For HotelBookingsBloc class ==> updateBookingType', () {
    bloc.updateBookingType(2);
    expect(bookingType, BookingType.ongoingBooking);

    bloc.updateBookingType(1);
    expect(bookingType, BookingType.ongoingBooking);

    bloc.updateBookingType(0);
    expect(bookingType, BookingType.ongoingBooking);
  });

  test('For HotelBookingsBloc class ==> getSelectedBookingType', () {
    bookingType = BookingType.canceledBookings;
    bloc.getSelectedBookingType;

    bookingType = BookingType.completedBooking;
    bloc.getSelectedBookingType;
  });

  test('For HotelBookingsBloc class ==> selectedBookings', () {
    bookingType = BookingType.ongoingBooking;
    bloc.selectedBookings;
    expect(model.ongoingBookings.isEmpty, true);

    bookingType = BookingType.canceledBookings;
    bloc.selectedBookings;
    expect(bookingType, BookingType.canceledBookings);

    bookingType = BookingType.completedBooking;
    bloc.selectedBookings;
    expect(bookingType, BookingType.completedBooking);
  });

  test('For HotelBookingsBloc class ==> resetBookingList', () {
    bloc.resetBookingList();
  });
  group('For HotelBookingsBloc class ==> getBookingHistoryData', () {
    test('For HotelBookingsBloc class ==> getBookingHistoryData', () async {
      bloc.getBookingHistoryData(type: '');
      expect(
          model.bookingHistoryViewModelState ==
              BookingHistoryViewModelState.pullDownLoading,
          true);
    });
  });
}

BookingArgumentDomain args = BookingArgumentDomain(
  serviceType: 'HOTEL',
  activityType: 'CANCELLED',
  limit: 10,
  pageNo: 0,
);
