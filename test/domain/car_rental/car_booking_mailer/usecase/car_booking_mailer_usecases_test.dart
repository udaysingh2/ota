import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_mock_data.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/repositories/car_booking_mailer_repository_impl.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/use_cases/car_booking_mailer_use_cases.dart';

void main() {
  CarBookingMailerUseCases? carServiceUseCases;
  CarBookingMailerArgumentDomain argument =
      CarBookingMailerArgumentDomain(confirmNo: "", mailId: "", bookingUrn: "");
  setUpAll(() async {
    carServiceUseCases = CarBookingMailerUseCasesImpl();
    carServiceUseCases = CarBookingMailerUseCasesImpl(
        repository: CarBookingMailerRepositoryImpl(
            remoteDataSource: CarBookingMailerMockDataSourceImpl()));
  });
  test('Car Booking Mailer UseCases ', () async {
    /// Consent user cases impl
    final carBookingMailerResult =
        await carServiceUseCases!.sendBookingCarMailer(argument);

    /// Get model from mock data.
    final CarBookingMailerModelDomain? model = carBookingMailerResult?.right;

    expect(model!.sendEmailConfirmation == null, false);
  });
}
