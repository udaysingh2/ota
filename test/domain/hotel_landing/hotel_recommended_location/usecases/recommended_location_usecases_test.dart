import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_mock_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/usecases/recommended_location_usecases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  RecommendedLocationUseCases? recommendedLocationUseCases;
  setUpAll(() async {
    /// Code coverage for default implementation.
    recommendedLocationUseCases = RecommendedLocationUseCasesImpl();

    /// Code coverage for mock class
    RecommendedLocationRepository recommendedLocationRepository =
        RecommendedLocationRepositoryImpl(
            remoteDataSource: RecommendedLocationMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());
    recommendedLocationUseCases = RecommendedLocationUseCasesImpl(
        repository: recommendedLocationRepository);
  });

  test(
      'Recommended Location UseCases '
      'When calling getPlayListData '
      'With Success response data', () async {
    /// Consent user cases impl
    final recommendedLocationResult = await recommendedLocationUseCases!
        .getRecommendedLocationData('HOTEL_LANDING');

    /// Get model from mock data.
    final RecommendedLocationModelDomain model =
        recommendedLocationResult!.right;

    /// Condition check for recommended value null
    expect(model.getRecommendedLocation != null, true);
  });
}
