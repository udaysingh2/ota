import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/data_sources/ota_search_mock_data_source.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/repositories/ota_search_repository_impl.dart';
import 'package:ota/domain/search/usecases/ota_search_use_cases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  OtaSearchUseCases? otaSearchUseCases;
  OtaSearchDataArgument argument = OtaSearchDataArgument(
    latitude: 0.0,
    longitude: 0.0,
    pageNumber: 1,
    pageSize: 'PageSize',
    searchKey: 'SearchKey',
    userId: 'UserId',
    searchAvailableApi: false,
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    OtaSearchRepository searchRepository = OtaSearchRepositoryImpl(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());
    otaSearchUseCases = OtaSearchUseCasesImpl(repository: searchRepository);
  });

  test('OTA search usecases', () async {
    /// Consent user cases impl
    final otaSearchResult = await otaSearchUseCases!.getOtaSearchData(argument);
    expect(otaSearchResult?.isLeft, false);
  });
}
