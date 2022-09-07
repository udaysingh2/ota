import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';
import 'package:ota/domain/ota_search_sort/repositories/ota_filter_sort_repository_impl.dart';
import 'package:ota/domain/ota_search_sort/usecases/ota_filter_sort_use_cases.dart';

import '../../../mocks/fixture_reader.dart';

class _OtaRepo implements OtaSearchSortRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  OtaSearchSortRemoteDataSource? otaSearchSortRemoteDataSource;

  @override
  Future<Either<Failure, OtaFilterSort>> getOtaSearchSortData() async {
    Map<String, dynamic> map =
        json.decode(fixture("ota_search_sort/search_sort.json"));
    OtaFilterSort sort = OtaFilterSort.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ota search Filter Use case group", () {
    test('Ota search Filter Use case', () async {
      OtaSearchSortUseCasesImpl();
      OtaSearchSortUseCases otaSearchSortUseCases =
          OtaSearchSortUseCasesImpl(repository: _OtaRepo());
      otaSearchSortUseCases.getOtaSearchSortData();
    });
  });
}
