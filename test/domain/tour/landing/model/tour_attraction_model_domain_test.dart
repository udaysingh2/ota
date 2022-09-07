import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("tour/landing/tour_attraction.json");

  TourAttractionsModelDomain tourAttractionsModelDomain =
      TourAttractionsModelDomain.fromJson(jsonString);
  test("Tour Attraction Method Domain Model Test", () {
    String stringData = tourAttractionsModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourAttractionsModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour Attractions domain model Test", () {
    GetTourServiceSuggestions getTourServiceSuggestions =
        GetTourServiceSuggestions.fromJson(jsonString);
    Map<String, dynamic> map = getTourServiceSuggestions.toMap();

    GetTourServiceSuggestions mapFromModel =
        GetTourServiceSuggestions.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
