import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_mock_data_source.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ota search Filter mock data source group", () {
    test('Ota search Filter mock data source', () async {
      OtaSearchSortRemoteDataSource otaSearchSortRemoteDataSource =
          OtaSearchSortMockDataSourceImpl();
      otaSearchSortRemoteDataSource = OtaSearchSortMockDataSourceImpl(
          graphQlResponse: GraphQlResponseImpl());
      otaSearchSortRemoteDataSource.getOtaSearchSortData();
    });
  });
}
