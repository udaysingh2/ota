import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';
import 'package:ota/domain/ota_search_sort/repositories/ota_filter_sort_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class MockedOtaSearchSortRemoteDataSource
    implements OtaSearchSortRemoteDataSource {
  @override
  Future<OtaFilterSort> getOtaSearchSortData() async {
    Map<String, dynamic> map =
        json.decode(fixture("ota_search_sort/search_sort.json"));
    OtaFilterSort sort = OtaFilterSort.fromMap(map);
    return sort;
  }
}

class MockedOtaSearchSortRemoteDataSourceExp
    implements OtaSearchSortRemoteDataSource {
  @override
  Future<OtaFilterSort> getOtaSearchSortData() async {
    throw Exception();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ota search Filter repo group", () {
    test('Ota search Filter repo internet success', () async {
      OtaSearchSortRepositoryImpl();
      OtaSearchSortRepository otaSearchSortRepository =
          OtaSearchSortRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedOtaSearchSortRemoteDataSource(),
      );
      otaSearchSortRepository.getOtaSearchSortData();
    });

    test('Ota search Filter repo internet failure', () async {
      OtaSearchSortRepositoryImpl();
      OtaSearchSortRepository otaSearchSortRepository =
          OtaSearchSortRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedOtaSearchSortRemoteDataSource(),
      );
      otaSearchSortRepository.getOtaSearchSortData();
    });

    test(
        'Translation analytics Repository '
        'When calling getGalleryResultModelUrlData '
        'With response data', () async {
      OtaSearchSortRepositoryImpl();
      OtaSearchSortRepository otaSearchSortRepository =
          OtaSearchSortRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedOtaSearchSortRemoteDataSourceExp(),
      );
      try {
        await otaSearchSortRepository.getOtaSearchSortData();
      } catch (_) {}
    });
  });
}
