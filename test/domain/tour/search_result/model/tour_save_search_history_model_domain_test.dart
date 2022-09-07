import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData = fixture("tour/search_result/tour_save_search_history.json");
  TourSaveSearchHistoryModelDomain tourSaveSearchHistoryModelDomain =
      TourSaveSearchHistoryModelDomain.fromJson(jsonData);
  test("Tour Save Search History Domain Model Test", () {
    String stringData = tourSaveSearchHistoryModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourSaveSearchHistoryModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Tour Save Search SaveRecentTourAndTicketSearchHistory", () {
    String jsonData =
        fixture("tour/search_result/tour_search_suggestion_mock.json");

    SaveRecentTourAndTicketSearchHistory saveRecentTourAndTicketSearchHistory =
        SaveRecentTourAndTicketSearchHistory.fromJson(jsonData);
    Map<String, dynamic> map = saveRecentTourAndTicketSearchHistory.toMap();

    SaveRecentTourAndTicketSearchHistory mapFromModel =
        SaveRecentTourAndTicketSearchHistory.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour Save Search Status", () {
    String jsonData =
        fixture("tour/search_result/tour_search_suggestion_mock.json");

    Status status = Status.fromJson(jsonData);
    Map<String, dynamic> map = status.toMap();

    Status mapFromModel = Status.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
}
