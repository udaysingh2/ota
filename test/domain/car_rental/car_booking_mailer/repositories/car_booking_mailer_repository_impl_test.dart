import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_mock_data.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/repositories/car_booking_mailer_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarBookingMailerDataSourceFailureMock
    implements CarBookingMailerRemoteDataSource {
  Future<CarBookingMailerModelDomain> getBookingCards(
      CarBookingMailerModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<CarBookingMailerModelDomain> sendCarBookingMailer(
      CarBookingMailerArgumentDomain argument) {
    throw UnimplementedError();
  }
}

void main() {
  CarBookingMailerRepository? carBookingMailerRepositoryMock;
  CarBookingMailerRepository? carBookingMailerRepositoryServerException;
  CarBookingMailerArgumentDomain argument =
      CarBookingMailerArgumentDomain(confirmNo: "", mailId: "", bookingUrn: "");

  setUpAll(() async {
    carBookingMailerRepositoryMock = CarBookingMailerRepositoryImpl();

    carBookingMailerRepositoryMock = CarBookingMailerRepositoryImpl(
        remoteDataSource: CarBookingMailerMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carBookingMailerRepositoryServerException = CarBookingMailerRepositoryImpl(
        remoteDataSource: CarBookingMailerMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test("Car Booking Mailer Repository" 'With Success response', () async {
    final result =
        await carBookingMailerRepositoryMock!.sendCarBookingMailer(argument);
    final CarBookingMailerModelDomain bookingData = result.right;
    expect(bookingData.sendEmailConfirmation == null, false);
  });

  test("Car Booking Mailer Repository" 'With Server Exception response data',
      () async {
    final result = await carBookingMailerRepositoryServerException!
        .sendCarBookingMailer(argument);
    expect(result.isLeft, true);
  });
}
