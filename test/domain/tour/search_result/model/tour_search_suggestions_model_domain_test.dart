import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData =
      fixture("tour/search_result/tour_search_suggestion_mock.json");
  TourSearchSuggestionsModelDomain tourSearchSuggestionsModelDomain =
      TourSearchSuggestionsModelDomain.fromJson(jsonData);
  test("Tour Search Suggestion Domain Model Test", () {
    String stringData = tourSearchSuggestionsModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourSearchSuggestionsModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Tour Search Suggestion Data Test", () {
    String jsonData =
        fixture("tour/search_result/tour_search_suggestion_mock.json");

    SuggestionsData suggestionsData = SuggestionsData.fromJson(jsonData);
    Map<String, dynamic> map = suggestionsData.toMap();

    SuggestionsData mapFromModel = SuggestionsData.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour Search GetTourAndTicketSearchSuggestion", () {
    String jsonData =
        fixture("tour/search_result/tour_search_suggestion_mock.json");

    GetTourAndTicketSearchSuggestion getTourAndTicketSearchSuggestion =
        GetTourAndTicketSearchSuggestion.fromJson(jsonData);
    Map<String, dynamic> map = getTourAndTicketSearchSuggestion.toMap();

    GetTourAndTicketSearchSuggestion mapFromModel =
        GetTourAndTicketSearchSuggestion.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour Search Suggestions", () {
    String jsonData =
        fixture("tour/search_result/tour_search_suggestion_mock.json");

    Suggestions suggestions = Suggestions.fromJson(jsonData);
    Map<String, dynamic> map = suggestions.toMap();

    Suggestions mapFromModel = Suggestions.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour Search Suggestion SuggestedItem", () {
    String jsonData =
        fixture("tour/search_result/tour_search_suggestion_mock.json");

    SuggestedItem suggestedItem = SuggestedItem.fromJson(jsonData);
    Map<String, dynamic> map = suggestedItem.toMap();

    SuggestedItem mapFromModel = SuggestedItem.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour Search Suggestion Status", () {
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
