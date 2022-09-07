import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/domain/confirm_booking/repositories/hotel_confirm_booking_repository_impl.dart';
import 'package:ota/domain/confirm_booking/usecases/hotel_confirm_booking_usecases.dart';

import '../../../mocks/fixture_reader.dart';

class ConfirmBookingPlayListUsecase
    implements HotelConfirmBookingRepositoryImpl {
  @override
  HotelConfirmBookingRemoteDataSource? hotelConfirmBookingRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, BookingConfirmationData>> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("confirm_booking/confirm_booking.json"));
    BookingConfirmationData sort = BookingConfirmationData.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("confirm booking Use case group", () {
    test('confirm booking Use case', () async {
      HotelConfirmBookingArgumentModelDomain argument =
          HotelConfirmBookingArgumentModelDomain(
        bookingUrn: '',
        hotelId: '',
        additionalNeedsText: '',
        bookingForSomeoneElse: false,
        roomCode: '',
        totalPrice: 2,
        customerInfo: CustomerInfoDataDomain(
            firstName: '', lastName: '', membershipId: ''),
      );
      HotelConfirmBookingUseCasesImpl();
      HotelConfirmBookingUseCases hotelConfirmBookingUseCases =
          HotelConfirmBookingUseCasesImpl(
              repository: ConfirmBookingPlayListUsecase());
      hotelConfirmBookingUseCases.getHotelConfirmBooking(argument);
    });
  });
}
