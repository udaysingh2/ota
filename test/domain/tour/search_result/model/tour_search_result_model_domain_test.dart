import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("tour/search_result/search_result.json");

  TourSearchResultModelDomain tourSearchResultModelDomain =
      TourSearchResultModelDomain.fromJson(jsonString);
  test("Tour Search Method Domain Model Test", () {
    String stringData = tourSearchResultModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourSearchResultModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour Search Result domain model Test", () {
    GetTourAndTicketSearchResult getTourAndTicketSearchResult =
        GetTourAndTicketSearchResult.fromJson(jsonString);
    Map<String, dynamic> map = getTourAndTicketSearchResult.toMap();

    GetTourAndTicketSearchResult mapFromModel =
        GetTourAndTicketSearchResult.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
