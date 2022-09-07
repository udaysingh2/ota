import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  test("Hotel Bookings List Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("hotel/hotel_booking/hotel_booking_list.json"));

    ///For class Hotel
    HotelBookingListModelDomain hotelBookingListModelDomain =
        HotelBookingListModelDomain.fromMap(jsonMap);
    String jsonStringData = hotelBookingListModelDomain.toJson();
    HotelBookingListModelDomain hotelJson =
        HotelBookingListModelDomain.fromJson(jsonStringData);
    expect(hotelJson.getBookingSummaryV2 != null, true);

    ///For class get Booking Summary
    GetBookingSummaryV2? getBookingSummary =
        hotelBookingListModelDomain.getBookingSummaryV2;
    String bookingString = getBookingSummary!.toJson();
    GetBookingSummaryV2? bookingJson =
        GetBookingSummaryV2?.fromJson(bookingString);
    expect(bookingJson.data != null, true);

    ///For class Data
    Data? data = hotelBookingListModelDomain.getBookingSummaryV2?.data;
    String dataString = data!.toJson();
    Data? dataJson = Data?.fromJson(dataString);
    expect(dataJson.bookingDetails != null, true);

    ///For class Hotel Booking History
    BookingDetail? bookingHistory = hotelBookingListModelDomain
        .getBookingSummaryV2?.data?.bookingDetails?[0];
    String bookingHistoryStringData = bookingHistory!.toJson();
    BookingDetail? bookingHistoryJson =
        BookingDetail?.fromJson(bookingHistoryStringData);
    expect(bookingHistoryJson.hotel != null, true);

    ///For class Booking
    BookingDetail? booking = hotelBookingListModelDomain
        .getBookingSummaryV2?.data?.bookingDetails?[0];
    String bookingStringData = booking!.toJson();
    BookingDetail? bookingsJson = BookingDetail?.fromJson(bookingStringData);
    expect(bookingsJson.hotel != null, true);

    ///For class Status
    Status? status = hotelBookingListModelDomain.getBookingSummaryV2?.status;
    String? statusStringData = status?.toJson();
    Status statusJson = Status?.fromJson(statusStringData!);
    expect(statusJson.code != null, true);
  });
}
