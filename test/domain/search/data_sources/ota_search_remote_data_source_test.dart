import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/search/data_sources/ota_search_remote_data_source.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/repositories/ota_search_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/ota_search_remote_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponseOtaSearch = MockOtaSearchGraphQl();
  OtaSearchDataArgument argument = OtaSearchDataArgument(
      userId: "1234",
      searchKey: 'Pakchong',
      pageSize: '20',
      pageNumber: 1,
      longitude: 19.7618,
      latitude: 140.542560,
      searchAvailableApi: true);
  OtaSearchRemoteDataSourceImpl.setMock(graphQlResponseOtaSearch);
  OtaSearchRepository otaSearchRepository = OtaSearchRepositoryImpl(
      remoteDataSource: OtaSearchRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Search Page Data Source", () {
    OtaSearchRemoteDataSource otaSearchRemoteDataSource =
        OtaSearchRemoteDataSourceImpl();
    OtaSearchRemoteDataSourceImpl.setMock(graphQlResponseOtaSearch);
    otaSearchRemoteDataSource.getOtaSearchData(argument);
  });
  test(
      'Ota Search Remote Repository '
      'When calling getOtaSearchData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await otaSearchRepository.getOtaSearchData(argument);

    expect(consentResult.isRight, true);
  });
}
