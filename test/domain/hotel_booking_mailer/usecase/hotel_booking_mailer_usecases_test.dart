import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/data_sources/hotel_booking_mailer_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/repositories/hotel_booking_mailer_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/use_cases/hotel_booking_mailer_use_cases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  HotelBookingMailerUseCases? hotelServiceUseCases;
  HotelBookingMailerArgumentDomain argument = HotelBookingMailerArgumentDomain(
      confirmNo: "", mailId: "", bookingUrn: "");
  setUpAll(() async {
    hotelServiceUseCases = HotelBookingMailerUseCasesImpl(
        repository: HotelBookingMailerRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: HotelBookingMailerMockDataSourceImpl()));
  });
  test('Hotel Booking Mailer UseCases ', () async {
    /// Consent user cases impl
    final hotelBookingMailerResult =
        await hotelServiceUseCases!.sendBookingHotelMailer(argument);

    /// Get model from mock data.
    final HotelBookingMailerModelDomain? model =
        hotelBookingMailerResult?.right;

    expect(model!.sendEmailConfirmation == null, false);
  });
}
