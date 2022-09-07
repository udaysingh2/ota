import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/hotel_booking_mailer/data_sources/hotel_booking_mailer_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/data_sources/hotel_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/repositories/hotel_booking_mailer_repository_impl.dart';
import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class HotelBookingMailerDataSourceFailureMock
    implements HotelBookingMailerRemoteDataSource {
  Future<HotelBookingMailerModelDomain> getBookingCards(
      HotelBookingMailerModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<HotelBookingMailerModelDomain> sendHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument) {
    throw UnimplementedError();
  }
}

void main() {
  HotelBookingMailerRepository? hotelBookingMailerRepositoryMock;
  HotelBookingMailerRepository? hotelBookingMailerRepositoryServerException;
  HotelBookingMailerArgumentDomain argument = HotelBookingMailerArgumentDomain(
      confirmNo: "", mailId: "", bookingUrn: "");

  setUpAll(() async {
    hotelBookingMailerRepositoryMock = HotelBookingMailerRepositoryImpl();

    hotelBookingMailerRepositoryMock = HotelBookingMailerRepositoryImpl(
        remoteDataSource: HotelBookingMailerMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    hotelBookingMailerRepositoryServerException =
        HotelBookingMailerRepositoryImpl(
            remoteDataSource: HotelBookingMailerMockDataSourceImpl(),
            internetInfo: InternetFailureMock());
  });

  test("Hotel Booking Mailer Repository" 'With Success response', () async {
    final result = await hotelBookingMailerRepositoryMock!
        .sendHotelBookingMailer(argument);
    final HotelBookingMailerModelDomain bookingData = result.right;
    expect(bookingData.sendEmailConfirmation == null, false);
  });

  test("Hotel Booking Mailer Repository" 'With Server Exception response data',
      () async {
    final result = await hotelBookingMailerRepositoryServerException!
        .sendHotelBookingMailer(argument);
    expect(result.isLeft, true);
  });
}
