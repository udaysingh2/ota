import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';

import 'ota_search_view_model.dart';
import 'ota_suggestion_view_model.dart';

class OtaSearchStateModel {
  OtaSuggestionModel? suggestion;
  OtaSearchHistoryModel? searchHistoryModel;
  FilterArgument? filterArgument;
  PageType pageType;
  HotelView? hotelView;
  bool? lastPageFlag;
  OtaSearchStateModel({
    required this.pageType,
    this.hotelView,
    this.suggestion,
    this.searchHistoryModel,
    this.filterArgument,
    this.lastPageFlag,
  });
}

enum PageType { hotel, filter, search }
