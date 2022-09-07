import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/usecases/car_searc_suggestion_use_cases.dart';

void main() {
  test("Car Search Suggestion Use Case", () {
    CarSearchSuggestionUseCasesImpl carSearchSuggestionUseCasesImpl =
        CarSearchSuggestionUseCasesImpl();
    carSearchSuggestionUseCasesImpl
        .getCarSearchSuggestionData(
            argument: CarSearchSuggestionArgumentModelDomain(
                searchCondition: '', limit: 0, searchType: [], serviceType: ""))
        .then((value) {});
  });
}
