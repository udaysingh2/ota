import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ota search Filter model group", () {
    test('Ota search Filter model', () async {
      Map<String, dynamic> map =
          json.decode(fixture("ota_search_sort/search_sort.json"));
      OtaFilterSort sort = OtaFilterSort.fromMap(map);
      OtaFilterSort.fromJson(sort.toJson());
      Data data = Data.fromJson(sort.data!.toJson());
      data = Data.fromMap(sort.data!.toMap());
      Criterion.fromJson(data.criteria!.first.toJson());
      Status.fromMap(sort.status!.toMap());
      Status.fromJson(sort.status!.toJson());
    });
  });
}
