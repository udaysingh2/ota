import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tour_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tours_booking_cancellation_remote_source_mock.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/repositories/tour_booking_cancellation_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class TourBookingCancellationDataSourceFailureMock
    implements TourBookingCancellationRemoteDataSource {
  Future<TourBookingDetailCancellationDomain> getBookingCancellation(
      TourBookingDetailCancellationDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<TourBookingDetailCancellationDomain> getTourCancellationDetail(
      TourBookingCancellationArgumentDomain argument) {
    throw UnimplementedError();
  }
}

void main() {
  TourBookingCancellationRepository? tourBookingCancellationRepositoryMock;
  TourBookingCancellationRepository?
      tourBookingCancellationRepositoryServerException;
  TourBookingCancellationArgumentDomain argument =
      TourBookingCancellationArgumentDomain(
          cancellationReason: " ", confirmationNo: "");

  setUpAll(() async {
    tourBookingCancellationRepositoryMock =
        TourBookingCancellationRepositoryImpl();

    tourBookingCancellationRepositoryMock =
        TourBookingCancellationRepositoryImpl(
            remoteDataSource: TourBookingCancellationMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());

    tourBookingCancellationRepositoryServerException =
        TourBookingCancellationRepositoryImpl(
            remoteDataSource: TourBookingCancellationMockDataSourceImpl(),
            internetInfo: InternetFailureMock());
  });

  test("Tour Booking Cancellation Repository" 'With Success response',
      () async {
    final result = await tourBookingCancellationRepositoryMock!
        .getTourCancellationDetail(argument);
    final TourBookingDetailCancellationDomain tourBookingCancellationData =
        result.right;
    expect(tourBookingCancellationData.getTourBookingReject == null, false);
  });

  test(
      "Tour Booking Cancellation Repository"
      'With Server Exception response data', () async {
    final result = await tourBookingCancellationRepositoryServerException!
        .getTourCancellationDetail(argument);
    expect(result.isLeft, true);
  });
}
