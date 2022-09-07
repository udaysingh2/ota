import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search/view/widget/tour_search_suggestions_tile_widget.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_suggestions_view_model.dart';

const String _kTourKey = "TOUR";
const String _kTicketKey = "TICKET";
const String _kLocationKey = "LOCATION";

const List<String> _kTourType = ["tour"];
const List<String> _kTicketType = ["ticket"];
const List<String> _kLocationType = ["city-location"];
const List<String> _kAllType = ["city-location", "tour", "ticket"];

class TourSearchSuggestionsHelper {
  static String getServiceType(ServiceType type) {
    switch (type) {
      case ServiceType.tour:
        return _kTourKey;
      case ServiceType.ticket:
        return _kTicketKey;
      case ServiceType.location:
        return _kLocationKey;
    }
  }

  static List<Item> getSuggestionItemList(List<SuggestedItem>? list) {
    if (list != null && list.isNotEmpty) {
      return List.generate(list.length, (index) => Item.from(list[index]));
    } else {
      return [];
    }
  }

  static List<String> getSearchType(int index) {
    switch (index) {
      case 0:
        return _kAllType;
      case 1:
        return _kLocationType;
      case 2:
        return _kTicketType;
      case 3:
        return _kTourType;
      default:
        return _kAllType;
    }
  }
}
