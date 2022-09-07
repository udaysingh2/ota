import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/details/data_sources/tours_details_remote_data_source_mock.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/details/repositories/tours_details_repository_impl.dart';
import 'package:ota/domain/tours/details/usecases/tours_details_usecases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  TourDetailsUseCases? tourDetailUseCases;
  TourDetailArgumentDomain argumentDomain = TourDetailArgumentDomain(
    countryId: "MA05110001",
    cityId: 'MA05110041',
    tourId: 'MA05110042',
    tourDate: '2021-12-26',
  );
  setUpAll(() async {
    tourDetailUseCases = TourDetailsUseCasesImpl(
        repository: ToursDetailsRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: TourDetailsMockDataSourceImpl()));
  });
  test(
      'Tour Detail UseCases '
      'When calling getTourDetails '
      'With Success response data', () async {
    /// Consent user cases impl
    final tourDetailResult =
        await tourDetailUseCases!.getToursDetails(argumentDomain);

    /// Get model from mock data.
    final TourDetail model = tourDetailResult!.right;

    /// Condition check for tourDetails value null
    expect(model.getTourDetails != null, true);
  });
}
