import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonData = fixture("tour/landing/tour_loading.json");
  TourLoadingData tourLoadingData = TourLoadingData.fromJson(jsonData);

  test("Tour Loading Model Test", () {
    expect(tourLoadingData.getTourServiceCards != null, true);

    Map<String, dynamic> mapData = tourLoadingData.toMap();

    TourLoadingData mapFromModel = TourLoadingData.fromMap(mapData);

    expect(mapFromModel.getTourServiceCards != null, true);

    String jsonConvert = tourLoadingData.toJson();
    expect(jsonConvert.isNotEmpty, true);
  });
  test("Tour Loading Service Card domain model Test", () {
    String jsonData = fixture("tour/landing/tour_loading.json");

    GetTourServiceCards getTourServiceSuggestions =
        GetTourServiceCards.fromJson(jsonData);
    Map<String, dynamic> map = getTourServiceSuggestions.toMap();

    GetTourServiceCards mapFromModel = GetTourServiceCards.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour loading data", () {
    String jsonData = fixture("tour/landing/tour_loading.json");

    Data data1 = Data.fromJson(jsonData);
    Map<String, dynamic> map = data1.toMap();

    Data mapFromModel = Data.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
}
