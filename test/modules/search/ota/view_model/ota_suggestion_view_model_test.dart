import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';

void main() {
  test(
    'OTA suggestion view model tests',
    () async {
      City city = City();
      OtaSuggestionModel otaSuggestionModel =
          OtaSuggestionModel.fromSuggestion(cityLocationModel: city);
      OtaSuggestionViewModel otaSuggestionViewModel = OtaSuggestionViewModel(
        suggestionList: [otaSuggestionModel],
      );

      expect(otaSuggestionViewModel.suggestionList.length, 1);
    },
  );
}
