import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData = fixture("tour/search_filter/tour_search_filter_mock.json");
  TourSearchFilterModelDomain tourSearchFilterModelDomain =
      TourSearchFilterModelDomain.fromJson(jsonData);
  test("Tour Search filter model domain test", () {
    String stringData = tourSearchFilterModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourSearchFilterModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Tour Search Filter GetSortCriteria", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    GetSortCriteria getSortCriteria = GetSortCriteria.fromJson(jsonData);
    Map<String, dynamic> map = getSortCriteria.toMap();

    GetSortCriteria mapFromModel = GetSortCriteria.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("TTour Search Filter Data", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    Data data = Data.fromJson(jsonData);
    Map<String, dynamic> map = data.toMap();

    Data mapFromModel = Data.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data1 = mapFromModel.toJson();
    expect(data1.isNotEmpty, true);
  });
  test("Tour Search Filter Criterion", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    Criterion criterion = Criterion.fromJson(jsonData);
    Map<String, dynamic> map = criterion.toMap();

    Criterion mapFromModel = Criterion.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data1 = mapFromModel.toJson();
    expect(data1.isNotEmpty, true);
  });
}
