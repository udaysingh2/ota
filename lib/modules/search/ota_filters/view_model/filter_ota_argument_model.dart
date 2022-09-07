import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_view_model.dart';

class FilterOtaArgumentModel {
  FilterOtaArgumentData? initialFilterOtaArgumentData;
  List<CapsulePromotions> promotions;
  List<String> sha;
  Function(FilterOtaArgumentData updatedFilterOtaArgumentData)? onSearchClicked;

  FilterOtaArgumentModel(
      {this.onSearchClicked,
      this.initialFilterOtaArgumentData,
      this.promotions = const [],
      this.sha = const []});
}

class FilterOtaArgumentData {
  List<SortingDataArgument>? listOfSortString;
  int? startingPrice;
  int? maximumPrice;
  int? rangeStaringPrice;
  int? rangeEndingPrice;
  Set<int>? starRating;
  List<CapsulePromotions>? selectedPromotions;
  Set<String>? selectedSha;
  List<FilterCriteriaViewModel>? filterCriteriaList;

  FilterOtaArgumentData({
    this.starRating,
    this.maximumPrice,
    this.startingPrice,
    this.rangeEndingPrice,
    this.rangeStaringPrice,
    this.listOfSortString,
    this.selectedPromotions,
    this.selectedSha,
    this.filterCriteriaList,
  });

  String? getSelectedSortMode() {
    for (SortingDataArgument data in listOfSortString ?? []) {
      if (data.isSelected!) {
        return data.id;
      }
    }
    return null;
  }

  FilterOtaArgumentData copy() {
    return FilterOtaArgumentData(
        rangeEndingPrice: rangeEndingPrice,
        rangeStaringPrice: rangeStaringPrice,
        listOfSortString: listOfSortString?.toList(),
        maximumPrice: maximumPrice,
        startingPrice: startingPrice,
        starRating: starRating?.toList().toSet(),
        selectedPromotions: selectedPromotions,
        selectedSha: selectedSha,
        filterCriteriaList: filterCriteriaList);
  }

  void reset() {
    listOfSortString = null;
    rangeStaringPrice = null;
    rangeEndingPrice = null;
    starRating = null;
    selectedSha = null;
  }
}

class SortingDataArgument {
  String? stringValue;
  String? id;
  bool? isSelected;

  SortingDataArgument({this.id, this.stringValue, this.isSelected = false});
}
