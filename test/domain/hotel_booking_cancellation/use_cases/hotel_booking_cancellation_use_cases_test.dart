import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/repositories/hotel_booking_cancellation_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/use_cases/hotel_booking_cancellation_use_cases.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  HotelBookingCancellationUseCases cancellationUseCases =
      HotelBookingCancellationUseCasesImpl();

  HotelBookingCancellationArgument argument = HotelBookingCancellationArgument(
    confirmNo: 'confirmNo',
    reason: 'reason',
  );

  setUpAll(() async {
    HotelBookingCancellationRepository cancellationRepository =
        HotelBookingCancellationRepositoryImpl(
      remoteDataSource: HotelBookingCancellationMockDataSourceImpl(),
      internetInfo: InternetSuccessMock(),
    );

    cancellationUseCases = HotelBookingCancellationUseCasesImpl(
      repository: cancellationRepository,
    );
  });

  test('Hotel booking cancellation use case test', () async {
    ///Consent use case impl
    final cancellationUseCaseResult =
        await cancellationUseCases.getHotelBookingCancellationData(argument);

    ///Get model from mock data
    final HotelBookingCancellationModelDomain actual =
        cancellationUseCaseResult!.right;

    expect(actual.data != null, true);
  });
}
