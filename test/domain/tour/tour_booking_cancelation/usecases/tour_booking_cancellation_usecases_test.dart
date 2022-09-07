import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tours_booking_cancellation_remote_source_mock.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/repositories/tour_booking_cancellation_repository_impl.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/use_cases/tour_booking_cancellation_usecases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  TourBookingCancellationUseCases? tourBookingCancellationUseCases;
  TourBookingCancellationArgumentDomain tourBookingCancellationArgumentDomain =
      TourBookingCancellationArgumentDomain(
          confirmationNo: "", cancellationReason: "");
  setUpAll(() async {
    tourBookingCancellationUseCases = TourBookingCancellationUseCasesImpl(
        repository: TourBookingCancellationRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: TourBookingCancellationMockDataSourceImpl()));
  });
  test('Tour Booking Cancellation UseCases ', () async {
    /// Consent user cases impl
    final tourBookingCancellationResult = await tourBookingCancellationUseCases
        ?.getTourCancellationDetail(tourBookingCancellationArgumentDomain);

    /// Get model from mock data.
    final TourBookingDetailCancellationDomain model =
        tourBookingCancellationResult!.right;

    expect(model.getTourBookingReject != null, true);
  });
}
