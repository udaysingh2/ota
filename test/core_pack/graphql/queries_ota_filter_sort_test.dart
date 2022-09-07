import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_filter_sort.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockedSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  test('OTA Queries Filter Sort ...', () async {
    String str = QueriesOtaFilterSort.getOtaFilterSortData();
    expect(str.isEmpty, false);
  });
}
