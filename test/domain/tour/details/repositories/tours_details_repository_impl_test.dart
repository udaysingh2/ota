import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/details/data_sources/tours_details_remote_data_source.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/tours/details/models/tour_package_details_argument_domain.dart';
import 'package:ota/domain/tours/details/repositories/tours_details_repository_impl.dart';
import '../../../../mocks/tour/tours_details_remote_data_source_mock.dart';
import '../../../../modules/hotel/repositories/Internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/Internet_success_mock.dart';

class TourDetailRemoteDataSourceFailureMock
    implements TourDetailsRemoteDataSource {
  @override
  Future<TourDetail> getTourDetails(TourDetailArgumentDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<TourDetail> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  ToursDetailsRepository? tourDetailRepositoryMock;
  ToursDetailsRepository? tourDetailRepositoryInternetFailure;
  ToursDetailsRepository? tourDetailRepositoryServerException;

  TourDetailArgumentDomain argumentDomain = TourDetailArgumentDomain(
    countryId: "MA05110001",
    cityId: 'MA05110041',
    tourId: 'MA05110042',
    tourDate: '2021-12-26',
  );
  setUpAll(() async {
    tourDetailRepositoryMock = ToursDetailsRepositoryImpl();

    tourDetailRepositoryMock = ToursDetailsRepositoryImpl(
        remoteDataSource: TourDetailsMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    tourDetailRepositoryServerException = ToursDetailsRepositoryImpl(
        remoteDataSource: TourDetailRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    tourDetailRepositoryInternetFailure = ToursDetailsRepositoryImpl(
        remoteDataSource: TourDetailsMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test("Tour Detail Repository" 'With Success response', () async {
    final result =
        await tourDetailRepositoryMock!.getTourDetails(argumentDomain);
    final TourDetail tourData = result.right;
    expect(tourData.getTourDetails != null, true);
  });

  test("Tour Detail Repository" 'With internet Failure response data',
      () async {
    final result = await tourDetailRepositoryInternetFailure!
        .getTourDetails(argumentDomain);
    expect(result.isLeft, true);
  });

  test("Tour Detail Repository" 'With Server Exception response data',
      () async {
    final result = await tourDetailRepositoryServerException!
        .getTourDetails(argumentDomain);
    expect(result.isLeft, true);
  });
}
