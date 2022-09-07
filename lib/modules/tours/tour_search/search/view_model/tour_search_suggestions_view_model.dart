import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search/helper/tour_search_suggestions_helpers.dart';

class TourSearchSuggestionsViewModel {
  TourSearchSuggestionsViewModelState suggestionsState;
  List<Item>? tour;
  List<Item>? ticket;
  List<Item>? location;

  TourSearchSuggestionsViewModel({
    this.suggestionsState = TourSearchSuggestionsViewModelState.none,
    this.tour,
    this.ticket,
    this.location,
  });

  factory TourSearchSuggestionsViewModel.fromData(
          {required SuggestionsData data}) =>
      TourSearchSuggestionsViewModel(
          tour: TourSearchSuggestionsHelper.getSuggestionItemList(
              data.suggestions!.tour),
          ticket: TourSearchSuggestionsHelper.getSuggestionItemList(
              data.suggestions!.ticket),
          location: TourSearchSuggestionsHelper.getSuggestionItemList(
              data.suggestions!.cityLocation));
}

class Item {
  Item({
    this.keyword,
    this.countryId,
    this.cityId,
    this.id,
    this.locationName,
  });

  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? id;
  final String? locationName;

  factory Item.from(SuggestedItem item) => Item(
      keyword: item.keyword,
      countryId: item.countryId,
      cityId: item.cityId,
      id: item.id,
      locationName: item.locationName);
}

enum TourSearchSuggestionsViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
