import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData = fixture("tour/tour_with_full_list_mock.json");
  TourDetail tourDetail = TourDetail.fromJson(jsonData);

  test("Tour Detail Model Test", () {
    expect(tourDetail.getTourDetails != null, true);

    Map<String, dynamic> mapData = tourDetail.toMap();

    TourDetail mapFromModel = TourDetail.fromMap(mapData);

    expect(mapFromModel.getTourDetails != null, true);

    String jsonConvert = tourDetail.toJson();
    expect(jsonConvert.isNotEmpty, true);
  });
}
